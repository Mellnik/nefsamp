/*								  			  NoDM-Zone v4 Include by Templer
											   (for SAMP 0.3 / or higher)
									(Inspiriert durch Marco2406 vom Breadfish Forum)
								Dieses Script darf von jedermann verändert und benutzt werden!
							Mir ist es sogar egal, wenn Ihr was von hier für euren Vorteil rauskopiert!

											Credits:
												-Marco2406 : Für die geistreiche Idee der NoDM Zone für Neulinge & das Textdraw
												-Double-O-Seven : Für das Zeigen wie Include und GM am besten kommunizieren!
												-Samp-Team : Die es überhaupt ermöglicht haben sowas Programmierbar für GTA zu machen!
												-creck : Für die wichtigen BugReport in v1 und v2
												-niCe: Für sein 'IsPlayerAimingAtPlayer'*/
/*Include Einstellungen*/
#define NODM_FILTERSCRIPT (0) //Auf '1' setzen wenn du dieses Include in einem Filterscript einbaust! (Default: 0)
#define NoDM_MAX_ZONES (5) //Wieviele DM Zonen max. verwendet werden. (Default: 10)
#define NoDM_ACTIVATE_MAPZONES //Auskommentieren um die NoDM Zonen auf der Karte anzuzeigen!
#define NoDM_UPDATE (2) //Angabe in Sekunden in welchen Intervalen geprüft werden soll, ob Spieler in einer NoDM Zone ist! (Default: 2)
#define NoDM_NOWEAPONS (1) //Sollen die Waffen vom Spieler in der NoDM Zone abgenommen und wieder zurückgegeben werden? (Ja = 1; Nein = 0) (Default: 1)
#define NoDM_AIMING_AT_PEOPLE (true) //Spieler Schaden hinzufügen, wenn sie einen Spieler, der in der NoDM Zone ist, von außerhalb anschießen. (Ja = true; Nein = false) (Default: true)

new Text:NoDMTextdraw; //Bitte dies unverändert lassen
//Hier kannst du dein eigenes Textdraw einfügen wenn dir das vorhandene nicht gefällt!
//Beachte das wenn du ein eigenes TextDraw einfügst die Definition 'NoDMTextdraw' gleich bleibt!
stock SB_CreateTextdraw()
{
	NoDMTextdraw = TextDrawCreate(24.000000,432.000000,"No DM-Zone");
	TextDrawAlignment(NoDMTextdraw,0);
	TextDrawBackgroundColor(NoDMTextdraw,0xff000066);
	TextDrawFont(NoDMTextdraw,2);
	TextDrawLetterSize(NoDMTextdraw,0.499999,0.899999);
	TextDrawColor(NoDMTextdraw,0xffffffff);
	TextDrawSetOutline(NoDMTextdraw,1);
	TextDrawSetProportional(NoDMTextdraw,1);
	TextDrawSetShadow(NoDMTextdraw,1);
}


#if defined NoDM_ACTIVATE_MAPZONES
#define NoDM_MAPZONE_COLOR (0xFF6347AA) //Welche Farbe ist bei NoDM Zonen die auf Karten angezeigt werden! (Nur wenn NoDM_ACTIVATE_MAPZONES auskommentiert wurde!) Default: Hellrot

/*Ab hier nichts mehr ändern, außer du mit dem Programmieren in PAWN vertraut bist!*/

new gDMMapZone[NoDM_MAX_ZONES];
#endif

#if (NoDM_UPDATE < 0) 
	#error "Definition von Wert NoDM_UPDATE kleiner als 0!"
#endif
#if (NODM_FILTERSCRIPT < 0 && NODM_FILTERSCRIPT > 1) 
	#error "Definition von Wert NODM_FILTERSCRIPT ungueltig!"
#endif
#if (NoDM_NOWEAPONS < 0 && NoDM_NOWEAPONS > 1)
	#error "Definition von Wert NoDM_NOWEAPONS ungueltig!"
#endif
#if (NoDM_MAX_ZONES < 0)
	#error "Anzahl an NODM-Zonen nicht weniger als 0!"
#endif
#if (defined NoDM_ACTIVATE_MAPZONES && NoDM_MAX_ZONES > 1024)
	#error "SanAndreas-Multiplayer MiniMap-Zonen Limit ueberschritten!" 
#endif
#if (NoDM_AIMING_AT_PEOPLE != false && NoDM_AIMING_AT_PEOPLE != true)
	#error "Definition NoDM_AIMING_AT_PEOPLE kann nur 'true' oder 'false' beinhalten!" 
