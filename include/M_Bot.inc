#define M_Bot_BOT_NAME "AntiBot"
#define M_BOT_COLOR 0xFF6347AA
/*

|+++++++++++++++++++++++++++++++++++++++++++++++++++++|
|+++++++++  Maercells AntiCheat-Bot © 2009  ++++++++++|
|++++++++++++++++++++++  v1.1  +++++++++++++++++++++++|
|+++++++++++++++++++++++++++++++++++++++++++++++++++++|
|+++++++++++++++++++++++++++++++++++++++++++++++++++++|


native SendClientMessageToAdmins(color,message[]);
native FreezePlayer(playerid);
native UnFreezePlayer(playerid);
native FreezeAll();
native UnFreezeAll();
native GetName(playerid);
native GetIP(playerid);
native GetWeaponSlot(wid);
native GetVehicleDriver(vehicleid);
native M_Kick(playerid);
native M_Ban(playerid);
native M_BanEx(playerid,reason[]);
native M_Log(string[]):
native M_GivePlayerWeapon(playerid,weapon,ammo);
native M_ResetPlayerWeapons(playerid);
native M_GetPlayerMoney(playerid);
native M_ResetPlayerMoney(playerid);
native M_GivePlayerMoney(playerid,summe);
native M_SetPlayerMoney(playerid,summe);
native M_SetPlayerHealth(playerid,Float:health);
native M_GivePlayerHealth(playerid,Float:health);
native M_SetPlayerArmour(playerid,Float:armour);
native M_GivePlayerArmour(playerid,Float:armour);
native M_SetPlayerPos(playerid,Float:Xpos,Float:Ypos,Float:Zpos,Float:Angle); // Spielerteleport ( + Winkel/Angle)=> Muss nicht dabei sein
native M_SetVehiclePos(playerid,Float:Xpos,Float:Ypos,Float:Zpos,Float:Angle); // Autoteleport ( + Winkel/Angle)=> Muss nicht dabei sein

native EnableM_Bot();
native M_OnPlayerSpawn(playerid); 
native M_OnPlayerConnect(playerid);
native M_OnPlayerDeath(playerid,killerid,reason);
native M_OnPlayerUpdate(playerid);
native M_OnPlayerCommandText(playerid,cmdtext[]);
*/


forward KickHim(playerid);
forward BanHim(playerid);
forward BanHimEx(playerid,reason[]);
forward Check();
forward CheckIPFromList(playerid);
forward EnableChecking(playerid);
forward EnablePingWarnAgain(playerid);
forward AFKOn(playerid);


enum SysInfo
{
	PMoney,
	PWeapon[13],
	PAmmo[13],
	PLastVehicleID,
	PLastInterior,
	PInactiveSeconds,
	PCheckHighPing,
	PHighPingWarns,
	PIPWarns,
	PBadWordWarns,
	PAFK,
	PAFKTimer,
	Float:PHealth,
	Float:PArmour,
	Float:PXpos,
	Float:PYpos,
	Float:PZpos,
	Float:PXpos2,
	Float:PYpos2,
	Float:PZpos2,
	PFrozen,
	PSpawned,
	PCheck
}

new M_Bot[MAX_PLAYERS][SysInfo];

new BanWeaponIDs[] = {
35,
36,
37,
38,
39,
40,
43,
44,
45
};

new BanClanTags[][] = {
"[LVG]",
"[RRG]"
};

new BanNames[][] = {
"Suppennoob"
};

new BadWords[][] = {
"Fuck",
"Fick",
"hdf",
"Fresse",
"Hurensohn",
"Huso",
"Fotze",
"Wixxer",
"Wichser",
"Kanacke",
"Arsch",
"Hure",
"verpiss",
"Mistgeburt",
"Fotze",
"Missgeburt"
};

new Float:GettedHealth,
    Float:GettedArmour,
    AllFrozen,
    MaxPing = 1000,
    MoneySpam[MAX_PLAYERS];


public EnableChecking(playerid)
{
	M_Bot[playerid][PCheck] = 1;
	return 1;
}

public EnablePingWarnAgain(playerid)
{
	M_Bot[playerid][PCheckHighPing] = 1;
	return 1;
}	

