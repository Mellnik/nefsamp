stock PlayerIP(playerid)
{
    new pIP[24];
    GetPlayerIp(playerid, pIP, sizeof(pIP));
    return pIP;
}

stock PlayerName(playerid)
{
    new pName[24];
    GetPlayerName(playerid, pName, 24);
    return pName;
}


stock PlayerPing(playerid)
{
    new pPing[24];
    GetPlayerPing(playerid, pPing, 24);
    return pPing;
}


stock CheckValidWeapon(wepid)
{
   if (wepid > 0 && wepid< 19 || wepid > 21 && wepid < 47)
   {
       return 1;
   }
    return 0;
}


stock CheckValidWeather(wid)
{
   if (wid > 0 && wid < 50)
   {
       return 1;
   }
    return 0;
}


stock CheckValidTime(timeid)
{
   if (timeid > 1 && timeid < 24)
   {
       return 1;
   }
    return 0;
}


stock CheckValidHealth(playerid,hp)
{
   if (hp => 0 && hp <= 100)
   {
       return 1;
   }
    return 0;
}


stock CheckValidArmour(playerid,arm)
{
   if (arm => 0 && arm <= 100)
   {
       return 1;
   }
    return 0;
}



stock CheckValidSkin(playerid,SkinID)
{
    if((SkinID == 0)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||(SkinID >= 43 && SkinID <= 64)||(SkinID >= 66 && SkinID    <= 73)||(SkinID >= 75 && SkinID <= 85)||(SkinID >= 87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >=    150 && SkinID <= 207)||(SkinID >= 209 && SkinID <= 264)||(SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID    <= 299))
   {
       return 1;
   }
   return 0;
}


//Not My Script
strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}