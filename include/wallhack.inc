/*
 * Copyright (C) 2013 Mellnik
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// extrasensory perception for SA-MP

#if defined _esp_included
  #endinput
#endif
#define _esp_included

#ifndef _samp_included
	#error "You must include a_samp.inc first"
#endif

#ifndef MAX_PLAYERS
	#error "MAX_PLAYERS not found!"
#endif

#include <YSI\y_hooks>
#include <YSI\y_iterate>
#include <YSI\y_stringhash>

enum (<<= 1)
{
	ESP_OFF,
	ESP_LOCAL = 1,
	ESP_GLOBAL
};

enum Vect3D
{
	Float:X,
	Float:Y,
	Float:Z
};

enum Vect4D
{
	Float:X,
	Float:Y,
	Float:Z,
	Float:A
};

Iterator:g_PlayerList<

enum (<<= 1)
{
	FLAG_
};

hook OnGameModeInit()
{

}

hook OnPlayerStreamIn(playerid, forplayerid)
{

}

hook OnPlayerStreamOut(playerid, forplayerid)
{

}


Float:Internal_GetDistance3D()
{

}

bool:Internal_WorldToScreen()
{



	return true;
}


//Internal_WorldToScreen(&
//Internal_GetDistance3D()

//Internal_DrawBox
//Internal_

//ApplyESP(playerid, color, mode);
//

