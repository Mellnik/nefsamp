#include <a_samp>
#include <zcmd>

new gTeam[MAX_PLAYERS];

#define NORMAL 0
#define GUNGAME 1

new const Float:RandPos[][] = {
	{-1291.6622,2513.7566,87.0500,355.3697},
	{-1303.8662,2527.4270,87.5878,358.6714},
	{-1308.1099,2544.3853,87.7422,171.4412},
	{-1321.0725,2526.1138,87.4379,183.3481},
	{-1335.7893,2520.8984,87.0469,270.7455},
	{-1298.5408,2547.2991,87.6747,356.4313},
	{-1291.3345,2533.8853,87.7422,92.7705},
	{-1288.5410,2528.5769,87.6331,183.0114},
	{-1316.3402,2499.9949,87.0420,271.8305}
};

new const Weaps[] = {
	23,
	22,
	27,
	26,
	29,
	32,
	30,
	31,
	38,
	33,
	34,
	35,
	36,
	24
};

enum status
{
	level,
	bool:dead,
	bool:pw, //Primary weapon
}
enum e_GunGame
{
	GG_iPlayer,
	GG_iLevel
}

new GunGame_Player[MAX_PLAYERS][status];

stock GunGame_OnPlayerConnect(playerid)
{
	GunGame_Player[playerid][level] = 0;
	GunGame_Player[playerid][dead] = true;
	GunGame_Player[playerid][pw] = true;
	return 1;
}

COMMAND:gungame(playerid,params[])
{
	if(gTeam[playerid] == GUNGAME )
	{
	    gTeam[playerid] = NORMAL;
	    LangMSG(playerid, RED, "Gungame left", "Gungame verlassen");
	    ResetPlayerWorldBounds(playerid);
	}
	else
	{
	    gTeam[playerid] = GUNGAME;
	    LangMSG(playerid, RED, "Gungame joined", "Gungame teilgenommen");
		GunGame_Player[playerid][level] = 0;
		GunGame_Player[playerid][dead] = true;
		GunGame_Player[playerid][pw] = true;
	}
	SpawnPlayer(playerid);
	return 1;
}

stock GunGame_OnPlayerSpawn(playerid)
{
	if(gTeam[playerid] == GUNGAME)
	{
		new rand = random(9);
		ResetPlayerWeapons(playerid);
		
		SetPlayerPos(playerid, RandPos[rand][0], RandPos[rand][1], RandPos[rand][2]);
		SetPlayerFacingAngle(playerid, RandPos[rand][3]);
		SetPlayerWorldBounds(playerid, -1274.2817, -1358.5095, 2575.6509, 2472.3486);
		SetCameraBehindPlayer(playerid);

		GivePlayerWeapon(playerid, 4, 1);
		GivePlayerWeapon(playerid, Weaps[GunGame_Player[playerid][level]], 65535);

		GunGame_Player[playerid][dead] = false;
		GunGame_Player[playerid][pw] = true;
		SetPlayerHealth(playerid, 20);
		return 1;
	}
	return 0;
}

stock GunGame_OnPlayerDeath(playerid, killerid, reason)
{
	if(gTeam[playerid] == GUNGAME)
	{
		SendDeathMessage(killerid, playerid, reason);
		GunGame_Player[playerid][dead] = true;
		if(killerid == INVALID_PLAYER_ID)
		{
		    SetPlayerCameraPos(playerid, -1251.1089, 2551.7546, 104.6863);
		    SetPlayerCameraLookAt(playerid, -1302.1554, 2533.4226, 93.8427);
		}
		else
		{
			if(reason == 4)
			{
			    GameTextForPlayer(killerid, "~r~Humiliation!~n~~y~Demoted the player by one rank!", 1850, 6);
				GameTextForPlayer(playerid, "~r~Humiliated~n~~y~You got demoted!", 1850, 6);
				if(GunGame_Player[playerid][level] != 0)
				{
					GunGame_Player[playerid][level]--;
				}
			}
		    else
			{
			    GameTextForPlayer(killerid, "~r~Player Killed!~n~~y~Advanced to the next tier!", 1850, 6);
			}
			    GunGame_Player[killerid][level]++;
				SetPlayerScore(killerid, GunGame_Player[killerid][level] + 1);
			    if(GunGame_Player[killerid][level] == 14)
			    {
					new
					    c,
					    g_WinnerName[3][MAX_PLAYER_NAME],
					    g_Data[MAX_PLAYERS][e_GunGame];
					    
					for(new i ; i < MAX_PLAYERS; i++)
					{
				        g_Data[i][GG_iPlayer] = i;
					    if(IsPlayerConnected(i) && gTeam[i] == GUNGAME)
						{
					        g_Data[i][GG_iLevel] = GunGame_Player[i][level];
					    }
					    else
						{
					        g_Data[i][GG_iLevel] = -1;
					    }
					}
					SortDeepArray(g_Data, GG_iLevel , .order = SORT_DESC);
					for(new i ; i < 3 ; i++)
					{
					    if(g_Data[i][GG_iLevel] == -1)
						{
							g_WinnerName[i] = "-INVALID-";
					    }
					    else
						{
					        c++;
						    GetPlayerName( g_Data[i][GG_iPlayer] , g_WinnerName[i] , MAX_PLAYER_NAME );
					    }
					}
			        for(new i; i < MAX_PLAYERS; i++)
			        {
					    if(IsPlayerConnected(i) && gTeam[i] == GUNGAME)
						{
							ResetPlayerWorldBounds(i);
							GunGame_Player[i][dead] = false;
							GunGame_Player[i][level] = 0;
							ResetPlayerWeapons(i);
							SpawnPlayer(i);
						}
					}
					new string[144];
					format(string, sizeof string, "~r~The match ended!~n~~g~1. %02i - %s~n~~y~2. %02i - %s~n~~r~~h~3. %02i - %s", g_Data[0][GG_iLevel], g_WinnerName[0], g_Data[1][GG_iLevel], g_WinnerName[1], g_Data[2][GG_iLevel], g_WinnerName[2]);
			        for(new i; i < MAX_PLAYERS; i++)
			        {
						GameTextForPlayer(i,string, 4500, 3);

			        }
	    	    }
		        else
				{
				    ResetPlayerWeapons(killerid);
				    GivePlayerWeapon(killerid, 4, 1);
					GivePlayerWeapon(killerid, Weaps[GunGame_Player[killerid][level]], 65535);
				}
		}
		return 1;
	}
	return 0;
}

stock GunGame_OnPlayerUpdate(playerid)
{
	if(gTeam[playerid] == GUNGAME)
	{
		if(GunGame_Player[playerid][dead] == false)
		{
			if(!GetPlayerWeapon(playerid))
			{
				if(GunGame_Player[playerid][pw] == true)
				{
					SetPlayerArmedWeapon(playerid, 4);
					GunGame_Player[playerid][pw] = false;
				}
					else
				{
				    SetPlayerArmedWeapon(playerid, Weaps[GunGame_Player[playerid][level]]);
					GunGame_Player[playerid][pw] = true;
				}
			}
			else GunGame_Player[playerid][pw] = GetPlayerWeapon(playerid) == 4 ? false : true;

		}
	}
	return 1;
}

stock ResetPlayerWorldBounds(playerid)
{
	#define FLOAT_INFINITY (Float:0x7F800000)
	SetPlayerWorldBounds(playerid,FLOAT_INFINITY,-FLOAT_INFINITY,FLOAT_INFINITY,-FLOAT_INFINITY);
	return 1;
}

