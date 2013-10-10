/*--    ---  .   .   --
|   |  |     |\ /|  |  \
|   |  |     | V |  |   |
|   |  |     |   |  |  /
 ---    ---  |   |   --
  I.O.O  by kleinerOpa*/
#include <a_samp>
forward ocmdOnPlayerCommandText(playerid,cmdtext[]);
#define ocmd:%1(%2) forward ocmd_%1(%2);\
public ocmd_%1(%2)
public OnPlayerCommandText(playerid,cmdtext[])
{
    cmdtext[0]='_';
    new ocmdStr[128],ocmdParams[128],bool:ocmdAffe,ocmdFu;
	for(new i;i<128;i++)
	{
	    if(cmdtext[i]=='\0')break;
	    if((cmdtext[i]==' ')&&(!ocmdAffe))
		{
			ocmdAffe=true;
			continue;
		}
	    if(!ocmdAffe)ocmdStr[i]=cmdtext[i];
	    else
		{
			ocmdParams[ocmdFu]=cmdtext[i];
			ocmdFu++;
		}
	}
	format(ocmdStr,128,"ocmd%s",ocmdStr);
	if(!strlen(ocmdParams))format(ocmdParams,128," ");
	if(CallLocalFunction(ocmdStr,"ds",playerid,ocmdParams))return 1;
	cmdtext[0]='/';
	return CallLocalFunction("ocmdOnPlayerCommandText","ds",playerid,cmdtext);
}
#define OnPlayerCommandText ocmdOnPlayerCommandText
