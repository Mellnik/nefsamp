/*
*
* M-Zones © by Marciii
*
* Released: 20.07.2009
* Version:  1.3
* Lignes:	370
* Language: German
* Coder:    Marciii
*
*
native M_CreateZone(Float:minx,Float:miny,Float:maxx,Float:maxy,zonecolor,text[]="",textcolor=0xFFFFFFFF);
native M_DestroyZone(zoneid);
native M_ZoneFlashForPlayer(playerid,zoneid,flashcolor);
native M_ZoneFlashForAll(zoneid,flashcolor);
native M_ZoneStopFlashForPlayer(playerid,zoneid);
native M_ZoneStopFlashForAll(zoneid);
native M_ZoneSetTextDraw(zoneid,text[]="",textcolor=0xFFFFFFFF);
native M_ZoneSetColor(zoneid,zonecolor);
native M_ZoneSetZone(zoneid,Float:minx,Float:miny,Float:maxx,Float:maxy,zonecolor);
native M_ZoneGetZoneCoords(zoneid,&Float:minx,&Float:miny,&Float:maxx,&Float:maxy);
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


enum ZoneInfo_enum
{
	zGangZoneID,
    zValid,
	Float:zMinX,
	Float:zMinY,
	Float:zMaxX,
	Float:zMaxY,
	Text:zTextDraw,
	zText[100],
	zColor,
	zFlash,
	zFlashColor,
}

new zones = 0;
new ZoneInfo[MAX_ZONES][ZoneInfo_enum];
new InZone[MAX_PLAYERS][MAX_ZONES];

forward ShowZoneText();
forward M_OnPlayerEnterZone(playerid,zoneid);
forward M_OnPlayerLeaveZone(playerid,zoneid);

M_Init()
{
	SetTimer("ShowZoneText",999,1);
	for(new zoneid=0; zoneid<MAX_ZONES; zoneid++)
	{
		ZoneInfo[zoneid][zGangZoneID] = -1;
		ZoneInfo[zoneid][zValid] = 0;
		ZoneInfo[zoneid][zMinX] = 0.0;
		ZoneInfo[zoneid][zMinY] = 0.0;
		ZoneInfo[zoneid][zMaxX] = 0.0;
		ZoneInfo[zoneid][zMaxY] = 0.0;
		strmid(ZoneInfo[zoneid][zText],"",0,100);
	}
	return 1;
}

M_Connect(playerid)
{
	for(new zoneid=0; zoneid<MAX_ZONES; zoneid++)
	{
		if(M_IsValidZone(zoneid))
		{
			GangZoneShowForPlayer(playerid,ZoneInfo[zoneid][zGangZoneID],ZoneInfo[zoneid][zColor]);
			if(ZoneInfo[zoneid][zFlash])
			{
				GangZoneFlashForPlayer(playerid,ZoneInfo[zoneid][zGangZoneID],ZoneInfo[zoneid][zFlashColor]);
			}
		}
	}
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
						if(ZoneInfo[zoneid][zText][0] != '\0')
						{
							TextDrawShowForPlayer(i,ZoneInfo[zoneid][zTextDraw]);
						}	
						InZone[i][zoneid] = 1;
						M_OnPlayerEnterZone(i,zoneid);
					}
					if(!M_IsPlayerInZone(i,zoneid) && InZone[i][zoneid] == 1)
					{
						if(ZoneInfo[zoneid][zText][0] != '\0')
						{
							TextDrawHideForPlayer(i,ZoneInfo[zoneid][zTextDraw]);
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
			ZoneInfo[zones][zTextDraw] = TextDrawCreate(600.0,380.0,text);
			TextDrawFont(ZoneInfo[zones][zTextDraw],1);
			TextDrawAlignment(ZoneInfo[zones][zTextDraw],3);
			TextDrawLetterSize(ZoneInfo[zones][zTextDraw],0.35,1.4);
			TextDrawSetShadow(ZoneInfo[zones][zTextDraw],0);
			TextDrawSetOutline(ZoneInfo[zones][zTextDraw],1);
			TextDrawColor(ZoneInfo[zones][zTextDraw],textcolor);
			TextDrawBackgroundColor(ZoneInfo[zones][zTextDraw],0x000000FF);
		}	
		if(minx > maxx) // FALSCHRUM!
		{
			ZoneInfo[zones][zMinX] = maxx;
			ZoneInfo[zones][zMaxX] = minx;
		}
		else
		{
			ZoneInfo[zones][zMinX] = minx;
			ZoneInfo[zones][zMaxX] = maxx;
		}
		if(miny > maxy)  // FALSCHRUM!
		{
			ZoneInfo[zones][zMinY] = maxy;
			ZoneInfo[zones][zMaxY] = miny;
		}
		else
		{
			ZoneInfo[zones][zMinY] = miny;
			ZoneInfo[zones][zMaxY] = maxy;
		}
		ZoneInfo[zones][zGangZoneID] = GangZoneCreate(ZoneInfo[zones][zMinX],ZoneInfo[zones][zMinY],ZoneInfo[zones][zMaxX],ZoneInfo[zones][zMaxY]);
		GangZoneShowForAll(ZoneInfo[zones][zGangZoneID],zonecolor);
		ZoneInfo[zones][zValid] = 1;
		ZoneInfo[zones][zColor] = zonecolor;
		strmid(ZoneInfo[zones][zText],text,0,strlen(text),255);
		zones++;
		return zones-1;
	}
	return -1;
}

stock M_DestroyZone(zoneid)
{
	if(M_IsValidZone(zoneid))
	{
		if(ZoneInfo[zoneid][zText][0] != '\0')
		{
			TextDrawHideForAll(ZoneInfo[zoneid][zTextDraw]);
			TextDrawDestroy(ZoneInfo[zoneid][zTextDraw]);
		}
		GangZoneHideForAll(ZoneInfo[zoneid][zGangZoneID]);
		GangZoneDestroy(ZoneInfo[zoneid][zGangZoneID]);
		ZoneInfo[zoneid][zValid] = 0;
		ZoneInfo[zoneid][zMinX] = 0.0;
		ZoneInfo[zoneid][zMinY] = 0.0;
		ZoneInfo[zoneid][zMaxX] = 0.0;
		ZoneInfo[zoneid][zMaxY] = 0.0;
		ZoneInfo[zoneid][zFlash] = 0;
		ZoneInfo[zoneid][zFlashColor] = 0x00000000;
		ZoneInfo[zoneid][zColor] = 0x00000000;
		strmid(ZoneInfo[zoneid][zText],"",0,0,255);	
		return 1;
	}	
	return 0;
}

stock M_ZoneFlashForPlayer(playerid,zoneid,flashcolor)
{
	if(M_IsValidZone(zoneid) && IsPlayerConnected(playerid))
	{
		GangZoneFlashForPlayer(playerid,ZoneInfo[zoneid][zGangZoneID],flashcolor);
		ZoneInfo[zoneid][zFlash] = 1;
		ZoneInfo[zoneid][zFlashColor] = flashcolor;
		return 1;
	}
	return 0;
}

stock M_ZoneFlashForAll(zoneid,flashcolor)
{
	if(M_IsValidZone(zoneid))
	{
		GangZoneFlashForAll(ZoneInfo[zoneid][zGangZoneID],flashcolor);
		ZoneInfo[zoneid][zFlash] = 1;
		ZoneInfo[zoneid][zFlashColor] = flashcolor;
		return 1;
	}
	return 0;
}

stock M_ZoneStopFlashForPlayer(playerid,zoneid)
{
	if(M_IsValidZone(zoneid) && IsPlayerConnected(playerid))
	{
		GangZoneStopFlashForPlayer(playerid,ZoneInfo[zoneid][zGangZoneID]);
		ZoneInfo[zoneid][zFlash] = 0;
		ZoneInfo[zoneid][zFlashColor] = 0x00000000;
		return 1;
	}
	return 0;
}

stock M_ZoneStopFlashForAll(zoneid)
{
	if(M_IsValidZone(zoneid))
	{
		GangZoneStopFlashForAll(ZoneInfo[zoneid][zGangZoneID]);
		ZoneInfo[zoneid][zFlash] = 0;
		ZoneInfo[zoneid][zFlashColor] = 0x00000000;
		return 1;
	}
	return 0;
}

stock M_ZoneSetTextDraw(zoneid,text[]="",textcolor=0xFFFFFFFF)
{
	if(M_IsValidZone(zoneid))
	{
		if(text[0] != '\0')
		{
			ZoneInfo[zoneid][zTextDraw] = TextDrawCreate(600.0,380.0,text);
			TextDrawFont(ZoneInfo[zoneid][zTextDraw],1);
			TextDrawAlignment(ZoneInfo[zoneid][zTextDraw],3);
			TextDrawLetterSize(ZoneInfo[zoneid][zTextDraw],0.35,1.4);
			TextDrawSetShadow(ZoneInfo[zoneid][zTextDraw],0);
			TextDrawSetOutline(ZoneInfo[zoneid][zTextDraw],1);
			TextDrawColor(ZoneInfo[zoneid][zTextDraw],textcolor);
			TextDrawBackgroundColor(ZoneInfo[zoneid][zTextDraw],0x000000FF);
		}	
		strmid(ZoneInfo[zoneid][zText],text,0,strlen(text),255);
		return 1;
	}
	return 0;
}

stock M_ZoneSetColor(zoneid,zonecolor)
{
	if(M_IsValidZone(zoneid))
	{
		GangZoneHideForAll(ZoneInfo[zoneid][zGangZoneID]);
		GangZoneShowForAll(ZoneInfo[zoneid][zGangZoneID],zonecolor);
		ZoneInfo[zoneid][zColor] = zonecolor;
		return 1;
	}
	return 0;
}

stock M_ZoneSetZone(zoneid,Float:minx,Float:miny,Float:maxx,Float:maxy,zonecolor)
{
	if(M_IsValidZone(zoneid))
	{
		if(minx > maxx) // FALSCHRUM!
		{
			ZoneInfo[zoneid][zMinX] = maxx;
			ZoneInfo[zoneid][zMaxX] = minx;
		}
		else
		{
			ZoneInfo[zoneid][zMinX] = minx;
			ZoneInfo[zoneid][zMaxX] = maxx;
		}
		if(miny > maxy)  // FALSCHRUM!
		{
			ZoneInfo[zoneid][zMinY] = maxy;
			ZoneInfo[zoneid][zMaxY] = miny;
		}
		else
		{
			ZoneInfo[zoneid][zMinY] = miny;
			ZoneInfo[zoneid][zMaxY] = maxy;		
		}
		GangZoneHideForAll(ZoneInfo[zoneid][zGangZoneID]);
		GangZoneDestroy(ZoneInfo[zoneid][zGangZoneID]);
		ZoneInfo[zoneid][zGangZoneID] = GangZoneCreate(ZoneInfo[zoneid][zMinX],ZoneInfo[zoneid][zMinY],ZoneInfo[zoneid][zMaxX],ZoneInfo[zoneid][zMaxY]);
		GangZoneShowForAll(ZoneInfo[zoneid][zGangZoneID],zonecolor);
		return 1;
	}
	return 0;
}

stock M_ZoneGetZoneCoords(zoneid,&Float:minx,&Float:miny,&Float:maxx,&Float:maxy)
{
	if(M_IsValidZone(zoneid))
	{
		minx = ZoneInfo[zoneid][minx];
		miny = ZoneInfo[zoneid][miny];
		maxx = ZoneInfo[zoneid][maxx];
		maxy = ZoneInfo[zoneid][maxy];
		return 1;
	}
	return 0;
}

stock M_IsValidZone(zoneid)
{
	return ZoneInfo[zoneid][zValid];
}

stock M_IsPlayerInZone(playerid,zoneid)
{
	if(M_IsValidZone(zoneid))
	{
		return (M_IsPlayerInArea(playerid,ZoneInfo[zoneid][zMinX],ZoneInfo[zoneid][zMinY],ZoneInfo[zoneid][zMaxX],ZoneInfo[zoneid][zMaxY]));
	}
	return 0;
}

stock M_IsPlayerInAnyZone(playerid)
{
	for(new zoneid=0; zoneid<MAX_ZONES; zoneid++)
	{
		if(M_IsValidZone(zoneid))
		{
			if(M_IsPlayerInZone(playerid,zoneid))
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
	if(pX >= minX && pX <= maxX && pY >= minY && pY <= maxY)
	{
		return 1;
	}
	return 0;
}
