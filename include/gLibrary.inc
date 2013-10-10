/*
														gLibrary 2.1	©2011 Gamer931215
														Released 27-03-2011
	
	Credits:
	
	Changelog:
	    V1.0 - First release
	    V1.2 - gCOLOR_ORANGE added, and fixed all warnings
	    V2.0 - New functions:
	            TransportVehicleToPlayerByAir(playerid,vehicleid)           Transports the vehicle to the player by air! (Andromada)
	            GetVehicleType(vehicleid)									Returns 0 when its a car, 1 when its a boat and 2 when its a plane
				GetVehicleSpeed(playerid,UseMPH = 0)                        Returns playerspeed (i took it from hiddos's stalkercows, i just tought this was a must-have)
				GetClosestVehicleForPlayer(playerid)                        Returns closest vehicleid
				GetClosestVehicleFromPoint(x,y,tx,ty)                       Returns closest vehicleid
				PutPlayerInObject(playerid,objectid)						Allows player to DRIVE/FLY a object! (Credits to hiddos for his turtle script)
				RemovePlayerFromObject(playerid)							Removes player from object
				IsPlayerInObject(playerid)									Returns 1 when player is flying an object
				GetPlayerObjectID(playerid)									Returns objectid
				GetVehicleNameByModelId(modelid)       			 			Returns vehicle name
				GetWeaponNameById(weaponid)            			 			Returns weaponname
				ToggleVehicleLights(vehicleid,toggle)						Toggle light on/off
				AreVehicleLightsOn(vehicleid)								Returns 1 when the lights are on
				ToggleVehicleAlarm(vehicleid,toggle)						Toggle alarm on/off
				IsVehicleAlarmOn(vehicleid)									Returns 1 when the alarm is going off
				SetVehicleToAlarm(vehicleid,time)							Start the vehicle's alarm and turn it off after the ammount of milisecconds you entered
                GetDistanceBetweenPoints(Float:x,Float:y,Float:tx,Float:ty) Returns distance between pts
                
		V2.1 - New functions:
		        CenterString(string[],size)                                 Centers the string !
		        AngleToPoint(x1,y1,x2,y2)                                   Gets angle to point
                
	Defines (to show the functions with arguments in pawno):
	    native AngleToPoint(x1,y1,x2,y2)
		native PutPlayerInObject(playerid,objectid)
		native RemovePlayerFromObject(playerid)
		native IsPlayerInObject(playerid)
		native GetPlayerObjectID(playerid)
		native GetWeaponIdByName(weaponname[])
		native GetVehicleModelIdByName(model[])
		native GetVehicleNameByModelId(modelid)
		native GetWeaponNameById(weaponid)
		native TransportVehicleToPlayerByAir(playerid,vehicleid)
		native GetVehicleSpeed(vehicleid,UseMPH = 0)
		native GetVehicleType(vehicleid)
		native GetDistanceBetweenPoints(Float:x,Float:y,Float:tx,Float:ty)
		native GetClosestVehicleForPlayer(playerid)
		native GetClosestVehicleFromPoint(x,y,tx,ty)
		native SetVehicleNumberPlateEx(vehicleid,numberplate[])
		native ToggleVehicleLights(vehicleid,toggle)
		native AreVehicleLightsOn(vehicleid)
		native ToggleVehicleAlarm(vehicleid,toggle)
		native IsVehicleAlarmOn(vehicleid)
		native SetVehicleToAlarm(vehicleid,time)
		native MutePlayer(playerid)
		native UnMutePlayer(playerid)
		native JailPlayer(playerid)
		native UnJailPlayer(playerid
		native SetPlayerToReconnect(playerid)
		native SetPlayerMoney(playerid,ammount)
		native GivePlayerScore(playerid,ammount)
		native GetPlayerNameEx(playerid)
		native GetPlayerIpEx(playerid)
		native SetPlayerPosEx(playerid,Float:x,Float:y,Float:z)
		native KickEx(playerid,reason[])
		native SendRconCommandEx(type[],{float,_}:...)
		native SendClientMessageEx(playerid,color,type[],{float,_}:...)
		native SendClientMessageToAllEx(color,type[],{float,_}:...)
		native GameTextForPlayerEx(playerid,time,style,type[],{Float,_}:...)
		native GameTextForAllEx(time,style,type[],{Float,_}:...)
		native CenterString(string[],size)
*/