public AFKOn(playerid)
{
	if(IsPlayerConnected(playerid) && M_Bot[playerid][PAFK] == 0)
	{
		new string[128];
		format(string,sizeof string,"*~ [AFK] %s ist in den AFK-Modus gegangen! /afklist ",GetName(playerid));
		SendClientMessageToAll(0xAFAFAFAA,string);
		M_Bot[playerid][PAFK] = 1;
		FreezePlayer(playerid);
		KillTimer(M_Bot[playerid][PAFKTimer]);
	}	
	return 1;
}

// ====================================================================================================================

stock SendClientMessageToAdmins(color,message[])
{
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i) && IsAnAdmin(i))
		{
			SendClientMessage(i,color,message);
		}
	}
}


stock FreezePlayer(playerid)
{
	TogglePlayerControllable(playerid,false);
	M_Bot[playerid][PFrozen] = 1;
}


stock UnFreezePlayer(playerid)
{
	TogglePlayerControllable(playerid,true);
	M_Bot[playerid][PFrozen] = 0;
}


stock FreezeAll()
{
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i))
		{
			TogglePlayerControllable(i,false);
			AllFrozen = 1;
		}
	}
}	

stock UnFreezeAll()
{
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i))
		{
			TogglePlayerControllable(i,true);
			AllFrozen = 0;
		}
	}
}

stock GetName(playerid)
{
	new getthename[MAX_PLAYER_NAME];
	GetPlayerName(playerid,getthename,sizeof(getthename));
	return getthename;
}

stock GetIP(playerid)
{
	new gettheip[15];
	GetPlayerIp(playerid,gettheip,sizeof(gettheip));
	return gettheip;
}


stock M_Kick(playerid)
{
	SetTimerEx("KickHim",100,0,"d",playerid);
}

public KickHim(playerid)
{
	Kick(playerid);
	return 1;
}


stock M_Ban(playerid)
{
	SetTimerEx("BanHim",100,0,"d",playerid);
}

public BanHim(playerid)
{
	Ban(playerid);
	return 1;
}


stock M_BanEx(playerid,reason[])
{
	SetTimerEx("BanHimEx",100,0,"ds",playerid,reason);
}

public BanHimEx(playerid,reason[])
{
	BanEx(playerid,reason);
	return 1;
}

stock GetVehicleDriver(vehicleid)
{
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid)
		{
			return i;
		}
	}
	return -1;
}


stock M_WriteIPToBlacklist(ip[])
{
    new File:BLACKLISTFILE;
	if(!fexist("/M_Bot/M_Black.cfg"))
	{
		BLACKLISTFILE = fopen("/M_Bot/M_Black.cfg",io_write);
	}
	else
	{
		BLACKLISTFILE = fopen("/M_Bot/M_Black.cfg",io_append);
	}	
    if(BLACKLISTFILE)
    {
		new string[20];
		format(string,sizeof(string),"%s\n",ip);
		fwrite(BLACKLISTFILE,string);
	}
	fclose(BLACKLISTFILE);
}

stock M_Log(string[])
{
	new File:logfile, mhour, mminute, msecond, myear, mmonth, mday;
	if(!fexist("/M_Bot/M_Log.txt"))
	{
		logfile = fopen("/M_Bot/M_Log.txt",io_write);
	}
	else
	{
		logfile = fopen("/M_Bot/M_Log.txt",io_append);
	}	
	gettime(mhour,mminute,msecond);
	getdate(myear,mmonth,mday);
	format(string,(strlen(string)+32),"Logged %02d.%02d.%d %d:%d:%d: %s\n",mday,mmonth,myear,mhour,mminute,msecond,string);
	fwrite(logfile,string);
	fclose(logfile);
}


stock M_PutPlayerInVehicle(playerid,vehicleid,seatid)
{
	GetVehiclePos(vehicleid,M_Bot[playerid][PXpos],M_Bot[playerid][PYpos],M_Bot[playerid][PZpos]);
	PutPlayerInVehicle(playerid,vehicleid,seatid);
}

stock M_SetPlayerPos(playerid,Float:Xpos,Float:Ypos,Float:Zpos,Float:Angle = -1.0)
{
	M_Bot[playerid][PXpos] = Xpos;
	M_Bot[playerid][PYpos] = Ypos;
	M_Bot[playerid][PZpos] = Zpos;
	SetPlayerPos(playerid,Xpos,Ypos,Zpos);
	if(Angle != -1.0)
	{
		SetPlayerFacingAngle(playerid,Angle);
	}
}

