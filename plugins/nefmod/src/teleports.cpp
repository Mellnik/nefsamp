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

#include "teleports.h"

Teleports::Teleports(int32_t Category, const char *Name, const char *Command, float x, float y, float z)
{
	this->Name.assign(Name);
	this->Command.append(Command);
	this->Category = Category;
	this->Position[0] = x;
	this->Position[1] = y;
	this->Position[2] = z;
}

const char *Teleports::GetCommandName()
{
	return this->Command.c_str();
}

void Teleports::GetPosition(float &x, float &y, float &z)
{
	x = this->Position[0];
	y = this->Position[1];
	z = this->Position[2];
}