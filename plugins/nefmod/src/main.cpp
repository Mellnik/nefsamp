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

#include <cstdlib>

#include "plugin.h"
#include "native.h"
#include "teleport.h"
#include "main.h"

logprintf_t logprintf;
extern void *pAMXFunctions;

PLUGIN_EXPORT unsigned int PLUGIN_CALL Supports()
{
	return SUPPORTS_VERSION | SUPPORTS_AMX_NATIVES;
}

PLUGIN_EXPORT bool PLUGIN_CALL Load(void **ppData)
{
	pAMXFunctions = ppData[PLUGIN_DATA_AMX_EXPORTS];
	logprintf = (logprintf_t)ppData[PLUGIN_DATA_LOGPRINTF];

	pPlugin.reset(new Plugin());
	pTeleport.reset(new Teleport());
	
	logprintf("[NEFMOD] Core successfully loaded "PLUGIN_VERSION"");
	return true;
}

PLUGIN_EXPORT void PLUGIN_CALL Unload()
{
	pPlugin.reset();
	pTeleport.reset();
	logprintf("[NEFMOD] Core unloaded.");
}

const AMX_NATIVE_INFO PluginNatives[] =
{
	{"NC_AddTeleport", Native::AddTeleport},	
	{"NC_ProcessTeleportRequest", Native::ProcessTeleportRequest},	
	{"NC_OutputTeleportInfo", Native::OutputTeleportInfo},
	{"NC_UnixtimeToDate", Native::UnixtimeToDate},
	{NULL, NULL}
};

PLUGIN_EXPORT int PLUGIN_CALL AmxLoad(AMX *amx)
{
	pPlugin->AddAmx(amx);
	return amx_Register(amx, PluginNatives, -1);
}

PLUGIN_EXPORT int PLUGIN_CALL AmxUnload(AMX *amx)
{
	pPlugin->EraseAmx(amx);
	return AMX_ERR_NONE;
}