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
#include "natives.h"
#include "main.h"

logprintf_t logprintf;
extern void *pAMXFunctions;

PLUGIN_EXPORT unsigned int PLUGIN_CALL Supports()
{
	return SUPPORTS_VERSION | SUPPORTS_AMX_NATIVES | SUPPORTS_PROCESS_TICK;
}

PLUGIN_EXPORT bool PLUGIN_CALL Load(void **ppData)
{
	pAMXFunctions = ppData[PLUGIN_DATA_AMX_EXPORTS];
	logprintf = (logprintf_t)ppData[PLUGIN_DATA_LOGPRINTF];

	logprintf("[NEFMOD] Core successfully loaded "PLUGIN_VERSION" (Compiled on "__DATE__", "__TIME__").");
	return true;
}

PLUGIN_EXPORT void PLUGIN_CALL Unload()
{
	Plugin::Destroy();
	logprintf("[NEFMOD] Plugin unloaded.");
}

PLUGIN_EXPORT void PLUGIN_CALL ProcessTick()
{

}

AMX_NATIVE_INFO nefmod_natives[] =
{
	{"ResolveHostname", Native::ResolveHostname},
	{NULL, NULL}
};

PLUGIN_EXPORT int PLUGIN_CALL AmxLoad(AMX *amx)
{
	Plugin::Get()->AddAmx(amx);
	return amx_Register(amx, nefmod_natives, -1);
}

PLUGIN_EXPORT int PLUGIN_CALL AmxUnload(AMX *amx)
{
	Plugin::Get()->EraseAmx(amx);
	return AMX_ERR_NONE;
}
