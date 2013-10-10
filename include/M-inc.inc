#include <a_samp>

// Die Messages bei Problemen darfst du definieren:
#define INVALID_VEH_MSG "Dieses Fahrzeug ist nicht zum Teleport geeignet!"
#define ZUWENIG_GELD_MSG "Du hast zu wenig Geld!"


/*
|+++++++++++++++++++++++++++++++++++++++++++++++++++++|
|+++++++++++++++++ M-inc by Maercell +++++++++++++++++|
|+++++++++++++++++++++++ v2.0 ++++++++++++++++++++++++|
|+++++++++++++++++++++++++++++++++++++++++++++++++++++|


======= Die Funktionen =======

CreateTeleport(playerid,Float:X,Float:Y,Float:Z,Float:Angle,bool:WithCar,int,vir,price); //Teleport
SendClientMessageToOthers(playerid,color,const message []); //Message für andere Spieler
SendClientMessageToAdmins(color,const message []); //Message für Admins
SendClientMessageToOtherAdmins(playerid,color,const message []); //Message für andere Admins
FreezePlayer(playerid); //Spieler einfrieren
UnFreezePlayer(playerid); // Spieler wieder "Auftauen"
FreezeAll(); //Alle Spieler einfrieren
UnFreezeAll(); // Alle Spieler wieder auftauen
GetName(playerid); // Name eines Spielers. BSP: format(string,256,"Der Spieler heist %s",GetName(playerid));
GetIP(playerid); // IP eines Spielers. BSP: format(string,256,"Die IP des Spielers ist %s",GetIP(playerid));
MKick(playerid); //Kick mit 100ms verspätung, um eine Kicknachricht zu senden
MBan(playerid); //Ban mit 100ms verspätung, um eine Bannachricht zu senden
IsValidNitroVehicle(modelid); // Abfrage, ob  ein Fahrzeug Nitrokompatibel ist(JA = return 1)
IsPlayerName(playerid,name); // Überprüft den Namen eines Spielers
GivePlayerHealth(playerid,health); // Gibt einem Spieler Lebenspunkte
GivePlayerArmour(playerid,armour); // Gibt einem Spieler "Westenpunkte"
IsPlayerInArea(playerid,Float:minX,Float:minY,Float:maxX,Float:maxY) // überprüft ob playerid in einer bestimmten Zone ist
//PS: IsPlayerInArea wurde von mir selbst geschrieben, jodoch ist die Idee nicht von mir!!!!!!
IsPlayerInFrac(playerid,fracid); // Überprüft ob ein spieler in einer Fraktion ist (NUR FÜR GODFATHER!)
SetAllPlayerPos(Float:allX,Float:allY,Float:allZ); // Telportiert alle Spieler zu einem Punkt
SetAllPlayerPosEx(Float:allX,Float:allY,Float:allZ,int,vir); // Teleportiert alle Spieler zu einem Punkt und setzt das Interior auf int und Virtualw auf vir
TeleAllPlayerToPlayer(playerid); // Telportiert alle Spieler zu playerid
IsPlayerInVehModel(playerid,modelid) // Überprüft ob ein Spieler in einer bestimmten Auto-modelid sitzt

*/

forward TimerToBan(playerid);
forward TimerToKick(playerid);



stock CreateTeleport(playerid,Float:X,Float:Y,Float:Z,Float:Angle,bool:WithCar,int,vir,price)
{
	if(GetPlayerMoney(playerid) < price)
	{
		SendClientMessage(playerid,0xAA3333AA,ZUWENIG_GELD_MSG);
		return 0;
	}
	else if(!IsValidTeleVeh(GetVehicleModel(GetPlayerVehicleID(playerid))))
	{
		SendClientMessage(playerid,0xAA3333AA,INVALID_VEH_MSG);
		return 0;
	}
	else if(WithCar)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid),Float:X,Float:Y,Float:Z);
			SetVehicleZAngle(GetPlayerVehicleID(playerid),Float:Angle);
			LinkVehicleToInterior(GetPlayerVehicleID(playerid),int);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),vir);
		}
		else
		{
			SetPlayerPos(playerid,Float:X,Float:Y,Float:Z);
			SetPlayerFacingAngle(playerid,Float:Angle);
		}
	}
	else if(!WithCar)
	{
		SetPlayerPos(playerid,Float:X,Float:Y,Float:Z);
		SetPlayerFacingAngle(playerid,Float:Angle);

	}
	SetCameraBehindPlayer(playerid);
	GivePlayerMoney(playerid,-price);
	SetPlayerInterior(playerid,int);
	SetPlayerVirtualWorld(playerid,vir);
	return 0;
}



stock SendClientMessageToOthers(playerid,color,const message [])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(i != playerid && IsPlayerConnected(i))
		{
			SendClientMessage(i,color,message);
		}
	}
}


stock SendClientMessageToAdmins(color,const message [])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerAdmin(i) &&  IsPlayerConnected(i))
		{
			SendClientMessage(i,color,message);
		}
	}
}

stock SendClientMessageToOtherAdmins(playerid,color,const message [])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(i != playerid && IsPlayerConnected(i) && IsPlayerAdmin(i))
		{
			SendClientMessage(i,color,message);
		}
	}
}

stock FreezePlayer(playerid)
{
	TogglePlayerControllable(playerid,false);
}


