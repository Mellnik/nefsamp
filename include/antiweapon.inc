#if defined nowebu_ready
	#endinput
#endif
#define nowebu_ready

//Script by Trooper[Y]
//Credits to seif_(marked part)


/*
Features :
*Anti-Ammohack
*No reload-bug by just swapping weapons

CMD´s:
man_reload(yn) | yn = 0/1 | If set to 1, you need to use the reload-cmd to make him reload (manual reload)
reload(playerid)  |  Makes a player reloading if necessary
GetBullets(playerid,wid)  |  wid = weaponid  |  Retrieves the reserve bullets left (Use getplayerweapondata for the rest-shots in the weapon)

*/

#include <a_samp>

new Text:txtdraw[MAX_PLAYERS],fastformat[MAX_PLAYERS][256],manualreload,lastwep[MAX_PLAYERS];

forward nowebu_OnCon(playerid);
forward nowebu_OnDis(playerid,reason);
forward nowebu_AddPlayerClass(skin, Float:x, Float:y, Float:z, Float:Angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
forward nowebu_AddPlayerClassEx(teamid, skin, Float:x, Float:y, Float:z, Float:Angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
forward nowebu_OnPlayerUpdate(playerid);
forward reload(playerid);
forward nowebu_key(playerid,newkeys,oldkeys);
forward man_reload(yn);
forward nowebu_GivePlayerWeapon(playerid,weaponid,ammo);
forward nowebu_ResetPlayerWeapons(playerid);
forward GetBullets(playerid,wid);

public man_reload(yn)
{
	manualreload = yn;
	return 1;
}

public nowebu_ResetPlayerWeapons(playerid)
{
    ResetPlayerWeapons(playerid);
    for(new bk=0;bk<=13;bk++)
    {
        format(fastformat[playerid],256,"nowebu_slot_%d",bk);
        SetPVarInt(playerid,fastformat[playerid],0);
    }
	return ;
}

public GetBullets(playerid,wid)
{
    format(fastformat[playerid],256,"nowebu_slot_%d",GetWeapSlotID(wid));
	return GetPVarInt(playerid,fastformat[playerid]);
}

public nowebu_GivePlayerWeapon(playerid,weaponid,ammo)
{
	new winfo[2],slot = GetWeapSlotID(weaponid);
	GetPlayerWeaponData(playerid,slot,winfo[0],winfo[1]);
	if(GetMagSize(weaponid) == 1) return GivePlayerWeapon(playerid,weaponid,ammo);
	if(winfo[1] != 0 || winfo[0] != 0)
	{
	    format(fastformat[playerid],256,"nowebu_slot_%d",slot);
		SetPVarInt(playerid,fastformat[playerid],GetPVarInt(playerid,fastformat[playerid])+ammo);
	}
	else
	{
	    format(fastformat[playerid],256,"nowebu_slot_%d",slot);
		SetPVarInt(playerid,fastformat[playerid],ammo-GetMagSize(weaponid));
		GivePlayerWeapon(playerid,weaponid,GetMagSize(weaponid));
	}
	
	return 1;
}

public OnPlayerConnect(playerid)
{
    txtdraw[playerid] = TextDrawCreate(500.000000, 67.000000, " ");
	TextDrawBackgroundColor(txtdraw[playerid], 255);
	TextDrawFont(txtdraw[playerid], 1);
	TextDrawLetterSize(txtdraw[playerid], 0.25, 0.7);
	TextDrawColor(txtdraw[playerid], -1);
	TextDrawSetOutline(txtdraw[playerid], 0);
	TextDrawSetProportional(txtdraw[playerid], 1);
	TextDrawSetShadow(txtdraw[playerid], 1);
	TextDrawUseBox(txtdraw[playerid], 1);
	TextDrawBoxColor(txtdraw[playerid], 255);
	TextDrawTextSize(txtdraw[playerid], 516.000000, 15.000000);

	return CallLocalFunction("nowebu_OnCon","i",playerid);
}

public OnPlayerDisconnect(playerid,reason)
{
	TextDrawDestroy(txtdraw[playerid]);
    return CallLocalFunction("nowebu_OnDis","ii",playerid,reason);
}

public nowebu_AddPlayerClass(skin, Float:x, Float:y, Float:z, Float:Angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo)
{
	if(weapon1 != 0 || weapon2 != 0 || weapon3 != 0) print("Reminder : You cant add weapons using AddPlayerClass, while using nowebu");
	return AddPlayerClass(skin, x, y, z, Angle, 0, 0, 0, 0, 0, 0);
}

public nowebu_AddPlayerClassEx(teamid, skin, Float:x, Float:y, Float:z, Float:Angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo)
{
	if(weapon1 != 0 || weapon2 != 0 || weapon3 != 0) print("Reminder : You cant add weapons using AddPlayerClassEx, while using nowebu");
	return AddPlayerClassEx(teamid,skin,x,y,z,Angle,0,0,0,0,0,0);
}

public OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
	if(newkeys & KEY_CROUCH)
	{
	    if(GetPVarInt(playerid,"crouching") == 1) SetPVarInt(playerid,"crouching",0);
	    else SetPVarInt(playerid,"crouching",1);
	}
	return CallLocalFunction("nowebu_key","iii",playerid,newkeys,oldkeys);
}

public OnPlayerUpdate(playerid)
{
	if(IsPlayerNPC(playerid)) return CallLocalFunction("nowebu_OnPlayerUpdate","i",playerid);
	SetPVarInt(playerid,"atmw",GetPlayerWeapon(playerid));
	SetPVarInt(playerid,"state",GetPlayerState(playerid));
	if(GetMagSize(GetPVarInt(playerid,"atmw")) != 1)
	{
	    SetPVarInt(playerid,"prepre",lastwep[playerid]);
		lastwep[playerid] = GetPVarInt(playerid,"atmw");
	}
	if(lastwep[playerid] == 0) return CallLocalFunction("nowebu_OnPlayerUpdate","i",playerid);
	
	new lcheck[3];
	lcheck[2] = GetWeapSlotID(GetPVarInt(playerid,"prepre"));
	GetPlayerWeaponData(playerid,lcheck[2],lcheck[0],lcheck[1]);
	format(fastformat[playerid],256,"nowebu_slot_%d",lcheck[2]);
	if(lcheck[1] > GetMagSize(GetPVarInt(playerid,"prepre"))+1)
	{
	    new tsave[31][2];
	    for(new bkup=0;bkup!=31;bkup++) GetPlayerWeaponData(playerid,bkup,tsave[bkup][0],tsave[bkup][1]);
	    ResetPlayerWeapons(playerid);
        for(new bkup=0;bkup!=31;bkup++) if(bkup != lcheck[2]) GivePlayerWeapon(playerid,tsave[bkup][0],tsave[bkup][1]);
        GivePlayerWeapon(playerid,lcheck[0],GetMagSize(lastwep[playerid]));
	    return CallLocalFunction("nowebu_OnPlayerUpdate","i",playerid);
	}
	if(lcheck[1] == 0 && GetPVarInt(playerid,fastformat[playerid]) >= 0 && GetMagSize(GetPVarInt(playerid,"prepre")) != 1)
	{
		SetPVarInt(playerid,"needreload",1);
	    if(manualreload == 0)
		{
			TogglePlayerControllable(playerid,0);
     		reload(playerid);
		}
		else
		{
		    TogglePlayerControllable(playerid,0);
		    GameTextForPlayer(playerid,"You need to reload",2000,3);
		}
	}
	
	format(fastformat[playerid],256,"nowebu_slot_%d",GetWeapSlotID(lastwep[playerid]));
	format(fastformat[playerid],256,"%d",GetPVarInt(playerid,fastformat[playerid]));
	TextDrawSetString(txtdraw[playerid],fastformat[playerid]);
	
	if(GetMagSize(GetPVarInt(playerid,"atmw")) == 1)
	{
	    if(GetPVarInt(playerid,"shown") == 1)
	    {
		    TextDrawHideForPlayer(playerid,txtdraw[playerid]);
		    SetPVarInt(playerid,"shown",0);
		}
		return CallLocalFunction("nowebu_OnPlayerUpdate","i",playerid);
	}
	if(GetPVarInt(playerid,"shown") == 0)
	{
	    if(GetPVarInt(playerid,"state") <= 3 && GetPVarInt(playerid,"state") != 0 && (GetMagSize(GetPVarInt(playerid,"atmw")) != 1 ))
	    {
		    TextDrawShowForPlayer(playerid,txtdraw[playerid]);
		    SetPVarInt(playerid,"shown",1);
		    format(fastformat[playerid],256,"nowebu_slot_%d",GetWeapSlotID(lastwep[playerid]));
		    format(fastformat[playerid],256,"%d",GetPVarInt(playerid,fastformat[playerid]));
		    TextDrawSetString(txtdraw[playerid],fastformat[playerid]);
		}
	}
	else
	{
	    if(GetPVarInt(playerid,"state") == 0 || GetPVarInt(playerid,"state") > 3)
	    {
		    TextDrawHideForPlayer(playerid,txtdraw[playerid]);
		    SetPVarInt(playerid,"shown",0);
	    }
	}
	return CallLocalFunction("nowebu_OnPlayerUpdate","i",playerid);
}

public reload(playerid)
{
	if(GetPVarInt(playerid,"needreload") == 0) return 0;
	TogglePlayerControllable(playerid,1);
	
	format(fastformat[playerid],256,"nowebu_slot_%d",GetWeapSlotID(GetPVarInt(playerid,"prepre")));
	if(GetPVarInt(playerid,fastformat[playerid]) <= 0)
	{
	    TextDrawHideForPlayer(playerid,txtdraw[playerid]);
	    SetPVarInt(playerid,"shown",0);
	    return 0;
	}
	SetPVarInt(playerid,fastformat[playerid],GetPVarInt(playerid,fastformat[playerid])-GetMagSize(GetPVarInt(playerid,"prepre")));
	format(fastformat[playerid],256,"%d",GetPVarInt(playerid,fastformat[playerid]));
	TextDrawSetString(txtdraw[playerid],fastformat[playerid]);
	
	GivePlayerWeapon(playerid,GetPVarInt(playerid,"prepre"),GetMagSize(GetPVarInt(playerid,"prepre")));
	for(new app=0;app!=4;app++) ApplyAnimation(playerid,"COLT45","colt45_reload",4.0,0,1,1,0,0);
	
	if(GetPVarInt(playerid,fastformat[playerid]) <= 0)
	{
	    TextDrawHideForPlayer(playerid,txtdraw[playerid]);
	    SetPVarInt(playerid,"shown",0);
	}
	return 1;
}

stock GetMagSize(weaponid)
{
	switch (weaponid)
	{
	    case 0..18,25,33..36,39,40,44..46: return 1;
	    case 22: return 34;
	    case 23: return 17;
	    case 24: return 7;
	    case 26: return 4;
	    case 27: return 7;
	    case 28,32: return 100;
	    case 29,30: return 30;
	    case 31,37: return 50;
	    case 38,41,42: return 500;
	    case 43: return 36;
	}
	return 1;
}

//#################### This part is copied from seif_, even he forgot some weapon in it ;) ############
stock GetWeapSlotID(weaponid)
{
	switch (weaponid)
	{
	    case 0,1: return 0;
	    case 30,31: return 5;
	    case 2..9: return 1;
	    case 10..15: return 10;
	    case 16..18,39: return 8;
	    case 22..24: return 2;
	    case 25..27: return 3;
	    case 28,29,32: return 4;
	    case 33,34: return 6;
	    case 35..38: return 7;
	    case 41..43: return 9;
	    case 44..46: return 11;
	    default: return 12;
	}
	return 0;
}
//#####################################################################################################

#define GivePlayerWeapon nowebu_GivePlayerWeapon
#define ResetPlayerWeapons nowebu_ResetPlayerWeapons
#define AddPlayerClass nowebu_AddPlayerClass
#define AddPlayerClassEx nowebu_AddPlayerClassEx

#if defined _def_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _def_OnPlayerConnect
#endif
#define OnPlayerConnect nowebu_OnCon

#if defined _def_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _def_OnPlayerUpdate
#endif
#define OnPlayerUpdate nowebu_OnPlayerUpdate

#if defined _def_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _def_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect nowebu_OnDis

#if defined _def_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _def_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange nowebu_key