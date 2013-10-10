/*----------------------------------------------------------------------------*\
					==============================
					  y_als2 - Advanced hooking.
					==============================
Description:
	This code uses code-rewriting to dynamically insert either a function call
	or a constant value.  This code is called once when a callback chain point
	is reached (i.e. when one callback wants to call the next callback of the
	same type), and replaces its own call with the new call.
Legal:
	Version: MPL 1.1
	
	The contents of this file are subject to the Mozilla Public License Version 
	1.1 (the "License"); you may not use this file except in compliance with 
	the License. You may obtain a copy of the License at 
	http://www.mozilla.org/MPL/
	
	Software distributed under the License is distributed on an "AS IS" basis,
	WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
	for the specific language governing rights and limitations under the
	License.
	
	The Original Code is the YSI vararg include.
	
	The Initial Developer of the Original Code is Alex "Y_Less" Cole.
	Portions created by the Initial Developer are Copyright (C) 2011
	the Initial Developer. All Rights Reserved.
	
	Contributors:
		ZeeX, koolk, JoeBullet/Google63, g_aSlice/Slice
	
	Thanks:
		JoeBullet/Google63 - Handy arbitrary ASM jump code using SCTRL.
		ZeeX - Very productive conversations.
		koolk - IsPlayerinAreaEx code.
		TheAlpha - Danish translation.
		breadfish - German translation.
		Fireburn - Dutch translation.
		yom - French translation.
		50p - Polish translation.
		Zamaroht - Spanish translation.
		Dracoblue, sintax, mabako, Xtreme, other coders - Producing other modes
			for me to strive to better.
		Pixels^ - Running XScripters where the idea was born.
		Matite - Pestering me to release it and using it.
	
	Very special thanks to:
		Thiadmer - PAWN, whose limits continue to amaze me!
		Kye/Kalcor - SA:MP.
		SA:MP Team past, present and future - SA:MP.
	
Version:
	1.0
Changelog:
	02/05/11:
		First version.
Functions:
	Public:
		-
	Core:
		-
	Stock:
		-
	Static:
		-
	Inline:
		-
	API:
		-
Callbacks:
	-
Definitions:
	-
Enums:
	-
Macros:
	-
Tags:
	-
Variables:
	Global:
		-
	Static:
		-
Commands:
	-
Compile options:
	-
Operators:
	-
\*----------------------------------------------------------------------------*/

// Hooks version three.  This code HIGHLY optimises for return calls, and
// slightly optimises for other calls.  Fake function calls are inserted in to
// the code to pad out space, then replaced at run-time.

/*#if !defined ALS_PREFIX
#endif

#include <YSI\y_als>

#if defined ALS_CALL
	#undef ALS_CALL
#endif


#if defined ALS_GET
	#undef ALS_GET
#endif*/

#undef _inc_als2