stock M_SetVehiclePos(vehicleid,Float:Xpos,Float:Ypos,Float:Zpos,Float:Angle = -1.0)
{
	new playerid = GetVehicleDriver(vehicleid);
	if(playerid != -1)
	{
		M_Bot[playerid][PXpos] = Xpos;
		M_Bot[playerid][PYpos] = Ypos;
		M_Bot[playerid][PZpos] = Zpos;
	}
	SetVehiclePos(vehicleid,Xpos,Ypos,Zpos);
	if(Angle != -1.0)
	{
		SetVehicleZAngle(vehicleid,Angle);
	}
	return 1;	
}

stock M_GivePlayerWeapon(playerid,weaponid,ammo)
{
	new slot = GetWeaponSlot(weaponid);
	if(ammo == 0)
		ammo = 1;
	M_Bot[playerid][PWeapon][slot] = weaponid;
	M_Bot[playerid][PAmmo][slot] += ammo;
	GivePlayerWeapon(playerid,weaponid,ammo);
}

stock M_ResetPlayerWeapons(playerid)
{
	for(new slot=0; slot<13; slot++)
	{
		M_Bot[playerid][PWeapon][slot] = -1;
		M_Bot[playerid][PAmmo][slot] = 0;
	}	
	ResetPlayerWeapons(playerid);
}


stock M_GetPlayerMoney(playerid)
{
	return M_Bot[playerid][PMoney];
}

stock M_ResetPlayerMoney(playerid)
{
	M_Bot[playerid][PMoney] = 0;
	ResetPlayerMoney(playerid);
}

forward M_GivePlayerMoney(playerid,summe);
public M_GivePlayerMoney(playerid,summe)
{
	M_Bot[playerid][PMoney] += summe;
	GivePlayerMoney(playerid,summe);
}

stock M_SetPlayerMoney(playerid,summe)
{
	ResetPlayerMoney(playerid);
	M_Bot[playerid][PMoney] = summe;
	GivePlayerMoney(playerid,summe);
}


stock M_SetPlayerHealth(playerid,Float:health)
{
	if(health <= 0)
	{
		M_Bot[playerid][PSpawned] = 0;
		M_Bot[playerid][PHealth] = health;
		SetPlayerHealth(playerid,health);
	}
	else if(health > 99.0)
	{
		M_Bot[playerid][PHealth] = 99.0;
		SetPlayerHealth(playerid,99.0);
	}
	else
	{
		M_Bot[playerid][PHealth] = health;
		SetPlayerHealth(playerid,health);
	}
}

stock M_GivePlayerHealth(playerid,Float:health)
{
	GetPlayerHealth(playerid,GettedHealth);
	if(GettedHealth + health <= 0)
	{
		M_Bot[playerid][PSpawned] = 0;
		M_Bot[playerid][PHealth] = health;
		SetPlayerHealth(playerid,GettedHealth + health);
	}
	else if(GettedHealth + health > 99.0)
	{
		M_Bot[playerid][PHealth] = 99.0;
		SetPlayerHealth(playerid,99.0);
	}
	else
	{
		M_Bot[playerid][PHealth] += health;
		SetPlayerHealth(playerid,GettedHealth + health);
	}
}


stock M_SetPlayerArmour(playerid,Float:armour)
{
	if(armour > 99.0)
	{
		M_Bot[playerid][PArmour] = 99.0;
		SetPlayerArmour(playerid,99.0);
	}
	else
	{
		M_Bot[playerid][PArmour] = armour;
		SetPlayerArmour(playerid,armour);
	}	
}

stock M_GivePlayerArmour(playerid,Float:armour)
{
	GetPlayerArmour(playerid,GettedArmour);
	if(GettedArmour + armour > 99.0)
	{
		M_Bot[playerid][PArmour] = 99.0;
		SetPlayerArmour(playerid,99.0);
	}
	else
	{
		M_Bot[playerid][PArmour] += armour;
		SetPlayerArmour(playerid,GettedArmour + armour);
	}
}


