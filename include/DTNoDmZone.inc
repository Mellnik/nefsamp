/*								  			  NoDM-Zone v3 by Dark-Trigardon

											  Credits:
											  -Marco2406 : Für die geistreiche Idee der NoDM Zone für Neulinge & das Textdraw
											  -Double-O-Seven : Für das Zeigen wie Include und GM am besten kommunizieren!
											  -Samp-Team : Die es überhaupt ermöglicht haben sowas Programmierbar für GTA zu machen!
											  -creck : Für die wichtigen BugReport in v1 und v2
											  - Nemesus für das Editieren.*/
/*Include Einstellungen*/
#define NODM_FILTERSCRIPT (0) //Auf '1' setzen wenn du dieses Include in einem Filterscript einbaust! (Default: 0)
#define MAX_DM_ZONES (10) //Wieviele DM Zonen max. verwendet werden. (Default: 10)
#define ACTIVATE_NODM_MAPZONES //Auskommentieren um die NoDM Zonen auf der Karte anzuzeigen!
#define NoDM_UPDATE (1) //Angabe in Sekunden in welchen Intervalen geprüft werden soll, ob Spieler in einer NoDM Zone ist! (Default: 1)
#define NoDM_NOWEAPONS (1) //Sollen die Waffen vom Spieler in der NoDM Zone abgenommen und wieder zurückgegeben werden? (Ja = 1; Nein = 0) (Default: 1)

new Text:NoDMTextdraw; //Bitte dies unverändert lassen
//Hier kannst du dein eigenes Textdraw einfügen wenn dir das vorhandene nicht gefällt!
//Beachte das wenn du ein eigenes TextDraw einfügst die Definition 'NoDMTextdraw' gleich bleibt!
stock SB_CreateTextdraw()
{
NoDMTextdraw = TextDrawCreate(500.000000, 108.000000, "No DM-Zone");
TextDrawBackgroundColor(NoDMTextdraw, 255);
TextDrawFont(NoDMTextdraw, 1);
TextDrawLetterSize(NoDMTextdraw, 0.500000, 1.000000);
TextDrawColor(NoDMTextdraw, -16776961);
TextDrawSetOutline(NoDMTextdraw, 1);
TextDrawSetProportional(NoDMTextdraw, 1);
}


#if defined ACTIVATE_NODM_MAPZONES
#define NoDM_MAPZONE_COLOR (0xFF6347AA) //Welche Farbe ist bei NoDM Zonen die auf Karten angezeigt werden! (Nur wenn ACTIVATE_NODM_MAPZONES auskommentiert wurde!) Default: Hellrot

/*Ab hier nichts mehr ändern, außer du mit dem Programmieren in PAWN vertraut bist!*/

new gDMMapZone[MAX_DM_ZONES];
#endif

#if (NoDM_UPDATE < 0) 
#error "Definition von Wert NoDM_UPDATE kleiner als 0!"
#endif
#if (NODM_FILTERSCRIPT < 0 || NODM_FILTERSCRIPT > 1) 
#error "Definition von Wert NODM_FILTERSCRIPT ungueltig!"
#endif
#if (NoDM_NOWEAPONS < 0 || NoDM_NOWEAPONS > 1) 
#error "Definition von Wert NoDM_NOWEAPONS ungueltig!"
#endif
#if (MAX_DM_ZONES < 0)
#error "Anzahl an NODM-Zonen nicht weniger als 0!"
#endif
#if (defined ACTIVATE_NODM_MAPZONES && MAX_DM_ZONES > 1024)
#error "SanAndreas-Multiplayer MiniMap-Zonen Limit ueberschritten!" 
#endif

new gCountNoDMZone = 0;
new bool:gLoaded = false;
new Float:NoDMInfo[MAX_DM_ZONES][4];
new bool:gFunction[MAX_PLAYERS];

#if (NODM_FILTERSCRIPT == 0)
forward NoDM_OnGameModeInit();
forward NoDM_OnGameModeExit();
#else
forward NoDM_OnFilterScriptInit();
forward NoDM_OnFilterScriptExit();
#endif
forward NoDM_OnPlayerDisconnect(playerid, reason);
forward NoDM_OnPlayerUpdate(playerid);

