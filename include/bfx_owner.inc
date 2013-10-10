/*
INCLUDE BlackFoX Owner - Created for Creating Car Owner Ships Easy and Fast

Project CarOwner Ship Startet on 29.11.2008 by BlackFoX[_UD_]

[ This Include is Copyrighted 2008 By BlackFoX ]
[ DO NOT REMOVE OR DELETE MY CREDITS FOR THIS INCLUDE AND PRESENT AS YOUR OWN WORK ]
[ RESPECT OTHER SCRIPTER AND HIS WORK BECAUSE THEY SCRIPT IT TO HELP YOU ]
*/
#include <a_samp>
#if defined _bfx_owner_included
	#endinput
#endif
#define _bfx_owner_included
#define MAX_BUY_CARS 500
#pragma library bfx_owner

#pragma tabsize 4
new Buy_ID;

enum VehicleLoads
{
	vOwner[256],
	dModel,
	farbe1,
	farbe2,
	Float:vx,
	Float:vy,
	Float:vz,
	Float:va,
	bool:BuyCar,
	v_buy_id,
}
new SetThings[MAX_VEHICLES][VehicleLoads];
/*
native CreateBuyVehicle(vModel,Float:x,Float:y,Float:z,Float:a, colorA, colorB, const PlayerName[]);
native IsBuyVehicle(vehicleid);
native GetBuyID(vehicleid);
native IsHisCar(playerid, vehicleid);
native SetBuyid(vehicleid, nBuyid);
native GetBuyOwner(vehicleid);
native SetOwner(vehicleid,const cOwner[]);
*/

stock CreateBuyVehicle(vModel,Float:x,Float:y,Float:z,Float:a, colorA, colorB, const PlayerName[])
{
	Buy_ID++;
	new carid = CreateVehicle(vModel,x,y,z,a,colorA,colorB,60000000);
    strmid(SetThings[carid][vOwner],PlayerName,0,256,256);
    SetThings[carid][dModel] = vModel;
    SetThings[carid][vx] = x;
    SetThings[carid][vy] = y;
    SetThings[carid][vz] = z;
    SetThings[carid][va] = a;
    SetThings[carid][farbe1] = colorA;
    SetThings[carid][farbe2] = colorB;
    SetThings[carid][BuyCar] = true;
    SetThings[carid][v_buy_id] = Buy_ID;
    return Buy_ID;
}
stock GetBuyID(vehicleid)
{
new dieid;
dieid = SetThings[vehicleid][v_buy_id];
return dieid;
}
stock IsBuyVehicle(vehicleid)
{
if(SetThings[vehicleid][BuyCar] == true) { return 1; }else{ return 0; }
}
stock IsHisCar(playerid, vehicleid)
{
new ssc[256];
GetPlayerName(playerid,ssc,sizeof(ssc));
if (!strcmp(SetThings[vehicleid][vOwner],ssc))
{
return true;
}
else
{
return false;
}
}
stock GetBuyOwner(vehicleid)
{
new OwnerName[256];
strmid(OwnerName,SetThings[vehicleid][vOwner],0,256,256);
return OwnerName;
}
stock SetOwner(vehicleid,const cOwner[])
{
if(IsBuyVehicle(vehicleid))
{
strmid(SetThings[vehicleid][vOwner],cOwner,0,256,256);
return true;
}
else
{
return false;
}
}
stock SetBuyid(vehicleid, nBuyid)
{
SetThings[vehicleid][v_buy_id] = nBuyid;
}
