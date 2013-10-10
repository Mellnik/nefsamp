/* 
 *  SA-MP Audio Message Hidesystem
 *  © 2011-2012 by BlackAce
 *
 *  Version: 1.5
 *
 *  Diese Include wurde von BlackAce gecodet.
 *  Die Entfernung der Credits werden mit einem schlechten Gewissen bestraft
 *
 *  Installation für RP Scripts:
 *  Folgendes sollte ihr in eurem Script haben	
 *
 *	
 *
 *
 *	Changelog:
 *
 *	1.0 
 *		- Erster Release
 *
 *	1.1 
 *		- LocalColor funktion entfernt - wird nicht mehr benötigt
 *
 *	1.2 
 *		- Problem gelöst das Auftrat, wenn man OnPlayerText in Script in Verbindung mit Local im GameMode hatte
 *		- auf 0.3e angepasst die Clientversion wird nun detected
 *
 *	1.2.1
 *		- Die Farbe beim Connecten auf einen 0.3e Server wurde angepasst -
 *					ist nun die richtige Farbe, der Fehler trat auf wenn man bereits einen Stream in OnPlayerConnect laufen hatte
 *
 *	1.5
 *		- Fehlerkorrektur in OnPlayerText - Danke dafür an 946Ben
 *					Wenn OnPlayerText Verwendet wurde konnte es durch das Update auf 1.2 passieren das Texte einfach verschwanden
 *		- Fehlerkorrektur in SendClientMessage 
 *					Es konnte manchmal die Message nicht vollständig versendet werden
 *		- Stabilitätsupdate
 *					Wenn in OnPlayerRequestClass PlayAudioStreamForPlayer aufgerufen wurde kam es manchmal zum Crash des Servers
 *
 *	1.5.1
 *
 *		- Fehlerkorrektur für die SA:MP Version 0.3e
 *					unter anderem ein Semikolon vergessen
 *
 *
 *
 *
 *		WICHTIG!
 *		Wenn ihr 0.3e benutzt, dann schreibt vor dem includieren Include #define v03e
 *
 *		Beispiel:
 *
 *		#define v03e
 *		#include <AudioHide>
 *
 *
 */

   
#undef MAX_PLAYERS
#define MAX_PLAYERS 500 // Bitte auf die Serverslot Zahl achten

#define MAX_CHAT_LINES 99 // Am besten so lassen ;)

#define SERVERIP "193.34.144.205" // Hier bitte die IP des Server eintragen. Ohne Port!

native _SendClientMessage(playerid, Color, const string[]) = SendClientMessage;
native _SendClientMessageToAll(Color, const string[]) = SendClientMessageToAll;
native _PlayAudioStreamForPlayer(playerid, url[], Float:posX=0.0,Float:posY=0.0,Float:posZ=0.0,Float:distance=50.0,usepos=0)= PlayAudioStreamForPlayer;

#define SendClientMessage __SendClientMessage
#define SendClientMessageToAll __SendClientMessageToAll
#define PlayAudioStreamForPlayer __PlayAudioStreamForPlayer

