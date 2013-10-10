/*
 $
 $ This include is part of gAdmin
 $
 $ gAdmin by :				Goldkiller (gta-goldkiller[at]web.de)
 $ Latest Update :			8/ 10/ 2009
 $ gAdmin Version :			1.1
 $ Visit :                  www.san-vice.de.vu
*/
/*
native _gAdmin_Functions();
native
*/
native CheckFileEntry(playerid,file[],params[]);
native WriteLog(file[],text[]);
native WriteIPBan(playerid,id);
native ReadIPBans(playerid);
native WriteBlacklist(playerid,params[]);
native ReadBlacklist(playerid);
native WriteClanBlacklist(playerid,params[]);
native ReadWhiteList(playerid);
native WriteWhiteList(playerid,params[]);
native ReadClanBlacklist(playerid);
native IsPlayerInBadHeli(playerid);
native TeleportPlayer(playerid,Float:bX,Float:bY,Float:bZ,Float:bD,interior);
native IsPlayerInCar(playerid);
native IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy);
native PlaySoundForAll(soundid);
native GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance);
native IsPlayerInCircle(playerid, Float:xPos, Float:yPos, Float:radius);
native GetXYZZoneName(Float:x, Float:y, Float:z);
native GetXYZZoneID(Float:x, Float:y, Float:z);
native IsXYZInZone(Float:x, Float:y, Float:z, zoneid);
native IsPlayerInZone(playerid, zoneid);
native IsPlayerInZoneName(playerid, zonename[]);
native IsValidSkin(skinid);
native IP2RootIP(ip[16], blocks);
native IsPlayerInBank(playerid);
native GetDistance(Float:xPos, Float:xPos2, Float:yPos, Float:yPos2);
native VehicleDriverID(vehicleid);
native IsVehicleInUse(vehicleid);
native sscanf(string[], format[], {Float,_}:...);
native IsIP(string[]);
native GetDateTilBanned(bandays,&day,&month,&year);
native IsDateReached(day,month,year);
native RGBAToHex(red, green, blue, a);
native HexToRGBA(colour, &red, &green, &blue, &a);

/*
native
native _gLanguage_Functions();
native
*/
native GetServerLanguage();
native ServerLanguage();
native SetServerLanguage(language);
native GetShortLanguageName(languageid);
native SetShortLanguageName(languageid,shorttext[]);
native GetLanguageName(languageid);
native SetLanguageName(languageid,longtext[]);
native GetLanguageExtension(languageid)
native SetLanguageExtension(languageid,extension[]);
native GetPlayerLanguageID(playerid);
native SetPlayerLanguageID(playerid,languageid);
native SetDefaultPlayerLanguageID(playerid,languageid);
native Language:AddLanguage(nshort[],nlong[],ext[]);
native LoadLanguageFile(Language:languageid);
native GetLanguageString(Language:languageid,iden[]);
native LoadBasicText();
native ReloadLanguages();
/*
native
native _gLanguage_YSI_Functions();
native
*/
native SendBuffedClientLanguageMessage(playerid,color);
native CreateClientLanguageMessage(languageid,const indentifier[], {Float,_}:...);
native CreateClientLanguageMessages(const indentifier[], {Float,_}:...);
native SendClientLanguageMessage(playerid,color,const format[], {Float,_}:...);
native SendClientLanguageMessageToAll(color,const identifier[], {Float,_}:...);
/*
native
native _gSQL_Functions();
native
*/
native InitSQL();
native CloseSQL();
native gSQL_ExistUser(nickname[]);
native gSQL_AddUser(nickname[], pwd[]);
native gSQL_DeleteUser(nickname[]);
native gSQL_UpdateUser(nickname[]);
native gSQL_GetUserVar(nickname[], where[]);
native gSQL_GetUserVarAsInteger(nickname[], where[]);
native gSQL_GetUserVarAsFloat(nickname[], where[]);
native gSQL_SetUserVar(nickname[], where[], var[]);
native gSQL_SetUserVarAsInteger(nickname[], where[], var);
native gSQL_SetUserVarAsFloat(nickname[], where[], Float:var);

native gSQL_SetVarAsFloat(table[],column[],Float:var,where[],is[],precision = 5);
native gSQL_SetVarAsInteger(table[],column[],var,where[],is[]);
native gSQL_SetVar(table[],column[],var[],where[],is[]);
native gSQL_GetVarAsFloat(column[],table[],where[],is[]);
native gSQL_GetVarAsInteger(column[],table[],where[],is[]);
native gSQL_GetVar(column[],table[],where[],is[]);
native gSQL_DeleteEntry(table[],where[],is[]);
native gSQL_ExistEntry(table[],where[],is[]);

native CheckTable(table[]);
native Log(text[]);