#include <a_samp>
#define gCOLOR_RED 0xFF1400FF
#define gCOLOR_GREEN 0x00FF00FF
#define gCOLOR_BLUE 0x00AFFFFF
#define gCOLOR_YELLOW 0xFFFF00FF
#define gCOLOR_ORANGE 0xFFAA00FF
#define gCOLOR_GRAY 0x8C8C8CFF
#define gCOLOR_BLACK 0x000000FF
#define gCOLOR_MAGENTA 0xFF00EBFF
#define gCOLOR_DARKRED 0xC30000FF
#define gCOLOR_DARKGREEN 0x0A6F0AFF
#define gCOLOR_DARKBLUE 0x0000C5FF


public OnPlayerDisconnect(playerid,reason)
{
	if(GetPVarInt(playerid,"reconnecting") == 1)
	{
		SendRconCommandEx("ss","unbanip ",GetPlayerIpEx(playerid));
		DeletePVar(playerid,"reconnecting");
		DeletePVar(playerid,"muted");
	}
	if(IsPlayerInObject(playerid))
	{
	    RemovePlayerFromObject(playerid);
	}
	SetPVarInt(playerid,"muted",0);
	return CallLocalFunction("gOnPlayerDisconnect","ii",playerid,reason);
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect gOnPlayerDisconnect
forward gOnPlayerDisconnect(playerid,reason);

public OnPlayerText(playerid, text[])
{
	if(GetPVarInt(playerid,"muted") == 1)
	{
	    SendClientMessage(playerid,0xFF0A00FF,"You cannot speak when muted.");
	    return 0;
	}
	return CallLocalFunction("gOnPlayerText","ss",playerid,text);
}
#if defined _ALS_OnPlayerText
	#undef OnPlayerText
#else
	#define _ALS_OnPlayerText
#endif
#define OnPlayerText gOnPlayerText
forward gOnPlayerText(playerid,text[]);

new gWeaponNames[][32] = { //from fsdebug
	{"Unarmed (Fist)"},
	{"Brass Knuckles"},
	{"Golf Club"},
	{"Night Stick"},
	{"Knife"},
	{"Baseball Bat"},
	{"Shovel"},
	{"Pool Cue"},
	{"Katana"},
	{"Chainsaw"},
	{"Purple Dildo"},
	{"Big White Vibrator"},
	{"Medium White Vibrator"},
	{"Small White Vibrator"},
	{"Flowers"},
	{"Cane"},
	{"Grenade"},
	{"Teargas"},
	{"Molotov"},
	{" "},
	{" "},
	{" "},
	{"Colt 45"},
	{"Colt 45 (Silenced)"},
	{"Desert Eagle"},
	{"Normal Shotgun"},
	{"Sawnoff Shotgun"},
	{"Combat Shotgun"},
	{"Micro Uzi (Mac 10)"},
	{"MP5"},
	{"AK47"},
	{"M4"},
	{"Tec9"},
	{"CountryRifle"},
	{"Sniper"},
	{"RocketLauncher"},
	{"Heat-Seeking Rocket Launcher"},
	{"Flamethrower"},
	{"Minigun"},
	{"Satchel Charge"},
	{"Detonator"},
	{"Spray Can"},
	{"Fire Extinguisher"},
	{"Camera"},
	{"Night Vision Goggles"},
	{"Infrared Vision Goggles"},
	{"Parachute"},
	{"Fake Pistol"}
};


new gVehicleNames[212][] = {// from fsdebug, Vehicle Names - Betamaster
	{"Landstalker"},
	{"Bravura"},
	{"Buffalo"},
	{"Linerunner"},
	{"Perrenial"},
	{"Sentinel"},
	{"Dumper"},
	{"Firetruck"},
	{"Trashmaster"},
	{"Stretch"},
	{"Manana"},
	{"Infernus"},
	{"Voodoo"},
	{"Pony"},
	{"Mule"},
	{"Cheetah"},
	{"Ambulance"},
	{"Leviathan"},
	{"Moonbeam"},
	{"Esperanto"},
	{"Taxi"},
	{"Washington"},
	{"Bobcat"},
	{"Mr Whoopee"},
	{"BF Injection"},
	{"Hunter"},
	{"Premier"},
	{"Enforcer"},
	{"Securicar"},
	{"Banshee"},
	{"Predator"},
	{"Bus"},
	{"Rhino"},
	{"Barracks"},
	{"Hotknife"},
	{"Trailer 1"}, //artict1
	{"Previon"},
	{"Coach"},
	{"Cabbie"},
	{"Stallion"},
	{"Rumpo"},
	{"RC Bandit"},
	{"Romero"},
	{"Packer"},
	{"Monster"},
	{"Admiral"},
	{"Squalo"},
	{"Seasparrow"},
	{"Pizzaboy"},
	{"Tram"},
	{"Trailer 2"}, //artict2
	{"Turismo"},
	{"Speeder"},
	{"Reefer"},
	{"Tropic"},
	{"Flatbed"},
	{"Yankee"},
	{"Caddy"},
	{"Solair"},
	{"Berkley's RC Van"},
	{"Skimmer"},
	{"PCJ-600"},
	{"Faggio"},
	{"Freeway"},
	{"RC Baron"},
	{"RC Raider"},
	{"Glendale"},
	{"Oceanic"},
	{"Sanchez"},
	{"Sparrow"},
	{"Patriot"},
	{"Quad"},
	{"Coastguard"},
	{"Dinghy"},
	{"Hermes"},
	{"Sabre"},
	{"Rustler"},
	{"ZR-350"},
	{"Walton"},
	{"Regina"},
	{"Comet"},
	{"BMX"},
	{"Burrito"},
	{"Camper"},
	{"Marquis"},
	{"Baggage"},
	{"Dozer"},
	{"Maverick"},
	{"News Chopper"},
	{"Rancher"},
	{"FBI Rancher"},
	{"Virgo"},
	{"Greenwood"},
	{"Jetmax"},
	{"Hotring"},
	{"Sandking"},
	{"Blista Compact"},
	{"Police Maverick"},
	{"Boxville"},
	{"Benson"},
	{"Mesa"},
	{"RC Goblin"},
	{"Hotring Racer A"}, //hotrina
	{"Hotring Racer B"}, //hotrinb
	{"Bloodring Banger"},
	{"Rancher"},
	{"Super GT"},
	{"Elegant"},
	{"Journey"},
	{"Bike"},
	{"Mountain Bike"},
	{"Beagle"},
	{"Cropdust"},
	{"Stunt"},
	{"Tanker"}, //petro
	{"Roadtrain"},
	{"Nebula"},
	{"Majestic"},
	{"Buccaneer"},
	{"Shamal"},
	{"Hydra"},
	{"FCR-900"},
	{"NRG-500"},
	{"HPV1000"},
	{"Cement Truck"},
	{"Tow Truck"},
	{"Fortune"},
	{"Cadrona"},
	{"FBI Truck"},
	{"Willard"},
	{"Forklift"},
	{"Tractor"},
	{"Combine"},
	{"Feltzer"},
	{"Remington"},
	{"Slamvan"},
	{"Blade"},
	{"Freight"},
	{"Streak"},
	{"Vortex"},
	{"Vincent"},
	{"Bullet"},
	{"Clover"},
	{"Sadler"},
	{"Firetruck LA"}, //firela
	{"Hustler"},
	{"Intruder"},
	{"Primo"},
	{"Cargobob"},
	{"Tampa"},
	{"Sunrise"},
	{"Merit"},
	{"Utility"},
	{"Nevada"},
	{"Yosemite"},
	{"Windsor"},
	{"Monster A"}, //monstera
	{"Monster B"}, //monsterb
	{"Uranus"},
	{"Jester"},
	{"Sultan"},
	{"Stratum"},
	{"Elegy"},
	{"Raindance"},
	{"RC Tiger"},
	{"Flash"},
	{"Tahoma"},
	{"Savanna"},
	{"Bandito"},
	{"Freight Flat"}, //freiflat
	{"Streak Carriage"}, //streakc
	{"Kart"},
	{"Mower"},
	{"Duneride"},
	{"Sweeper"},
	{"Broadway"},
	{"Tornado"},
	{"AT-400"},
	{"DFT-30"},
	{"Huntley"},
	{"Stafford"},
	{"BF-400"},
	{"Newsvan"},
	{"Tug"},
	{"Trailer 3"}, //petrotr
	{"Emperor"},
	{"Wayfarer"},
	{"Euros"},
	{"Hotdog"},
	{"Club"},
	{"Freight Carriage"}, //freibox
	{"Trailer 3"}, //artict3
	{"Andromada"},
	{"Dodo"},
	{"RC Cam"},
	{"Launch"},
	{"Police Car (LSPD)"},
	{"Police Car (SFPD)"},
	{"Police Car (LVPD)"},
	{"Police Ranger"},
	{"Picador"},
	{"S.W.A.T. Van"},
	{"Alpha"},
	{"Phoenix"},
	{"Glendale"},
	{"Sadler"},
	{"Luggage Trailer A"}, //bagboxa
	{"Luggage Trailer B"}, //bagboxb
	{"Stair Trailer"}, //tugstair
	{"Boxville"},
	{"Farm Plow"}, //farmtr1
	{"Utility Trailer"} //utiltr1
};

stock Float:AngleToPoint(x1,y1,x2,y2)
{
	return atan2( (y2 - y1) , (x2 - x1) ) + 270;
}

stock GetVehicleModelIdByName(vehiclename[])
{
    for(new i = 0;i<sizeof(gVehicleNames);i++)
    {
        if(!strcmp(gVehicleNames[i],vehiclename,true))
        {
            return i +400;
        }
    }
    return -1;
}

stock GetWeaponIdByName(weaponname[])
{
    for(new i = 0;i<sizeof(gWeaponNames);i++)
    {
        if(!strcmp(gWeaponNames[i],weaponname,true))
        {
            return i;
        }
    }
    return -1;
}

stock GetVehicleNameByModelId(vehiclemodel)
{
	new str[32];format(str,sizeof str,"%s",gVehicleNames[vehiclemodel -400]);return str;
}

stock GetWeaponNameById(weaponid)
{
	new str[32];format(str,sizeof str,"%s",gWeaponNames[weaponid]);return str;
}

stock SetVehicleNumberPlateEx(vehicleid,numberplate[])
{
	new Float:pos[6];GetVehiclePos(vehicleid,pos[0],pos[1],pos[2]);
	SetVehicleNumberPlate(vehicleid,numberplate);SetVehicleToRespawn(vehicleid);
	GetVehiclePos(vehicleid,pos[3],pos[4],pos[5]);
	if(pos[3] != pos[0] || pos[4] != pos[1])
	{
	    SetVehiclePos(vehicleid,pos[0],pos[1],pos[2]);
	}
	return 1;
}

stock ToggleVehicleLights(vehicleid,toggle)
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicleid,engine,toggle,alarm,doors,bonnet,boot,objective);
	return 1;
}

