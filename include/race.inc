forward Race_calcPosition();
forward TextInfo(playerid);
forward ShowDialog(playerid, dialogid);
forward LoadRaceNames();
forward LoadAutoRace(rName[]);
forward LoadRace(playerid, rName[]);
forward SetCP(playerid, PrevCP, NextCP, MaxCP, Type);
forward SetupRaceForPlayer(playerid);
forward CountTillRace();
forward StartRace();
forward StopRace();
forward delayAutoRace();
forward RaceCounter();

enum e_RacePosition
{
	RP_iPlayer,
	RP_iValue
}
enum
{
	RaceStatus_Inactive,
	RaceStatus_StandBy,
	RaceStatus_StartUp,
	RaceStatus_Active
}

new
	BuildRace,
	BuildRaceType,
	BuildVehicle,
	BuildCreatedVehicle,
	BuildModeVID,
	BuildVirtualWorld,
	BuildName[30],
	bool:BuildTakeVehPos,
	BuildVehPosCount,
	bool:BuildTakeCheckpoints,
	BuildCheckPointCount,
	RaceName[30],
	RaceVehicle,
	RaceType,
	RaceVirtualWorld,
	TotalRaceCP,
	Float:RaceVehCoords[RACE_MAX_PLAYERS][4],
	Float:CPCoords[MAX_RACE_CHECKPOINTS_EACH_RACE][4],
	PlayerRaceVehicle[MAX_PLAYERS],
	PlayersCount[2],
	tRaceCount = -1,
	tRacePosition = -1,
	RaceCountAmount,
	RaceTick,
	CPProgess[MAX_PLAYERS],
	rPosition,
	RaceFinishCount = 0,
	RaceJoinCount = 0,
	RaceSpawnCount,
	trCounter = -1,
	RaceTime,
	PlayerText:RaceInfo[MAX_PLAYERS],
	RacePosition[MAX_PLAYERS],
	RaceNames[MAX_RACES][128],
 	TotalRaces,
 	RaceStatus
;

stock Race_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case 599:
	    {
	        if(!response) return BuildRace = 0;
	        switch(listitem)
	        {
	        	case 0: BuildRaceType = 0;
	        	case 1: BuildRaceType = 3;
			}
			ShowDialog(playerid, 600);
			return 1;
	    }
	    case 600..601:
	    {
	        if(!response) return ShowDialog(playerid, 599);
	        if(!strlen(inputtext)) return ShowDialog(playerid, 601);
	        if(strval(inputtext) < 0) return ShowDialog(playerid, 601);
	        BuildVirtualWorld = strval(inputtext);
	        format(BuildName,sizeof(BuildName), GetNextFreeRace() );
	        ShowDialog(playerid, 602);
			return 1;
	    }
	    case 602..603:
	    {
	        if(!response) return ShowDialog(playerid, 600);
	        if(!strlen(inputtext)) return ShowDialog(playerid, 603);
	        if(IsNumeric(inputtext))
	        {

	            if(!IsValidVehicle(strval(inputtext))) return ShowDialog(playerid, 603);
				new
	                Float: pPos[4]
				;
				GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
				GetPlayerFacingAngle(playerid, pPos[3]);
				BuildModeVID = strval(inputtext);
				BuildCreatedVehicle = (BuildCreatedVehicle == 0x01) ? (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00) : (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00);
	            BuildVehicle = CreateVehicle(strval(inputtext), pPos[0], pPos[1], pPos[2], pPos[3], random(126), random(126), (60 * 60));
	            PutPlayerInVehicle(playerid, BuildVehicle, 0);
				BuildCreatedVehicle = 0x01;
				ShowDialog(playerid, 604);
				return 1;
			}
	        else
	        {
	            if(!IsValidVehicle(GetVehicleModelID(inputtext))) return ShowDialog(playerid, 603);
				new
	                Float: pPos[4]
				;
				GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
				GetPlayerFacingAngle(playerid, pPos[3]);
				BuildModeVID = GetVehicleModelID(inputtext);
				BuildCreatedVehicle = (BuildCreatedVehicle == 0x01) ? (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00) : (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00);
	            BuildVehicle = CreateVehicle(GetVehicleModelID(inputtext), pPos[0], pPos[1], pPos[2], pPos[3], random(126), random(126), (60 * 60));
	            PutPlayerInVehicle(playerid, BuildVehicle, 0);
				BuildCreatedVehicle = 0x01;
				ShowDialog(playerid, 604);
				return 1;
	        }
	    }
	    case 604:
	    {
	        if(!response) return ShowDialog(playerid, 602);
			SendClientMessage(playerid, GREEN, ">> Go to the start line on the left road and press 'KEY_FIRE' and do the same with the right road block.");
			SendClientMessage(playerid, GREEN, "   - When this is done, you will see a dialog to continue.");
			BuildVehPosCount = 0;
	        BuildTakeVehPos = true;
			return 1;
	    }
	    case 605:
	    {
	        if(!response) return ShowDialog(playerid, 604);
	        SendClientMessage(playerid, GREEN, ">> Start taking checkpoints now by clicking 'KEY_FIRE'.");
	        SendClientMessage(playerid, GREEN, "   - IMPORTANT: Press 'ENTER' when you're done with the checkpoints! If it doesn't react press again and again.");
	        BuildCheckPointCount = 0;
	        BuildTakeCheckpoints = true;
			return 1;
	    }
	    case 606:
	    {
	        if(!response) return ShowDialog(playerid, 606);
	        BuildRace = 0;
	        BuildCheckPointCount = 0;
	        BuildVehPosCount = 0;
	        BuildTakeCheckpoints = false;
	        BuildTakeVehPos = false;
	        BuildCreatedVehicle = (BuildCreatedVehicle == 0x01) ? (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00) : (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00);
			return 1;
	    }
	}
	return 0;
}