#if !defined _ALS_2_INCLUDED
	#define _ALS_2_INCLUDED
	
	#if defined ALS_PREFIX
		#tryinclude <YSI\y_als>
	#else
		#define ALS_PREFIX
		#tryinclude <YSI\y_als>
		#undef ALS_PREFIX
	#endif
	
	#if defined _Y_ALS_INCLUDED
		#if defined _JIT
			// Support the new extended syntex.
			
			//#undef ALS_CALL
			//#undef ALS_GET
			
			//#define ALS_CALL<%0> ALS_DO:ALS_C_INT<%0>
			//#define ALS_GET<%0> ALS_DO:_ALS_C_INT<%0>
			
			#endinput
		#endif
		// Don't remove ALS_FORWARD
		
		#undef ALS_CALL
		#undef ALS_GET
		
		#undef ALS_DATA
		#define ALS_DATA<>
		
		#undef ALS_DETECT
		#define ALS_DETECT<%0>
	#else
		#if defined _JIT
			#error _JIT requires YSI\y_als to work.
		#endif
	#endif
	
	#define string:
	
	//#define ALS_CALL<%0> return _:_ALS_WITH_ON:_ALS_NO_ON:_ALS_NOTHING:_ALS_NO_P:ALS_Chain(%0)
	//#define ALS_CALL<%0> return _:_ALS_NOTHING:_ALS_NO_P:ALS_Chain(%0);
	#define ALS_CALL<%0> return _:_ALS_WITH_ON:_ALS_NOTHING:_ALS_NO_P:ALS_Chain(%0);
	
	//#define ALS_GET<%0> _:_ALS_WITH_ON:_ALS_NO_ON:_ALS_NOTHING:ALS_Call(%0)
	#define ALS_GET<%0> _:_ALS_WITH_ON:_ALS_NOTHING:ALS_Call(%0);
	//#define ALS_GET<%0> _:_ALS_NOTHING:ALS_Call(%0);
	
	//#define _ALS_WITH_ON:_ALS_NO_ON:_ALS_NOTHING:%3(%0_On%1) _ALS_P_%1(%3)(#%0"_On"#%1, _ALS_R_%1)
	#define _ALS_WITH_ON:_ALS_NOTHING:%3(%0_On%1) _ALS_P_%1(%3)(#%0"_On"#%1, _ALS_R_%1)
	//#define _ALS_NO_ON:_ALS_NOTHING:%3(%0_%1) _ALS_P_%1(%3)(#%0"_On"#%1, _ALS_R_%1)
	#define _ALS_NOTHING:%3(%1) _ALS_P_%1(%3)(#ALS_PREFIX"_On"#%1, _ALS_R_%1)
	
	#define _ALS_NO_P:%3ALS_%0_%1( %3ALS_%0(
	
	//#define _ALS_CALL ALS_Call
	//#define _ALS_CHAIN _ALS_ONLY_2:ALS_Chain
	
	//#define _ALS_ONLY_2:ALS_Chain(%0,%1,%2) ALS_Chain(%0,%1)
	
	// Define the default return values for every callback.
	#define _ALS_R_GameModeInit 1
	#define _ALS_R_GameModeExit 1
	#define _ALS_R_FilterScriptInit 1
	#define _ALS_R_FilterScriptExit 1
	#define _ALS_R_PlayerConnect 1
	#define _ALS_R_PlayerDisconnect 1
	#define _ALS_R_PlayerSpawn 1
	#define _ALS_R_PlayerDeath 1
	#define _ALS_R_VehicleSpawn 1
	#define _ALS_R_VehicleDeath 1
	#define _ALS_R_PlayerText 1
	#define _ALS_R_PlayerCommandText 0
	#define _ALS_R_PlayerRequestClass 1
	#define _ALS_R_PlayerEnterVehicle 1
	#define _ALS_R_PlayerExitVehicle 1
	#define _ALS_R_PlayerStateChange 1
	#define _ALS_R_PlayerEnterCheckpoint 1
	#define _ALS_R_PlayerLeaveCheckpoint 1
	#define _ALS_R_PlayerEnterRaceCP 1
	#define _ALS_R_PlayerLeaveRaceCP 1
	#define _ALS_R_RconCommand 1
	#define _ALS_R_PlayerRequestSpawn 1
	#define _ALS_R_ObjectMoved 1
	#define _ALS_R_PlayerObjectMoved 1
	#define _ALS_R_PlayerPickUpPickup 1
	#define _ALS_R_VehicleMod 1
	#define _ALS_R_EnterExitModShop 1
	#define _ALS_R_VehiclePaintjob 1
	#define _ALS_R_VehicleRespray 1
	#define _ALS_R_VehicleDamageStatusUp 1
	#define _ALS_R_PlayerSelectedMenuRow 1
	#define _ALS_R_PlayerExitedMenu 1
	#define _ALS_R_PlayerInteriorChange 1
	#define _ALS_R_PlayerKeyStateChange 1
	#define _ALS_R_RconLoginAttempt 1
	#define _ALS_R_PlayerUpdate 1
	#define _ALS_R_PlayerStreamIn 1
	#define _ALS_R_PlayerStreamOut 1
	#define _ALS_R_VehicleStreamIn 1
	#define _ALS_R_VehicleStreamOut 1
	#define _ALS_R_DialogResponse 1
	#define _ALS_R_PlayerClickPlayer 1
	#define _ALS_R_PlayerClickMap 1
	#define _ALS_R_PlayerClickTextDraw 1
	#define _ALS_R_PlayerClickPlayerTD 1
	#define _ALS_R_PlayerEditObject 1
	#define _ALS_R_PlayerEditAttachedObj 1
	#define _ALS_R_PlayerSelectObject 1
	#define _ALS_R_PlayerTakeDamage 1
	#define _ALS_R_PlayerGiveDamage 1
	
	// Define the number of parameter for every callback.
	#define _ALS_P_GameModeInit(%0) %0_0
	#define _ALS_P_GameModeExit(%0) %0_0
	#define _ALS_P_FilterScriptInit(%0) %0_0
	#define _ALS_P_FilterScriptExit(%0) %0_0
	#define _ALS_P_PlayerConnect(%0) %0_Def
	#define _ALS_P_PlayerDisconnect(%0) %0_2
	#define _ALS_P_PlayerSpawn(%0) %0_Def
	#define _ALS_P_PlayerDeath(%0) %0_3
	#define _ALS_P_VehicleSpawn(%0) %0_Def
	#define _ALS_P_VehicleDeath(%0) %0_2
	#define _ALS_P_PlayerText(%0) %0_2
	#define _ALS_P_PlayerCommandText(%0) %0_2
	#define _ALS_P_PlayerRequestClass(%0) %0_2
	#define _ALS_P_PlayerEnterVehicle(%0) %0_3
	#define _ALS_P_PlayerExitVehicle(%0) %0_2
	#define _ALS_P_PlayerStateChange(%0) %0_3
	#define _ALS_P_PlayerEnterCheckpoint(%0) %0_Def
	#define _ALS_P_PlayerLeaveCheckpoint(%0) %0_Def
	#define _ALS_P_PlayerEnterRaceCP(%0) %0_Def
	#define _ALS_P_PlayerLeaveRaceCP(%0) %0_Def
	#define _ALS_P_RconCommand(%0) %0_Def
	#define _ALS_P_PlayerRequestSpawn(%0) %0_Def
	#define _ALS_P_ObjectMoved(%0) %0_Def
	#define _ALS_P_PlayerObjectMoved(%0) %0_2
	#define _ALS_P_PlayerPickUpPickup(%0) %0_2
	#define _ALS_P_VehicleMod(%0) %0_3
	#define _ALS_P_EnterExitModShop(%0) %0_3
	#define _ALS_P_VehiclePaintjob(%0) %0_3
	#define _ALS_P_VehicleRespray(%0) %0_4
	#define _ALS_P_VehicleDamageStatusUp(%0) %0_2
	#define _ALS_P_PlayerSelectedMenuRow(%0) %0_2
	#define _ALS_P_PlayerExitedMenu(%0) %0_Def
	#define _ALS_P_PlayerInteriorChange(%0) %0_3
	#define _ALS_P_PlayerKeyStateChange(%0) %0_3
	#define _ALS_P_RconLoginAttempt(%0) %0_3
	#define _ALS_P_PlayerUpdate(%0) %0_Def
	#define _ALS_P_PlayerStreamIn(%0) %0_2
	#define _ALS_P_PlayerStreamOut(%0) %0_2
	#define _ALS_P_VehicleStreamIn(%0) %0_2
	#define _ALS_P_VehicleStreamOut(%0) %0_2
	#define _ALS_P_DialogResponse(%0) %0_5
	#define _ALS_P_PlayerClickPlayer(%0) %0_3
	#define _ALS_P_PlayerClickMap(%0) %0_4
	#define _ALS_P_PlayerClickTextDraw(%0) %0_2
	#define _ALS_P_PlayerClickPlayerTD(%0) %0_3
	#define _ALS_P_PlayerEditObject(%0) %0_Def0
	#define _ALS_P_PlayerEditAttachedObj(%0) %0_Def4
	#define _ALS_P_PlayerSelectObject(%0) %0_7
	#define _ALS_P_PlayerTakeDamage(%0) %0_4
	#define _ALS_P_PlayerGiveDamage(%0) %0_4
	
	static
		ALS_gsWriteOffset = -1,
		ALS_gsJumpOffset = -1,
		ALS_gsPublicOffset = -1;
	
	stock ALS_Call_Def(const string:func[])
	{
		// ALS_Call_Def is an optimised version for single parameter functions that
		// return "1".
		return ALS_Call(func, 1, 1, 1);
	}
	
	stock ALS_Call_0(const string:func[], ret)
	{
		// We need to write the code this horrible way to avoid having parameters
		// being allocated on the heap instead of the stack (as happens with "...").
		return ALS_Call(func, ret, 0, 2);
	}
	
	stock ALS_Call_1(const string:func[], ret)
	{
		return ALS_Call(func, ret, 1, 2);
	}
	
	stock ALS_Call_2(const string:func[], ret)
	{
		return ALS_Call(func, ret, 2, 2);
	}
	
	stock ALS_Call_3(const string:func[], ret, _p0 = 0)
	{
		// The fake parameters are just there to ensure we reserve enough code space
		// to do all the pushing required.
		#pragma unused _p0
		return ALS_Call(func, ret, 3, 3);
	}
	
	stock ALS_Call_4(const string:func[], ret, _p0 = 0, _p1 = 0)
	{
		#pragma unused _p0, _p1
		return ALS_Call(func, ret, 4, 4);
	}
	
	stock ALS_Call_5(const string:func[], ret, _p0 = 0, _p1 = 0, _p2 = 0)
	{
		#pragma unused _p0, _p1, _p2
		return ALS_Call(func, ret, 5, 5);
	}
	
	stock ALS_Call_6(const string:func[], ret, _p0 = 0, _p1 = 0, _p2 = 0, _p3 = 0)
	{
		#pragma unused _p0, _p1, _p2, _p3
		return ALS_Call(func, ret, 6, 6);
	}
	
	stock ALS_Call_7(const string:func[], ret, _p0 = 0, _p1 = 0, _p2 = 0, _p3 = 0, _p4 = 0)
	{
		#pragma unused _p0, _p1, _p2, _p3, _p4
		return ALS_Call(func, ret, 7, 7);
	}
	
	stock ALS_Call_8(const string:func[], ret, _p0 = 0, _p1 = 0, _p2 = 0, _p3 = 0, _p4 = 0, _p5 = 0)
	{
		#pragma unused _p0, _p1, _p2, _p3, _p4, _p5
		return ALS_Call(func, ret, 8, 8);
	}
	
	stock ALS_Call_9(const string:func[], ret, _p0 = 0, _p1 = 0, _p2 = 0, _p3 = 0, _p4 = 0, _p5 = 0, _p6 = 0)
	{
		#pragma unused _p0, _p1, _p2, _p3, _p4, _p5, _p6
		return ALS_Call(func, ret, 9, 9);
	}
	
	stock ALS_Call_10(const string:func[], ret, _p0 = 0, _p1 = 0, _p2 = 0, _p3 = 0, _p4 = 0, _p5 = 0, _p6 = 0, _p7 = 0)
	{
		#pragma unused _p0, _p1, _p2, _p3, _p4, _p5, _p6, _p7
		return ALS_Call(func, ret, 10, 10);
	}
	
	stock ALS_Call_11(const string:func[], ret, _p0 = 0, _p1 = 0, _p2 = 0, _p3 = 0, _p4 = 0, _p5 = 0, _p6 = 0, _p7 = 0, _p8 = 0)
	{
		#pragma unused _p0, _p1, _p2, _p3, _p4, _p5, _p6, _p7, _p8
		return ALS_Call(func, ret, 11, 11);
	}
	
	stock ALS_Call_12(const string:func[], ret, _p0 = 0, _p1 = 0, _p2 = 0, _p3 = 0, _p4 = 0, _p5 = 0, _p6 = 0, _p7 = 0, _p8 = 0, _p9 = 0)
	{
		#pragma unused _p0, _p1, _p2, _p3, _p4, _p5, _p6, _p7, _p8, _p9
		return ALS_Call(func, ret, 12, 12);
	}
	
	stock ALS_Call_13(const string:func[], ret, _p0 = 0, _p1 = 0, _p2 = 0, _p3 = 0, _p4 = 0, _p5 = 0, _p6 = 0, _p7 = 0, _p8 = 0, _p9 = 0, _p10 = 0)
	{
		#pragma unused _p0, _p1, _p2, _p3, _p4, _p5, _p6, _p7, _p8, _p9, _p10
		return ALS_Call(func, ret, 13, 13);
	}
	
	stock ALS_Call_14(const string:func[], ret, _p0 = 0, _p1 = 0, _p2 = 0, _p3 = 0, _p4 = 0, _p5 = 0, _p6 = 0, _p7 = 0, _p8 = 0, _p9 = 0, _p10 = 0, _p11 = 0)
	{
		#pragma unused _p0, _p1, _p2, _p3, _p4, _p5, _p6, _p7, _p8, _p9, _p10, _p11
		return ALS_Call(func, ret, 14, 14);
	}
	
	stock ALS_Call_15(const string:func[], ret, _p0 = 0, _p1 = 0, _p2 = 0, _p3 = 0, _p4 = 0, _p5 = 0, _p6 = 0, _p7 = 0, _p8 = 0, _p9 = 0, _p10 = 0, _p11 = 0, _p12 = 0)
	{
		#pragma unused _p0, _p1, _p2, _p3, _p4, _p5, _p6, _p7, _p8, _p9, _p10, _p11, _p12
		return ALS_Call(func, ret, 15, 15);
	}
	
	static stock ALS_DoNothing()
	{
		// New global base address code based on code by Zeex in YSI.  See:
		// https://github.com/Y-Less/YSI/pull/14
		return 0;
	}
	
	static stock ALS_GetGlobal()
	{
		new
			addr;
		// Get the offset from "DAT" to "COD" for writing new code.
		#emit LCTRL          0
		#emit MOVE.alt
		#emit LCTRL          1
		#emit SUB.alt
		#emit STOR.pri       ALS_gsWriteOffset
		// Call dummy function and read its (absolute) address from code.
		ALS_DoNothing();
		#emit LCTRL          6
		#emit ADD.C          0xFFFFFFF4
		#emit LOAD.alt       ALS_gsWriteOffset
		#emit ADD
		#emit STOR.S.pri     addr
		#emit LREF.S.pri     addr
		// Get difference between absolute and relative addresses.
		#emit CONST.alt      ALS_DoNothing
		#emit SUB
		#emit STOR.pri       ALS_gsJumpOffset
		// Get the relative offset to the start of the publics table.
		#emit LCTRL          1
		#emit NEG
		#emit MOVE.alt
		#emit ADD.C          32
		#emit STOR.S.pri     addr
		#emit LREF.S.pri     addr
		#emit ADD
		#emit STOR.pri       ALS_gsPublicOffset
	}
	
	stock ALS_Call(const string:func[], ret, count, clamped)
	{
		//printf("ret = %d", ret);
		if (ALS_gsWriteOffset == -1)
		{
			ALS_GetGlobal();
		}
		// Put the address offset in to "addr".  Need code to handle the case where
		// the callback has less parameters than this function.
		new
			end,
			//clamped = ((count <= 2) ? (2) : (count)),
			addr = clamped * 8 + 16,
			idx = funcidx(func) * 8;
		// Get the write address MANY bytes before the PREVIOUS function call.
		#emit LOAD.S.pri         0
		#emit ADD.C              4
		#emit LOAD.I
		#emit STOR.S.pri         end
		#emit LOAD.S.alt         addr
		#emit SUB
		#emit MOVE.alt
		// Store the new return to the previous function's stack.
		#emit LOAD.S.pri         0
		#emit ADD.C              4
		#emit XCHG
		#emit STOR.I
		// Get the write offset to the function address.
		#emit LOAD.alt           ALS_gsWriteOffset
		#emit ADD
		#emit STOR.S.pri         addr
		// This version basically replaces itself with call to the next item in the
		// chain if needed, or a CONST.pri if not to get the default return.
		// Change "count" to an instruction length offset.
		if (idx == -8)
		{
			// This writes code to return the value given in "ret" back in the
			// calling function, then jumps to that new code.
			#emit CONST.pri      11
			#emit SREF.S.pri     addr
			addr += 4;
			#emit LOAD.S.pri     ret
			#emit SREF.S.pri     addr
			addr += 4;
			// Now we need to jump over at least 4 cells.  Here the extra "2" in
			// "clamped" account for the parameter count "push" and "call" opcodes.
			#emit CONST.pri      51
			#emit SREF.S.pri     addr
			addr += 4;
			// Calculate the absolute address.
			#emit LOAD.S.pri     0
			#emit ADD.C          4
			#emit LOAD.I
			#emit LOAD.alt       ALS_gsJumpOffset
			#emit ADD
			// Add on enough offsets to jump past the function call.
			#emit ADD.C          16
			#emit LOAD.S.alt     clamped
			#emit XCHG
			#emit SMUL.C         8
			#emit ADD
			#emit SREF.S.pri     addr
			// NOP the remaining code.
			addr += 4;
			end += ALS_gsWriteOffset;
			while (addr != end)
			{
				#emit CONST.pri  134
				#emit SREF.S.pri addr
				addr += 4;
			}
			return 0;
		}
		else
		{
			while (clamped > count)
			{
				// NOP NOP
				#emit CONST.pri  134
				#emit SREF.S.pri addr
				addr += 4;
				#emit CONST.pri  134
				#emit SREF.S.pri addr
				addr += 4;
				--clamped;
			}
			// Start writing code to push all the parameters.
			clamped = clamped * 4 + 8;
			while (clamped > 8)
			{
				// PUSH.S <clamped>
				#emit CONST.pri  41
				#emit SREF.S.pri addr
				addr += 4;
				#emit LOAD.S.pri clamped
				#emit SREF.S.pri addr
				#emit ADD.C      0xFFFFFFFC
				#emit STOR.S.pri clamped
				addr += 4;
			}
			// PUSH.C <count * 4>
			#emit CONST.pri  39
			#emit SREF.S.pri addr
			addr += 4;
			#emit LOAD.S.pri count
			#emit SMUL.C     4
			#emit SREF.S.pri addr
			addr += 4;
			// Get the absolute address of the function to call.
			idx += ALS_gsPublicOffset;
			#emit LREF.S.pri     idx
			#emit LOAD.alt       ALS_gsJumpOffset
			#emit ADD
			#emit STOR.S.pri     idx
			// Write the new call code.
			// CALL
			#emit CONST.pri      49
			#emit SREF.S.pri     addr
			addr += 4;
			#emit LOAD.S.pri     idx
			#emit SREF.S.pri     addr
			addr += 4;
			end += ALS_gsWriteOffset;
			while (addr != end)
			{
				#emit CONST.pri  134
				#emit SREF.S.pri addr
				addr += 4;
			}
			return 0;
		}
	}
	
	stock ALS_Chain(const string:func[], ret)
	{
		if (ALS_gsWriteOffset == -1)
		{
			ALS_GetGlobal();
		}
		new
			start,
			end,
			addr,
			idx = funcidx(func) * 8;
		// Get the original cleanup code.
		#emit LOAD.S.pri         4
		#emit LOAD.alt           ALS_gsWriteOffset
		#emit ADD
		#emit STOR.S.pri         start
		#emit STOR.S.pri         end
		do
		{
			#emit LREF.S.pri     end
			#emit STOR.S.pri     addr
			end += 4;
			// Find "RETN".
		}
		while (addr != 48);
		// Get the write address 32 bytes before this function call.
		#emit LOAD.S.pri         4
		#emit ADD.C              0xFFFFFFE0
		// Store the new return.
		#emit STOR.S.pri         4
		#emit LOAD.alt           ALS_gsWriteOffset
		#emit ADD
		#emit STOR.S.pri         addr
		if (idx == -8)
		{
			// This writes code to return the value given in "ret" back in the
			// calling function, then jumps to that new code.
			// "CONST.pri"
			#emit CONST.pri      11
			#emit SREF.S.pri     addr
			addr += 4;
			#emit LOAD.S.pri     ret
			#emit SREF.S.pri     addr
			addr += 4;
			// Restore the existing cleanup code.  Should also manage the heap.
			while (start != end)
			{
				#emit LREF.S.pri start
				#emit SREF.S.pri addr
				start += 4;
				addr += 4;
			}
			// Make everything else "NOP".
			while (addr != end)
			{
				#emit CONST.pri  134
				#emit SREF.S.pri addr
				addr += 4;
			}
			return 0;
		}
		else
		{
			// Get the absolute address of the function to jump in to.
			idx += ALS_gsPublicOffset;
			#emit LREF.S.pri     idx
			#emit LOAD.alt       ALS_gsJumpOffset
			#emit ADD
			#emit ADD.C          4
			#emit STOR.S.pri     idx
			// Write the new call code.
			// First clean up the stack.
			end -= 4;
			while (start != end)
			{
				#emit LREF.S.pri start
				#emit SREF.S.pri addr
				start += 4;
				addr += 4;
			}
			//end += 4;
			// JUMP
			#emit CONST.pri      51
			#emit SREF.S.pri     addr
			addr += 4;
			#emit LOAD.S.pri     idx
			#emit SREF.S.pri     addr
			// Blank with NOPs.
			while (addr != end)
			{
				addr += 4;
				#emit CONST.pri  134
				#emit SREF.S.pri addr
			}
			return 0;
		}
	}
#endif

#if !defined ALS_PREFIX
	//#error You must define a callback prefix before including y_als.
	#define ALS_PREFIX Mode
#endif