enum _ch { _inhalt[128], _color }
new _Chat[MAX_PLAYERS][MAX_CHAT_LINES][_ch];
new bool:sended[MAX_PLAYERS];
forward __OnPlayerConnect(playerid);
public OnPlayerConnect(playerid)
{
	for(new i;i!=MAX_CHAT_LINES;i++) strdel(_Chat[playerid][i][_inhalt],0,128),_Chat[playerid][i][_color]=-1;
	SetPlayerColor(playerid,-1);
	sended{playerid}=false;
	#if defined v03e
	new v[10];
	GetPlayerVersion(playerid,v,10);
	format(_Chat[playerid][MAX_CHAT_LINES-4][_inhalt],128,"SA-MP {B9B9BF}%s {FFFFFF}Started",v);
	#else
	format(_Chat[playerid][MAX_CHAT_LINES-4][_inhalt],128,"SA-MP {EE5555}0.3d {FFFFFF}Started");
	#endif
	_Chat[playerid][MAX_CHAT_LINES-4][_color]=-1;
	format(_Chat[playerid][MAX_CHAT_LINES-3][_inhalt],128,"Connecting to "SERVERIP":%d...",(GetServerVarAsInt("port"))?GetServerVarAsInt("port"):8192);
	_Chat[playerid][MAX_CHAT_LINES-3][_color]=0xA9C4E4FF;
	format(_Chat[playerid][MAX_CHAT_LINES-2][_inhalt],128,"Connected. Joining the game...");
	_Chat[playerid][MAX_CHAT_LINES-2][_color]=0xA9C4E4FF;
	CallLocalFunction("__OnPlayerConnect","d",playerid);
	return true;
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect __OnPlayerConnect
forward __OnPlayerRequestClass(playerid, classid);
public OnPlayerRequestClass(playerid, classid)
{
	if(!sended[playerid])
	{
		if(_Chat[playerid][MAX_CHAT_LINES-1][_inhalt][0])
		{
			for(new i=1;i!=MAX_CHAT_LINES;i++) if(_Chat[playerid][i][_inhalt][0]) format(_Chat[playerid][i-1][_inhalt],128,_Chat[playerid][i][_inhalt]),_Chat[playerid][i-1][_color]=_Chat[playerid][i][_color];
		}
		GetServerVarAsString("hostname",_Chat[playerid][MAX_CHAT_LINES-1][_inhalt],128);
		#if defined v03e
		format(_Chat[playerid][MAX_CHAT_LINES-1][_inhalt],128,"Connected to {B9B9BF}%s",_Chat[playerid][MAX_CHAT_LINES-1][_inhalt]);
		#else
		format(_Chat[playerid][MAX_CHAT_LINES-1][_inhalt],128,"Connected to {EE5555}%s",_Chat[playerid][MAX_CHAT_LINES-1][_inhalt]);
		#endif
		_Chat[playerid][MAX_CHAT_LINES-1][_color]=0xA9C4E4FF;
		sended[playerid]=true;
	}
	CallLocalFunction("__OnPlayerRequestClass","ii",playerid,classid);
	return true;
}
#if defined _ALS_OnPlayerRequestClass
	#undef __OnPlayerRequestClass
#else
	#define _ALS_OnPlayerRequestClass
#endif
#define OnPlayerRequestClass __OnPlayerRequestClass
stock __SendClientMessage(playerid, Color, const string[])
{	
	for(new i=1;i!=MAX_CHAT_LINES;i++) 
	{
		format(_Chat[playerid][i-1][_inhalt],128,_Chat[playerid][i][_inhalt]);
		_Chat[playerid][i-1][_color]=_Chat[playerid][i][_color];
	}
	format(_Chat[playerid][MAX_CHAT_LINES-1][_inhalt],128,string);
	_Chat[playerid][MAX_CHAT_LINES-1][_color]=Color;
	_SendClientMessage(playerid, Color, string);
	return true;
}

stock __SendClientMessageToAll(Color, const string[])
{	
	new playerid,j;
	for(;playerid!=MAX_PLAYERS;playerid++)
	{
		if(!IsPlayerConnected(playerid)) continue;
		for(j=1;j!=MAX_CHAT_LINES;j++)
		{
			format(_Chat[playerid][j-1][_inhalt],128,_Chat[playerid][j][_inhalt]);
			_Chat[playerid][j-1][_color]=_Chat[playerid][j][_color];
		}
		format(_Chat[playerid][MAX_CHAT_LINES-1],128,string);
		_Chat[playerid][MAX_CHAT_LINES-1][_color]=Color;
	}
	_SendClientMessageToAll(Color, string);
	return true;
}
forward __OnPlayerText(playerid, text[]);
public OnPlayerText(playerid, text[])
{
	if(funcidx("Local")!=-1) if(CallLocalFunction("Local","")) return false;
	for(new j=1;j!=MAX_CHAT_LINES;j++)
	{
		format(_Chat[playerid][j-1][_inhalt],128,_Chat[playerid][j][_inhalt]);
		_Chat[playerid][j-1][_color]=_Chat[playerid][j][_color];
	}
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	format(_Chat[playerid][MAX_CHAT_LINES-1][_inhalt],128,"%s: {FFFFFF}%s",name,text);
	_Chat[playerid][MAX_CHAT_LINES-1][_color]=GetPlayerColor(playerid);
	CallLocalFunction("__OnPlayerText","ds",playerid,text);
	return true;
}
#if defined _ALS_OnPlayerText
	#undef OnPlayerText
#else
	#define _ALS_OnPlayerText
#endif
#define OnPlayerText __OnPlayerText

stock __PlayAudioStreamForPlayer(playerid, url[], Float:posX=0.0,Float:posY=0.0,Float:posZ=0.0,Float:distance=50.0,usepos=0)
{
	_PlayAudioStreamForPlayer(playerid, url, posX,posY,posZ,distance,usepos);
	for(new i;i!=MAX_CHAT_LINES-1;i++) _SendClientMessage(playerid,_Chat[playerid][i][_color],_Chat[playerid][i][_inhalt]);
	return true;
}