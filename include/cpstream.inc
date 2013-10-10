/*
***********************
* 	CPstream v_0.2 r  *
***********************	
*/

#if defined _CPstream_included
	#endinput
#endif

#define _CPstream_included
#pragma library CPstream

// =========================================================== System variables and defines =============================================================

#define MAX_CP 500

new gPlayerConfig[MAX_PLAYERS][3],  //cp  -  timer  -  in checkpoint
	Float:gCParray[MAX_CP][5],		//x  -  y  -  z  -  cp size  -  sphere size
	gCPmessage[MAX_CP][64],	
	gCPcount = -1,
	gSystemTimer;
	
forward CheckSpheres(); //Handles CP streaming
forward CheckCheckpoints(playerid, cpid); //Handles PlayerCheckpoint Actions (in/out)

// ============================================================= Add checkpoint function ==========================================================

/*
native SetCheckpoint(Float:x, Float:y, Float:z, Float:size = 2.0, Float:area_radius = 10.0, message[64] = "");
native IsPlayerInCheckpointID(playerid, cpid)
*/
	
stock SetCheckpoint(Float:x, Float:y, Float:z, Float:size = 2.0, Float:area_radius = 10.0, message[64] = "")
{
	gCPcount ++; //start at 0
	
	gCParray[gCPcount][0] = x;
	
	gCParray[gCPcount][1] = y;	
	
	gCParray[gCPcount][2] = z;	
	
	gCParray[gCPcount][3] = size;	
	
	gCParray[gCPcount][4] = area_radius;	
	
	strins(gCPmessage[gCPcount], message, 0, 64);
	
    if (!gSystemTimer) 
	{
		gSystemTimer = SetTimer("CheckSpheres", 333, true);
		new year, 
			month, 
			day,
			hour, 
			minute, 
			second;
			
		getdate(year, month, day);
		gettime(hour, minute, second);    		 
		printf("CPstream system activated on %d/%d/%d - %d:%d:%d", day, month, year, hour, minute, second);		
	}
	
	return gCPcount;
}

// ======================================================= Area checking functions ================================================================

stock IsPlayerInCheckpointID(playerid, cpid)
{
	if (!IsPlayerConnected(playerid)) return 0;
	if (cpid > gCPcount || cpid < 0) return 0;	
	if (gPlayerConfig[playerid][2] && gPlayerConfig[playerid][0] == cpid) return 1;
	return 0;
}

CpIsPlayerInSphere(playerid, Float:x, Float:y, Float:z, Float:radius)
{
	new Float:px,
		Float:py,
		Float:pz;
		
	GetPlayerPos(playerid, px, py, pz);	
	
	return (floatsqroot(floatpower(floatabs(floatsub(x, px)), 2) + floatpower(floatabs(floatsub(y, py)), 2) + floatpower(floatabs(floatsub(z, pz)), 2)) < radius) ? 1 : 0;	
}

public CheckSpheres() 
{		
    for (new i; i < GetMaxPlayers(); i ++) 
	{
		if (IsPlayerConnected(i)) 
		{
			for (new j; j <= gCPcount; j ++)
			{
				if (CpIsPlayerInSphere(i, gCParray[j][0], gCParray[j][1], gCParray[j][2], gCParray[j][4])) 
				{
					if (j != gPlayerConfig[i][0]) 
					{
						gPlayerConfig[i][0] = j;
						
						SetPlayerCheckpoint(i, gCParray[j][0], gCParray[j][1], gCParray[j][2], gCParray[j][3]);						
						
						gPlayerConfig[i][1] = SetTimerEx("CheckCheckpoints", 600, true, "ii", i, j);
					} 					
					goto end;
				} 
				else 
				{
					if (j == gPlayerConfig[i][0]) 
					{
						DisablePlayerCheckpoint(i); 
						
						KillTimer(gPlayerConfig[i][1]);						
						
						gPlayerConfig[i][0] = -1;				
						
						gPlayerConfig[i][1] = 0;
						
						gPlayerConfig[i][2] = 0;						
					}
				}
			}
		}
		else
		{
			//reset variables to protect against bugs/conflictions/errors with none active ids
			
			gPlayerConfig[i][0] = -1; //cp id
			
			gPlayerConfig[i][1] = 0; //timer 			
			
			gPlayerConfig[i][2] = 0; //in checkpoint
		}
    }     
	end:
}

// ============================================================ Callback sorting function ==============================================================

public CheckCheckpoints(playerid, cpid)
{
	if (IsPlayerInCheckpoint(playerid) && !gPlayerConfig[playerid][2])
	{
		gPlayerConfig[playerid][2] = 1;
		
		if (strlen(gCPmessage[cpid]))
		{
			new str[64];
			
			format(str, sizeof(str), "~w~%s", gCPmessage[cpid]);
			
			GameTextForPlayer(playerid, str, 3000, 4);
		}
		
		OnPlayerEnterCheckpointEx(playerid, cpid); //call this in your script
	}
		
	if (!IsPlayerInCheckpoint(playerid))
	{
		if (gPlayerConfig[playerid][2])
		{			
			OnPlayerLeaveCheckpointEx(playerid, cpid); //call this in your script
		}
		
		gPlayerConfig[playerid][2] = 0;
	}
}