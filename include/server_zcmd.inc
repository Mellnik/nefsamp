#if defined _zcmd_included
	#endinput
#endif	
#define _zcmd_included

#define MAX_FUNC_NAME (32)

#define COMMAND:%1(%2)          \
			forward cmd_%1(%2); \
			public cmd_%1(%2)

#if !defined isnull
	#define isnull(%1) \
				((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

forward OnPlayerCommandReceived(playerid, cmdtext[]); 
forward OnPlayerCommandPerformed(playerid, cmdtext[], success); 

static
	bool:zcmd_g_HasOPCS = false,
	bool:zcmd_g_HasOPCE = false;


public OnGameModeInit()
{
	zcmd_g_HasOPCS = funcidx("OnPlayerCommandReceived") != -1;
	zcmd_g_HasOPCE = funcidx("OnPlayerCommandPerformed") != -1;
	if (funcidx("zcmd_OnGameModeInit") != -1)
	{
		return CallLocalFunction("zcmd_OnGameModeInit", "");
	}	
	return 1;
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit zcmd_OnGameModeInit
forward zcmd_OnGameModeInit();

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(isnull(cmdtext)) return SendInfo(playerid, "~r~~h~Unknown command!~n~~n~~w~These commands may help you~n~~g~~h~/help /cmds /tele /rules", 4000);
    if(zcmd_g_HasOPCS && !CallLocalFunction("OnPlayerCommandReceived", "is", playerid, cmdtext))
    {
        return 1;
    }
    
    new pos, funcname[MAX_FUNC_NAME];
		
    while(cmdtext[++pos] > ' ')
	{
		if(pos > 31) return SendInfo(playerid, "~r~~h~Unknown command!~n~~n~~w~These commands may help you~n~~g~~h~/help /cmds /tele /rules", 4000);
		funcname[pos-1] = tolower(cmdtext[pos]); 
	}
	format(funcname, sizeof(funcname), "cmd_%s", funcname);
    while(cmdtext[pos] == ' ') pos++;
	if(!cmdtext[pos])
	{
		if(zcmd_g_HasOPCE)
		{
			return CallLocalFunction("OnPlayerCommandPerformed", "isi", playerid, cmdtext, CallLocalFunction(funcname, "is", playerid, "\1"));
		}
		return CallLocalFunction(funcname, "is", playerid, "\1");	
	}
	if(zcmd_g_HasOPCE)
	{
		return CallLocalFunction("OnPlayerCommandPerformed", "isi", playerid, cmdtext, CallLocalFunction(funcname, "is", playerid, cmdtext[pos]));
	}
	return CallLocalFunction(funcname, "is", playerid, cmdtext[pos]);
}

#if defined _ALS_OnPlayerCommandText
    #undef OnPlayerCommandText
#else
    #define _ALS_OnPlayerCommandText
#endif
#define OnPlayerCommandText zcmd_OnPlayerCommandText
forward zcmd_OnPlayerCommandText(playerid, cmdtext[]);