stock NoDM_IsAPlane(carid)
{
	switch(GetVehicleModel(carid))
	{
		case 460,476,511..513,519,520,533,577,592,593: return true;
	}
	return false;
}

stock NoDM_IsPlayerInArea(playerid,Float:minX,Float:minY,Float:maxX,Float:maxY)
{
	new Float:pX,Float:pY,Float:pZ;
	if(!IsPlayerInAnyVehicle(playerid)) GetPlayerPos(playerid,pX,pY,pZ);
	else GetVehiclePos(GetPlayerVehicleID(playerid),pX,pY,pZ);
	if(pX >= minX && pX <= maxX && pY >= minY && pY <= maxY) return true;
	else return false;
}

stock AddNoDMZone(Float:minX, Float:maxX, Float:minY, Float:maxY)
{
	if(gLoaded == true)
	{
		print("[noDM] Erstellen von NoDM Zonen mit der Funktion AddNoDMZone nur möglich beim ScriptStart! (Unter OnGameModeInit/OnFilterScriptInit!)");
		return false;
	}
	NoDMInfo[gCountNoDMZone][0] = minX;
	NoDMInfo[gCountNoDMZone][1] = maxX;
	NoDMInfo[gCountNoDMZone][2] = minY;
	NoDMInfo[gCountNoDMZone][3] = maxY;
	#if defined ACTIVATE_NODM_MAPZONES
	gDMMapZone[gCountNoDMZone] = GangZoneCreate(minX, minY, maxX, maxY);
	#endif
	gCountNoDMZone++;
	return true;
}
#if (NODM_FILTERSCRIPT == 0)
public OnGameModeInit()
{
	new playerid = 0, zeit[3];
	gettime(zeit[0], zeit[1], zeit[2]);
	for(; playerid < MAX_PLAYERS; playerid++)
	{
		SetPVarInt(playerid, "PastSecond", zeit[2]);
		SetPVarInt(playerid, "BSNTextDrawShowed", 0);
	}
	SB_CreateTextdraw();
	print("NoDM-Zone v3 by Templer loaded...");
	return CallLocalFunction("NoDM_OnGameModeInit","");
}

public OnGameModeExit()
{
	#if defined ACTIVATE_NODM_MAPZONES
	new zone = 0;
	for(; zone < gCountNoDMZone; zone++)
	{
		GangZoneDestroy(gDMMapZone[zone]);
	}
	#endif
	TextDrawDestroy(NoDMTextdraw);
	return CallLocalFunction("NoDM_OnGameModeExit","");
}
#else
public OnFilterScriptInit()
{
	new playerid = 0, zeit[3];
	gettime(zeit[0], zeit[1], zeit[2]);
	for(; playerid < MAX_PLAYERS; playerid++)
	{
		SetPVarInt(playerid, "PastSecond", zeit[2]);
		SetPVarInt(playerid, "BSNTextDrawShowed", 0);
	}
	SB_CreateTextdraw();
	print("NoDM-Zone v3 by Templer loaded...");
	return CallLocalFunction("NoDM_OnFilterScriptInit","");
}

public OnFilterScriptExit()
{
	#if defined ACTIVATE_NODM_MAPZONES
	new zone = 0;
	for(; zone < gCountNoDMZone; zone++)
	{
		GangZoneDestroy(gDMMapZone[zone]);
	}
	#endif
	TextDrawDestroy(NoDMTextdraw);
	return CallLocalFunction("NoDM_OnFilterScriptExit","");
}
#endif

public OnPlayerDisconnect(playerid, reason)
{
	#if defined ACTIVATE_NODM_MAPZONES
	new zone = 0, cache[32];
	for(; zone < gCountNoDMZone; zone++)
	{
		format(cache, 32, "ShowedDMZone_%d", zone);
		SetPVarInt(playerid, cache, 0);
		GangZoneHideForPlayer(playerid, gDMMapZone[zone]);
	}
	#endif
	return CallLocalFunction("NoDM_OnPlayerDisconnect","dd", playerid, reason);
}

