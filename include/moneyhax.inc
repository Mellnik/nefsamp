#if defined FILTERSCRIPT
	#endinput
#endif

#if defined _moneyhax_included
	#endinput
#endif
#define _moneyhax_included

#define CHECK_TIME 30 // in seconds to check if money is equal to the saved one.

new PMoney[MAX_PLAYERS];

forward GetPlayerMonez(playerid);
forward ResetPlayerMonez(playerid);
forward GivePlayerMonez(playerid,money);
forward MoneyCheck();

public MoneyCheck()
{
	new money;
	#if defined _foreach_included
	foreach(Player,playerid)
	{
		money = GetPlayerMoney(playerid);
		if( money < PMoney[playerid] && money > -1 ) PMoney[playerid]=money;
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid,PMoney[playerid]);
	}
	#else
	for(new playerid;playerid<MAX_PLAYERS;playerid++) if(IsPlayerConnected(playerid))
	{
		money = GetPlayerMoney(playerid);
		if( money < PMoney[playerid] && money > -1 ) PMoney[playerid]=money;
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid,PMoney[playerid]);

	}
	#endif

	return 1;
}

public GivePlayerMonez(playerid, money)
{
	new rmoney = GetPlayerMoney(playerid);
	if( rmoney < PMoney[playerid] && rmoney > -1 ) PMoney[playerid]=rmoney;

	PMoney[playerid]+=money;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,PMoney[playerid]);
	return 1;
}
public ResetPlayerMonez(playerid)
{
	ResetPlayerMoney(playerid);
	PMoney[playerid]=0;
	return 1;
}
public GetPlayerMonez(playerid) return PMoney[playerid];


#define GivePlayerMoney GivePlayerMonez
#define GetPlayerMoney GetPlayerMonez
#define ResetPlayerMoney ResetPlayerMonez




public OnGameModeInit()
{
	SetTimer("MoneyCheck",CHECK_TIME*1000,true);
	if (funcidx("moneyhax_OnGameModeInit") != -1)
	{
		return CallLocalFunction("moneyhax_OnGameModeInit", "");
	}
	return 1;
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit moneyhax_OnGameModeInit
forward moneyhax_OnGameModeInit();

public OnPlayerConnect(playerid)
{
	PMoney[playerid]=0;
	if (funcidx("moneyhax_OnPlayerConnect") != -1)
	{
		return CallLocalFunction("moneyhax_OnPlayerConnect", "i", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect moneyhax_OnPlayerConnect
forward moneyhax_OnPlayerConnect(playerid);