stock AreVehicleLightsOn(vehicleid)
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	return lights
}

stock ToggleVehicleAlarm(vehicleid,toggle)
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicleid,engine,lights,toggle,doors,bonnet,boot,objective);
	return 1;
}

stock IsVehicleAlarmOn(vehicleid)
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	return alarm
}

stock SetVehicleToAlarm(vehicleid,time)
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicleid,engine,lights,1,doors,bonnet,boot,objective);
	SetTimerEx("gStopAlarm",time,false,"i",vehicleid);
	return 1;
}
forward gStopAlarm(vehicleid);
public gStopAlarm(vehicleid)
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicleid,engine,lights,0,doors,bonnet,boot,objective);
}

stock GetVehicleType(vehicleid)
{
	new model = GetVehicleModel(vehicleid);
	switch(model)
	{
	    case 520 , 577 , 511 , 592 , 512 , 513 , 519 , 593 , 553 , 476, 425, 447, 469, 548, 417:
	    {
	        return 2; //planes
	    }
	    case 430, 446, 452, 453, 454, 472, 473, 484, 493, 495:
	    {
	        return 1; //boat
	    }
	    default:
	    {
	        return 0; //car/trains
	    }
	}
	return -1;
}

stock Float:GetVehicleSpeed(vehicleid,UseMPH = 0)
{
	new Float:speed_x,Float:speed_y,Float:speed_z,Float:temp_speed;
	GetVehicleVelocity(vehicleid,speed_x,speed_y,speed_z);
	if(UseMPH == 0)
	{
	    temp_speed = floatsqroot(((speed_x*speed_x)+(speed_y*speed_y))+(speed_z*speed_z))*136.666667;
	} else {
	    temp_speed = floatsqroot(((speed_x*speed_x)+(speed_y*speed_y))+(speed_z*speed_z))*85.4166672;
	}
	floatround(temp_speed,floatround_round);return temp_speed;
}

