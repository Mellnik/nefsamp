#if defined _h_inc_included
        #endinput
#endif
#define _h_inc_included


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

stock CheckPlayerDistanceToVehicle(Float:radi, playerid, vehicleid)
{
	if(IsPlayerConnected(playerid))
	{
	    new Float:PX,Float:PY,Float:PZ,Float:X,Float:Y,Float:Z;
	    GetPlayerPos(playerid,PX,PY,PZ);
	    GetVehiclePos(vehicleid, X,Y,Z);
	    new Float:Distance = (X-PX)*(X-PX)+(Y-PY)*(Y-PY)+(Z-PZ)*(Z-PZ);
	    if(Distance <= radi*radi)
	    {
	        return 1;
	    }
	}
	return 0;
}

stock GetIP(playerid)
{
	new gettheip[15];
	GetPlayerIp(playerid,gettheip,sizeof(gettheip));
	return gettheip;
}

stock GetName(playerid)
{
	new getthename[MAX_PLAYER_NAME];
	GetPlayerName(playerid,getthename,sizeof(getthename));
	return getthename;
}

stock GetWeaponSlot(wid) // Dank an [NSG]roschti für die Funktion
{
    new id;
    switch(wid)
    {
        case 0,1:                     id=0;
        case 2,3,4,5,6,7,8,9:         id=1;
        case 22,23,24:                 id=2;
        case 25,26,27:                 id=3;
        case 28,29,32:                 id=4;
        case 30,31:                 id=5;
        case 33,34:                 id=6;
        case 35,36,37,38:             id=7;
        case 16,17,18,19,39:         id=8;
        case 41,42,43:                 id=9;
        case 10,11,12,13,14,15:     id=10;
        case 44,45,46:                 id=11;
        case 40:                     id=12;
        case 20,21,47,49,50,53,54:     id=(-1);
        default:                     id=(-1);
    }
    return id;
}

stock GetGasMax(vehmodel)
{
    if(vehmodel >= 400 && vehmodel <= 611)
    {
        return GasMax[(vehmodel-400)];
    }
    return 100;
}

stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
    new Float:a;
    GetPlayerPos(playerid, x, y, a);
    GetPlayerFacingAngle(playerid, a);

    if(GetPlayerVehicleID(playerid))
    {
        GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
    }

    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
}

stock right(source[], len)
{
    new retval[MAX_STRING], srclen;
    srclen = strlen(source);
    strmid(retval, source, srclen - len, srclen, MAX_STRING);
    return retval;
}
stock IsValidDate(day, month, year)
{
    new maxDays;
    if (year < 1900 || year > 2010) return 0; // Bad Year
    switch (month)
    {
        case 1,3,5,7,8,10,12: maxDays = 31;
        case 4,6,9,11: maxDays = 30;
        case 2:
        {
            if(IsLeapYear(year))
             {
                 maxDays = 29;
            }
            else
            {
                maxDays = 28;
            }
        }
        default: return 0; // Bad Month
    }

    if (day < 1 || day > maxDays) return 0; // Bad Day
    return 1;
}

stock IsLeapYear(year)
{
    /*if (year % 4 == 0 &&
        (year % 100 != 0 ||
         year % 400 == 0)) {
        return 1;
    } else {
        return 0;
    }*/
    return ( year % 4 == 0 && (year % 100 != 0 || year % 400 == 0) );
}