public CheckIPFromList(playerid)
{
    new playerip[15], read[32], TwoNumbersLength = 0, count = 0;
	GetPlayerIp(playerid,playerip,sizeof(playerip));
	for(new c=0; c<strlen(playerip); c++)
	{
	    if(playerip[c] == '.')
		{
			count++;
		}
	    if(count == 2)
	    {
	        TwoNumbersLength = c-1;
	        break;
	    }
	}
	new File:BLACKLISTFILE = fopen("/M_Bot/M_Black.cfg", io_read);
	if(BLACKLISTFILE)
	{
		while(fread(BLACKLISTFILE,read))
		{
			for(new x=0; x<strlen(read); x++)
			{
			    if(read[x] == '\n')
				{
				    read[x] = '\0';
				}
			}
			if(!strcmp(read,playerip,false,TwoNumbersLength) || !strcmp(read,playerip,false))
			{
				fclose(BLACKLISTFILE);
				return 1;
			}
		}
	}
	fclose(BLACKLISTFILE);
	/*new playerip[16], read[32], ipstr[4][8], ip[2], ipstr2[4][8], ip2[2];
	
	GetPlayerIp(playerid,playerip,sizeof(playerip));
	split(playerip,ipstr2,'.');
	ip2[0] = strval(ipstr2[0]);
	ip2[1] = strval(ipstr2[1]);
	
	new File:BLACKLISTFILE = fopen("/M_Bot/M_Black.cfg", io_read);
	if(BLACKLISTFILE)
	{
		while(fread(BLACKLISTFILE,read))
		{
			split(read,ipstr,'.');
			ip[0] = strval(ipstr[0]);
			ip[1] = strval(ipstr[1]);
			
			if(ip[0] == ip2[0] && ip[1] == ip2[1])
			{
				fclose(BLACKLISTFILE);
				return 1;
			}			
		}
	}
	fclose(BLACKLISTFILE);*/
	return 0;
}

