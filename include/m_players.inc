/* Sa-Mp Include m_players
 *
 * (c) by Kaliber, 2013
 *
 */
#include <a_samp>
#if defined mx_players
	#endinput
#endif
#define mx_players
new HighestID;
#define m_players 0
forward _OnPlayerConnect(playerid);
forward _OnPlayerDisconnect(playerid,reason);
public OnPlayerConnect(playerid) {
	if(playerid != HighestID) return CallLocalFunction("_OnPlayerConnect", "i", playerid);
	HighestID++;
	#undef m_players
	#define m_players HighestID
	return CallLocalFunction("_OnPlayerConenct", "i", playerid);
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect _OnPlayerConnect
public OnPlayerDisconnect(playerid,reason) {
	if(playerid != HighestID-1) return CallLocalFunction("_OnPlayerDisconnect", "ii", playerid, reason);
	new count,i;
	for(; i<MAX_PLAYERS; i++) if(IsPlayerConnected(i)) count=i;
	HighestID = (count+1);
	#undef m_players
	#define m_players HighestID
	return CallLocalFunction("_OnPlayerDisconnect", "ii", playerid, reason);
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect _OnPlayerDisconnect
