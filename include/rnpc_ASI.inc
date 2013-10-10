/**
 *	RNPC - Recordfile NPCs
 *  Version 0.3
 *	made by Mauzen, parts based on Joe Staffs code
 */
 
 new bool:BotDeath[MAX_PLAYERS];
 
#define PLAYER_RECORDING_TYPE_NONE		0
#define PLAYER_RECORDING_TYPE_DRIVER	1
#define PLAYER_RECORDING_TYPE_ONFOOT	2

#define RNPC_SPEED_SPRINT				(0.0095)
#define RNPC_SPEED_RUN					(0.0057)
#define RNPC_SPEED_WALK					(0.0015)

#define MAP_ANDREAS_MODE_NONE			0
#define MAP_ANDREAS_MODE_MINIMAL		1
#define MAP_ANDREAS_MODE_MEDIUM			2	// currently unused
#define MAP_ANDREAS_MODE_FULL			3
#define MAP_ANDREAS_MODE_NOBUFFER		4

// @since 0.2
native RNPC_CreateBuild(npcid, type, slot=0);
native RNPC_FinishBuild(clear=1);
native RNPC_AddMovement(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:speed=RNPC_SPEED_RUN);
native RNPC_AddAutoMovement(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:speed=RNPC_SPEED_RUN, maxsteps=1000);
native RNPC_ConcatMovement(Float:x, Float:y, Float:z, Float:speed=RNPC_SPEED_RUN);
native RNPC_AddPause(time);

native RNPC_SetUpdateRate(rate);

native RNPC_SetLRKeys(lr);
native RNPC_SetUDKeys(ud);
native RNPC_SetKeys(keys);
native RNPC_SetQuat1(Float:w);
native RNPC_SetQuat2(Float:x);
native RNPC_SetQuat3(Float:y);
native RNPC_SetQuat4(Float:z);
native RNPC_SetHealth(hp);
native RNPC_SetArmour(arm);
native RNPC_SetSpecialAction(sp);
native RNPC_SetWeaponID(weaponid);
native RNPC_SetAnimID(anim);
native RNPC_SetAnimParams(params);
native RNPC_SetAngleQuats(Float:a, Float:h, Float:b);

native MapAndreas_Init(mode);
native MapAndreas_FindZ_For2DCoord(Float:X, Float:Y, &Float:Z);
native MapAndreas_FindAverageZ(Float:X, Float:Y, &Float:Z);
native MapAndreas_Unload();

// @since 0.2.1
native RNPC_GetBuildLength();

// @since 0.3
native RNPC_SetSirenState(siren);
native RNPC_SetDriverHealth(health);
native RNPC_SetInternalPos(Float:x, Float:y, Float:z);
native RNPC_SetAcceleration(Float:acc);
native RNPC_SetDeceleration(Float:dec);		// Unused yet
native RNPC_AddMovementAlt(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:speed=RNPC_SPEED_RUN, bool:lock=true);

// Fake communication functions
#define RNPC_SetAutorepeat(%1,%2)		new rtxt[10]; format(rtxt, 10, "RNPC:%d", 110 + %2); SendClientMessage(%1, -1, rtxt)

forward OnRNPCPlaybackFinished(npcid);

/**
 *	Connects a new RNPC, returning his ID.
 *	@since 	V0.1
 */
stock ConnectRNPC(name[])
{
	new slot = -1;
	for (new i = 0; i < MAX_PLAYERS; i++) {
		if (!IsPlayerConnected(i)) {
			slot = i;
			break;
		}
	}
	ConnectNPC(name, "RNPC");
	
	return slot;
}

/**
 *	Moves a RNPC to the given position.
 *	@since 	V0.1
 */
stock MoveRNPC(npcid, Float:x, Float:y, Float:z, Float:speed)
{
	if (!IsPlayerNPC(npcid)) return false;
	if(BotDeath[npcid] == true)return false;
	new Float:nx, Float:ny, Float:nz;
	if (IsPlayerInAnyVehicle(npcid)) {
		GetVehiclePos(GetPlayerVehicleID(npcid), nx, ny, nz);
		RNPC_CreateBuild(npcid, PLAYER_RECORDING_TYPE_DRIVER);
		RNPC_AddMovement(nx, ny, nz, x, y, z, speed);
		RNPC_FinishBuild();
	} else {
		GetPlayerPos(npcid, nx, ny, nz);
		RNPC_CreateBuild(npcid, PLAYER_RECORDING_TYPE_ONFOOT);
		RNPC_AddMovement(nx, ny, nz, x, y, z, speed);
		RNPC_FinishBuild();
	}
	RNPC_StartBuildPlayback(npcid);
	
	SendClientMessage(npcid, -1, "RNPC:101:0");
	
	return true;
}

/**
 *
 *	@since	V0.1.1
 */
 
stock StopPayback(npcid)
{
	if (!IsPlayerNPC(npcid)) return false;
	SendClientMessage(npcid, -1, "RNPC:120:0");
	return 1;
}
stock RNPC_StartPlayback(npcid, rec[])
{
	if (!IsPlayerNPC(npcid)) return false;
	
	new form[40];
	format(form, 40, "RNPC:109:%s", rec);
	SendClientMessage(npcid, -1, form);
	
	return true;
}

/**
 *
 *	@since V0.2
 */
stock RNPC_StartBuildPlayback(npcid, slot=0, vehicleid=0)
{
	if (vehicleid) {
		PutPlayerInVehicle(npcid, vehicleid, 0);
		SetTimerEx("DelayStart", 100, 0, "iii", npcid, vehicleid, slot);
	}
	new cmd[16];
	format(cmd, 16, "RNPC:101:%d", slot);
	SendClientMessage(npcid, -1, cmd);	
}

/**
 * Delayed second start to fix vehicle playback problems
 * @since V0.3
 */
forward DelayStart(npcid, vehicleid, slot);
public DelayStart(npcid, vehicleid, slot)
{
	PutPlayerInVehicle(npcid, vehicleid, 0);
	new cmd[16];
	format(cmd, 16, "RNPC:101:%d", slot);
	SendClientMessage(npcid, -1, cmd);
}

/**
 *
 * @since V0.3
 */
RNPC_StopPlayback(npcid)
{
	//new Float:x, Float:y, Float:z;
	//if (IsPlayerInAnyVehicle(npcid)) GetVehiclePos(GetPlayerVehicleID(npcid), x, y, z);
	//	else GetPlayerPos(npcid, x, y, z);		
	SendClientMessage(npcid, -1, "RNPC:102");
	//RNPC_SetInternalPos(x, y, z);	
}

/**
 *	Serverside interface for RNPC communication
 */
public OnPlayerCommandText(playerid, cmdtext[]) {
	if (!IsPlayerNPC(playerid)) return CallLocalFunction("RNPC_OnPlayerCommandText", "is", playerid, cmdtext);
	
	#if defined RNPC_DEBUG
		printf("RNPC %d: [CMD] %s", playerid, cmdtext);
	#endif
	
	if (!strcmp("RNPC:002", cmdtext, true, 8)) {
		CallLocalFunction("OnRNPCPlaybackFinished", "i", playerid);
	} else {
		return CallLocalFunction("RNPC_OnPlayerCommandText", "is", playerid, cmdtext);
	}	
	
	return true;
}
#if defined _ALS_OnPlayerCommandText
	#undef OnPlayerCommandText
#else
	#define _ALS_OnPlayerCommandText
#endif
#define OnPlayerCommandText RNPC_OnPlayerCommandText
forward RNPC_OnPlayerCommandText(playerid, cmdtext[]);
