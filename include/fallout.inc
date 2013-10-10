#include <a_samp>
#include <a_players>
#include <streamer>
forward SpawnPlayerClass(playerid);
forward SquareShake(objectid);
forward ResetSpam(playerid);
forward UpdatesUpdate();
forward DecideWinners();
forward StartFalling();
forward SolarFall();
forward CountDown();
forward LoseGame();

enum ( += 1 ) {
	e_Fallout_Inactive,
	e_Fallout_Startup,
	e_Fallout_Running,
	e_Fallout_Finish
}

new g_FalloutStatus;

enum eInfo
{
	I_iShaketimer[101],
	I_iNumberout[101],
	I_iObject[101],
	I_iShake[101],
	I_iTimer[2],
	I_iCount,
	I_iJoin,
	I_tLoseGame
}


new Info[eInfo];



COMMAND:fallout(playerid,params[]) {
	if( gTeam[playerid] == NORMAL ) {
	    /*
		new
			skinid;
		do {
			skinid = random(300);
		}
		while( InvalidSkin(skinid) );
		SetPlayerSkin(playerid, skinid);
		*/
		if( g_FalloutStatus == e_Fallout_Inactive ) {
		    Fallout_BuildMap();
		    Fallout_StartGame();
		    
			gTeam[playerid] = FALLOUT;
			g_FalloutStatus = e_Fallout_Startup;
			Fallout_SetPlayer(playerid);
            LangTextForAll(BLUE,"Fallout started /fallout","Fallout gestartet /fallout");
		}
		else if( g_FalloutStatus == e_Fallout_Startup ) {
			gTeam[playerid] = FALLOUT;
			Fallout_SetPlayer(playerid);
		}
		else if( g_FalloutStatus == e_Fallout_Running ) {
		    SendClientMessage(playerid,RED,"Zu Spät");
		}
	}
	else {
	    SendClientMessage(playerid,RED,"Fehler");
	}
	return 1;
}

stock InvalidSkin( skin ) {
	switch(skin)
	{
		case 3, 4, 5, 6, 7, 8, 42, 65, 74, 86, 119, 149, 208, 268, 273, 289: return true;
	}
	return false;
}
stock Fallout_OnPlayerDeath(playerid, killerid, reason)
{
	#pragma unused killerid,reason
	if( gTeam[playerid] == FALLOUT ) {
		GameTextForPlayer(playerid, "~r~You lose!", 5000, 3);
		PlayerInfo[playerid][lost] = 1;
		gTeam[playerid] = NORMAL;
		SpawnPlayer(playerid);
		return 1;
	}
	return 0;
}


public SquareShake(objectid)
{
	if(objectid == 0)
	{
		return KillTimer(Info[I_iShaketimer][objectid]);
	}

	switch(Info[I_iShake][objectid])
	{
		case 0, 5:
		{
			SetDynamicObjectRot( Info[I_iObject][objectid] , 31.8, 2, 0);
		}
		case 1, 6:
		{
			SetDynamicObjectRot(Info[I_iObject][objectid] , 33.8, 0, 0);
		}
		case 2, 7:
		{
			SetDynamicObjectRot(Info[I_iObject][objectid] , 31.8, -2, 0);
		}
		case 3, 8:
		{
			SetDynamicObjectRot(Info[I_iObject][objectid] , 29.8, 0, 0);
		}
		case 4, 9:
		{
			SetDynamicObjectRot(Info[I_iObject][objectid] , 31.8, 0, 0);
		}
		case 10:
		{
			new Float:X, Float:Y, Float:Z;
			GetDynamicObjectPos(Info[I_iObject][objectid] , X, Y, Z);
			MoveDynamicObject(Info[I_iObject][objectid] , X, Y, Z - 100, 4);
		}
		case 11..99:
		{
		   SetDynamicObjectPos(Info[I_iObject][objectid] , 31.8 - ((Info[I_iShake][objectid] * 2) - 20), 0, 0);
		}
		case 100:
		{
			DestroyDynamicObject(Info[I_iObject][objectid] );

			KillTimer(Info[I_iShaketimer][objectid]);
		}
	}

	Info[I_iShake][objectid]++;
	return 1;
}


public DecideWinners()
{
	g_FalloutStatus = e_Fallout_Inactive;

	SendClientMessageToAll(YELLOW, "Winners:");

	new pname[MAX_PLAYER_NAME], string[128], winners;

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if( IsPlayerConnected(i) ) {
			if(PlayerInfo[i][lost] == 0 && gTeam[i] == FALLOUT)
			{
				winners++;

				GetPlayerName(i, pname, sizeof(pname));
				format(string, sizeof(string), "%d) %s", winners, pname);
				SendClientMessageToAll(YELLOW, string);

				SetPlayerScore(i, GetPlayerScore(i) + 1);
				gTeam[i] = NORMAL;
				SpawnPlayer(i);
			}
		}
	}
	Fallout_Cancel();

	if(winners == 0) SendClientMessageToAll(RED, "No winners this time!");
	return 1;
}

public StartFalling()
{
	Info[I_iTimer][0] = SetTimer("SolarFall", 500, 1);
	Info[I_tLoseGame] = SetTimer("LoseGame", 500, 1);
	return 1;
}

