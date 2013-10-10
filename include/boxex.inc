/*
* Extrrme Box INC
* FNC: CreateBox(playerid,header[],text[])
* Verzija: 1.0
* Credits: ExtremePower, Y_Less ( foreach )
* Za: Balkan-samp.com
*/

#if defined _Box_included
  #endinput
#endif
#define _Box_included
#pragma library Box
#include <foreach>

forward textdrawiskljucise(playerid);

static
       bool:fnc[2] = false;
new
Text:Header[MAX_PLAYERS],
Text:Text[MAX_PLAYERS];

public OnPlayerConnect(playerid)
{
     if(fnc[0]) CallLocalFunction("Box_OnPlayerConnect", "i", playerid);
	 Header[playerid] = TextDrawCreate(28.000000, 125.000000, "Sunset City");
	 TextDrawBackgroundColor(Header[playerid], 255);
	 TextDrawFont(Header[playerid], 2);
	 TextDrawLetterSize(Header[playerid], 0.430000, 1.999998);
	 TextDrawColor(Header[playerid], -1);
	 TextDrawSetOutline(Header[playerid], 0);
	 TextDrawSetProportional(Header[playerid], 1);
	 TextDrawSetShadow(Header[playerid], 1);
	 TextDrawUseBox(Header[playerid], 1);
	 TextDrawBoxColor(Header[playerid], 13132900);
	 TextDrawTextSize(Header[playerid], 182.000000, -29.000000);

	 Text[playerid] = TextDrawCreate(28.000000, 147.000000, "Du kannst dieses Fahrzeug mit /rentveh mieten");
	 TextDrawBackgroundColor(Text[playerid], 255);
	 TextDrawFont(Text[playerid], 2);
	 TextDrawLetterSize(Text[playerid], 0.280000, 1.100000);
	 TextDrawColor(Text[playerid], -1);
	 TextDrawSetOutline(Text[playerid], 0);
	 TextDrawSetProportional(Text[playerid], 1);
	 TextDrawSetShadow(Text[playerid], 1);
	 TextDrawUseBox(Text[playerid], 1);
	 TextDrawBoxColor(Text[playerid], 100);
	 TextDrawTextSize(Text[playerid], 182.000000, 21.000000);
	 return 1;
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Box_OnPlayerConnect
forward Box_OnPlayerConnect(playerid);

stock CreateBox(playerid,header[],text[])
{
	new
	string[128];
	format(string, sizeof string,"%s",header);
	TextDrawSetString(Text:Header[playerid],string);
	TextDrawShowForPlayer(playerid,Text:Header[playerid]);
	// Text
	format(string, sizeof string,"%s",text);
	TextDrawSetString(Text:Text[playerid],string);
	TextDrawShowForPlayer(playerid,Text:Text[playerid]);
	SetPVarInt(playerid,"CreateBoxEx",1);
	SetTimerEx("textdrawiskljucise", 5000, 0, "i", playerid);
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
     if(fnc[0]) CallLocalFunction("Box_OnPlayerKeyStateChange", "i", playerid);
     if(newkeys & KEY_FIRE)
     {
	    if(GetPVarInt(playerid,"CreateBoxEx") == 1)
	    {
          TextDrawHideForPlayer(playerid,Text:Text[playerid]);
          TextDrawHideForPlayer(playerid,Text:Header[playerid]);
		  SetPVarInt(playerid,"CreateBoxEx",0);
	    }
	 }
	 return 1;
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange Box_OnPlayerKeyStateChange
forward Box_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);

public OnGameModeInit()
{
	fnc[0] = (funcidx("Box_OnPlayerConnect") != -1);
	fnc[1] = (funcidx("Box_OnPlayerKeyStateChange") != -1);
	CallLocalFunction("Box_OnGameModeInit", "");
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit Box_OnGameModeInit

forward Box_OnGameModeInit();

public textdrawiskljucise(playerid)
{
		TextDrawHideForPlayer(playerid,Text:Text[playerid]);
        TextDrawHideForPlayer(playerid,Text:Header[playerid]);
        return 1;
}