public OnPlayerUpdate(playerid)
{
	new zeit[3], zone = 0;
	#if (defined ACTIVATE_NODM_MAPZONES || NoDM_NOWEAPONS == 1)
		new cachestring[2][32];
	#endif
	#if (NoDM_NOWEAPONS == 1)
		new cache[13][2], slot = 1;
	#endif
	gettime(zeit[0], zeit[1], zeit[2]);
	if(zeit[2] < GetPVarInt(playerid, "PastSecond")) SetPVarInt(playerid, "PastSecond", zeit[2]);
	if((zeit[2] - GetPVarInt(playerid, "PastSecond")) >= NoDM_UPDATE && gFunction[playerid] == false)
	{
		gFunction[playerid] = true;
		SetPVarInt(playerid, "PastSecond", zeit[2]);
		if(gLoaded == false) gLoaded = true;
		while(zone < gCountNoDMZone)
		{
			#if defined ACTIVATE_NODM_MAPZONES
				format(cachestring[0], 32, "ShowedDMZone_%d", zone);
				if(GetPVarInt(playerid, cachestring[0]) != 1)
				{
					SetPVarInt(playerid, cachestring[0], 1);
					GangZoneShowForPlayer(playerid, gDMMapZone[zone], NoDM_MAPZONE_COLOR);
				}
			#endif
			if(NoDM_IsPlayerInArea(playerid, NoDMInfo[zone][0], NoDMInfo[zone][2], NoDMInfo[zone][1], NoDMInfo[zone][3]) && GetPVarInt(playerid, "BSNTextDrawShowed") == 0)
			{
				#if (NoDM_NOWEAPONS == 1)
					for(; slot < 12; slot++)
					{
						GetPlayerWeaponData(playerid, slot, cache[slot][0], cache[slot][1]);
						format(cachestring[0], 32, "WaffenID_%d", slot);
						format(cachestring[1], 32, "AmmoID_%d", slot);
						SetPVarInt(playerid, cachestring[0], cache[slot][0]);
						SetPVarInt(playerid, cachestring[1], cache[slot][1]);
					}
					ResetPlayerWeapons(playerid);
				#endif
				SetPVarInt(playerid, "BSNTextDrawShowed", 1);
				TextDrawShowForPlayer(playerid,NoDMTextdraw);
				break;
			}
			else if(!NoDM_IsPlayerInArea(playerid, NoDMInfo[zone][0], NoDMInfo[zone][2], NoDMInfo[zone][1], NoDMInfo[zone][3]) && GetPVarInt(playerid, "BSNTextDrawShowed") == 1)
			{
				#if (NoDM_NOWEAPONS == 1)
					for(; slot < 12; slot++)
					{
						format(cachestring[0], 32, "WaffenID_%d", slot);
						format(cachestring[1], 32, "AmmoID_%d", slot);
						if(GetPVarInt(playerid, cachestring[0]) > 0) GivePlayerWeapon(playerid, GetPVarInt(playerid, cachestring[0]), GetPVarInt(playerid, cachestring[1]));
						SetPVarInt(playerid, cachestring[0], -1);
						SetPVarInt(playerid, cachestring[1], -1);
					}
				#endif
				SetPVarInt(playerid, "BSNTextDrawShowed", 0);
				TextDrawHideForPlayer(playerid,NoDMTextdraw);
				break;
			}
			zone++;
		}
		gFunction[playerid] = false;
	}
	return CallLocalFunction("NoDM_OnPlayerUpdate","d", playerid);
}

#if (NODM_FILTERSCRIPT == 0)
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit NoDM_OnGameModeInit

	#if defined _ALS_OnGameModeExit
		#undef OnGameModeExit
	#else
		#define _ALS_OnGameModeExit
	#endif
	#define OnGameModeExit NoDM_OnGameModeExit
#elseif (NODM_FILTERSCRIPT == 1)
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif
	#define OnFilterScriptInit NoDM_OnFilterScriptInit

	#if defined _ALS_OnFilterScriptExit
		#undef OnFilterScriptExit
	#else
		#define _ALS_OnFilterScriptExit
	#endif
	#define OnFilterScriptExit NoDM_OnFilterScriptExit
#endif

#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect NoDM_OnPlayerDisconnect

#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate NoDM_OnPlayerUpdate