public Check()
{
	for(new playerid=0; playerid<GetMaxPlayers(); playerid++)
	if(IsPlayerConnected(playerid))
	{
		new admstring[128], playername[MAX_PLAYER_NAME], weapon = -1, ammo = 0;
		GetPlayerName(playerid,playername,sizeof(playername));
		GetPlayerHealth(playerid,GettedHealth);
		GetPlayerArmour(playerid,GettedArmour);	
		GetPlayerPos(playerid,M_Bot[playerid][PXpos2],M_Bot[playerid][PYpos2],M_Bot[playerid][PZpos2]);
		//distance = (((M_Bot[playerid][PXpos2]-M_Bot[playerid][PXpos])*(M_Bot[playerid][PXpos2]-M_Bot[playerid][PXpos]))+((M_Bot[playerid][PYpos2]-M_Bot[playerid][PYpos])*(M_Bot[playerid][PYpos2]-M_Bot[playerid][PYpos])))/100;

		new differenz = (GetPlayerMoney(playerid) - M_Bot[playerid][PMoney]);
		if(differenz >= 4490)
		{
			format(admstring,sizeof(admstring)," %s: %s ist unter Moneyhackverdacht! Ercheateter Betrag: %d ",M_Bot_BOT_NAME,playername,differenz);
			SendClientMessageToAdmins(M_BOT_COLOR,admstring);
			M_SetPlayerMoney(playerid,M_Bot[playerid][PMoney]);
			M_Log(admstring);
			MoneySpam[playerid]++;
		}
		/*if(MoneySpam[playerid] >= 20)
		{
			format(admstring,sizeof(admstring)," %s wurde von %s gebannt! (GRUND: MoneyCheat)",playername,M_Bot_BOT_NAME);
			SendClientMessageToAll(M_BOT_COLOR,admstring);
			format(admstring,sizeof(admstring)," Bann von %s (GRUND: MoneyCheat | IP: %s) ",playername,GetIP(playerid));
			MoneySpam[playerid] = 0;
			M_Log(admstring);
			M_BanEx(playerid,"MoneyCheat");
	    		return 1;
		}*/


		/*if(M_Bot[playerid][PSpawned] && M_Bot[playerid][PCheck])
		{
			if(GettedHealth > 99.0)
			{
				if(M_Bot[playerid][PHealth] > 99.0)
				{
					M_SetPlayerHealth(playerid,99.0);
				}
				else
				{
					format(admstring,sizeof(admstring)," %s: %s ist unter Healthcheatverdacht! ",M_Bot_BOT_NAME,playername);
					SendClientMessageToAdmins(M_BOT_COLOR,admstring);
					M_SetPlayerHealth(playerid,M_Bot[playerid][PHealth]);
					//M_Log(admstring);
				}
			}
			if(GettedArmour > 99.0)
			{
				format(admstring,sizeof(admstring)," %s: %s ist unter Armourcheatverdacht! ",M_Bot_BOT_NAME,playername);
				SendClientMessageToAdmins(M_BOT_COLOR,admstring);
				M_SetPlayerArmour(playerid,M_Bot[playerid][PArmour]);
				//M_Log(admstring);
			}
			if(distance > 1000.0) // Hohe Distanz
			if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING) // Nicht beim Spectaten
			if(!IsAPlaneForNoCheck(GetPlayerVehicleID(playerid))) // Nicht wenn man im Flugzeug ist
			{
				format(admstring,sizeof(admstring)," %s: %s ist unter Speedhack/Teleport-verdacht! ",M_Bot_BOT_NAME,playername);
				SendClientMessageToAdmins(M_BOT_COLOR,admstring);
			}
		}*/
		
		/*if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
		{
			format(admstring,sizeof(admstring)," %s wurde von %s gebannt! (GRUND: Jetpack) ",playername,M_Bot_BOT_NAME);
			SendClientMessageToAll(M_BOT_COLOR,admstring);
			format(admstring,sizeof(admstring)," Bann von %s (GRUND: Jetpack | IP: %s) ",playername,GetIP(playerid));
			M_Log(admstring);
			M_BanEx(playerid,"Jetpack");
		}*/

		for(new w=0; w<sizeof(BanWeaponIDs); w++)
		{
			GetPlayerWeaponData(playerid,GetWeaponSlot(BanWeaponIDs[w]),weapon,ammo);
			if(weapon == BanWeaponIDs[w] && ammo > 0)
			{
				format(admstring,sizeof(admstring)," %s wurde von %s gebannt! (GRUND: Waffenhack)",playername,M_Bot_BOT_NAME);
				SendClientMessageToAll(M_BOT_COLOR,admstring);
				format(admstring,sizeof(admstring)," Bann von %s (GRUND: Waffenhack | IP: %s) ",playername,GetIP(playerid));
				M_Log(admstring);
				M_BanEx(playerid,"Waffenhack");
			}
		}
	
		
		if(GetPlayerPing(playerid) >= MaxPing && M_Bot[playerid][PCheckHighPing] && M_Bot[playerid][PSpawned])
		{
			M_Bot[playerid][PHighPingWarns]++;
			if(M_Bot[playerid][PHighPingWarns] >= 5)
			{
				format(admstring,sizeof(admstring)," %s wurde von %s gekickt! (GRUND: PING: %d | MAXPING: %d) ",playername,M_Bot_BOT_NAME,GetPlayerPing(playerid),MaxPing);
				SendClientMessageToAll(M_BOT_COLOR,admstring);
				M_Kick(playerid);
				M_Log(admstring);
			}
			else
			{
				format(admstring,sizeof(admstring)," [!] Dein Ping ist zu hoch! (PING: %d | MAXPING: %d | WARNUNG: %d/5)",GetPlayerPing(playerid),MaxPing,M_Bot[playerid][PHighPingWarns]);
				SendClientMessage(playerid,M_BOT_COLOR,admstring);
				SetTimerEx("EnablePingWarnAgain",15000,0,"i",playerid);
			}
		}
		
		if(M_Bot[playerid][PSpawned])
		{
			M_Bot[playerid][PInactiveSeconds]++;
		}

		if(M_Bot[playerid][PFrozen] || AllFrozen)
		{
			FreezePlayer(playerid);
		}
		
		if(M_Bot[playerid][PAFK] == 1)
		{
			GameTextForPlayer(playerid,"~y~Du bist AFK~n~~g~Um aus dem ~r~AFK-Modus~g~ zu gehen:~n~~y~/back",3500,3);
		}	
		
		M_Bot[playerid][PXpos] = M_Bot[playerid][PXpos2];
		M_Bot[playerid][PYpos] = M_Bot[playerid][PYpos2];
		M_Bot[playerid][PZpos] = M_Bot[playerid][PZpos2];
		M_Bot[playerid][PLastInterior] = GetPlayerInterior(playerid);
	}	
	return 1;
}


