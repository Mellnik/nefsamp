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

#include "plugin.h"

void Plugin::AddAmx(AMX *amx)
{
	amx_List.push_back(amx);
}

void Plugin::EraseAmx(AMX *amx)
{
	for (std::list<AMX *>::iterator i = amx_List.begin(); i != amx_List.end(); ++i) 
	{
		if (*i == amx) 
		{
			amx_List.erase(i);
			break;
		}
	}
}

std::list<AMX *> &Plugin::GetAmxList()
{
	return amx_List;
}
