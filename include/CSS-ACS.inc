#include <a_samp>

/*
|+++++++++++++++++++++++++++++++++++++++++++++++++++++|
|++++++++++++++ M-AntiCheat by Maercell ++++++++++++++|
|+++++++++++++++++++++++ v1.0 ++++++++++++++++++++++++|
|+++++++++++++++++++++++++++++++++++++++++++++++++++++|

Natives

EnableMAntiCheat(); // In OnGameModeInit/OnFilterScriptInit Einfügen
OnMPlayerSpawn(playerid); // In OnPlayerSpawn Einfügen
OnMPlayerConnect(playerid); // In OnPlayerConnect Einfügen
OnMPlayerDeath(playerid); // In OnPlayerDeath Einfügen
native GetMMoney(playerid);
native ResetMMoney(playerid);
native GiveMMoney(playerid,summe);
native SetMMoney(playerid,summe);
native GetMHealth(playerid);
native SetMHealth(playerid,Float:health);
native GiveMHealth(playerid,Float:health);
native GetMArmour(playerid);
native SetMArmour(playerid,Float:armour);
native GiveMArmour(playerid,Float:armour);

*/



forward CheatCheck();

#define MAX_DIF 4999
#define SPAWN_HEALTH 100.0
#define SPAWN_ARMOUR 0.0
#define CONNECT_MONEY 5000

new BanWeaponIDs[] = {
36,
37,
38,
39,
40,
43,
44,
45
};

new PMoney[MAX_PLAYERS],
    Float:PHealth[MAX_PLAYERS],
    Float:GettedHealth,
    Float:PArmour[MAX_PLAYERS],
    Float:GettedArmour,
    bool:IsPlayerSpawned[MAX_PLAYERS];


EnableMAntiCheat()
{
	SetTimer("CheatCheck",2000,1);
}

OnMPlayerSpawn(playerid)
{
	IsPlayerSpawned[playerid] = true;
	SetMHealth(playerid,SPAWN_HEALTH);
	SetMArmour(playerid,SPAWN_ARMOUR);
}

OnMPlayerConnect(playerid)
{
	IsPlayerSpawned[playerid] = false;
	SetMMoney(playerid,CONNECT_MONEY);
}

OnMPlayerDeath(playerid)
{
	IsPlayerSpawned[playerid] = false;
}


stock GetMMoney(playerid)
{
	return PMoney[playerid];
}

stock ResetMMoney(playerid)
{
	PMoney[playerid] = 0;
	ResetPlayerMoney(playerid);
}

stock GiveMMoney(playerid,summe)
{
	PMoney[playerid] += summe;
	GivePlayerMoney(playerid,summe);
}

stock SetMMoney(playerid,summe)
{
	ResetMMoney(playerid);
	GiveMMoney(playerid,summe);
}

stock SetMHealth(playerid,Float:health)
{
	PHealth[playerid] = health;
	SetPlayerHealth(playerid,health);
}

stock GiveMHealth(playerid,Float:health)
{
	PHealth[playerid] += health;
	GetPlayerHealth(playerid,GettedHealth);
	SetPlayerHealth(playerid,GettedHealth + health);
}

stock SetMArmour(playerid,Float:armour)
{
	PArmour[playerid] = armour;
	SetPlayerArmour(playerid,armour);
}

stock GiveMArmour(playerid,Float:armour)
{
	PArmour[playerid] += health;
	GetPlayerArmour(playerid,GettedArmour);
	SetPlayerArmour(playerid,GettedArmour + armour);
}


public CheatCheck()
{
	for(new playerid=0; playerid<GetMaxPlayers(); playerid++)
	if(IsPlayerConnected(playerid))
	{
		new admstring[128], cheatername[MAX_PLAYER_NAME];
		GetPlayerName(playerid,cheatername,sizeof(cheatername));
		GetPlayerHealth(playerid,GettedHealth);
		GetPlayerArmour(playerid,GettedArmour);	

		if(GetPlayerMoney(playerid)-PMoney[playerid] > MAX_DIF)
		{
			format(admstring,sizeof(admstring)," [AntiCheat] %s ist unter Moneyhackverdacht! ",cheatername);
			SendCheaterWarning(0xFF0000FF,admstring);
			SetMMoney(playerid,PMoney[playerid]);
		}
		else if(GetPlayerMoney(playerid)-PMoney[playerid] <= MAX_DIF)
		{
			SetMMoney(playerid,GetPlayerMoney(playerid));
		}
		if(IsPlayerSpawned[playerid] == true)
		{
			if(GettedHealth > PHealth[playerid])
			{
				format(admstring,sizeof(admstring)," [AntiCheat] %s ist unter Healthcheatverdacht! ",cheatername);
				SendCheaterWarning(0xFF0000FF,admstring);
				SetMHealth(playerid,PHealth[playerid]);
			}	
			if(GettedArmour > PArmour[playerid])
			{
				format(admstring,sizeof(admstring)," [AntiCheat] %s ist unter Armourcheatverdacht! ",cheatername);
				SendCheaterWarning(0xFF0000FF,admstring);
				SetMArmour(playerid,PArmour[playerid]);
			}
		}
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
		{
			format(admstring,sizeof(admstring)," [AntiCheat] %s was banned (Jetpack) ",cheatername);
			SendClientMessageToAll(0xFF0000FF,admstring);
			BanEx(playerid,"Jetpack");
		}
		for(new w=0; w<sizeof(BanWeaponIDs); w++)
		{
			new weapon, ammo;
			GetPlayerWeaponData(playerid,GetWeaponSlot(BanWeaponIDs[w]),weapon,ammo);
			if(weapon == BanWeaponIDs[w] && ammo > 0)
			{
				format(admstring,sizeof(admstring)," [AntiCheat] %s was banned! (Weaponhack) ",cheatername);
				SendClientMessageToAll(0xFF0000FF,admstring);
				BanEx(playerid,"Waffenhack");
			}
		}
	}	
	return 1;
}

stock SendCheaterWarning(color,const warning[])
{
	for(new i=0; i<GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i) && IsAnAdmin(i))
		{
			SendClientMessage(i,color,warning);
		}
	}
}


stock GetWeaponSlot(wid) // Dank an [NSG]roschti für die Funktion
{
    new id;
    switch(wid)
    {
        case 0,1: id=0;
        case 2,3,4,5,6,7,8,9: id=1;
        case 22,23,24: id=2;
        case 25,26,27: id=3;
        case 28,29,32: id=4;
        case 30,31: id=5;
        case 33,34: id=6;
        case 35,36,37,38: id=7;
        case 16,17,18,19,39: id=8;
        case 41,42,43: id=9;
        case 10,11,12,13,14,15: id=10;
        case 44,45,46: id=11;
        case 40: id=12;
        case 20,21,47,49,50,53,54: id=(-1);
        default: id=(-1);
    }
    return id;
}