stock IsAPlaneForNoCheck(vehicleid)
{
	new modelid = GetVehicleModel(vehicleid);
	if(modelid == 417 || modelid == 425 || modelid == 447 || modelid == 460 || modelid == 469 || modelid == 476 || modelid == 487 || modelid == 488 || modelid == 497 || modelid == 511 || modelid == 512 || modelid == 513 || modelid == 519 || modelid == 520 || modelid == 548 || modelid == 553 || modelid == 563 || modelid == 577 || modelid == 593)
	{
		return 1;
	}
	return 0;
}

stock GetWeaponSlot(wid) // Dank an [NSG]roschti für die Funktion
{
    new id;
    switch(wid)
    {
        case 0,1: 					id=0;
        case 2,3,4,5,6,7,8,9: 		id=1;
        case 22,23,24: 				id=2;
        case 25,26,27: 				id=3;
        case 28,29,32: 				id=4;
        case 30,31: 				id=5;
        case 33,34: 				id=6;
        case 35,36,37,38: 			id=7;
        case 16,17,18,19,39: 		id=8;
        case 41,42,43: 				id=9;
        case 10,11,12,13,14,15: 	id=10;
        case 44,45,46: 				id=11;
        case 40: 					id=12;
        case 20,21,47,49,50,53,54: 	id=(-1);
        default: 					id=(-1);
    }
    return id;
}



// ====================================================================================================================



EnableM_Bot()
{
	SetTimer("Check",2500,1);
	AllFrozen = 0;
	return 1;
}

M_OnPlayerSpawn(playerid)
{
	M_Bot[playerid][PSpawned] = 1;
	M_Bot[playerid][PCheck] = 0;
	SetTimerEx("EnableChecking",3333,0,"i",playerid);
	if(AllFrozen)
	{
		FreezePlayer(playerid);
	}
	return 1;
}

M_OnPlayerConnect(playerid)
{
	if(!strcmp(M_Bot_BOT_NAME,GetName(playerid),true))
	{
	    M_Kick(playerid);
	}
	
	if(CheckIPFromList(playerid))
	{
	    SendClientMessage(playerid,M_BOT_COLOR," Du hast einen PERM-BANN auf diesem Server !");
	    GameTextForPlayer(playerid,"~r~BYE",60000,3);
	    M_Kick(playerid);
	}
	for(new n=0; n<sizeof(BanClanTags); n++)
	{
		if(strfind(GetName(playerid),BanClanTags[n],false) == 0)
		{
			new banstring[128];
			format(banstring,sizeof(banstring)," Dein Clan %s ist von diesem Server gebannt!",BanClanTags[n]);
			SendClientMessage(playerid,M_BOT_COLOR,banstring);
			format(banstring,sizeof(banstring)," %s aus dem gebannten Clan %s hat den Server betreten und wurde gebannt!",GetName(playerid),BanClanTags[n]);
			SendClientMessageToAdmins(M_BOT_COLOR,banstring);
			M_Log(banstring);
			format(banstring,sizeof(banstring),"Clan %s",BanClanTags[n]);
			M_BanEx(playerid,banstring);
		}
	}
	for(new n=0; n<sizeof(BanNames); n++)
	{
		if(strcmp(GetName(playerid),BanNames[n],true) == 0)
		{
			new banstring[128];
			format(banstring,sizeof(banstring)," Dein Name %s ist von diesem Server gebannt!",GetName(playerid));
			SendClientMessage(playerid,M_BOT_COLOR,banstring);
			format(banstring,sizeof(banstring)," %s hat den Server betreten und wurde gebannt!",GetName(playerid));
			SendClientMessageToAdmins(M_BOT_COLOR,banstring);
			M_Log(banstring);
			format(banstring,sizeof(banstring),"Name %s",BanNames[n]);
			M_BanEx(playerid,banstring);
		}
	}
	// Reset Vars
	M_Bot[playerid][PMoney] = 0;
	M_Bot[playerid][PLastInterior] = 0;
	M_Bot[playerid][PInactiveSeconds] = 0;
	M_Bot[playerid][PIPWarns] = 0;
	M_Bot[playerid][PBadWordWarns] = 0;
	M_Bot[playerid][PHighPingWarns] = 0;
	M_Bot[playerid][PAFK] = 0;
	M_Bot[playerid][PFrozen] = 0;
	M_Bot[playerid][PSpawned] = 0;
	M_Bot[playerid][PCheck] = 0;
	M_Bot[playerid][PCheckHighPing] = 0;
	for(new slot=0; slot<13; slot++)
	{
		M_Bot[playerid][PWeapon][slot] = -1;
		M_Bot[playerid][PAmmo][slot] = 0;
	}	
	return 1;	
}