stock SetPlayerPosEx(playerid,Float:x,Float:y,Float:z)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
	    return SetVehiclePos(GetPlayerVehicleID(playerid),x,y,z);
	} else return SetPlayerPos(playerid,x,y,z);
}

stock Float:GetDistanceBetweenPoints(Float:x,Float:y,Float:tx,Float:ty)
{
  new Float:temp1, Float:temp2;
  temp1 = x-tx;temp2 = y-ty;
  return floatsqroot(temp1*temp1+temp2*temp2);
}

stock GetClosestVehicleForPlayer(playerid)
{
	new Float:x,Float:y,Float:z;GetPlayerPos(playerid,x,y,z);
	return GetClosestVehicleFromPoint(x,y);
}

stock GetClosestVehicleFromPoint(Float:x,Float:y)
{
	new Float:distance = 2222,Float:tx,Float:ty,Float:z,vehicleid = -1;
	for(new i = 0;i<MAX_VEHICLES;i++)
	{
	    GetVehiclePos(i,tx,ty,z);
		new Float:temp = GetDistanceBetweenPoints(x,y,tx,ty);
		if(temp < distance)
		{
			vehicleid = i;
			distance = temp;
		}
	}
	return vehicleid;
}

new androID[MAX_PLAYERS];
new paraID[MAX_PLAYERS] = -1;
new shipping[MAX_PLAYERS];
forward create_andro(playerid);
forward remove_andro(vehicleid,playerid);
forward create_vehicle(playerid,ID,Float:x,Float:y,Float:z);
forward update_pos(vehicleid);