public LoadRaceNames()
{
	new count1 = GetTickCount() + 10800000;
	new
	    rNameFile[64],
	    string[64],
	    count0;

	format(rNameFile, sizeof(rNameFile), "/Race/Index/Index.ini");
	TotalRaces = dini_Int(rNameFile, "TotalRaces");

	for(new x = 0; x < TotalRaces; x++)
	{
	    format(string, sizeof(string), "Race_%i", x), strmid(RaceNames[x], dini_Get(rNameFile, string), 0, 20, sizeof(RaceNames));
	    printf("- Loaded Race: %s", RaceNames[x]);
	    count0++;
	}
	printf("#Races loaded in %i ms Total: %i", (GetTickCount() + 10800000) - count1, count0);
	return 1;
}

public LoadAutoRace(rName[])
{
	new
		rFile[256],
		string[256];

	format(rFile, sizeof(rFile), "/Race/%s.race", rName);
	if(!dini_Exists(rFile)) return printf("Race \"%s\" doesn't exist!", rName);
	strmid(RaceName, rName, 0, strlen(rName), sizeof(RaceName));
	RaceVehicle = dini_Int(rFile, "vModel");
	RaceType = dini_Int(rFile, "rType");
	RaceVirtualWorld = dini_Int(rFile, "rVirtualworld");
	TotalRaceCP = dini_Int(rFile, "TotalRaceCP");

	for(new x = 0; x < RACE_MAX_PLAYERS; x++)
	{
		format(string, sizeof(string), "vPosX_%i", x), RaceVehCoords[x][0] = dini_Float(rFile, string);
		format(string, sizeof(string), "vPosY_%i", x), RaceVehCoords[x][1] = dini_Float(rFile, string);
		format(string, sizeof(string), "vPosZ_%i", x), RaceVehCoords[x][2] = dini_Float(rFile, string);
		format(string, sizeof(string), "vAngle_%i", x), RaceVehCoords[x][3] = dini_Float(rFile, string);
	}

	for(new x = 0; x < TotalRaceCP; x++)
	{
 		format(string, sizeof(string), "CP_%i_PosX", x), CPCoords[x][0] = dini_Float(rFile, string);
 		format(string, sizeof(string), "CP_%i_PosY", x), CPCoords[x][1] = dini_Float(rFile, string);
 		format(string, sizeof(string), "CP_%i_PosZ", x), CPCoords[x][2] = dini_Float(rFile, string);
	}

	rPosition = 0;
	RaceFinishCount = 0;
	RaceJoinCount = 0;
	RaceSpawnCount = 0;

	for(new x = 0; x < 2; x++)
	{
		PlayersCount[x] = 0;
	}

	RaceCountAmount = COUNT_DOWN_TILL_RACE_START;

	RaceTime = MAX_RACE_TIME;

	for(new i = 0; i < MAX_PLAYERS ; i++)
	{
	    RacePosition[i] = 0;
	}
	return 1;
}

