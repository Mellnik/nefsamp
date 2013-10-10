//------< INCLUDEs >------//
	#include <a_samp>
	#include <dini>
//------------------------//

//-------------< DEFINEs >--------------//
	#define foxBanFile "TimeBans/%s.ini"
//--------------------------------------//

//---------------< FORWARDs >---------------//
	forward FB_OnPlayerConnect(playerid);
//------------------------------------------//

//-----< NEWs >-----//
	new tbDir[64];
//------------------//

//----------------------------------------------------------< OnPlayerConnect >-----------------------------------------------------------//
	public OnPlayerConnect(playerid)
	{
		new pName[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pName,sizeof(pName));
		format(tbDir,sizeof(tbDir),foxBanFile,pName);
		if(dini_Exists(tbDir))
		{
			if(dini_Int(tbDir,"fbTime")+dini_Int(tbDir,"fbDuration") > Time())
			{
				new string[96];
				new sekki=(dini_Int(tbDir,"fbTime")+dini_Int(tbDir,"fbDuration"))-Time(),minni=sekki/60;
				sekki=sekki-minni*60;
				format(string,sizeof(string),"Du bist von diesem Server noch für %d Minuten und %d Sekunden gebannt.",minni,sekki);
				SendClientMessage(playerid,0xAA3333AA,string);
				Kick(playerid);
			} else { dini_Remove(tbDir); }
		}
		return CallLocalFunction("FB_OnPlayerConnect","i",playerid);
	}
//----------------------------------------------------------------------------------------------------------------------------------------//

//------------------------< TBAN >------------------------//
	stock TBan(pID,bTime)
	{
		new pName[MAX_PLAYER_NAME];
		GetPlayerName(pID,pName,sizeof(pName));
		format(tbDir,sizeof(tbDir),foxBanFile,pName);
		dini_Create(tbDir);
		dini_IntSet(tbDir,"fbTime",Time());
		dini_IntSet(tbDir,"fbDuration",bTime*60);
		Kick(pID);
	}
//--------------------------------------------------------//

//---------------------------< TUNBAN >---------------------------//
	stock TUnban(playername[])
	{
		format(tbDir,sizeof(tbDir),foxBanFile,playername);
		if(dini_Exists(tbDir)) { return dini_Remove(tbDir); }
		return 0;
	}
//----------------------------------------------------------------//

//---------------------------------------------< TUNBAN >---------------------------------------------//
	stock GetPlayerBanTime(playername[],&minu=0,&seco=0)
	{
		format(tbDir,sizeof(tbDir),foxBanFile,playername);
		if(dini_Exists(tbDir))
		{
			seco=(dini_Int(tbDir,"fbTime")+dini_Int(tbDir,"fbDuration"))-Time();
			seco=seco-minu*60;
			minu=seco/60;
			return 1;
		}
		return 0;
	}
//----------------------------------------------------------------------------------------------------//

//------------------------< BanFileExist >------------------------//
	stock BanFileExist(playername[])
	{
		format(tbDir,sizeof(tbDir),foxBanFile,playername);
		if(dini_Exists(tbDir)) { return 1; } else { return 0; }
	}
//----------------------------------------------------------------//

#define OnPlayerConnect FB_OnPlayerConnect