stock TransportVehicleToPlayerByAir(playerid,vehicleid)
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	SetVehiclePos(vehicleid,0,0,-30);
	androID[playerid] = CreateObject(14553,x,y+200,z+60,12.25,0,0);
	MoveObject(androID[playerid],x,y-250,z+180,15);
	shipping[playerid] = 1;
	SetTimerEx("create_vehicle",12500,false,"iifff",playerid,vehicleid,x,y+13,z+60);
	SetTimerEx("remove_andro",16000,false,"ii",androID[playerid],playerid);
	return 1;
}

public create_vehicle(playerid,ID,Float:x,Float:y,Float:z)
{
	SetVehiclePos(ID,x,y,z);
	if(paraID[playerid] != -1){ DestroyObject(paraID[playerid]); }
	paraID[playerid] = CreateObject(2903,x,y,z,0,0,0);
	AttachObjectToVehicle(paraID[playerid],ID,0,0,7.3,0,0,90);
	return 1;
}


public remove_andro(vehicleid,playerid)
{
	DestroyObject(vehicleid);
	DestroyObject(paraID[playerid]);
	paraID[playerid] = -1;
	shipping[playerid] = 0;
	return 1;
}

new FlyingObj[MAX_PLAYERS] = {-1, -1, ...};
new speed[MAX_PLAYERS];
new UpdateTimer[MAX_PLAYERS];
stock PutPlayerInObject(playerid,objectid) //modified version of Hiddos's turtle script
{
    new Float:Pos[4];
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	GetPlayerFacingAngle(playerid, Pos[3]);
	FlyingObj[playerid] = objectid;
	TogglePlayerSpectating(playerid, 1);
	OnPlayerDriveObject(playerid);
	speed[playerid] = 0;
	UpdateTimer[playerid] = SetTimerEx("OnPlayerDriveObject", 30, 1, "i", playerid);
	return 1;
}

