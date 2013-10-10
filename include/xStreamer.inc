/*  
	xStreamer by Boylett
 */

#if defined _xstreamer_included
	#endinput
#endif
#define _xstreamer_included
#pragma library xstreamer

//------------------------------------------------------------------------------

#if !defined OBJECT_TIMER
#define OBJECT_TIMER 500
#endif

native ConnectPlayer(playerid);
native DisconnectPlayer(playerid);
native StreamObjects(playerid,Float:x,Float:y,Float:z);

native CreateStreamedObject(modelid,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz);
native DestroyStreamedObject(objectid);
native MoveStreamedObject(objectid,Float:x,Float:y,Float:z,Float:speed);

forward sampCreatePlayerObject(playerid,modelid,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz);
forward sampDestroyPlayerObject(playerid,objectid);
forward sampMovePlayerObject(playerid, objectid, Float:X, Float:Y, Float:Z, Float:Speed);

forward xStreamer_Run();
forward xStreamer_OnGameModeInit();
forward xStreamer_OnPlayerConnect(playerid);
forward xStreamer_OnPlayerSpawn(playerid);
forward xStreamer_OnPlayerDisconnect(playerid,reason);

public sampCreatePlayerObject(playerid,modelid,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz)
{
	//printf("CreatePlayerObject(%d,%d,%f,%f,%f,%f,%f,%f)",playerid,modelid,x,y,z,rx,ry,rz);
	return CreatePlayerObject(playerid,modelid,x,y,z,rx,ry,rz);
}

public sampDestroyPlayerObject(playerid,objectid)
{
	//printf("DestroyPlayerObject(%d,%d)",playerid,objectid);
	return DestroyPlayerObject(playerid,objectid);
}

public sampMovePlayerObject(playerid, objectid, Float:X, Float:Y, Float:Z, Float:Speed)
{
	//printf("MovePlayerObject(%d,%d,%f,%f,%f,%f)",playerid, objectid, X, Y, Z, Speed);
	return MovePlayerObject(playerid, objectid, X, Y, Z, Speed);
}

public xStreamer_Run()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			new
				Float:x,
				Float:y,
				Float:z;
			GetPlayerPos(i,x,y,z);
			StreamObjects(i,x,y,z);
		}
	}
}

public OnGameModeInit()
{
	SetTimer("xStreamer_Run",OBJECT_TIMER,1);
	return CallLocalFunction("xStreamer_OnGameModeInit","");
}

public OnPlayerConnect(playerid)
{
	ConnectPlayer(playerid);
	return CallLocalFunction("xStreamer_OnPlayerConnect","i",playerid);
}

public OnPlayerSpawn(playerid)
{
	new
		Float:x,
		Float:y,
		Float:z;
	GetPlayerPos(playerid,x,y,z);
	StreamObjects(playerid,x,y,z);
	return CallLocalFunction("xStreamer_OnPlayerSpawn","i",playerid);
}

public OnPlayerDisconnect(playerid,reason)
{
	DisconnectPlayer(playerid);
	return CallLocalFunction("xStreamer_OnPlayerDisconnect","ii",playerid,reason);
}

#define OnGameModeInit xStreamer_OnGameModeInit
#define OnPlayerConnect xStreamer_OnPlayerConnect
#define OnPlayerDisconnect xStreamer_OnPlayerDisconnect
#define OnPlayerSpawn xStreamer_OnPlayerSpawn

stock xStreamer_SetPlayerPos(playerid,Float:x,Float:y,Float:z)
{
	StreamObjects(playerid,x,y,z);
	SetPlayerPos(playerid,x,y,z);
}

#define SetPlayerPos xStreamer_SetPlayerPos