public SolarFall()
{
	new objectid, go;
	for(new i = 0; i < 101; i++) if(Info[I_iNumberout][i] == -1) go++;

	if(go == 3)
	{
		if( g_FalloutStatus == e_Fallout_Running ) {
			g_FalloutStatus = e_Fallout_Finish;
			SetTimer("DecideWinners", 200, 0);
		    printf("SetTimer für DecideWinners @ SolarFall");
		}
		KillTimer(Info[I_iTimer][0]);
		return 1;
	}

	start:
	objectid = random(101);
	if(Info[I_iNumberout][objectid] != -1) goto start;

	Info[I_iNumberout][objectid] = 0;

	Info[I_iShaketimer][objectid] = SetTimerEx("SquareShake", 100, 1, "i",objectid);
	/*
	new
		alive,
		connected;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1) {
		    if( PlayerInfo[i][lost] == 0 && gTeam[i] == FALLOUT ) alive++;
		}
	}

	if(alive <= 0 && Info[I_iDead] == 0)
	{
		SetTimer("DecideWinners", 1500, 0);
		Info[I_iDead] = 1;
	}
	*/
	return 1;
}

public CountDown()
{
	new
		player,
		string[128];
	Info[I_iCount]--;
	if( Info[I_iCount] == 0 ) {
		format(string, sizeof(string), "~b~ Start!");
	}
	else {
		format(string, sizeof(string), "~g~ Starting in ~y~%d", Info[I_iCount]);
	}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if( gTeam[i] == FALLOUT ) {
			GameTextForPlayer(i,string, 1150, 3);
	    }
	}

	if(Info[I_iCount] == 0) {
		KillTimer(Info[I_iTimer][1]);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if( gTeam[i] == FALLOUT ) {
				Streamer_Update(i);
				TogglePlayerControllable(i,true);
				PlayerInfo[i][lost] = 0;
				player++;
		    }
		}
		if( player <= 1 ) {
		    // Abbrechen weil zu wenig Spieler
		    Fallout_Cancel();
		    SendClientMessageToAll(RED,"Fallout abbruch da zu wenig Spieler!");
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			    if( gTeam[i] == FALLOUT ) {
			        SpawnPlayer(i);
			        gTeam[i] = NORMAL;
			    }
			}
		}
		else {
			SetTimer("StartFalling", 587, 0);
			g_FalloutStatus = e_Fallout_Running;
		}
	}
	return 1;
}

public LoseGame()
{
	new
	    players,
		Float:X,
		Float:Y,
		Float:Z;

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] != FALLOUT ) continue;
		if(PlayerInfo[i][lost] == 1) continue;

		GetPlayerPos(i, X, Y, Z);

		if(Z <= 158.0 && PlayerInfo[i][lost] == 0)
		{
			GameTextForPlayer(i, "~r~You lose!", 5000, 3);
			PlayerInfo[i][lost] = 1;
			gTeam[i] = NORMAL;
			SpawnPlayer(i);
		}
		else {
		    players++;
		}
	}
	if( players <= 1 && g_FalloutStatus == e_Fallout_Running ) {
	    g_FalloutStatus = e_Fallout_Finish;
	    printf("SetTimer für DecideWinners @ LoseGame");
		SetTimer("DecideWinners", 1500, 0);
	}
	return 1;
}

stock Fallout_Cancel() {
	g_FalloutStatus = e_Fallout_Inactive;
	for(new i = 0; i < 101; i++)
	{
		DestroyDynamicObject( Info[I_iObject][i] );
		Info[I_iNumberout][i] = -1;
		KillTimer(Info[I_iShaketimer][i]);
		Info[I_iShake][i] = 0;
	}
	KillTimer(Info[I_iTimer][0]);
	KillTimer(Info[I_tLoseGame]);
	return 1;
}

stock Fallout_BuildMap()
{
	for(new i = 0; i < 101; i++)
	{
		DestroyDynamicObject( Info[I_iObject][i] );
		Info[I_iNumberout][i] = -1;
		KillTimer(Info[I_iShaketimer][i]);
		KillTimer(Info[I_iTimer][0]);
		Info[I_iShake][i] = 0;
	}
	new
	    j;
	Info[I_iCount] = 15;

	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	return 1;
}

stock Fallout_StartGame()
{

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		PlayerInfo[i][lost] = 0;
	    if( gTeam[i] == FALLOUT ) {
			SetPlayerHealth(i, 100.0);
	    }
	}

	Info[I_iTimer][1] = SetTimer("CountDown", 1000, 1);

	new string[128], hour, minute, second;
	gettime(hour, minute, second);

	format(string, sizeof(string), "A new game has started - %d:%d:%d", hour, minute, second);
	SendClientMessageToAll(ORANGE, string);
	return 1;
}

stock Fallout_SetPlayer(playerid) {
	SetPlayerPos(playerid, 2482.1921 - random(39), -1660.4783 + random(47), 161.0000);
	SetPlayerFacingAngle(playerid, random(360));
	Streamer_Update(playerid);
	TogglePlayerControllable(playerid,false);
	SetCameraBehindPlayer(playerid);
	ResetPlayerWeapons(playerid);
	return 1;
}
