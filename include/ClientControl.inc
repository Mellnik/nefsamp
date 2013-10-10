/*
 * Copyright (C) 2012 Mellnik
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

#if defined _clientcontrol_included
  #endinput
#endif

#define _clientcontrol_included
#pragma library ClientControl

forward OnPlayerClientControlConnect(playerid);
forward OnPlayerClientControlDisconect(playerid, reason);
forward OnPlayerPressKey(playerid, key);

enum (+= 1)
{
	KEY_M,
	KEY_K,
	KEY_N
}
// 0xB7CB49  check

#define REASON_LEAVE 0
#define REASON_TIMEOUT 1

// 0xBA6748 + 0x5C
#define RADIO_PLAYBACKFM 1
#define RADIO_OFF 13

native SetPlayerRadioStation(playerid);
native GetPlayerRadioStation(playerid);
native TogglePlayerRadar(playerid, bool:enabled = true);
native SetPlayerGravity(playerid, Float:gravity); // 0x863984 
native IsPlayerCrouching(playerid); // 0xB6F5F0 + 0x46F // 128 no 132 yes
native TogglePlayerGodMode(playerid, bool:enabled = true);
native IsPlayerInGodMode(playerid);
native TogglePlayerUnlimitedAmmo(playerid, bool:enabled = true);
native HasPlayerUnlimitedAmmo(playeird);
native TogglePlayerUnlimitedOxygen(playerid, bool:enabled = true);
native HasPlayerUnlimitedOxygen(playerid);