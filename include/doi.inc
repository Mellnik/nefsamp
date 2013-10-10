//+-----------------------+
//¦     Double-O-Info     ¦
//¦           by          ¦
//¦    Double-O-Seven     ¦
//+-----------------------+
/*
You may not:
- re-release this
- claim this as your own
- steal this idea
*/


#include <a_samp>

#undef INVALID_TEXT_DRAW
#define INVALID_TEXT_DRAW Text:0xFFFF
#define MAX_INFO_TEXTS 40

new InfoPickup[MAX_PICKUPS];
new PickupInfo[MAX_PICKUPS];
new PlayerInfoText[MAX_PLAYERS];
new Text:PlayerInfoTitle[MAX_PLAYERS];
new InfoCount;
new Text:InfoText[MAX_INFO_TEXTS];

forward AddInfo(info[]);
forward AddInfoPickup(Float:x,Float:y,Float:z,infoid);
forward HidePlayerInfoText(playerid);
forward ShowPlayerInfoText(playerid,infoid);

DOIX_OnPlayerKeyStateChange(playerid,newkeys)
{
    if(newkeys==KEY_SPRINT)
	{
	    if(PlayerInfoText[playerid]>0)
		{
			new infoid=PlayerInfoText[playerid];
	        infoid++;
	        if(infoid>InfoCount)
	            infoid=1;
			ShowPlayerInfoText(playerid,infoid);
		}
	}
	else if(newkeys==KEY_FIRE)
		HidePlayerInfoText(playerid);
}

DOIX_OnPlayerConnect(playerid)
{
    PlayerInfoTitle[playerid]=INVALID_TEXT_DRAW;
	PlayerInfoText[playerid]=0;
}

DOIX_OnPlayerDisconnect(playerid)
{
	HidePlayerInfoText(playerid);
}

DOIX_OnPlayerPickUpPickup(playerid,pickupid)
{
	if(InfoPickup[pickupid])
	    ShowPlayerInfoText(playerid,PickupInfo[pickupid]);
}

stock IsValidInfo(infoid)
{
	if(infoid<1 || infoid>InfoCount)
	    return false;
	return true;
}

public AddInfoPickup(Float:x,Float:y,Float:z,infoid)
{
	new pickupid=CreatePickup(1239,2,x,y,z);
	PickupInfo[pickupid]=infoid;
	InfoPickup[pickupid]=true;
	return pickupid;
}

public AddInfo(info[])
{
	InfoCount++;
	if(InfoCount>=MAX_INFO_TEXTS)
	{
	    print("[info] Max infos reached!");
	    return 0;
	}

	new string[512];
	format(string,sizeof(string),"~n~~n~~n~%s~n~~n~~w~Continue: ~g~~k~~PED_SPRINT~~n~~w~Close: ~r~~k~~PED_FIREWEAPON~",info);
	InfoText[InfoCount]=TextDrawCreate(20,120,string);
	TextDrawFont(InfoText[InfoCount],1);
	TextDrawTextSize(InfoText[InfoCount],200,250);
	TextDrawLetterSize(InfoText[InfoCount],0.3,1.1);
	TextDrawSetProportional(InfoText[InfoCount],true);
	TextDrawUseBox(InfoText[InfoCount],true);
	TextDrawBoxColor(InfoText[InfoCount],0x00000080);
	return InfoCount;
}

public HidePlayerInfoText(playerid)
{
	if(PlayerInfoTitle[playerid]!=INVALID_TEXT_DRAW)
	{
	    TextDrawDestroy(PlayerInfoTitle[playerid]);
        PlayerInfoTitle[playerid]=INVALID_TEXT_DRAW;
	}

	if(PlayerInfoText[playerid]!=0)
	{
		TextDrawHideForPlayer(playerid,InfoText[PlayerInfoText[playerid]]);
	    PlayerInfoText[playerid]=0;
	    return 1;
	}
 	else
	 	return 0;
}

public ShowPlayerInfoText(playerid,infoid)
{
    if(!IsValidInfo(infoid))
        return 0;

	if(PlayerInfoText[playerid]!=0)
	    TextDrawHideForPlayer(playerid,InfoText[PlayerInfoText[playerid]]);

	PlayerInfoText[playerid]=infoid;
    TextDrawShowForPlayer(playerid,InfoText[infoid]);

	new string[16];
    format(string,sizeof(string),"Info %d/%d",infoid,InfoCount);
    if(PlayerInfoTitle[playerid]!=INVALID_TEXT_DRAW)
        TextDrawSetString(PlayerInfoTitle[playerid],string);
	else
	{
	    PlayerInfoTitle[playerid]=TextDrawCreate(60,125,string);
	    TextDrawLetterSize(PlayerInfoTitle[playerid],0.6,1.7);
		TextDrawFont(PlayerInfoTitle[playerid],0);
		TextDrawSetOutline(PlayerInfoTitle[playerid],1);
		TextDrawShowForPlayer(playerid,PlayerInfoTitle[playerid]);
	}
    return infoid;
}