stock GetPlayerObjectID(playerid)
{
	return FlyingObj[playerid];
}

stock IsPlayerInObject(playerid)
{
	if(FlyingObj[playerid] != -1) return 1;
	return 1;
}

stock RemovePlayerFromObject(playerid)
{
	if(!IsPlayerInObject(playerid)) return 1;
	KillTimer(UpdateTimer[playerid]);
	new Float:x,Float:y,Float:z;
	GetObjectPos(FlyingObj[playerid],x,y,z);
	FlyingObj[playerid] = -1;
	TogglePlayerSpectating(playerid, 0);
	SetTimerEx("backtopos",500,false,"ifff",playerid,x,y,z);
	return 1;
}
forward backtopos(playerid,Float:x,Float:y,Float:z);
public backtopos(playerid,Float:x,Float:y,Float:z)
{
	SetPlayerPos(playerid,x+2,-2,z+1);
}
forward OnPlayerDriveObject(playerid);
public OnPlayerDriveObject(playerid)
{
	new Keys[3];
	GetPlayerKeys(playerid, Keys[0], Keys[1], Keys[2]);
	new Float:Pos[9]; //X - Y - Z - rX - rY - rZ - nZ
	GetObjectRot(FlyingObj[playerid], Pos[3], Pos[4], Pos[5]);

	if(Keys[0] & KEY_JUMP && !(Keys[0] & KEY_SPRINT)) speed[playerid]--;
	if(Keys[0] & KEY_SPRINT && !(Keys[0] & KEY_JUMP)) speed[playerid]++;

//Rotation part
	Pos[4] = ((Keys[2] < 0) ? (-33.3) : (Keys[2] > 0) ? (33.3) : (0.0));
	Pos[5] += (((Keys[2] < 0 && speed[playerid] >= 0) || (Keys[2] > 0 && speed[playerid] < 0)) ? (3.5) : ((Keys[2] > 0 && speed[playerid] >= 0) || (Keys[2] < 0 && speed[playerid] < 0) ? (-3.5) : (0.0)));
	//That's quite a line
	//Don't mention this text. I like giving feedback on my own scripting lol.
	Pos[3] = ((Keys[1] < 0) ? (-33.3) : (Keys[1] > 0) ? (33.3) : (0.0));

	SetObjectRot(FlyingObj[playerid], Pos[3], Pos[4], Pos[5]);

//Location part - Sarcasm(YAY, YAY, YAY, YAY, YAY, YAY);
	GetObjectPos(FlyingObj[playerid], Pos[0], Pos[1], Pos[2]);
	Pos[7] = Pos[0] + (floatdiv(speed[playerid], 145) * floatsin(-Pos[5], degrees) * ((Keys[1] == 0) ? (1.0) : (floatdiv(2, 3))));
	Pos[8] = Pos[1] + (floatdiv(speed[playerid], 145) * floatcos(-Pos[5], degrees) * ((Keys[1] == 0) ? (1.0) : (floatdiv(2, 3))));

	Pos[2] += ((Keys[1] < 0) ? (-0.333) : (Keys[1] > 0) ? (0.333) : (0.0)) * floatdiv(speed[playerid], 145);
	SetObjectPos(FlyingObj[playerid], Pos[7], Pos[8], Pos[2]);

//Camera part. This pisses me off all the time...
	SetPlayerCameraLookAt(playerid, Pos[0] + (4 * floatsin(-Pos[5], degrees)), Pos[1] + (4 * floatcos(-Pos[5], degrees)), Pos[ ((Pos[6] > Pos[1]+1) ? (6) : (2)) ] + 1);
	Pos[0] -= (8 * floatsin(-Pos[5], degrees));
	Pos[1] -= (8 * floatcos(-Pos[5], degrees));
	SetPlayerCameraPos(playerid, Pos[0], Pos[1], Pos[ ((Pos[6] > Pos[1]+1) ? (6) : (2)) ] + 6.8);
}