stock UnFreezePlayer(playerid)
{
	TogglePlayerControllable(playerid,true);
}


stock FreezeAll()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			TogglePlayerControllable(i,false);
		}
	}
}	

stock UnFreezeAll()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			TogglePlayerControllable(i,true);
		}
	}
}


stock GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	return name;
}


stock GetIP(playerid)
{
	new IP[24];
	GetPlayerIp(playerid,IP,24);
	return IP;
}


stock MBan(playerid)
{
	SetTimerEx("TimeToBan",100,0,"i",playerid);
}


stock MKick(playerid)
{
	SetTimerEx("TimeToKick",100,0,"i",playerid);
}

stock TimeToKick(playerid)
{
	Kick(playerid);
}

stock TimeToBan(playerid)
{
	Ban(playerid);
}


stock IsValidNitroVehicle(vehicleid)
{
	if(vehicleid == 581 || 
	   vehicleid == 523 || 
	   vehicleid == 462 || 
	   vehicleid == 521 || 
	   vehicleid == 463 || 
	   vehicleid == 522 || 
	   vehicleid == 461 || 
	   vehicleid == 448 || 
	   vehicleid == 468 || 
	   vehicleid == 586 ||
	   vehicleid == 509 || 
	   vehicleid == 481 || 
	   vehicleid == 510 || 
	   vehicleid == 472 || 
	   vehicleid == 473 || 
	   vehicleid == 493 || 
	   vehicleid == 595 || 
	   vehicleid == 484 || 
	   vehicleid == 430 || 
	   vehicleid == 453 || 
	   vehicleid == 452 || 
	   vehicleid == 446 || 
	   vehicleid == 454 || 
	   vehicleid == 590 || 
	   vehicleid == 569 || 
	   vehicleid == 537 || 
	   vehicleid == 538 || 
	   vehicleid == 570 || 
	   vehicleid == 449) return 0;
	else return 1;
}

stock IsValidTeleVeh(vehicleid)
{
	if(vehicleid == 460 || 
	   vehicleid == 476 || 
	   vehicleid == 511 || 
	   vehicleid == 512 || 
	   vehicleid == 513 || 
	   vehicleid == 519 || 
	   vehicleid == 520 || 
	   vehicleid == 553 || 
	   vehicleid == 577 || 
	   vehicleid == 592 ||
	   vehicleid == 593 || 
	   vehicleid == 417 || 
	   vehicleid == 425 || 
	   vehicleid == 447 || 
	   vehicleid == 469 || 
	   vehicleid == 487 || 
	   vehicleid == 488 || 
	   vehicleid == 497 || 
	   vehicleid == 548 || 
	   vehicleid == 563 || 
	   vehicleid == 432) return 0;
	else return 1;
}


stock IsPlayerName(playerid,const isname[])
{
	new nameofplayerid[MAX_PLAYER_NAME];
	GetPlayerName(playerid,nameofplayerid,sizeof(nameofplayerid));
	if(!strcmp(isname[],nameofplayerid) return 1;
	else return 0;
}


stock GivePlayerHealth(playerid,health)
{
	new Float:healthofplayerid;
	GetPlayerHealth(playerid,healthofplayerid);
	SetPlayerHealth(playerid,healthofplayerid+health);
	return 1;
}

stock GivePlayerArmour(playerid,armour)
{
	new Float:armourofplayerid;
	GetPlayerArmour(playerid,armourofplayerid);
	SetPlayerArmour(playerid,armourofplayerid+armour);
	return 1;
}

stock IsPlayerInArea(playerid,Float:minX,Float:minY,Float:maxX,Float:maxY)
{
	new Float:pX,Float:pY,Float:pZ;
	GetPlayerPos(playerid,pX,pY,pZ);
	if(pX >= minX && pX <= maxX && pY >= minY && pY <= maxY) return 1;
	else return 0;
}

stock IsPlayerInFrac(playerid,fracid)
{
	if (PlayerInfo[playerid][pMember] == fracid || PlayerInfo[playerid][pLeader] == fracid) return 1;
	else return 0;
}


stock SetAllPlayerPos(Float:allX,Float:allY,Float:allZ)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			SetPlayerPos(i,allX,allY,allZ);
		}
	}
	return 1;
}

stock SetAllPlayerPosEx(Float:allX,Float:allY,Float:allZ,int,vir)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			SetPlayerPos(i,allX,allY,allZ);
			SetPlayerInterior(i,int);
			SetPlayerVirtualWorld(i,vir);
		}
	}
	return 1;
}

stock TeleAllPlayerToPlayer(playerid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			SetPlayerPos(i,pX,pY,pZ);
			SetPlayerInterior(i,GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(i,GetPlayerVirtualWorld(playerid));
		}
	}
	return 1;
}

stock IsPlayerInVehModel(playerid,modelid)
{
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == modelid) return 1;
	else return 0;
}



/*
-----------------++++++++++++++++ Credits: +++++++++++++++++++++++-----------------------

http://samp.breadfish.de	->    	Kick & BanTimer
				->    	ScriptUnterstützung bzw. "Scriptwissen"
Unbekannter Scripter		->	Idee für IsPlayerInArea

-----------------++++++++++++++++----------+++++++++++++++++++++++-----------------------
*/