public SetCP(playerid, PrevCP, NextCP, MaxCP, Type)
{
	if(Type == 0)
	{
		if(NextCP == MaxCP)
		{
			SetPlayerRaceCheckpoint(playerid, 1, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
		}
		else
		{
			SetPlayerRaceCheckpoint(playerid, 0, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
		}
	}
	else if(Type == 3)
	{
		if(NextCP == MaxCP)
		{
			SetPlayerRaceCheckpoint(playerid, 4, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
		}
		else
		{
			SetPlayerRaceCheckpoint(playerid, 3, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
		}
	}
	return 1;
}
public SetupRaceForPlayer(playerid)
{
	CPProgess[playerid] = 0;
	TogglePlayerControllable(playerid, false);
	CPCoords[playerid][3] = 0;
	SetCP(playerid, CPProgess[playerid], CPProgess[playerid]+1, TotalRaceCP, RaceType);
	SetCameraBehindPlayer(playerid);
	PlayerRaceVehicle[playerid] = CreateVehicle(RaceVehicle, RaceVehCoords[RaceSpawnCount][0], RaceVehCoords[RaceSpawnCount][1], RaceVehCoords[RaceSpawnCount][2]+2, RaceVehCoords[RaceSpawnCount][3], random(126), random(126), (60 * 60));
	SetPlayerPos(playerid, RaceVehCoords[RaceJoinCount][0], RaceVehCoords[RaceSpawnCount][1], RaceVehCoords[RaceSpawnCount][2]+2);
	SetPlayerFacingAngle(playerid, RaceVehCoords[RaceSpawnCount][3]);
	SetPlayerVirtualWorld(playerid, RaceVirtualWorld );

	SetVehicleNumberPlate(PlayerRaceVehicle[playerid], ""red"NGS-Race");
	SetVehicleToRespawn(PlayerRaceVehicle[playerid]);
	SetVehicleVirtualWorld(PlayerRaceVehicle[playerid], RaceVirtualWorld);
	AddVehicleComponent(PlayerRaceVehicle[playerid], 1010);
	RepairVehicle(PlayerRaceVehicle[playerid]);

	PutPlayerInVehicle(playerid, PlayerRaceVehicle[playerid], 0);

	TextDrawHideForPlayer(playerid, TXTKeyInfo);
	PlayerTextDrawHide(playerid, TXTWanteds[playerid]);

	new string[128];

	if(mysql_ping(gSQL))
	{
	    format(string,sizeof(string),"SELECT `name`,`time` FROM `race` WHERE `track` = '%s' ORDER BY `time` ASC LIMIT 5;", RaceName);
		mysql_query(string, THREAD_RACE_TOPLIST, playerid, gSQL);
	}

	RaceJoinCount++;
	RaceSpawnCount++;
	return 1;
}

public CountTillRace()
{
	switch(RaceCountAmount)
	{
 		case 0:
	    {
			for (new i = 0; i < MAX_PLAYERS; i++)
			{
			    if(!IsPlayerConnected(i) || IsPlayerNPC(i)) continue;
			    if(gTeam[i] != RACE)
			    {
			        new
			            string[128];

					format(string, sizeof(string), "» Race %s has been disabled! Now racers joined!", RaceName);
					SendClientMessage(i, RED, string);
				}
			}
			StartRace();
	    }
	    case 1..5:
	    {
	        new
	            string[10];

			format(string, sizeof(string), "~b~%i", RaceCountAmount);
			for (new i = 0; i < MAX_PLAYERS; i++)
			{
			    if(!IsPlayerConnected(i) || IsPlayerNPC(i)) continue;
			    if(gTeam[i] == RACE)
			    {
			    	GameTextForPlayer(i, string, 999, 5);
			    	PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			    }
			}
	    }
	    case 31, 6:
	    {
	        new
	            string[128];

			format(string, sizeof(string), ""green"» %i seconds till \"%s\" named race starts! "grey"[/race]", RaceCountAmount-1, RaceName);
			SendClientMessageToAll(GREEN, string);
	    }
	}
	return RaceCountAmount--;
}

public StartRace()
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerConnected(i) || IsPlayerNPC(i)) continue;
	    if(gTeam[i] == RACE)
	    {
	        TogglePlayerControllable(i, true);
	        PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
  			GameTextForPlayer(i, "~g~GO~w~! ~g~GO~w~! ~g~GO~w~!", 2000, 5);
			SetCameraBehindPlayer(i);
	    }
	}
	LangMSGToAll(GREY, "The current race has been started!", "Das aktuelle Rennen wurde gestartet!");
	trCounter = SetTimer("RaceCounter", 1000, true);
	tRacePosition = SetTimer("Race_calcPosition",751,true);
	RaceTick = GetTickCount() + 10800000;
	RaceStatus = RaceStatus_Active;
	KillTimer(tRaceCount);
	return 1;
}

public StopRace()
{
	KillTimer(trCounter);
	KillTimer(tRacePosition);
	RaceTick = 0;
	RaceJoinCount = 0;
	RaceFinishCount = 0;
	RaceStatus = RaceStatus_Inactive;

	for (new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerConnected(i) || IsPlayerNPC(i)) continue;
	    if(gTeam[i] == RACE)
	    {
	    	DisablePlayerRaceCheckpoint(i);
	    	DestroyVehicle(PlayerRaceVehicle[i]);
			gTeam[i] = NORMAL;
			ResetPlayerWorld(i);
			RandomWeapon(i);
			HidePlayerRaceTextdraws(i);
			CPProgess[i] = 0;
		}
	}
	SetTimer("delayAutoRace",(10*30*1000) + 307 ,false);
	return 1;
}

