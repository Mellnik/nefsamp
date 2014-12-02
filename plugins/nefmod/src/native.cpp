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
#include <ctime>

#include "native.h"
#include "teleport.h"

/* NC_Init(nc_version) */
cell AMX_NATIVE_CALL Native::Init(AMX *amx, cell *params)
{
	static const unsigned ParamCount = 1;
	PARAM_CHECK(ParamCount, "NC_Init");
	
	int32_t clientVersion = params[1];
	
	if (clientVersion != CORE_VERSION)
	{
		logprintf("[NEFMOD] Version mismatch 0x%X, expect 0x%X.", clientVersion, CORE_VERSION);
		return 0;
	}	
	return 1;
}

/* NC_AddTeleport(tp_category, const tp_name[], const tp_cmd[], Float:x, Float:y, Float:z) */
cell AMX_NATIVE_CALL Native::AddTeleport(AMX *amx, cell *params)
{
	static const unsigned ParamCount = 6;
	PARAM_CHECK(ParamCount, "NC_AddTeleport");
	
	if (params[1] < 0 || params[1] >= MAX_TELE_CATEGORIES)
	{
		logprintf("[NEFMOD] Invalid teleport category.");
		return 0;
	}
	
	if (pTeleport->GetCategorySize(params[1]) >= MAX_TELES_PER_CATEGORY)
	{
		logprintf("[NEFMOD] Teleport category %i max capacity reached.", params[1]);
		return 0;
	}
	
	char *tp_name = NULL, *tp_cmd = NULL;
	amx_StrParam(amx, params[2], tp_name);
	amx_StrParam(amx, params[3], tp_cmd);
	
	if (tp_name == NULL || tp_cmd == NULL)
	{
		logprintf("[NEFMOD] Could not retrieve strings in AddTeleport (NULL).");
		return 0;
	}
	
	if (std::strlen(tp_cmd) > MAX_TELE_COMMAND_NAME)
	{
		logprintf("[NEFMOD] tp_cmd %s size overflow (%i), allowed: %i.", tp_cmd, std::strlen(tp_cmd), MAX_TELE_COMMAND_NAME);
		return 0;
	}
	
	Teleport_t *tp = new Teleport_t(params[1], tp_name, tp_cmd, amx_ftoc(params[4]), amx_ftoc(params[5]), amx_ftoc(params[6]));
	
	std::strcat(pTeleport->g_TeleportDialogString[params[1]], tp_name);
	std::strcat(pTeleport->g_TeleportDialogString[params[1]], " (/");
	std::strcat(pTeleport->g_TeleportDialogString[params[1]], tp_cmd);
	std::strcat(pTeleport->g_TeleportDialogString[params[1]], ")\n");
	
	pTeleport->AddTeleport((int32_t)params[1], tp);
	return 1;
}

/* NC_GetTeleportDialogString(tp_category, dest[], len = sizeof(dest)) */
cell AMX_NATIVE_CALL Native::GetTeleportDialogString(AMX *amx, cell *params)
{
	static const unsigned ParamCount = 3;
	PARAM_CHECK(ParamCount, "NC_GetTeleportDialogString");
	
	if (params[1] < 0 || params[1] >= MAX_TELE_CATEGORIES)
	{
		logprintf("[NEFMOD] Invalid teleport category.");
		return 0;
	}
	
	cell *amx_Addr = NULL;
	amx_GetAddr(amx, params[2], &amx_Addr);
	if (amx_Addr == NULL)
	{
		logprintf("[NEFMOD] [debug] CRASH DETECTED! amx_Addr = NULL from amx_GetAddr in GetTeleportDialogString");
		return 0;
	}
	
	amx_SetString(amx_Addr, pTeleport->g_TeleportDialogString[params[1]], 0, 0, params[3] > 0 ? params[3] : std::strlen(pTeleport->g_TeleportDialogString[params[1]]) + 1);
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
	
	auto ReqTeleport = pTeleport->GetTeleport(params[1], params[2]);
	
	if (ReqTeleport == NULL || ReqTeleport == nullptr)
	{
		logprintf("[NEFMOD] [debug] CRASH DETECTED! ReqTeleport == NULL");
		return 0;
	}
	
	cell *amx_Addr = NULL;
	amx_GetAddr(amx, params[3], &amx_Addr);
	if (amx_Addr == NULL)
	{
		logprintf("[NEFMOD] [debug] CRASH DETECTED! amx_Addr = NULL from amx_GetAddr in ProcessTeleportRequest");
		return 0;
	}
	
	amx_SetString(amx_Addr, ReqTeleport->CCommand, 0, 0, params[4] > 0 ? params[4] : std::strlen(ReqTeleport->CCommand) + 1);
	return 1;
}

/* NC_OutputTeleportInfo() */
cell AMX_NATIVE_CALL Native::OutputTeleportInfo(AMX *amx, cell *params)
{
	for (int32_t i = 0; i < MAX_TELE_CATEGORIES; ++i)
	{
		logprintf("[NEFMOD] TP Category %i: %i TPs", i, pTeleport->GetCategorySize(i));
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
	
	std::time_t unixt = params[2];
	struct tm *ntime = localtime(&unixt);
	
	char date[50];
	std::strftime(date, sizeof(date), "%d/%m/%Y %H:%M:%S", ntime);
	
	cell *amx_Addr = NULL;
	amx_GetAddr(amx, params[1], &amx_Addr);
	if (amx_Addr == NULL)
	{
		logprintf("[NEFMOD] [debug] CRASH DETECTED! amx_Addr = NULL from amx_GetAddr in UnixtimeToDate");
		return 0;
	}
	amx_SetString(amx_Addr, date, 0, 0, params[3] > 0 ? params[3] : std::strlen(date));
	return 1;
}

/* NC_StringReplace(const transform[], const from[], const to[], dest[], len = sizeof(dest)) */
cell AMX_NATIVE_CALL Native::StringReplace(AMX *amx, cell *params)
{
	static const unsigned ParamCount = 5;
	PARAM_CHECK(ParamCount, "NC_StringReplace");
	
	char *_arg1 = NULL, *_arg2 = NULL, *_arg3 = NULL;
	amx_StrParam(amx, params[1], _arg1);
	amx_StrParam(amx, params[2], _arg2);
	amx_StrParam(amx, params[3], _arg3);
	
	if (_arg1 == NULL || _arg2 == NULL || _arg3 == NULL)
	{
		logprintf("[NEFMOD] Could not retrieve strings in StringReplace (NULL).");
		return 0;
	}
	
	std::string transform(_arg1);
	std::string from(_arg2);
	std::string to(_arg3);
	
	size_t begin = transform.find(from);
	if (begin == std::string::npos)
		return -1;
	
	transform.erase(begin, from.length());
	transform.insert(begin, to);
	
	cell *amx_Addr = NULL;
	amx_GetAddr(amx, params[4], &amx_Addr);
	if (amx_Addr == NULL)
	{
		logprintf("[NEFMOD] [debug] CRASH DETECTED! amx_Addr = NULL from amx_GetAddr in StringReplace");
		return -1;
	}
	
	amx_SetString(amx_Addr, transform.c_str(), 0, 0, params[5] > 0 ? params[5] : transform.length() + 1);
	return static_cast<cell>(begin);
}