M_OnPlayerDeath(playerid,killerid,reason)
{
	M_Bot[playerid][PSpawned] = 0;
	if(GetPlayerState(killerid) == PLAYER_STATE_DRIVER && GetDistanceBetweenPlayers(playerid,killerid) < 20  && (reason == WEAPON_MP5 || reason == WEAPON_VEHICLE || reason == WEAPON_COLLISION))
	{
		new kickstring[128];
		format(kickstring,sizeof(kickstring)," %s wurde von %s gekickt! (GRUND: Fahrer-DriveBy)",GetName(killerid),M_Bot_BOT_NAME);
		SendClientMessageToAll(M_BOT_COLOR,kickstring);
		M_Kick(killerid);
	}
	return 1;	
}

M_OnPlayerUpdate(playerid)
{
	M_Bot[playerid][PInactiveSeconds] = 0;
	return 1;
}

M_OnPlayerStateChange(playerid, newstate, oldstate)
{
	#pragma unused oldstate
	if(newstate == PLAYER_STATE_DRIVER)
	{
		if(IsAnAmbulance(GetPlayerVehicleID(playerid)))
		{
			M_SetPlayerHealth(playerid,99.0);
		}
	}	
	return 1;
}

M_OnPlayerCommandText(playerid,cmdtext[])
{
	new string[128];
		
	/*if(strcmp("/afk",cmdtext,true) == 0)
	{
	    if(!M_Bot[playerid][PAFK])
		{
		    SendClientMessage(playerid,0x33AA33AA,"In 15 Sekunden wirst du in den AFK-Modus gebracht!");
			KillTimer(M_Bot[playerid][PAFKTimer]);
			M_Bot[playerid][PAFKTimer] = SetTimerEx("AFKOn",15000,0,"i",playerid);
		}
		else
		{
		    SendClientMessage(playerid,0xAA3333AA,"Du bist schon AFK!");
		}
	    return 1;
	}*/
	if(strcmp("/back",cmdtext,true) == 0)
	{
	    if(M_Bot[playerid][PAFK])
		{
			format(string,sizeof string,"*~ [AFK] %s ist vom AFK-Modus zurück!",GetName(playerid));
			SendClientMessageToAll(0xAFAFAFAA,string);
			M_Bot[playerid][PAFK] = 0;
			UnFreezePlayer(playerid);
			KillTimer(M_Bot[playerid][PAFKTimer]);
		}
		else
		{
		    SendClientMessage(playerid,0xAA3333AA,"Du bist nicht AFK!");
		}
	    return 1;
	}
	if(strcmp("/afklist",cmdtext,true) == 0)
	{
	    new countafk = 0;
	    SendClientMessage(playerid,0x33AA33AA,"|---------------------- AFK-List -----------------------|");
	    for(new i=0; i<GetMaxPlayers(); i++)
	    {
	        if(IsPlayerConnected(i) && M_Bot[i][PAFK])
			{
				format(string,sizeof string,"* [AFK] %s",GetName(i));
				SendClientMessage(playerid,0x33AA33AA,string);
				countafk++;
			}
		}
		if(countafk == 0) SendClientMessage(playerid,0x33AA33AA,"         Niemand ist AFK !");
		SendClientMessage(playerid,0x33AA33AA,"|----------------------------------------------------------|");
		return 1;
	}
		
	return 1;
	
}


#define GivePlayerWeapon 	M_GivePlayerWeapon
#define ResetPlayerWeapons	M_ResetPlayerWeapons
#define GivePlayerMoney 	M_GivePlayerMoney
#define GetPlayerMoney 		M_GetPlayerMoney
#define ResetPlayerMoney 	M_ResetPlayerMoney
#define SetPlayerHealth 	M_SetPlayerHealth
#define SetPlayerArmour 	M_SetPlayerArmour
#define PutPlayerInVehicle 	M_PutPlayerInVehicle
#define SetVehiclePos 		M_SetVehiclePos
#define SetPlayerPos 		M_SetPlayerPos
#define Kick				M_Kick
#define Ban 				M_Ban
#define BanEx 				M_BanEx


