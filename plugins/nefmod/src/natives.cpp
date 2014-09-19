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

#include <limits>

#include "natives.h"
#include "teleports.h"

std::vector<Teleports *> g_mTeleports[MAX_TELE_CATEGORIES];

/* NC_AddTeleport(tp_category, const tp_name[], const tp_cmd[], Float:x, Float:y, Float:z) */
cell AMX_NATIVE_CALL Native::AddTeleport(AMX *amx, cell *params)
{
	static const unsigned ParamCount = 6;
	PARAM_CHECK(ParamCount, "NC_AddTeleport");
	
	if (params[1] < 0 || params[1] > MAX_TELE_CATEGORIES)
	{
		logprintf("[NEFMOD] Invalid tp category");
		return 0;
	}
	
	char *tp_name = NULL, *tp_cmd = NULL;
	amx_StrParam(amx, params[2], tp_name);
	amx_StrParam(amx, params[3], tp_cmd);
	
	if (tmp_name == NULL || tp_cmd == NULL)
	{
		logprintf("[NEFMOD] Could not retrieve strings in AddTeleport");
		return 0;
	}
	
	g_mTeleports[params[1]].push_back(new Teleports(params[1], tp_name, tp_cmd, amx_ftoc(params[4]), amx_ftoc(params[5]), amx_ftoc(params[6])));
	return 1;
}

/* NC_ProcessTeleportRequest(playerid, tp_category, input) */
cell AMX_NATIVE_CALL Native::ProcessTeleportRequest(AMX *amx, cell *params)
{
	static const unsigned ParamCount = 3;
	PARAM_CHECK(ParamCount, "NC_ProcessTeleportRequest");
	
	return 1;
}

/* NC_ResolveHostname(dest[], hostname[], len = sizeof(dest)) */
cell AMX_NATIVE_CALL Native::ResolveHostname(AMX *amx, cell *params)
{
	static const unsigned ParamCount = 3;
	PARAM_CHECK(ParamCount, "NC_ResolveHostname");
	
	return 1;
}

/* NC_UnixtimeToDate(dest[], unixtime, len = sizeof(dest)) */
cell AMX_NATIVE_CALL Native::UnixtimeToDate(AMX *amx, cell *params)
{
	static const unsigned ParamCount = 3;
	PARAM_CHECK(ParamCount, "NC_UnixtimeToDate");
	
	if (params[2] < 0 || params[2] > std::numeric_limits<int>::max())
	{
		logprintf("[NEFMOD] Invalid unixtime provided in UnixtimeToDate");
		return 0;
	}
	
	return 1;
}

