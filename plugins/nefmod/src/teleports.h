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

#ifndef _TELEPORTS_H_
#define _TELEPORTS_H_

#include <string>
#include <vector>

#include "main.h"
#include "singleton.h"

#define MAX_TELE_CATEGORIES 9
#define MAX_TELES_PER_CATEGORY 32
#define MAX_TELE_COMMAND_NAME 16

class Teleports
{
public:
	Teleports(int32_t Category, const char *Name, const char *Command, float x, float y, float z);
	~Teleports();
	
	const char *GetCommandName();
	void GetPosition(float &x, float &y, float &z);

private:
	int32_t Category = 0;
	std::string Name;
	std::string Command = "/";
	
	float Position[3] = {0.0f, 0.0f, 0.0f};
};

#endif /* _TELEPORTS_H_ */
