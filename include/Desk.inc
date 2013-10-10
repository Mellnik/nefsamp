/*
					Desktop Check by RFT
					(C) 2010
					Version 0.1

native IsPlayerOnDesktop(playerid)
native GetPlayerDesktopTime(playerid);
*/



#include <a_samp>

forward Desk_SecondTimer();
forward Desk_OnPlayerUpdate(playerid);
forward Desk_OnGameModeInit();




public Desk_OnGameModeInit()
{
	SetTimer("Desk_SecondTimer", 1000, true);
	return true;
}

#define Desk_OnGameModeInit OnGameModeInit



public Desk_OnPlayerUpdate(playerid)
{
	SetPVarInt(playerid, "DeskCheck", 1);
	return true;
}
#define Desk_OnPlayerUpdate OnPlayerUpdate

public Desk_SecondTimer()
{
	for(new i = 0; i < MAX_PLAYERS; i ++)
	{
	    if(!IsPlayerConnected(i))continue;
	    if(GetPVarInt(i, "DeskCheck") == 1)
		{
			SetPVarInt(i, "DeskCheck", 0);
	        SetPVarInt(i, "AFKTime", 0);
			return true;
		}
	    if(GetPVarInt(i, "DeskCheck") == 0)
	    {
	        SetPVarInt(i, "AFKTime", GetPVarInt(i, "AFKTime")+1);
		}
	}
	return true;
}

stock IsPlayerOnDesktop(playerid)
{
	if(GetPVarInt(playerid, "DeskCheck") == 0)return true;
	return false;
}

stock GetPlayerDesktopTime(playerid)
{
	return GetPVarInt(playerid, "AFKTime");
}