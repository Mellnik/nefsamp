#define bcmd:%1(%2) forward bcmd_%1(%2); \
					public bcmd_%1(%2)
forward BCMD_OnPlayerCommandText(playerid,cmdtext[]);
public OnPlayerCommandText(playerid,cmdtext[])
{
	cmdtext[0] = '_';
	new blacmd[40],s[97];
	new i=0;
	for(;i!=32;i++)
	{
		if(cmdtext[i]==' '||cmdtext[i]=='\0')break;
		blacmd[i] = tolower(cmdtext[i]);
	}
	strins(blacmd,"bcmd",0);
	for(new j;i!=128;j++,i++)
	{
		if(cmdtext[i]=='\0') break;
		s[j]=cmdtext[i];
	}
	if(CallLocalFunction(blacmd,"is",playerid,(!s[0])?(" "):s)) return true;
	cmdtext[0] = '/';
	return CallLocalFunction("BCMD_OnPlayerCommandText","ds",playerid,cmdtext);
}
#if defined _ALS_OnPlayerCommandText
	#undef OnPlayerCommandText
#else
	#define _ALS_OnPlayerCommandText
#endif
#define OnPlayerCommandText BCMD_OnPlayerCommandText