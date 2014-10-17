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

#ifndef _TELEPORT_H_
#define _TELEPORT_H_

#include <string.h>
#include <string>
#include <vector>
#include <memory>

#include "main.h"

#define MAX_TELE_CATEGORIES 9
#define MAX_TELES_PER_CATEGORY 32
#define MAX_TELE_COMMAND_NAME 17

struct Teleport_t
{
public:
	Teleport_t(int32_t Category, const char *Name, const char *Command, float x, float y, float z)
	{
		this->Name.assign(Name);
		this->Command = "/";
		this->Command.append(Command);
		this->Category = Category;
		this->Position[0] = x;
		this->Position[1] = y;
		this->Position[2] = z;
	
		strncpy(CCommand, this->Command.c_str(), MAX_TELE_COMMAND_NAME);
	}
	
	char CCommand[MAX_TELE_COMMAND_NAME + 1];
	
private:
	int32_t Category;
	std::string Name;
	std::string Command;
	
	float Position[3];
};

class Teleport
{
public:
	Teleport() 
	{ 
		for (int32_t i = 0; i < MAX_TELE_CATEGORIES; ++i)
		{
			m_Teleports[i].reserve(MAX_TELES_PER_CATEGORY);
		}
	}
	
	~Teleport() { }
	
	void AddTeleport(int32_t category, Teleport_t *tp);
	int32_t GetCategorySize(int32_t category);
	Teleport_t *GetTeleport(int32_t category, int32_t port);
	
private:
	std::vector<Teleport_t *> m_Teleports[MAX_TELE_CATEGORIES];
};

extern std::unique_ptr<Teleport> pTeleport;

#endif /* _TELEPORT_H_ */