public delayAutoRace()
{
	new string[128], gstring[128], estring[128];
	strmid(string, RaceNames[random(TotalRaces)], 0, 128, 128);
	LoadAutoRace(string);
	RaceStatus = RaceStatus_StandBy;
	format(gstring, sizeof(gstring), "» New Race "white"%s "yellow"ist nun aktiv. [/race]", string);
	format(estring, sizeof(estring), "» Neues Race "white"%s "yellow"ist nun aktiv. [/race]", string);
	LangMSGToAll(YELLOW, estring, gstring);
	return 1;
}

public RaceCounter()
{
	if(RaceStatus == RaceStatus_Active)
	{
		RaceTime--;
		if(RaceJoinCount <= 0)
		{
			StopRace();
			SendClientMessageToAll(RED, "» Race ended.. No one left in the race!");
		}
	}
	if(RaceTime <= 0)
	{
	    StopRace();
	}
	return 1;
}


public ShowDialog(playerid, dialogid)
{
	switch(dialogid)
	{
		case 599:
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, "Race creating", "Normal Race\nAir Race", "Next", "Exit");
		}
	    case 600:
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, "Build New Race (Step 1/4)", ""white"virtual world:", "Next", "Back");
		}
	    case 601:
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, "Build New Race (Step 1/4)", ""er"Wrong virtualworld (min. 1 - max. 2147483647)\n\nvirtual world:", "Next", "Back");
		}
		case 602:
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, "Build New Race (Step 2/4)", "vehicle id:", "Next", "Back");
		}
		case 603:
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, "Build New Race (Step 2/4)", ""er"Invalid Vehilce ID/Name\nvehicle id:", "Next", "Back");
		}
		case 604:
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, "Build New Race (Step 3/4)", "'KEY_FIRE'", "OK", "Back");
		}
		case 605:
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, "Build New Race (Step 4/4)", "Checkpoints", "OK", "Back");
		}
		case 606:
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, "Build New Race (Done)", "You have created your race and it's ready to use now", "Finish", "Exit");
		}
	}
	return 1;
}

public Race_calcPosition()
{
	new
	    cp,
	    vehicleid,
	    Float:X,
	    Float:Y,
	    Float:Z,
	    Float:distance,
	    c,
		g_RacePosition[12][e_RacePosition];

	for(new i ; i < sizeof(g_RacePosition); i++)
	{
	    g_RacePosition[i][RP_iPlayer] = INVALID_PLAYER_ID;
	    g_RacePosition[i][RP_iValue] = -(i + 1);
	}
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
	        if(gTeam[i] == RACE)
			{
				vehicleid = GetPlayerVehicleID(i);
				GetVehiclePos(vehicleid,X,Y,Z);
				cp = CPProgess[i] + 1;
				distance = GetDistance(X, Y,Z,CPCoords[cp][0] , CPCoords[cp][1],CPCoords[cp][2]);
				if(distance > OFFSET_VALUE)
				{
				    distance = OFFSET_VALUE;
				}
				distance = (OFFSET_VALUE - distance);
	            g_RacePosition[c][RP_iPlayer] = i;
	            g_RacePosition[c][RP_iValue] = (CPProgess[i] * OFFSET_VALUE) + floatround(distance);
	            c++;
	        }
	    }
	}
	SortDeepArray(g_RacePosition, RP_iValue , .order = SORT_DESC);
	for(new i ; i < sizeof(g_RacePosition); i++)
	{
        if(g_RacePosition[i][RP_iPlayer] != INVALID_PLAYER_ID)
		{
            RacePosition[ g_RacePosition[i][RP_iPlayer] ] = i + 1;
		}
	}
	return 1;
}
