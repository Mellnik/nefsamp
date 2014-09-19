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

#include <cstring>
#include <limits>

#include "natives.h"
#include "teleports.h"

std::vector<Teleports *> g_mTeleports[MAX_TELE_CATEGORIES];

/* NC_AddTeleport(tp_category, const tp_name[], const tp_cmd[], Float:x, Float:y, Float:z) */
cell AMX_NATIVE_CALL Native::AddTeleport(AMX *amx, cell *params)
{
	static const unsigned ParamCount = 6;
	PARAM_CHECK(ParamCount, "NC_AddTeleport");
	
	if (params[1] < 0 || params[1] >= MAX_TELE_CATEGORIES)
	{
		logprintf("[NEFMOD] Invalid tp category");
		return 0;
	}
	
	if (g_mTeleports[params[1]].size() >= MAX_TELES_PER_CATEGORY)
	{
		logprintf("[NEFMOD] Teleport category %i full", params[1]);
		return 0;
	}
	
	char *tp_name = NULL, *tp_cmd = NULL;
	amx_StrParam(amx, params[2], tp_name);
	amx_StrParam(amx, params[3], tp_cmd);
	
	if (tp_name == NULL || tp_cmd == NULL)
	{
		logprintf("[NEFMOD] Could not retrieve strings in AddTeleport");
		return 0;
	}
	
	if (std::strlen(tp_cmd) > MAX_TELE_COMMAND_NAME)
	{
		logprintf("[NEFMOD] tp_cmd %s size too large (%i)", tp_cmd, std::strlen(tp_cmd));
		return 0;
	}
	
	g_mTeleports[params[1]].push_back(new Teleports(params[1], tp_name, tp_cmd, amx_ftoc(params[4]), amx_ftoc(params[5]), amx_ftoc(params[6])));
	return 1;
}

/* NC_ProcessTeleportRequest(tp_category, input, dest[], len = sizeof(dest)) */
cell AMX_NATIVE_CALL Native::ProcessTeleportRequest(AMX *amx, cell *params)
{
	static const unsigned ParamCount = 4;
	PARAM_CHECK(ParamCount, "NC_ProcessTeleportRequest");
	
	if (params[1] < 0 || params[1] > MAX_TELE_CATEGORIES)
	{
		logprintf("[NEFMOD] Invalid tp category");
		return 0;
	}
	
	if (params[2] >= MAX_TELES_PER_CATEGORY || params[2] < 0)
	{
		logprintf("[NEFMOD] Invalid input exceeds restrictions, %i, %i", params[1], params[2]);
		return 0;
	}
	
	auto tp_rel = g_mTeleports[params[1]][params[2]];
	
	cell *amx_Addr = NULL;
	amx_GetAddr(amx, params[3], &amx_Addr);
	amx_SetString(amx_Addr, tp_rel->GetCommandName(), 0, 0, params[4] > 0 ? params[4] : std::strlen(tp_rel->GetCommandName()) + 1);
	return 1;
}

/* NC_OutputTeleportInfo() */
cell AMX_NATIVE_CALL Native::OutputTeleportInfo(AMX *amx, cell *params)
{
	for(uint32_t i = 0; i < MAX_TELE_CATEGORIES; ++i)
	{
		logprintf("[NEFMOD] TP Category %i: %i tps", i, g_mTeleports[i].size());
	}
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