stock MutePlayer(playerid)
{
	return SetPVarInt(playerid,"muted",1);
}

stock UnMutePlayer(playerid)
{
    return SetPVarInt(playerid,"muted",0);
}

stock JailPlayer(playerid)
{
	SetPlayerInterior(playerid,6);SetPlayerPos(playerid, 265.6881,76.6573,1001.0391);TogglePlayerControllable(playerid,0);
	SetPlayerCameraPos(playerid,269.5,77.5,1002);return SetPlayerCameraLookAt(playerid,264.6288,77.5742,1001.0391);
}

stock UnJailPlayer(playerid)
{
    SetPlayerPos(playerid, 267.6288,77.5742,1001.0391);TogglePlayerControllable(playerid,1);return SetCameraBehindPlayer(playerid);
}

stock SetPlayerToReconnect(playerid)
{
	SetPVarInt(playerid,"reconnecting",1);TogglePlayerSpectating(playerid,1);return SendRconCommandEx("ss","banip ",GetPlayerIpEx(playerid));
}

stock SetPlayerMoney(playerid,ammount)
{
	ResetPlayerMoney(playerid);return GivePlayerMoney(playerid,ammount);
}

stock GivePlayerScore(playerid,ammount)
{
	new score = GetPlayerScore(playerid);score=score+ammount;return SetPlayerScore(playerid,score);
}

stock GetPlayerNameEx(playerid)
{
	new pName[MAX_PLAYER_NAME];GetPlayerName(playerid,pName,sizeof pName);return pName;
}

stock GetPlayerIpEx(playerid)
{
	new ip[32];GetPlayerIp(playerid,ip,sizeof ip);return ip;
}

stock KickEx(playerid,reason[])
{
    SendClientMessageEx(playerid,0xA8C3E0FF,"ss","You have been kicked from this server, reason: ",reason);printf("%s has been kicked by the server. (Reason: %s)",GetPlayerNameEx(playerid),reason);return Kick(playerid);
}

stock SendRconCommandEx(type[],{Float,_}:...)
{
	new string[128];
	for(new i = 0;i<numargs();i++)
	{
	    switch(type[i])
	    {
	        case 's':
	        {
				new result[128];
				for(new a= 0;getarg(i +1,a) != 0;a++)
				{
				    result[a] = getarg(i +1,a);
				}
				if(!strlen(string))
				{
				    format(string,sizeof string,"%s",result);
				} else format(string,sizeof string,"%s%s",string,result);
	        }

	        case 'i':
	        {
	            new result = getarg(i +1);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%i",result);
				} else format(string,sizeof string,"%s%i",string,result);
	        }

	        case 'f':
	        {
				new Float:result = Float:getarg(i +1);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%f",result);
				} else format(string,sizeof string,"%s%f",string,result);
	        }
	    }
	}
    SendRconCommand(string);
    return 1;
}

