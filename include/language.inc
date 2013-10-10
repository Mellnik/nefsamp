/*
            MULTI LANGUAGE INCLUDE
		   (¯`·._.·MELLNIK·._.·´¯)
     		     VERSION: 1.0
               0.3e compatible
*/

#include <a_samp>

#if defined _language_included
	#endinput
#endif
#define _language_included

new PlayerLanguage[MAX_PLAYERS];

stock SetPlayerLanguage(playerid, langid)
{
	if(langid == 1)
	{
	    PlayerLanguage[playerid] = 1;
	    return 1;
	}
	else if(langid == 2)
	{
	    PlayerLanguage[playerid] = 2;
	    return 1;
	}
	else
	{
	    return 0;
	}
}

stock SetAllLanguage(langid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(langid == 1)
	    {
	        PlayerLanguage[i] = 1;
			return 1;
		}
		else if(langid == 1)
		{
		    PlayerLanguage[i] = 2;
			return 1;
		}
		else
		{
		    return 0;
		}
	}
}

stock GetPlayerLanguage(playerid)
{
	return PlayerLanguage[playerid];
}


stock SendLanguageMessage(playerid, color, const string1[], const string2[])
{
	if(PlayerLanguage[playerid] == 1)
	{
		SendClientMessage(playerid, color, string1);
	}
	else if(PlayerLanguage[playerid] == 2)
	{
		SendClientMessage(playerid, color, string2);
	}
	return 1;
}

stock SendClientLangMessageToAll(playerid, color, const string1[], const string2[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][Lang] == 1)
		{
			SendClientMessage(i, color, string1);
		}
		else if(PlayerInfo[i][Lang] == 2)
		{
			SendClientMessage(i, color, string2);
		}
	}
	return 1;
}

stock LangGameText(playerid, const string1[], const string2[], time, style)
{
	if(PlayerInfo[playerid][Lang] == 1)
	{
		GameTextForPlayer(playerid, string1, time, style);
	}
	else if(PlayerInfo[playerid][Lang] == 2)
	{
		GameTextForPlayer(playerid, string2, time, style);
	}
	return 1;
}

stock LangGameTextForAll(const string1[], const string2[], time, style)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][Lang] == 1)
		{
			GameTextForPlayer(i,string1, time, style);
		}
		else if(PlayerInfo[i][Lang] == 2)
		{
			GameTextForPlayer(i,string2, time, style);
		}
	}
	return 1;
}
