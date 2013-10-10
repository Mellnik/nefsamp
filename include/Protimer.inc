/*ProTimer System (c) 2008 by Einstein
*/

#if defined _protimer_included
  #endinput
#endif
#define _protimer_included
#define MAX_TIMERS 200

forward ProTimer();

new ProTimerID;
new ProTimerTime[MAX_TIMERS];
new ProTimerName[MAX_TIMERS][32];
new ProTimerAcTime[MAX_TIMERS];
new ProTimerRepeat[MAX_TIMERS];
new ProTimerSpecial[MAX_TIMERS];
new bool:ProTimerActive[MAX_TIMERS];

stock ProTimer_OnGameModeInit()
{
SetTimer("ProTimer", 1000, true);
}

stock SetProTimer(name[], time, repeat)
{
ProTimerActive[ProTimerID] = true;
format(ProTimerName[ProTimerID], 512, name);
ProTimerTime[ProTimerID] = time;
ProTimerRepeat[ProTimerID] = repeat;
ProTimerSpecial[ProTimerID] = -256;
ProTimerID++;
return ProTimerID-1;
}

stock SetProTimerEx(name[], time, repeat, number)
{
ProTimerActive[ProTimerID] = true;
format(ProTimerName[ProTimerID], 512, name);
ProTimerTime[ProTimerID] = time;
ProTimerRepeat[ProTimerID] = repeat;
ProTimerSpecial[ProTimerID] = number;
ProTimerID++;
return ProTimerID-1;
}

stock KillProTimer(protimerid)
{
ProTimerActive[protimerid] = false;
}

public ProTimer()
{
	for(new timer=0; timer<ProTimerID; timer++)
	    {
	    if(ProTimerActive[timer] == true)
	        {
		    ProTimerAcTime[timer]++;
		    if(ProTimerAcTime[timer] == ProTimerTime[timer])
		        {
		    	if(ProTimerSpecial[ProTimerID] == -256) CallLocalFunction(ProTimerName[timer], "");
				else CallLocalFunction(ProTimerName[timer], "i", ProTimerSpecial[timer]);
				ProTimerAcTime[timer] = 0;
		    	if(ProTimerRepeat[timer] == 0) ProTimerActive[timer] = false;
		    	}
		    }
	    }
	return 1;
}


