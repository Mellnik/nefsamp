/*==============================*/
/*=======DOUBLE-O-ICONS=========*/
/*=======by Double-O-Seven======*/
/*==============================*/
/*You are not allowed to edit and release this include without my permission.
  You are only allowed to edit for yourself. ...and don't remove my credits.
*/

#include <a_samp>

#define MAX_ICONS 500
#define MAX_SLOTS 32
#define INVALID_SLOT -1
#define INVALID_ICON_ID -1
#undef MAX_PLAYERS
#define MAX_PLAYERS 50
#define DISTANCE 400

new SlotIconID[MAX_PLAYERS][MAX_SLOTS];

new Float:IconPos[MAX_ICONS][3];
new IconModel[MAX_ICONS];
new IconColor[MAX_ICONS];
new IconActive[MAX_ICONS];
new IconSlot[MAX_PLAYERS][MAX_ICONS];

forward InitMapIconStreaming();
public InitMapIconStreaming()
{
 	for(new i=0;i<MAX_PLAYERS;i++)
 	{
	    for(new j=0;j<MAX_SLOTS;j++)
	        SlotIconID[i][j]=INVALID_ICON_ID;
	        
		for(new j=0;j<MAX_ICONS;j++)
	        IconSlot[i][j]=INVALID_SLOT;
	}
	
	SetTimer("MapIconUpdate",2000,1);
	return 1;
}

forward CreateMapIcon(modelid,color,Float:x,Float:y,Float:z);
public CreateMapIcon(modelid,color,Float:x,Float:y,Float:z)
{
	for(new i=0;i<MAX_ICONS;i++)
	{
		if(!IconActive[i])
		{
			IconPos[i][0]=x;
			IconPos[i][1]=y;
			IconPos[i][2]=z;
			IconModel[i]=modelid;
			IconColor[i]=color;
			IconActive[i]=true;
			return i;
		}
	}
	print("[mapicon] Could not create map-icon!");
	return INVALID_ICON_ID;
}

forward DestroyMapIcon(id);
public DestroyMapIcon(id)
{
	if(!IconActive[id]) return 0;
	
	new slot;
	IconActive[id]=false;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        slot=IconSlot[i][id];
			if(slot!=INVALID_SLOT)
			{
			    RemovePlayerMapIcon(i,slot);
				SlotIconID[i][slot]=INVALID_ICON_ID;
			    IconSlot[i][id]=INVALID_SLOT;
			}
		}
	}
	return 1;
}

forward MapIconUpdate();
public MapIconUpdate()
{
	new id,oldid;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        for(new j=0;j<MAX_SLOTS;j++)
	        {
	            oldid=SlotIconID[i][j];
				if(oldid!=INVALID_ICON_ID)//Slot benutzt
				{
				    if(GetDistanceToPoint(i,IconPos[oldid][0],IconPos[oldid][1],IconPos[oldid][2])>DISTANCE)
				    {
				        id=GetClosestUnusedMapIcon(i);
				        if(id!=INVALID_ICON_ID)
				        {
							RemovePlayerMapIcon(i,j);
							IconSlot[i][oldid]=INVALID_SLOT;
							if(GetDistanceToPoint(i,IconPos[id][0],IconPos[i][1],IconPos[id][2])<DISTANCE)
							{
								SetPlayerMapIcon(i,j,IconPos[id][0],IconPos[id][1],IconPos[id][2],IconModel[id],IconColor[id]);
								SlotIconID[i][j]=id;
								IconSlot[i][id]=j;
							}
							else
							    SlotIconID[i][j]=INVALID_ICON_ID;
						}
				    }
				}
				else
				{
			    	id=GetClosestUnusedMapIcon(i);
			        if(id!=INVALID_ICON_ID)
			        {
						if(GetDistanceToPoint(i,IconPos[id][0],IconPos[id][1],IconPos[id][2])<DISTANCE)
						{
							SetPlayerMapIcon(i,j,IconPos[id][0],IconPos[id][1],IconPos[id][2],IconModel[id],IconColor[id]);
							SlotIconID[i][j]=id;
							IconSlot[i][id]=j;
						}
					}
				}
			}
	    }
	}
	return 1;
}

stock ResetMapIcons(playerid)
{
	new id;
	for(new i=0;i<MAX_SLOTS;i++)
	{
		id=SlotIconID[playerid][i];
		if(id!=INVALID_ICON_ID)
		{
		    RemovePlayerMapIcon(playerid,i);
		    SlotIconID[playerid][i]=INVALID_ICON_ID;
		    IconSlot[playerid][id]=INVALID_SLOT;
		}
	}
	return playerid;
}

stock GetClosestUnusedMapIcon(playerid)
{
	new dis=50000,tmpdis,id=INVALID_ICON_ID;
	for(new i=0;i<MAX_ICONS;i++)
	{
	    if(IconActive[i] && IconSlot[playerid][i]==INVALID_SLOT)
		{
		    tmpdis=GetDistanceToPoint(playerid,IconPos[i][0],IconPos[i][1],IconPos[i][2]);
		    if(tmpdis<dis)
		    {
		        id=i;
				dis=tmpdis;
		    }
		}
	}
	return id;
}

stock GetDistanceToPoint(playerid,Float:x,Float:y,Float:z)
{
	new Float:dis;
	new Float:x1,Float:y1,Float:z1;
	GetPlayerPos(playerid,x1,y1,z1);
	dis=floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)+floatpower(floatabs(floatsub(z,z1)),2));
	return floatround(dis);
}
