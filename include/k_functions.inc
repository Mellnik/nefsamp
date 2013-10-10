#include <a_samp>
#if defined _k_functions_included
	#endinput
#endif
#define _k_functions_included
#pragma library k_functions

/*
native IsPlayerInterior(playerid)
native ResetAllCash()
native KickAll()
native SetAllPos(Float:x,Float:y,Float:z)
native SetAllHealth(Float:Health)
native SetAllArmour(Float:Armour)
native SetAllSkin(Skinid)
native GiveAllWeapon(Weaponid,Ammo)
native SetAllScore(Score)
native ResetAllWeapons()
native SetAllTime(Hour,Minute)
native FreezeAll()
native UnfreezeAll()
native IsPlayerSkin(playerid,Skinid)
native IsPlayerHealth(playerid,Float:Health)
native SetAllVirtualWorld(Worldid)
//--
native SetAllTeam(Team)
native LockAllCars()
native UnlockAllCars()
native GivePlayerArmour(playerid, Float:Armour)
native GiveScore(playerid,score)
native GivePlayerHealth(playerid, Float:health)
//--
native UnlockPlayerCar(playerid)
native UnlockcarForPlayer(playerid,carid)
native Unlockcar(carid)
native Lockcar(carid)
native LockPlayerCar(playerid)
native LockcarForPlayer(playerid,carid)
//--
IsPlayerArmoured(playerid)
IsPlayerAlive(playerid)
Slap (playerid,Height,Health)
RespawnAllVehicles()
*/

#pragma unused IsPlayerInterior
#pragma unused ResetAllCash
#pragma unused KickAll
#pragma unused SetAllPos
#pragma unused SetAllHealth
#pragma unused SetAllArmour
#pragma unused SetAllSkin
#pragma unused GiveAllWeapon
#pragma unused SetAllScore
#pragma unused ResetAllWeapons
#pragma unused SetAllTime
#pragma unused FreezeAll
#pragma unused UnfreezeAll
#pragma unused IsPlayerSkin
#pragma unused IsPlayerHealth
#pragma unused SetAllVirtualWorld
//--
#pragma unused SetAllTeam
#pragma unused LockAllCars
#pragma unused UnlockAllCars
#pragma unused GivePlayerHealth
#pragma unused GivePlayerArmour
#pragma unused GiveScore
#pragma unused UnlockPlayerCar
#pragma unused UnlockcarForPlayer
#pragma unused Unlockcar
#pragma unused Lockcar
#pragma unused LockPlayerCar
#pragma unused LockcarForPlayer
//--
#pragma unused IsPlayerArmoured
#pragma unused IsPlayerAlive
#pragma unused Slap 
#pragma unused RespawnAllVehicles

IsPlayerInterior(playerid)
{
if (GetPlayerInterior(playerid)>0)
return true;
else 
return false;
}

ResetAllCash()
{
for(new i=0; i < MAX_PLAYERS; i++)
ResetPlayerMoney(i);
}

KickAll()
{
for(new i=0; i < MAX_PLAYERS; i++)
Kick(i);
}

SetAllPos(Float:x,Float:y,Float:z)
{
for(new i=0; i < MAX_PLAYERS; i++)
SetPlayerPos(i,x,y,z);
}


SetAllHealth(Float:Health)
{
for(new i=0; i < MAX_PLAYERS; i++)
SetPlayerHealth(i,Health);
}

SetAllArmour(Float:Armour)
{
for(new i=0; i < MAX_PLAYERS; i++)
SetPlayerArmour(i,Armour);
}

SetAllSkin(Skinid)
{
for(new i=0; i < MAX_PLAYERS; i++)
SetPlayerSkin(i,Skinid);
}

SetAllScore(Score)
{
for(new i=0; i < MAX_PLAYERS; i++)
SetPlayerScore(i,Score);
}

GiveAllWeapon(Weaponid,Ammo)
{
for(new i=0; i < MAX_PLAYERS; i++)
GivePlayerWeapon(i,Weaponid,Ammo);
}

