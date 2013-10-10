/**********************************
 *                                *
 *   @Author:      wups           *
 *   @Version:     1.1.0          *
 *   @Released:    31/10/2010     *
 *                                *
 **********************************/

#if defined _moneyhax_included
	#endinput
#endif
#define _moneyhax_included

stock moneyhax_GivePlayerMoney(playerid,amount)
	return CallRemoteFunction("GivePlayerMonez","ii",playerid,amount);
	
stock moneyhax_ResetPlayerMoney(playerid)
	return CallRemoteFunction("ResetPlayerMonez","i",playerid);

stock moneyhax_GetPlayerMoney(playerid)
	return CallRemoteFunction("GetPlayerMonez","i",playerid);

#define GivePlayerMoney 			moneyhax_GivePlayerMoney
#define ResetPlayerMoney 			moneyhax_ResetPlayerMoney
#define GetPlayerMoney 				moneyhax_GetPlayerMoney