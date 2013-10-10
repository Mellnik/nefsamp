/*
*       |Eazy Language System by [NSG]Bright|
*
*   You are free to edit this Include, BUT
*   you are not supposed to release this as YOUR Include
*
*   I hope you will have fun with it and use it with success.
*
*   Functions:
*
*   ~ SetLanguageForPlayer(playerid, LanguageID);
*       - Language ID: 0 stands for the first language and 1 for the second.
*	Sets the Language for the Player to the chosen one.
*
*   ~ SetLanguageForAll(LanguageID);
*       - Watch above for declaration of Language ID.
*   Sets the Language for all to the chosen Language ID.
*
*   ~ SendLanguageMessage(playerid, color, langmessage 1, langmessage 2);
*		- The color has to be written in the hexadezimal code if it is not defined yet.
*   Sends a Language Message with the chosen color to playerid.CreateObject.
*
*   ~ SendLanguageMessageForAll(color, langmessage 1, langmessage 2);
*		- The color has to be written in the hexadezimal code if it is not defined yet.
*   Sends a Language Message with the chosen color to all players.
*
*   ~ LanguageGameTextForPlayer(playerid, langmessage 1, langmessage 2, style, time);
*       - The Style is the same as in GameTextForPlayer or GameTextForAll. Just like the time.
*   Shows a Language GameText for playerid with your chosen Style and Time.
*
*   ~ LanguageGameTextForAll(langmessage 1, langmessage 2, style, time);
*       - Watch the LanguageGameTextForPlayer Declaration for a description.
*   Shows a Language GameText for all Players with your chosen Style and Time.
*
*
*       | Version 2 | Changelog:
*
*   You can either use 2 or from now on up to 3 different languages.
*
*   If you want to send a 3 language-message just use this:
*
*   ~ SendLanguageMessageEx(playerid, color, langmessage 1, langmessage 2, langmessage 3);
*   ~ SendLanguageMessageForAllEx(color, langmessage 1, langmessage 2, langmessage 3);
*   ~ LanguageGameTextForPlayerEx(playerid, langmessage 1, langmessage 2, langmessage 3, style, time);
*   ~ LanguageGameTextForAllEx(langmessage 1, langmessage 2, langmessage 3, style, time);
*/  
#include <a_samp>
#if defined _EazyLang_included
	#endinput
#endif
#define _EazyLang_included
/*

native      ___ 2 Languages ___

native SetLanguageForPlayer(playerid, LanguageID);
native SetLanguageForAll(LanguageID);
native SendLanguageMessage(playerid, color, langmessage1[], langmessage2[]);
native SendLanguageMessageForAll(color, langmessage1[], langmessage2[]);
native LanguageGameTextForPlayer(playerid, langmessage1[], langmessage2[], style, time);
native LanguageGameTextForAll(langmessage1[], langmessage2[], style, time);

native      ___ 3 Languages ___

native SendLanguageMessageEx(playerid, color, langmessage1[], langmessage2[], langmessage3[]);
native SendLanguageMessageForAllEx(color, langmessage1[], langmessage2[], langmessage3[]);
native LanguageGameTextForPlayerEx(playerid, langmessage1[], langmessage2[], langmessage3[], style, time);
native LanguageGameTextForAllEx(langmessage1[], langmessage2[], langmessage3[], style, time);

*/
new PlayerLanguage[MAX_PLAYERS];

stock SetLanguageForPlayer(playerid, LanguageID)
{
	if(LanguageID == 0)
	{
	    PlayerLanguage[playerid] = 0;
	    return 1;
	}
	else if(LanguageID == 1)
	{
	    PlayerLanguage[playerid] = 1;
	    return 1;
	}
	else if(LanguageID == 2)
	{
	    PlayerLanguage[playerid] = 2;
		return 1;
	}
	else
	{
	    return 0;
	}
}

