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

native AddTeleport();
native ProcessTeleportRequest(playerid);

native ResolveHostname(dest[], hostname[], len = sizeof(dest));
native UnixtimeToDate(dest[], unixtime, len = sizeof(dest));