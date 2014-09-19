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

class Teleports
{
public:
	Teleports(int32_t Category, const char *Name, const char *Command, float x, float y, float z);
	~Teleports();
	
	void GetPosition(float &x, float &y, float &z);

private:
	int32_t Category;
	std::string Name;
	std::string Command;
	
	float Position[3];
};

#endif /* _TELEPORTS_H_ */
