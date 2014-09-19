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

#pragma once

#ifndef _PLUGIN_H_
#define _PLUGIN_H_

#include <list>

#include "main.h"
#include "singleton.h"

class Plugin : public CSingleton<Plugin>
{
public:
	Plugin() { }
	~Plugin() { }

	void EraseAmx(AMX *amx);
	void AddAmx(AMX *amx);
	std::list<AMX *> &GetAmxList();

private:
	std::list<AMX *> amx_List;
};

#endif
