/*
BFX Pickup Streamer (c) 2008 - 2009 by BlackFoX_UD_

Slyfer1@googlemail.com

*/
#include <a_samp>
/*
native b_CreatePickup(Stream_model,p_type,Float:pp_x,Float:pp_y,Float:pp_z);
native b_DestroyPickup(stream_id);
native GetStreamID(pickupid);
*/
//
#define P_DISTANZ 50
#define MAX_PICKZ 2000
#define IsPosInDistance(%0,%1,%2,%3,%4,%5,%6) \
        (((%0 - %3) * (%0 - %3)) + ((%1 - %4) * (%1 - %4)) + ((%2 - %5) * (%2 - %5)) <= %6 * %6)
//
enum pickupz
{
	p_model,
	Float:pickup_x,
	Float:pickup_y,
	Float:pickup_z,
	p__pickup_stream_id,
	p_pickup_id,
	p_pickup_exist,
	p_showed,
	pickup_type,
}
new bfx_pickups[MAX_PICKZ][pickupz];
new Core_timex;
//------------------------------------------------------------------------------
stock b_CreatePickup(Stream_model,p_type,Float:pp_x,Float:pp_y,Float:pp_z)
{
	new created_p = 0;
	new lastid = -1;
	for(new i = 0;i<MAX_PICKZ;i++)
	{
	    if(created_p == 0)
	    {
			if(bfx_pickups[i][p_pickup_exist] == 0)
			{
  			  	bfx_pickups[i][p_model] = Stream_model;
	    		bfx_pickups[i][pickup_x] = (pp_x);
		    	bfx_pickups[i][pickup_y] = (pp_y);
		    	bfx_pickups[i][pickup_z] = (pp_z);
		    	bfx_pickups[i][p__pickup_stream_id] = i;
		    	bfx_pickups[i][p_pickup_exist] = 1;
		    	bfx_pickups[i][pickup_type] = p_type;
		    	bfx_pickups[i][p_pickup_id] = -1;
		    	bfx_pickups[i][p_showed] = 0;
			    lastid = i;
		    	created_p =  1;
			}
		}
	}
	return lastid;
}
//------------------------------------------------------------------------------
stock b_DestroyPickup(stream_id)
{
	if(bfx_pickups[stream_id][p_showed] == 1)
	{
		DestroyPickup(bfx_pickups[stream_id][p_pickup_id]);
	    bfx_pickups[stream_id][p_pickup_exist] = 0;
	    bfx_pickups[stream_id][p_showed] = 0;
	}
	else
	{
 		bfx_pickups[stream_id][p_pickup_exist] = 0;
	    bfx_pickups[stream_id][p_showed] = 0;
	}
}
//------------------------------------------------------------------------------
forward pCore_777();
public pCore_777()
{
	for(new playerid = 0;playerid<GetMaxPlayers();playerid++)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        new Float:last_xx,Float:last_yy,Float:last_zz;
			for(new i = 0;i<MAX_PICKZ;i++)
			{
				if(GetPlayerPos(playerid,last_xx,last_yy,last_zz))
				{
					if(IsPosInDistance(last_xx,last_yy,last_zz,bfx_pickups[i][pickup_x],bfx_pickups[i][pickup_y],bfx_pickups[i][pickup_z],P_DISTANZ))
   					{
   					    if(bfx_pickups[i][p_pickup_exist] == 1)
   					    {
   					        if(bfx_pickups[i][p_showed] == 0)
   					        {
   					            bfx_pickups[i][p_pickup_id] = CreatePickup(bfx_pickups[i][p_model],bfx_pickups[i][pickup_type],bfx_pickups[i][pickup_x],bfx_pickups[i][pickup_y],bfx_pickups[i][pickup_z]);
   					            bfx_pickups[i][p_showed] = 1;
   					        }
   					    }
   					}
   					else
   					{
				    	if(bfx_pickups[i][p_pickup_exist] == 1)
   					    {
   					        if(bfx_pickups[i][p_showed] == 1)
   					        {
								DestroyPickup(bfx_pickups[i][p_pickup_id]);
   					            bfx_pickups[i][p_showed] = 0;
   					            bfx_pickups[i][p_pickup_id] = -1;
   					        }
   					    }
   					}
				}
			}
		}
	}
}
//------------------------------------------------------------------------------
stock p_GameModeInit()
{
    Core_timex = SetTimer("pCore_777",1000,1);
}
//------------------------------------------------------------------------------
stock p_GameModeExit()
{
	KillTimer(Core_timex);
}
//------------------------------------------------------------------------------
stock GetStreamID(pickupid)
{
	new gefundene_id;
	for(new i2 = 0;i2<MAX_PICKZ;i2++)
	{
		if(bfx_pickups[i2][p_pickup_id] == pickupid)
		{
			if(bfx_pickups[i2][p_pickup_exist] == 1)
			{
				gefundene_id = bfx_pickups[i2][p__pickup_stream_id];
				break;
			}
		}
	}
	return gefundene_id;
}
