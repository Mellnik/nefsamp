/*=======================================================================================

This file is simply the Initial Staging platform of all of the code libraries that the TSS system uses

-----------------------------------------------------------------------------------------

LICENCE:=-

    tAxI's Streamer Systems: Main include - for SA-MP Multiplayer Modification
    of Grand Theft Auto - San Andreas.

    Copyright (C) 2008  Chris Johnstone (tAxI/Necrioss)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.

=======================================================================================*/

/*------------- Initiate System Loadup --------------*/

#include "TSS_LIB/TSS_core/TSS_core.own"

/*------------ System Natives --------------

			native tAxI_OnGameModeInit()
			native tAxI_OnVehicleDeath(vehicleid)
			native tAxI_OnPlayerEnterVehicle(playerid,vehicleid)
			native tAxI_OnPlayerExitVehicle(vehicleid)
			native tAxI_OnVehicleMod(vehicleid,componentid)
			native tAxI_OnVehicleRespray(vehicleid,color1,color2)
			native tAxI_OnVehiclePaintjob(vehicleid,paintjobid)
			native tAxI_OnVehicleSpawn(vehicleid)
			native tAxI_OnPlayerKeyStateChange(playerid,newkeys)
			native tAxI_OnPlayerStateChange(playerid,newstate,oldstate)
			native tAxI_OnPlayerDisconnect(playerid)
			native tAxI_OnPlayerConnect(playerid)
			native SetActiveStreamers(bool:vehicle,bool:minimap,bool:pickup,bool:object)
			native ------------------------------------------------------
			native SetBikeAntiFallForPlayer(playerid,bool:toggle)
			native ToggleAutoModSave(bool:toggle)
			native CreateStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2)
			native CreateStaticStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2,respawn_delay)
			native DestroyStreamVehicle(vstreamid)
			native SetStreamVehicleToRespawn(vstreamid)
			native CreateTempStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2)
			native GetPlayerVehicleStreamID(playerid)
			native GetVehicleStreamID(vehicleid)
			native GetVehicleStreamModel(vstreamid)
			native GetStreamVehicleID(vstreamid)
			native SetStreamVehiclePos(vstreamid,Float:x,Float:y,Float:z,Float:a)
			native SetVehicleStreamSpawnInfo(vstreamid,vmodel,Float:x,Float:y,Float:z,Float:a,color1,color2)
			native ForceStreamVehicleSpawn(vstreamid,Float:x,Float:y,Float:z,Float:a,worldid,interiorid,objective,UseSavedMods)
			native ChangeStreamVehiclePaintjob(vstreamid,paintjobid)
			native ChangeStreamVehicleColor(vstreamid,col1,col2)
			native AddStreamVehicleMod(vstreamid,componentid)
			native SetStreamVehicleParamsForPlayer(vstreamid,playerid,objective,doorslocked);
			native LinkStreamVehicleToInterior(vstreamid,interiorid)
			native SetStreamVehicleVirtualWorld(vstreamid,world)
			native GetStreamVehicleVirtualWorld(vstreamid)
			native ImportModsFromFile(const savefile[])
			native ExportModsToFile(const savefile[])
			native GetStreamVehiclePos(vstreamid,&Float:Xpos,&Float:Ypos,&Float:Zpos)
			native GetStreamVehicleZAngle(vstreamid,&Float:Angle)
			native PutPlayerInStreamVehicle(playerid,vstreamid)
			native SetStreamVehicleHealth(vstreamid,Float:health)
			native IsStreamVehicleStatic(vstreamid)
			native -------------------------------------------------------
			native CreateStreamObject(modelid,Float:x,Float:y,Float:z,Float:xrot,Float:yrot,Float:zrot,Float:spawn_dist)
			native DestroyStreamObject(objectid)
			native AttachStreamObjectToPlayer(objectid,playerid,Float:xoffset,Float:yoffset,Float:zoffset,Float:rotX,Float:rotY,Float:rotZ)
			native DetachStreamObjectFromPlayer(playerid)
			native IsAnyObjectAttachedToPlayer(playerid)
			native GetPlayerAttachedObject(playerid)
			native IsObjectAttachedToPlayer(objectid,playerid)
			native IsObjectAttachedToAnyPlayer(objectid)
			native MoveStreamObject(objectid,Float:X,Float:Y,Float:Z,Float:Speed)
			native StopStreamObject(objectid)
			native IsValidPlayerStreamObject(objectid,playerid)
			native SetObjectInfo(objectid,modelid,Float:X,Float:Y,Float:Z,Float:rotX,Float:rotY,Float:rotZ)
			native --------------------------------------------------------
			native CreateMapIcon(Float:x,Float:y,Float:z,modelid,Float:spawn_dist)
			native DestroyMapIcon(iconid)
			native GetPlayerClosestIcon(playerid)
			native IsPlayerInRangeOfIcon(playerid,iconid)
			native ChangeMapIconInfo(iconid,Float:x,Float:y,Float:z,modelid,Float:spawn_dist)
			native --------------------------------------------------------
			native CreateStreamPickup(modelid,type,Float:x,Float:y,Float:z,custom_type)
	                native DestroyStreamPickup(pstreamid)
	                native SetStreamPickupInfo(pstreamid,modelid,type,Float:x,Float:y,Float:z,custom_type)
	                native GetPickupStreamID(pickupid)
	                native GetStreamPickupID(pstreamid)
	                native GetStreamPickupCustomType(pstreamid)
			native --------------------------------------------------------
			native IsPlayerLoggedInHouseSystem(playerid)
			native IsHouseVehicle(vehicleid)
			native IsVehicleLinkedToHouse(vehicleid,houseid)
			native IsPlayerHouseOwner(playerid,houseid)
			native IsPlayerHouseVehicleOwner(playerid,vehicleid)
			native IsHouseLocked(houseid)
			native IsHouseVehicleLocked(houseid)
			native GetPlayerClosestHouse(playerid)
			native IsPlayerInRangeOfHouse(playerid,houseid,Float:max_range)
			native IsPlayerInAnyHouse(playerid)
			native GetPlayerCurrentHouse(playerid)
			native LogPlayerIntoHouseSystem(playerid)
			native LogPlayerOutOfHouseSystem(playerid)
			native SetSpawnAtHome(bool:toggle)
			native PutPlayerInHouse(playerid,houseid)
			native RemovePlayerFromHouse(playerid)
			native SetHouseLocked(houseid,bool:toggle)
			native SetHouseVehicleLocked(houseid,bool:toggle)
			native SetHouseVehicleAutoModForPlayer(playerid,bool:toggle)
			native LoadHouses()
			native SaveHouses()
			native CreateHouse(Float:enterx,Float:entery,Float:enterz,Float:intx,Float:inty,Float:intz,price,interior,intworld)
			native CreateHouseVehicle(houseid,model,Float:x,Float:y,Float:z,Float:rot,color1,color2)
			native SetHouseVehicleSpawnInfo(houseid,model,Float:x,Float:y,Float:z,Float:rot,color1,color2)
			native GetHouseSafeValue(houseid)
			native SetHouseSafeValue(houseid,value)
			native GetHouseCost(houseid)
			native SetHouseCost(houseid,cost)
			native GetHouseOwnerID(houseid)
			native GetHouseVehicleOwnerID(vehicleid)
			native GetHouseVehicleHouseID(vehicleid)
			native GetHouseVehicleStreamID(houseid)
			native GetHouseVehicleID(houseid)
			native SetHouseNotOwned(houseid)
			native MakePlayerHouseOwner(playerid,houseid)
			native SetHouseName(houseid,const name[])

------------ File End ------------*/
