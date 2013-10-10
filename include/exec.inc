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

#if defined _exec_included
  #endinput
#endif

#define _exec_included

// Execute an OS command
native exec(command[]);

// Enable command logging
native exec_debug(bool:enable=true);

// Get enviroment variable (http://www.cplusplus.com/reference/cstdlib/getenv/)
native getenv(command[], dest[], len=sizeof(dest));

// Called when a command has been executed
forward OnCommandExecuted(command[], result_code);
