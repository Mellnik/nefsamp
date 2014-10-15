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

#include <string>
#include <vector>
#include <memory>

#include "main.h"

#define MAX_TELE_CATEGORIES 9
#define MAX_TELES_PER_CATEGORY 32
#define MAX_TELE_COMMAND_NAME 16

struct Teleport_t
{
public:
	Teleport_t(int32_t Category, const char *Name, const char *Command, float x, float y, float z)
	{
		this->Command = "/";
		this->Name.assign(Name);
		this->Command.append(Command);
		this->Category = Category;
		this->Position[0] = x;
		this->Position[1] = y;
		this->Position[2] = z;
	}
	
	const char *GetCommandName();
	void GetPosition(float &x, float &y, float &z);
	
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
	
	void AddTeleport(int32_t category, Teleport_t *tp)
	{
		m_Teleports[category].push_back(tp);
	}
	
	int32_t GetCategorySize(int32_t category)
	{
		return m_Teleports[category].size();
	}
	
	Teleport_t *GetTeleport(int32_t category, int32_t port)
	{
		return m_Teleports[category][port];
	}
	
private:
	std::vector<Teleport_t *> m_Teleports[MAX_TELE_CATEGORIES];
};

extern std::unique_ptr<Teleport> pTeleport;

#endif /* _TELEPORT_H_ */