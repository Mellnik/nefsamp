/* BlackFoX's Anti Money Hack Version 1.0
   Anti Money Cheat, Reset Money fast and Easy*/
#include <a_samp>
#if defined _bfx_money_included
	#endinput
#endif
#define _bfx_money_included
#pragma library bfx_money

#pragma tabsize 4
forward EnableAntiMoneyHack();
enum PlayerMoney
{
	Money,
}
new PlayerCapital[MAX_PLAYERS][PlayerMoney];
/*
native bGetPlayerMoney(playerid);
native bGivePlayerMoney(playerid, Moneys);
native bResetPlayerMoney(playerid);
native bMoney_check();
native EnableAntiMoneyHack();
native bSetPlayerMoney(playerid,Moneys);
*/
/* Set Player Money Function with Anti Hack */
stock bSetPlayerMoney(playerid,Moneys)
{
new aPlayer[256];
PlayerCapital[playerid][Money] = Moneys;
new GeT2 = GetPlayerMoney(playerid);
GivePlayerMoney(playerid,-GeT2);
GivePlayerMoney(playerid,PlayerCapital[playerid][Money]);
GetPlayerName(playerid,aPlayer,sizeof(aPlayer));
printf("[BFX - ANTI MONEY HACK]: Sets The Money for Player %s to %d$",aPlayer,Moneys);
return PlayerCapital[playerid][Money];
}
/* Give Player Money Function , Anti Hack */
stock bGivePlayerMoney(playerid,Moneys)
{
new bPlayer[256];
PlayerCapital[playerid][Money]+=Moneys;
GivePlayerMoney(playerid,Moneys);
GetPlayerName(playerid,bPlayer,sizeof(bPlayer));
printf("[BFX - ANTI MONEY HACK]: Give Player %s a Value of %d$",bPlayer,Moneys);
return 0;
}
stock bResetPlayerMoney(playerid)
{
new cPlayer[256];
new GeT3 = GetPlayerMoney(playerid);
GivePlayerMoney(playerid,-GeT3);
GivePlayerMoney(playerid,PlayerCapital[playerid][Money]);
PlayerCapital[playerid][Money] = 0;
GetPlayerName(playerid,cPlayer,sizeof(cPlayer));
printf("[BFX - ANTI MONEY HACK]: Reset Money of Player %s",cPlayer);
return 0;
}
public EnableAntiMoneyHack()
{
SetTimer("bMoney_check",100,1);
}
stock bMoney_check()
{
for(new i = 0; i <= MAX_PLAYERS; i++)
{
if(IsPlayerConnected(i))
{
new dPlayer[256];
if(GetPlayerMoney(i) > PlayerCapital[i][Money] || GetPlayerMoney(i) < PlayerCapital[i][Money])
{
new GeT = GetPlayerMoney(i);
GivePlayerMoney(i,-GeT);
GivePlayerMoney(i,PlayerCapital[i][Money]);
GetPlayerName(i,dPlayer,sizeof(dPlayer));
printf("[BFX - ANTI MONEY HACK]: The Player has Hacked Money %s , Reset!",dPlayer);
}
}
}
return 0;
}
stock bGetPlayerMoney(playerid)
{
return PlayerCapital[playerid][Money];
}
