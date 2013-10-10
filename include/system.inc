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

#if defined _system_included
  #endinput
#endif

#define _system_included

#define exec(%1) system(%1)
#define exec_debug(%1) system_debug(%1)

// Execute an OS command
native system(command[]);

// Enable system(...) command logging
native system_debug(bool:enable=true);

// Get enviroment variable (http://www.cplusplus.com/reference/cstdlib/getenv/ and http://msdn.microsoft.com/en-us/library/ms175774%28v=vs.80%29.aspx)
native getenv(env_var[], dest[], len=sizeof(dest));

// Modify value of an enviroment variable
native setenv(env_var[], value[]);

// Delete an enviroment variable
native delenv(env_var[]);

// Get total amount of physical memory
native total_phys_memory();

// Get amount of available physical memory
native avail_phys_memory();

// Called when a exec command has been executed
forward OnCommandExecuted(command[], result_code);

// Get amount of physical memory currently in use
stock inuse_phys_memory()
{
	return (total_phys_memory() - avail_phys_memory());
}