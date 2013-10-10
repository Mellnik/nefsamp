
#include <a_samp>
#pragma tabsize 0
#define r1 																	return 1; //Einfache return Schreibweise
#define r0 																	return 0;
#define pp- 																playerid,params[]
#define p-                                                                  params[]
#define UP-%1(%2); forward %1(%2);
#define UC-%1(%2) 	UP-UC_%1(%2); public UC_%1(%2)
#define UCPublic.@UCcmd 	new UCSs[40], i=1; for(;i<120;i++) { if(!cmdtext[i]||cmdtext[i]==' ')break; UCSs[i-1]=tolower(cmdtext[i]); } format(UCSs,120,"UC_%s",UCSs); if(!strlen(cmdtext[i+1])&&CallLocalFunction(UCSs,"is",playerid," "))return 1; if(CallLocalFunction(UCSs,"is",playerid,cmdtext[i+1])) return 1; return CallLocalFunction("@UCcmd","is",playerid,cmdtext); //Courier New
UP-@UCcmd(playerid,cmdtext[]);
public OnPlayerCommandText(playerid,cmdtext[])
{UCPublic.@UCcmd}
#define OnPlayerCommandText 													@UCcmd

/*
EXAMPLE:
				  _______
|        |      /
|        |     |
|        |     |
|        |     |
|        |     |
|        |     |
|________|      \ _______
*/


