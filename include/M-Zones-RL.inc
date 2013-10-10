/*
*
* M-Zones © by Maercell
*
* Released: 31.05.2009
* Version:  1.X - Modifikation für German Life - Streets of SA
* Lignes:	192
* Language: German
* Coder:    Maercell aka [GCW]Marciii
*
*
native M_CreateZone(Float:minx,Float:miny,Float:maxx,Float:maxy,zonecolor,text[]="",textcolor=0xFFFFFFFF);
native M_DestroyZone(zoneid);
native M_IsValidZone(zoneid);
native M_IsPlayerInZone(playerid,zoneid);
native M_IsPlayerInAnyZone(playerid);
native M_GetPlayerCurrentZone(playerid);
native M_IsPlayerInArea(playerid,Float:minX,Float:minY,Float:maxX,Float:maxY);
native M_OnPlayerEnterZone(playerid,zoneid);
native M_OnPlayerLeaveZone(playerid,zoneid);
*
*/

#if defined m_zones_included
	#endinput
#endif
#define m_zones_included

// Wenn du mehr als 20 Zonen verwenden willst, erhöhe diese Zahl
#define MAX_ZONES 20


enum ZoneInfo
{
	zGangZoneID,
    zValid,
	Float:zMinX,
	Float:zMinY,
	Float:zMaxX,
	Float:zMaxY,
	zText[100],
	Text:zTextDraw,
}

new zones = 0;
new Zonen[MAX_ZONES][ZoneInfo];
new InZone[MAX_PLAYERS][MAX_ZONES];

forward ShowZoneText();
forward M_OnPlayerEnterZone(playerid,zoneid);
forward M_OnPlayerLeaveZone(playerid,zoneid);

M_Init()
{
	SetTimer("ShowZoneText",777,1);
	return 1;
}

public ShowZoneText()
{
	for(new i=0; i<GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i))
		{
			for(new zoneid=0; zoneid<MAX_ZONES; zoneid++)
			{
		        if(M_IsValidZone(zoneid))
		        {
				    if(M_IsPlayerInZone(i,zoneid) && InZone[i][zoneid] == 0)
				    {
						if(Zonen[zoneid][zText][0] != '\0')
						{
							TextDrawShowForPlayer(i,Zonen[zoneid][zTextDraw]);
						}	
						InZone[i][zoneid] = 1;
						M_OnPlayerEnterZone(i,zoneid);
					}
					if(!M_IsPlayerInZone(i,zoneid) && InZone[i][zoneid] == 1)
					{
						if(Zonen[zoneid][zText][0] != '\0')
						{
							TextDrawHideForPlayer(i,Zonen[zoneid][zTextDraw]);
						}	
						InZone[i][zoneid] = 0;	
						M_OnPlayerLeaveZone(i,zoneid);
					}
				}
			}
		}
	}
	return 1;
}

stock M_CreateZone(Float:minx,Float:miny,Float:maxx,Float:maxy,zonecolor,text[]="",textcolor=0xFFFFFFFF)
{
	if(!M_IsValidZone(zones) && zones != MAX_ZONES)
	{
		if(text[0] != '\0')
		{
			Zonen[zones][zTextDraw] = TextDrawCreate(600.0,415.0,text);
			TextDrawFont(Zonen[zones][zTextDraw],1);
			TextDrawAlignment(Zonen[zones][zTextDraw],3);
			TextDrawLetterSize(Zonen[zones][zTextDraw],0.45,1.6);
			TextDrawSetShadow(Zonen[zones][zTextDraw],0);
			TextDrawSetOutline(Zonen[zones][zTextDraw],1);
			TextDrawColor(Zonen[zones][zTextDraw],textcolor);
			TextDrawBackgroundColor(Zonen[zones][zTextDraw],0x000000FF);
		}	
		Zonen[zones][zGangZoneID] = GangZoneCreate(minx,miny,maxx,maxy);
		GangZoneShowForAll(Zonen[zones][zGangZoneID],zonecolor);
		Zonen[zones][zValid] = 1;
		Zonen[zones][zMinX] = minx;
		Zonen[zones][zMinY] = miny;
		Zonen[zones][zMaxX] = maxx;
		Zonen[zones][zMaxY] = maxy;
		strmid(Zonen[zones][zText],text,0,strlen(text),255);
		zones++;
		return zones-1;
	}
	return -1;
}

stock M_DestroyZone(zoneid)
{
	if(M_IsValidZone(zoneid))
	{
		if(Zonen[zoneid][zTEXT] != "")
		{
			TextDrawHideForAll(Zonen[zoneid][zTextDraw]);
			TextDrawDestroy(Zonen[zoneid][zTextDraw]);
		}
		GangZoneHideForAll(Zonen[zoneid][zGangZoneID],zonecolor);
		GangZoneDestroy(Zonen[zoneid][zGangZoneID]);
		Zonen[zoneid][zValid] = 0;
		Zonen[zoneid][zMinX] = 0.0;
		Zonen[zoneid][zMinY] = 0.0;
		Zonen[zoneid][zMaxX] = 0.0;
		Zonen[zoneid][zMaxY] = 0.0;
		strmid(Zonen[zoneid][zTEXT],"",0,0,255);	
		return 1;
	}	
	return 0;
}

stock M_IsValidZone(zoneid)
{
	return Zonen[zoneid][zValid];
}

stock M_IsPlayerInZone(playerid,zoneid)
{
	return (M_IsPlayerInArea(playerid,Zonen[zoneid][zMinX],Zonen[zoneid][zMinY],Zonen[zoneid][zMaxX],Zonen[zoneid][zMaxY]));
}

stock M_IsPlayerInAnyZone(playerid)
{
	for(new zoneid=0; zoneid<MAX_ZONES; zoneid++)
	{
		if(M_IsValidZone(zoneid))
		{
			if(IsPlayerInZone(playerid,zoneid))
			{
				return 1;
			}
		}
	}
	return 0;
}

stock M_GetPlayerCurrentZone(playerid)
{
	for(new zoneid=0; zoneid<MAX_ZONES; zoneid++)
	{
		if(M_IsValidZone(zoneid))
		{
			if(M_IsPlayerInZone(playerid,zoneid))
			{
				return zoneid;
			}
		}
	}
	return -1;
}

stock M_IsPlayerInArea(playerid,Float:minX,Float:minY,Float:maxX,Float:maxY)
{
	new Float:pX, Float:pY, Float:pZ;
	GetPlayerPos(playerid,pX,pY,pZ);
	if(pX >= minX && pX <= maxX && pY >= minY && pY <= maxY) return 1;
	else return 0;
}