#endif

new gCountNoDMZone = 0;
new bool:gLoaded = false;
new Float:NoDMInfo[NoDM_MAX_ZONES][4];
new bool:gFunction[MAX_PLAYERS];

#if (NODM_FILTERSCRIPT == 0)
	forward NoDM_OnGameModeInit();
	forward NoDM_OnGameModeExit();
#else
	forward NoDM_OnFilterScriptInit();
	forward NoDM_OnFilterScriptExit();
#endif
forward NoDM_Timer();
forward NoDM_OnPlayerConnect(playerid);
forward NoDM_OnPlayerDisconnect(playerid, reason);
#if (NoDM_AIMING_AT_PEOPLE == true)
	forward NoDM_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#define NoDM_HOLDING(%0) \
		((newkeys & (%0)) == (%0))
	stock Float:GetPointAngleToPoint(Float:x2, Float:y2, Float:X, Float:Y) {

	  new Float:DX, Float:DY;
	  new Float:angle;

	  DX = floatabs(floatsub(x2,X));
	  DY = floatabs(floatsub(y2,Y));

	  if (DY == 0.0 || DX == 0.0) {
		if(DY == 0 && DX > 0) angle = 0.0;
		else if(DY == 0 && DX < 0) angle = 180.0;
		else if(DY > 0 && DX == 0) angle = 90.0;
		else if(DY < 0 && DX == 0) angle = 270.0;
		else if(DY == 0 && DX == 0) angle = 0.0;
	  }
	  else {
		angle = atan(DX/DY);

		if(X > x2 && Y <= y2) angle += 90.0;
		else if(X <= x2 && Y < y2) angle = floatsub(90.0, angle);
		else if(X < x2 && Y >= y2) angle -= 90.0;
		else if(X >= x2 && Y > y2) angle = floatsub(270.0, angle);
	  }

	  return floatadd(angle, 90.0);
	}
	stock GetXYInFrontOfPoint(&Float:x, &Float:y, Float:angle, Float:distance) 
	{
		x += (distance * floatsin(-angle, degrees));
		y += (distance * floatcos(-angle, degrees));
	}
	stock IsPlayerAimingAtPlayer(playerid, targetplayerid) 
	{
	  new Float:x, Float:y, Float:z;
	  GetPlayerPos(targetplayerid, x, y, z);
	  return IsPlayerAimingAt(playerid, x, y, z, 1.1);
	}
#endif

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
		print("[noDM] Erstellen von NoDM Zonen mit der Funktion AddNoDMZone nur beim ScriptStart möglich! (Unter OnGameModeInit/OnFilterScriptInit!)");
		return false;
	}
	NoDMInfo[gCountNoDMZone][0] = minX;
	NoDMInfo[gCountNoDMZone][1] = maxX;
	NoDMInfo[gCountNoDMZone][2] = minY;
	NoDMInfo[gCountNoDMZone][3] = maxY;
	#if defined NoDM_ACTIVATE_MAPZONES
		gDMMapZone[gCountNoDMZone] = GangZoneCreate(minX, minY, maxX, maxY);
	#endif
	gCountNoDMZone++;
	return true;
}
#if (NODM_FILTERSCRIPT == 0)
public OnGameModeInit()
{
	SB_CreateTextdraw();
	SetTimer("NoDM_Timer",NoDM_UPDATE*1000,true);
	print("NoDM-Zone v3 by Templer loaded...");
	return CallLocalFunction("NoDM_OnGameModeInit","");
}

public OnGameModeExit()
{
	#if defined NoDM_ACTIVATE_MAPZONES
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
	SB_CreateTextdraw();
	SetTimer("NoDM_Timer",NoDM_UPDATE*1000,true);
	print("NoDM-Zone v3 by Templer loaded...");
	return CallLocalFunction("NoDM_OnFilterScriptInit","");
}

