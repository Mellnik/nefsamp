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

#define CORE_VERSION 0xB

#define MAX_TELE_CATEGORIES 9
#define MAX_TELES_PER_CATEGORY 32
#define MAX_TELE_COMMAND_NAME 16

native NC_Init(nc_version = CORE_VERSION);

// Teleport System
native NC_AddTeleport(tp_category, const tp_name[], const tp_cmd[], Float:x, Float:y, Float:z);
native NC_GetTeleportDialogString(tp_category, dest[], len = sizeof(dest));
native NC_ProcessTeleportRequest(tp_category, input, dest[], len = sizeof(dest));
native NC_OutputTeleportInfo();

// General Util
native NC_UnixtimeToDate(dest[], unixtime, len = sizeof(dest));
native NC_StringReplace(const transform[], const from[], const to[], dest[], len = sizeof(dest));