stock SetLanguageForAll(LanguageID)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(LanguageID == 0)
	    {
	        PlayerLanguage[i] = 0;
			return 1;
		}
		else if(LanguageID == 1)
		{
		    PlayerLanguage[i] = 1;
			return 1;
		}
		else
		{
		    return 0;
		}
	}
}

stock SendLanguageMessage(playerid, color, langmessage1[], langmessage2[])
{
	if(PlayerLanguage[playerid] == 0)
	{
	    SendClientMessage(playerid, color, langmessage1)
		return 1;
	}
	else if(PlayerLanguage[playerid] == 1)
	{
	    SendClientMessage(playerid, color, langmessage2)
		return 1;
	}
}

stock SendLanguageMessageForAll(color, langmessage1[], langmessage2[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(PlayerLanguage[i] == 0)
	    {
	        SendClientMessage(i, color, langmessage1);
	        return 1;
		}
		else if(PlayerLanguage[i] == 1)
		{
		    SendClientMessage(i, color, langmessage2);
			return 1;
		}
	}
	return 1;
}

stock LanguageGameTextForPlayer(playerid, langmessage1[], langmessage2[], style, time)
{
	if(PlayerLanguage[playerid] == 0)
	{
	    GameTextForPlayer(playerid, langmessage1, style, time);
		return 1;
	}
	else if(PlayerLanguage[playerid] == 1)
	{
	    GameTextForPlayer(playerid, langmessage2, style, time);
		return 1;
	}
}

stock LanguageGameTextForAll(langmessage1[], langmessage2[], style, time)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerLanguage[i] == 0)
		{
		    GameTextForPlayer(i, langmessage1[], style, time);
		    return 1;
		}
		else if(PlayerLanguage[i] == 1)
		{
		    GameTextForPlayer(i, langmessage2[], style, time);
			return 1;
		}
	}
}

stock SendLanguageMessageEx(playerid, color, langmessage1[], langmessage2[], langmessage3[])
{
	if(PlayerLanguage[playerid] == 0)
	{
	    SendClientMessage(playerid, color, langmessage1);
	    return 1;
	}
	else if(PlayerLanguage[playerid] == 1)
	{
	    SendClientMessage(playerid, color, langmessage2);
	    return 1;
	}
	else if(PlayerLanguage[playerid] == 2)
	{
	    SendClientMessage(playerid, color, langmessage3);
	    return 1;
	}
}

stock SendLanguageMessageForAllEx(color, langmessage1[], langmessage2[], langmessage3[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(PlayerLanguage[i] == 0)
	    {
	        SendClientMessage(i, color, langmessage1);
	        return 1;
		}
		else if(PlayerLanguage[i] == 1)
		{
		    SendClientMessage(i, color, langmessage2);
		    return 1;
		}
		else if(PlayerLanguage[i] == 2)
		{
		    SendClientMessage(i, color, langmessage3);
			return 1;
		}
	}
}

stock LanguageGameTextForPlayerEx(playerid, langmessage1[], langmessage2[], langmessage3[], style, time)
{
	if(PlayerLanguage[playerid] == 0)
	{
	    GameTextForPlayer(playerid, langmessage1, style, time);
		return 1;
	}
	else if(PlayerLanguage[playerid] == 1)
	{
	    GameTextForPlayer(playerid, langmessage2, style, time);
		return 1;
	}
	else if(PlayerLanguage[playerid] == 2)
	{
	    GameTextForPlayer(playerid, langmessage3, style, time);
	    return 1;
	}
}

stock LanguageGameTextForAllEx(langmessage1[], langmessage2[], langmessage3[], style, time)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerLanguage[i] == 0)
		{
		    GameTextForPlayer(i, langmessage1[], style, time);
		    return 1;
		}
		else if(PlayerLanguage[i] == 1)
		{
		    GameTextForPlayer(i, langmessage2[], style, time);
			return 1;
		}
		else if(PlayerLanguage[i] == 2)
		{
		    GameTextForPlayer(i, langmessage3, style, time);
	    	return 1;
		}
	}
}
