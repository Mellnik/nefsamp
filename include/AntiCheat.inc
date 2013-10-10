#include <a_samp>

new PMoney[MAX_PLAYERS];
new Float:PHealth[MAX_PLAYERS];
new Float:GettedHealth;

forward CheatCheck();

OnACSInit()
{
	SetTimer("CheatCheck",250,1);
	print("  -----------------------------------------------------");
	print("    Maercells AntiHack wurde erfolgreich geladen!");
	print("  -----------------------------------------------------");
	for(new i=0; i<MAX_PLAYERS; i++) ResetMMoney(i);
	EnableStuntBonusForAll(false); //sonst würde man bei Stuntbonus gebannt werden...
}

OnACSPlayerSpawn(playerid)
{
	SetMHealth(playerid,100.0);
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


public CheatCheck()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		GetPlayerHealth(i,GettedHealth);

		if(IsPlayerConnected(i) && GetPlayerMoney(i) > PMoney[i])
		{
			SetMMoney(i,PMoney[i]);
			
			/*new meldung[128];
			new cheatername[MAX_PLAYER_NAME];
			GetPlayerName(i,cheatername,sizeof cheatername);
			format(meldung,sizeof meldung,"[BANN] %s wurde wegen Moneyhack gebannt!",cheatername);
			SendClientMessageToAll(0xFF0000FF,meldung);
			print(meldung);
			Ban(i);*/
		}
		if(IsPlayerConnected(i) && GettedHealth > PHealth[i])
		{
			SetMHealth(i,PHealth[i]);
		}
	}
	return 1;
}