stock SendClientMessageEx(playerid,color,type[],{Float,_}:...)
{
	new string[128];
	for(new i = 0;i<numargs() -2;i++)
	{
	    switch(type[i])
	    {
	        case 's':
	        {
				new result[128];
				for(new a= 0;getarg(i +3,a) != 0;a++)
				{
				    result[a] = getarg(i +3,a);
				}
				if(!strlen(string))
				{
				    format(string,sizeof string,"%s",result);
				} else format(string,sizeof string,"%s%s",string,result);
	        }

	        case 'i':
	        {
	            new result = getarg(i +3);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%i",result);
				} else format(string,sizeof string,"%s%i",string,result);
	        }

	        case 'f':
	        {
				new Float:result = Float:getarg(i +3);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%f",result);
				} else format(string,sizeof string,"%s%f",string,result);
	        }
	    }
	}
    SendClientMessage(playerid,color,string);
    return 1;
}

stock SendClientMessageToAllEx(color,type[],{Float,_}:...)
{
	new string[128];
	for(new i = 0;i<numargs() -1;i++)
	{
	    switch(type[i])
	    {
	        case 's':
	        {
				new result[128];
				for(new a= 0;getarg(i +2,a) != 0;a++)
				{
				    result[a] = getarg(i +2,a);
				}
				if(!strlen(string))
				{
				    format(string,sizeof string,"%s",result);
				} else format(string,sizeof string,"%s%s",string,result);
	        }

	        case 'i':
	        {
	            new result = getarg(i +2);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%i",result);
				} else format(string,sizeof string,"%s%i",string,result);
	        }

	        case 'f':
	        {
				new Float:result = Float:getarg(i +2);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%f",result);
				} else format(string,sizeof string,"%s%f",string,result);
	        }
	    }
	}
    SendClientMessageToAll(color,string);
    return 1;
}

stock GameTextForPlayerEx(playerid,time,style,type[],{Float,_}:...)
{
	new string[128];
	for(new i = 0;i<numargs() -3;i++)
	{
	    switch(type[i])
	    {
	        case 's':
	        {
				new result[128];
				for(new a= 0;getarg(i +4,a) != 0;a++)
				{
				    result[a] = getarg(i +4,a);
				}
				if(!strlen(string))
				{
				    format(string,sizeof string,"%s",result);
				} else format(string,sizeof string,"%s%s",string,result);
	        }

	        case 'i':
	        {
	            new result = getarg(i +4);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%i",result);
				} else format(string,sizeof string,"%s%i",string,result);
	        }

	        case 'f':
	        {
				new Float:result = Float:getarg(i +4);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%f",result);
				} else format(string,sizeof string,"%s%f",string,result);
	        }
	    }
	}
    GameTextForPlayer(playerid,string,time,style);
    return 1;
}

stock GameTextForAllEx(time,style,type[],{Float,_}:...)
{
	new string[128];
	for(new i = 0;i<numargs() -2;i++)
	{
	    switch(type[i])
	    {
	        case 's':
	        {
				new result[128];
				for(new a= 0;getarg(i +3,a) != 0;a++)
				{
				    result[a] = getarg(i +3,a);
				}
				if(!strlen(string))
				{
				    format(string,sizeof string,"%s",result);
				} else format(string,sizeof string,"%s%s",string,result);
	        }

	        case 'i':
	        {
	            new result = getarg(i +3);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%i",result);
				} else format(string,sizeof string,"%s%i",string,result);
	        }

	        case 'f':
	        {
				new Float:result = Float:getarg(i +3);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%f",result);
				} else format(string,sizeof string,"%s%f",string,result);
	        }
	    }
	}
    GameTextForAll(string,time,style);
    return 1;
}

stock CenterString(string[],leng)
{
	new temp[128],tmp;
	format(temp,sizeof temp,"%s",string);
	tmp = (leng - strlen(temp)) / 2;
	for(new a = 0;a<tmp;a++)
	{
		format(temp,sizeof temp," %s",temp);
	}
	return temp;
}