ResetAllWeapons()
{
for(new i=0; i < MAX_PLAYERS; i++)
ResetPlayerWeapons(i);
}

SetAllTime(Hour,Minute)
{
for(new i=0; i < MAX_PLAYERS; i++)
SetPlayerTime(i,Hour,Minute);
}


FreezeAll()
{
for(new i=0; i < MAX_PLAYERS; i++)
TogglePlayerControllable(i,0);
}

UnfreezeAll()
{
for(new i=0; i < MAX_PLAYERS; i++)
{
TogglePlayerControllable(i,1);
}
}


IsPlayerSkin(playerid,Skinid)
{
if (GetPlayerSkin(playerid) == Skinid)
return true;
else
return false;
}

IsPlayerHealth(playerid,Float:Health)
{
new Float:health;
if (GetPlayerHealth(playerid,health)==Health)
return true;
else
return false;
}


SetAllVirtualWorld(World)
{
for(new i=0; i < MAX_PLAYERS; i++)
SetPlayerVirtualWorld(i,World);
}

SetAllTeam(Team)
{
for(new i=0; i < MAX_PLAYERS; i++)
SetPlayerTeam(i,Team);
}


LockAllCars()
{
for(new k = 0; k < MAX_VEHICLES;k++)
{
for(new i=0; i < MAX_PLAYERS; i++)
{
SetVehicleParamsForPlayer(k,i,0,1);
}
}
}

UnlockAllCars()
{
for(new k = 0; k < MAX_VEHICLES;k++)
{
for(new i=0; i < MAX_PLAYERS; i++)
{
SetVehicleParamsForPlayer(k,i,0,0);
}
}
}

GiveScore(playerid,score)
{
SetPlayerScore(playerid, GetPlayerScore(playerid)+score);
}

GivePlayerHealth(playerid, Float:health)
{
new Float:health1;
GetPlayerHealth(playerid, health1);
SetPlayerHealth(playerid, health1+health);
}

GivePlayerArmour(playerid, Float:Armour)
{
new Float:Armour1;
GetPlayerArmour(playerid, Armour1);
SetPlayerArmour(playerid, Armour1+Armour);
}

Lockcar(carid)
{
for(new i=0; i < MAX_PLAYERS; i++)
SetVehicleParamsForPlayer(carid,i,0,1);
}

LockPlayerCar(playerid)
{
new VEH;
VEH= GetPlayerVehicleID(playerid);
if (IsPlayerInVehicle(playerid,VEH))
{
for(new i=0; i < MAX_PLAYERS; i++)
SetVehicleParamsForPlayer(VEH,i,0,1);
}
}

LockcarForPlayer(playerid,carid)
{
SetVehicleParamsForPlayer(carid,playerid,0,1);
}

Unlockcar(carid)
{
for(new i=0; i < MAX_PLAYERS; i++)
SetVehicleParamsForPlayer(carid,i,0,0);
}

UnlockcarForPlayer(playerid,carid)
{
SetVehicleParamsForPlayer(carid,playerid,0,0);
}

UnlockPlayerCar(playerid)
{
new VEH;
VEH= GetPlayerVehicleID(playerid);
if (IsPlayerInVehicle(playerid,VEH))
{
for(new i=0; i < MAX_PLAYERS; i++)
SetVehicleParamsForPlayer(VEH,i,0,1);
}
}

Slap (playerid,Height,Health)
{
new Float:X, Float:Y, Float:Z,Float:health1;
GetPlayerPos(playerid,X,Y,Z);
SetPlayerPos(playerid,X,Y,Z+Height);
GetPlayerHealth(playerid, health1);
SetPlayerHealth(playerid, health1+Health);
}

IsPlayerAlive(playerid)
{
new Float:health;
if (GetPlayerHealth(playerid,health)<0)
return false;
else 
return true;
}

IsPlayerArmoured(playerid)
{
new Float:armour;
if (GetPlayerArmour(playerid,armour)==0)
return false;
else 
return true;
}

RespawnAllVehicles()
{
for(new k = 0; k < MAX_VEHICLES;k++)
{
SetVehicleToRespawn(k);
}
}
