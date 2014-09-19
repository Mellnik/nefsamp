/*======================================================================*\
|| #################################################################### ||
|| # Project New Evolution Freeroam - NEFMOD Core          			  # ||
|| # ---------------------------------------------------------------- # ||
|| # Copyright (c)2011-2014 New Evolution Freeroam  				  # ||
|| # Created by Mellnik                                               # ||
|| # ---------------------------------------------------------------- # ||
|| # http://www.nefserver.net	    	                      		  # ||
|| #################################################################### ||
\*======================================================================*/

#if defined _nefmod_included
	#endinput
#endif
#define _nefmod_included

native NC_AddTeleport(tp_category, const tp_name[], const tp_cmd[], Float:x, Float:y, Float:z);
native NC_ProcessTeleportRequest(playerid, tp_category, input);

native NC_ResolveHostname(dest[], hostname[], len = sizeof(dest));
native NC_UnixtimeToDate(dest[], unixtime, len = sizeof(dest));