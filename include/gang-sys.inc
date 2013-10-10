/*##############################################################################
#                                                                              #
#                         Gang-System by Pillepalle.                           #
#                         Copyright by Pillepalle.                             #
#                         Copyright darf nicht entfernt werden.                #
#                                                                              #
#                                                                              #
##############################################################################*/
//Start#########################################################################
//Defines
#define MAX_GANG_NAME 70
#define MAX_GANG_MEMBER_DATA 1024
#define MAX_GANGS 128
//Includes
#include <a_samp>
//Enums
enum eData
{
	bool:Used,
	MemberName[MAX_PLAYER_NAME],
        Gangid
};
enum eGang
{
    gOwner[MAX_PLAYER_NAME],
	gName[MAX_GANG_NAME],
};
//News
new Data[MAX_GANG_MEMBER_DATA][eData];
new Gangs[MAX_GANGS][eGang];
//Forwards
forward CreateGang(name[MAX_GANG_NAME],owner[MAX_PLAYER_NAME]);
forward PutPlayerInGang(Name[MAX_PLAYER_NAME],GangID);
forward LoadGangMember(id);
forward LoadGang(id);
forward GetFreeGangMemberDataID();
forward GetPlayerGang(playerid);
forward SetGangName(id,newname[MAX_GANG_NAME]);
forward SetGangOwner(id,owner[MAX_PLAYER_NAME]);
forward IsPlayerInGang(playerid);
forward IsPlayerGangOwner(playerid, gid);
forward split(const strsrc[], strdest[][], delimiter);
//CreateGang####################################################################
stock CreateGang(name[MAX_GANG_NAME],owner[MAX_PLAYER_NAME])
{
    new string[256],File:hFile;
	for(new i = 0; i < MAX_GANGS; i++)
	{
	    format(string, sizeof(string), "/gangs/%d.gang", i);
	    if(!fexist(string))
	    {
	        hFile = fopen(string, io_write);
	        format(string, sizeof(string), "%s|%s", name,owner);
	        fwrite(hFile, string);
	        fclose(hFile);
	        Gangs[i][gName] = name;
	        Gangs[i][gOwner] = owner;
	        hFile = fopen("ganglog.log", io_append);
			format(string, sizeof(string), "Gang %d added: %s|%s", i, name,owner);
			fwrite(hFile, string);
			fclose(hFile);
			return i;
	    }
	}
	return -1;
}
//PutPlayerInGang###############################################################
stock PutPlayerInGang(Name[MAX_PLAYER_NAME],GangID)
{
    new string[256],File:hFile;
    new i = GetFreeGangMemberDataID();
 	format(string, sizeof(string), "/gangs/members/%d.gangmember", i);
	if(!fexist(string))
	{
	    hFile = fopen(string, io_write);
	    format(string, sizeof(string), "%s|%d", Name,GangID);
	    fwrite(hFile, string);
	    fclose(hFile);
	    Data[i][MemberName] = Name;
	    Data[i][Gangid] = GangID;
		return i;
	}
	return -1;
}
//LoadGangMember################################################################
stock LoadGangMember(id)
{
	new string[256], File:hFile, farray[7][32];
	format(string, sizeof(string), "/gangs/members/%d.gangmember", id);
	if(!fexist(string)) return -1;
	hFile = fopen(string, io_read);
	fread(hFile, string);
 	split(string, farray, '|');
	Data[id][MemberName] = strval(farray[1]);
	Data[id][Gangid] = strval(farray[2]);
	fclose(hFile);
	return id;
}
//LoadGang######################################################################
stock LoadGang(id)
{

	new string[256], File:hFile, farray[7][32];
	format(string, sizeof(string), "/gangs/%d.gang", id);
	if(!fexist(string)) return -1;
	hFile = fopen(string, io_read);
	fread(hFile, string);
 	split(string, farray, '|');
	Gangs[id][gOwner] = strval(farray[1]);
	Gangs[id][gName] = strval(farray[2]);
	fclose(hFile);
	return id;
}
//GetFreeGangMemberDataID#######################################################
stock GetFreeGangMemberDataID()
{
	for(new i = 0; i < MAX_GANG_MEMBER_DATA; i++)
	{
	    if(!Data[i][Used]) return i;
	}
	return 0;
}
//GetPlayerGang#################################################################
stock GetPlayerGang(playerid)
{
	new zurueck, playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
	for(new i = 0; i < MAX_GANGS; i++)
	{
		if(strcmp(playername, Gangs[i][gOwner], true) == 0)
		{
		    zurueck = i;
			break;
		}
		else
		{
			zurueck = -1;
			break;
		}
	}
	if(zurueck == -1)
	{
		for(new i = 0; i < MAX_GANG_MEMBER_DATA; i++)
		{
			if(strcmp(playername, Data[i][MemberName], true) == 0)
			{
				zurueck = i;
				break;
            }
            else
			{
				zurueck = -1;
				break;
			}
		}
	}
	return zurueck;
}
//SetGangName###################################################################
stock SetGangName(id,newname[MAX_GANG_NAME])
{
	strmid(Gangs[id][gName], newname, 0, strlen(newname), MAX_GANG_NAME);
	return newname;
}
//SetGangOwner##################################################################
stock SetGangOwner(id, owner[MAX_PLAYER_NAME])
{
	strmid(Gangs[id][gOwner], owner, 0, strlen(owner), MAX_PLAYER_NAME);
	return owner;
}
//IsPlayerInGang################################################################
stock IsPlayerInGang(playerid)
{
	new zurueck, playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
    for(new i = 0; i < MAX_GANGS; i++)
    {
		if(strcmp(playername, Gangs[i][gOwner], true) == 0)
		{
		    zurueck = 1;
		    break;
		}
		else
		{
		    zurueck = -1;
		    break;
		}
    }
    if(zurueck == -1)
    {
        for(new i = 0; i < MAX_GANG_MEMBER_DATA; i++)
        {
		    if(strcmp(playername, Data[i][MemberName], true) == 0)
		    {
			    zurueck = 1;
			    break;
		    }
		    else
		    {
			    zurueck = -1;
			    break;
            }
	    }
    }
    return zurueck;
}
//IsPlayerGangOwner#############################################################
stock IsPlayerGangOwner(playerid, gid)
{
	if(playerid == Gangs[gid][gOwner]
	{
	    return 1;
	}
	else
	{
		return -1;
	}
}
//Split#########################################################################
stock split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc))
	{
	    if(strsrc[i]==delimiter || i==strlen(strsrc))
		{
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}
//THE_END#######################################################################
