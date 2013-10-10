/* NATIVES
native iAddStreamIcon(Float:stream_x,Float:stream_y,Float:stream_z,stream_typ,stream_farbe);
native iRemoveStreamIcon(stream_idx);
native iGameModeInit_X();
native iGameModeExit_X();
native iPlayerConnect_X(playerid);
*/
#include <a_samp>
//------------------------------------------------------------------------------
#define MAX_MAP 3000
#define MAX_STREAM 31
#define MAP_DISTANZ 200
//------------------------------------------------------------------------------
#define IsPosInDistance(%0,%1,%2,%3,%4,%5,%6) \
        (((%0 - %3) * (%0 - %3)) + ((%1 - %4) * (%1 - %4)) + ((%2 - %5) * (%2 - %5)) <= %6 * %6)
//------------------------------------------------------------------------------
new map_id = 0;
new bool:Platz[MAX_PLAYERS][32];
new bool:Showed[MAX_PLAYERS][MAX_MAP];
new UsedBy[MAX_PLAYERS][MAX_MAP];
new CoreTimer;
//------------------------------------------------------------------------------
enum mapdata
{
	mStream_id,
	Float:map_x,
	Float:map_y,
	Float:map_z,
	map_typ,
	map_color,
	bool:erstellt_m,
	bool:gezeigt,
}
new MapX[MAX_MAP][mapdata];
//------------------------------------------------------------------------------
stock iAddStreamIcon(Float:stream_x,Float:stream_y,Float:stream_z,stream_typ,stream_farbe)
{
	map_id++;
	MapX[map_id][map_x] = stream_x;
	MapX[map_id][map_y] = stream_y;
	MapX[map_id][map_z] = stream_z;
	MapX[map_id][map_typ] = stream_typ;
	MapX[map_id][map_color] = stream_farbe;
	MapX[map_id][erstellt_m] = true;
	MapX[map_id][mStream_id] = map_id;
	return map_id;
}
//------------------------------------------------------------------------------
stock iRemoveStreamIcon(stream_idx)
{
	for(new i = 1;i<MAX_MAP;i++)
	{
		if(MapX[i][mStream_id] == stream_idx)
		{
		MapX[i][map_x] = 0.0;
		MapX[i][map_y] = 0.0;
		MapX[i][map_z] = 0.0;
		MapX[i][map_typ] = 0;
		MapX[i][map_color] = 0;
		MapX[i][erstellt_m] = false;
		MapX[i][mStream_id] = 0;
		}
	}
}
//------------------------------------------------------------------------------
forward iCore_MapStreamer();
public iCore_MapStreamer()
{
	for(new playerid = 0;playerid<GetMaxPlayers();playerid++)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        new Float:map_pos_x,Float:map_pos_y,Float:map_pos_z;
			for(new i = 1;i<MAX_MAP;i++)
			{
			    if(GetPlayerPos(playerid,map_pos_x,map_pos_y,map_pos_z))
			    {
			    	if(IsPosInDistance(map_pos_x,map_pos_y,map_pos_z,MapX[i][map_x],MapX[i][map_y],16.7380,MAP_DISTANZ))
			    	{
        				if(MapX[i][erstellt_m] == true)
   	        			{
  	            			if(Showed[playerid][i] == false)
   	            			{
   	            			    if(FreierPlatz(playerid)!=-1)
   	            			    {
   	            			    	new Slot = FreierPlatz(playerid);
   	            			    	UsedBy[playerid][i] = Slot;
			    	            	Showed[playerid][i] = true;
			    	            	SetPlayerMapIcon(playerid,Slot,MapX[i][map_x],MapX[i][map_y],MapX[i][map_z],MapX[i][map_typ],MapX[map_id][map_color]);
			    	            }
		    	            }
		    	        }
			    	}
			    	else
			    	{
			    	RemovePlayerMapIcon(playerid,UsedBy[playerid][i]);
			    	UsedBy[playerid][i] = -1;
			    	Showed[playerid][i] = false;
			    	}
			    }
			}
		}
	}
	return 1;
}
//------------------------------------------------------------------------------
forward FreierPlatz(playerid);
public FreierPlatz(playerid)
{
	new free = -1;
	for(new p = 0;p<32;p++)
	{
		if(free == -1)
		{
		    if(Platz[playerid][p] == false)
		    {
		        Platz[playerid][p] = true;
		        free = p;
		    }
		}
	}
	return free;
}
//------------------------------------------------------------------------------
forward iPlayerConnect_X(playerid);
public iPlayerConnect_X(playerid)
{
	for(new i = 1;i<MAX_MAP;i++)
	{
	Showed[playerid][i] = false;
	UsedBy[playerid][i] = -1;
	}
	for(new i = 0;i<32;i++){
	Platz[playerid][i] = false;}
}
//------------------------------------------------------------------------------
forward iGameModeInit_X();
public iGameModeInit_X()
{
	CoreTimer = SetTimer("iCore_MapStreamer",1000,1);
}
//------------------------------------------------------------------------------
forward iGameModeExit_X();
public iGameModeExit_X()
{
	KillTimer(CoreTimer);
}
