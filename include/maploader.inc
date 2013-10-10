/*
 * Copyright (c) 2013, Mellnik
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
 
#if defined _maploader_included
	#endinput
#endif
#define _maploader_included

#include <a_samp>
#include <YSI\y_iterate>
#include <YSI\y_hooks>
#include <sscanf2>
#include <streamer>

#define MAX_MAPS (10)

enum E_map_data
{
	e_model_id,
	Float:e_pos_x,
	Float:e_pos_y,
	Float:e_pos_z,
	Float:e_rot_x,
	Float:e_rot_y,
	Float:e_rot_z,
	Float:e_static_sd,
	e_worldid,
	e_interiorid,
	e_playerid,
	Float:e_dyn_sd
};

new Iterator:g_Maps[MAX_MAPS]<50000>;

stock LoadMap(mapfile[], bool:streamed)
{
	if(!fexist(mapfile)) return 0;

	new buffer[255],
		File:fmap = fopen(mapfile, io_read),
		MapData[E_map_data];
	
	for(new line = 1; fread(fmap, buffer); line++)
	{
	    if(streamed)
	    {
			if(!sscanf(buffer, "e<P<(),>{s[20]}iffffff-fI(-1)I(-1)I(-1)F(300.0)>", MapData))
			{
   				CreateDynamicObject(MapData[e_model_id], MapData[e_pos_x], MapData[e_pos_y], MapData[e_pos_z], MapData[e_rot_x], MapData[e_rot_y], MapData[e_rot_z], MapData[e_worldid], MapData[e_interiorid], MapData[e_playerid], MapData[e_dyn_sd]);
			}
			else
			{
			    printf("[ML] Failed loading dynamic object in %s at line %i", mapfile, line);
			}
		}
	    else
	    {
	        if(!sscanf(buffer, "e<P<(),>{s[20]}iffffffF(0.0)-i-i-i-f>", MapData))
			{
		        CreateObject(MapData[e_model_id], MapData[e_pos_x], MapData[e_pos_y], MapData[e_pos_z], MapData[e_rot_x], MapData[e_rot_y], MapData[e_rot_z], MapData[e_static_sd]);
		    }
			else
			{
			    printf("[ML] Failed loading object in %s at line %i", mapfile, line);
			}
		}
	}
	fclose(fmap);
	
	return 1;
}

#if !defined FILTERSCRIPT

hook OnGameModeInit()
{
	Iter_Init(g_Maps);
	return 1;
}

#else

hook OnFilterScriptInit()
{
	Iter_Init(g_Maps);
	return 1;
}

#endif