public OnFilterScriptExit()
{
	#if defined NoDM_ACTIVATE_MAPZONES
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

public OnPlayerConnect(playerid)
{
	new zeit[3]; gettime(zeit[0], zeit[1], zeit[2]);
	SetPVarInt(playerid, "PastSecond", zeit[2]);
	SetPVarInt(playerid, "BSNTextDrawShowed", -1);
	return CallLocalFunction("NoDM_OnPlayerConnect","d",playerid);
}

public OnPlayerDisconnect(playerid, reason)
{
	#if defined NoDM_ACTIVATE_MAPZONES
	new zone = 0, cache[32];
	for(; zone < gCountNoDMZone; zone++)
	{
		format(cache, 32, "ShowedDMZone_%d", zone);
		if(GetPVarInt(playerid,cache)==0) continue;
		GangZoneHideForPlayer(playerid, gDMMapZone[zone]);
		DeletePVar(playerid,cache);
	}
	#endif
	DeletePVar(playerid,"PastSecond");
	DeletePVar(playerid,"BSNTextDrawShowed");
	return CallLocalFunction("NoDM_OnPlayerDisconnect","dd", playerid, reason);
}

#if (NoDM_AIMING_AT_PEOPLE == true)
	public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
	{
		if(NoDM_HOLDING(KEY_FIRE) && !IsPlayerInAnyVehicle(playerid))
		{
			for(new giveplayerid=0;giveplayerid!=MAX_PLAYERS;giveplayerid++)
			{
				if(!IsPlayerConnected(giveplayerid)||!IsPlayerAimingAtPlayer(playerid,giveplayerid)||GetPVarInt(giveplayerid,"BSNTextDrawShowed")==-1) continue;
				new Float:PlayerHealth; GetPlayerHealth(playerid,PlayerHealth);
				SetPlayerHealth(playerid,floatsub(PlayerHealth,15.0)); SetPlayerFacingAngle(playerid,float(random(360)));
				SendClientMessage(playerid,0xFF9900AA,"Angriffe werden in einer No DM-Zone nicht toleriert. -15 Leben");
				break;
			}
		}
		return CallLocalFunction("NoDM_OnPlayerKeyStateChange", "ddd", playerid, newkeys, oldkeys);
	}
#endif

public NoDM_Timer()
{
	new zeit[3], zone = 0, playerid=0;
	#if (defined NoDM_ACTIVATE_MAPZONES || NoDM_NOWEAPONS == 1)
		new cachestring[2][32];
	#endif
	#if (NoDM_NOWEAPONS == 1)
		new cache[13][2], slot = 1;
	#endif
	gettime(zeit[0], zeit[1], zeit[2]);
	for(;playerid!=MAX_PLAYERS;playerid++)
	{
		if(!IsPlayerConnected(playerid)) continue;
		if(zeit[2] < GetPVarInt(playerid, "PastSecond")) SetPVarInt(playerid, "PastSecond", zeit[2]);
		if((zeit[2] - GetPVarInt(playerid, "PastSecond")) >= NoDM_UPDATE && gFunction[playerid] == false)
		{
			gFunction[playerid] = true;
			SetPVarInt(playerid, "PastSecond", zeit[2]);
			if(gLoaded == false) gLoaded = true;
			zone=0;
			while(zone < gCountNoDMZone)
			{
				#if defined NoDM_ACTIVATE_MAPZONES
					format(cachestring[0], 32, "ShowedDMZone_%d", zone);
					if(GetPVarInt(playerid, cachestring[0]) != 1)
					{
						SetPVarInt(playerid, cachestring[0], 1);
						GangZoneShowForPlayer(playerid, gDMMapZone[zone], NoDM_MAPZONE_COLOR);
					}
				#endif
				if(NoDM_IsPlayerInArea(playerid, NoDMInfo[zone][0], NoDMInfo[zone][2], NoDMInfo[zone][1], NoDMInfo[zone][3]) && GetPVarInt(playerid, "BSNTextDrawShowed") == -1)
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
					SetPVarInt(playerid, "BSNTextDrawShowed", zone);
					TextDrawShowForPlayer(playerid,NoDMTextdraw);
				}
				else if(!NoDM_IsPlayerInArea(playerid, NoDMInfo[zone][0], NoDMInfo[zone][2], NoDMInfo[zone][1], NoDMInfo[zone][3]) && GetPVarInt(playerid, "BSNTextDrawShowed") == zone)
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
					SetPVarInt(playerid, "BSNTextDrawShowed", -1);
					TextDrawHideForPlayer(playerid,NoDMTextdraw);
				}
				zone++;
			}
			gFunction[playerid] = false;
		}
	}
	return true;
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

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect NoDM_OnPlayerConnect

#if (NoDM_AIMING_AT_PEOPLE == true)
	#if defined _ALS_OnPlayerKeyStateChange
		#undef OnPlayerKeyStateChange
	#else
		#define _ALS_OnPlayerKeyStateChange
	#endif
	#define OnPlayerKeyStateChange NoDM_OnPlayerKeyStateChange
#endif