//nMIStream by NaS (c) 2008
#if defined nMIStream_LOADED
	#endinput
#endif

#define nMIStream_LOADED

#if defined P_REACH
#else
	#define P_REACH  200.0  //Reach of the player to the Map Icons to be shown
#endif

#if defined MAX_S_ICONS
#else
	#define MAX_S_ICONS  500 //Maximum stream icons
#endif

#if defined TIMER_INTERVAL
#else
	#define TIMER_INTERVAL  500 //Maximum stream icons
#endif

forward UpdateIcons();
enum eMapIcons
{
	bool:iconexist,
	Float:icX,
	Float:icY,
	Float:icZ,
	iconmarkertype,
};
new nIcons[MAX_PLAYERS][MAX_S_ICONS][eMapIcons];
nIconsInit()
{
	SetTimer("UpdateIcons",TIMER_INTERVAL,1);
	return 1;
}
public UpdateIcons()
{
	for(new playerid=0;playerid < MAX_PLAYERS;playerid++)
	{
		if(!IsPlayerConnected(playerid)) continue;
		new Float:X,Float:Y,Float:Z;
		GetPlayerPos(playerid,X,Y,Z);
		for(new i=0; i <=31;i++)
		{
			RemovePlayerMapIcon(playerid,i);
		}
		new iid;
		for(new icon=0;icon < MAX_S_ICONS; icon++)
		{
			if(nIcons[playerid][icon][iconexist]==true)
			{
				if(IsInReach(X,Y,Z,nIcons[playerid][icon][icX],nIcons[playerid][icon][icY],nIcons[playerid][icon][icZ],P_REACH) && iid<= 31)
				{
					SetPlayerMapIcon(playerid,iid,nIcons[playerid][icon][icX],nIcons[playerid][icon][icY],nIcons[playerid][icon][icZ],nIcons[playerid][icon][iconmarkertype],0);
					iid++;
				}
			}
		}
	}
}
nIconAddForPlayer(playerid,Float:x,Float:y,Float:z,markertype)
{
	new ID;
	while (ID < MAX_S_ICONS)
	{
		if(nIcons[playerid][ID][iconexist]==false)
		{
			nIcons[playerid][ID][icX]=x;
			nIcons[playerid][ID][icY]=y;
			nIcons[playerid][ID][icZ]=z;
			nIcons[playerid][ID][iconmarkertype]=markertype;
			nIcons[playerid][ID][iconexist]=true;
			break;
		}
		ID++;
	}
	return ID;
}
/*nIconAddForAll(Float:x,Float:y,Float:z,markertype)
{
	new idss[MAX_PLAYERS];
	for(new i; i < MAX_PLAYERS; i++)
	{
		idss[i]=nIconAddForPlayer(i,x,y,z,markertype);
	}
	return idss;
}*/
nIconDestroy(playerid,ID)
{
	nIcons[playerid][ID][iconexist]=false;
}

stock IsInReach(Float:x,Float:y,Float:z,Float:x2,Float:y2,Float:z2,Float:dist)
{
	x = (x > x2) ? x - x2 : x2 - x;
	if(x > dist) return false;
	y = (y > y2) ? y - y2 : y2 - y;
	if(y > dist) return false;
	z = (z > z2) ? z - z2 : z2 - z;
	if(z > dist) return false;
	return true;
}