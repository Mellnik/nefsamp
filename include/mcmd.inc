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

#if defined _mcmd_included
  #endinput
#endif
#define _mcmd_included

#define mcmd:%1(%2)          \
			forward mcmd_%1(%2); \
			public mcmd_%1(%2)	

#define CMD: mcmd:
#define COMMAND: mcmd:

forward OnPlayerCommandReceived(playerid, cmdtext[]);
forward OnPlayerCommandPerformed(playerid, cmdtext[], cmd_found);

enum E_MCMD_OPT
{
	DISABLE_OPCR,
	DISABLE_OPCP
}

native mcmd_setopt(E_MCMD_OPT:opt, value);
