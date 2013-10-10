	    ////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-//
	   //							FOXHOUND'S FUNCTIONS							//
	  //								  foXfunc!								   //
	 //					  COPYRIGHT BY FOXHOUND / PSPGAMER					      //
	////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-//

//--------------------< PRAGMAs >--------------------//
	#pragma unused ClearChatForPlayer
	#pragma unused ClearChatForAll
	#pragma unused SetPlayerCash
	#pragma unused RemovePlayerWorldBounds
	#pragma unused BanAll
	#pragma unused KickAll
	#pragma unused Kill
	#pragma unused Slap
	#pragma unused KillAll
	#pragma unused SlapAll
	#pragma unused SetMapName
	#pragma unused FilterScriptInit
	#pragma unused FilterScriptReload
	#pragma unused FilterScriptExit
	#pragma unused SendFormattedClientMessage
	#pragma unused SendFormattedClientMessageToAll
	#pragma unused FormattedGameTextForPlayer
	#pragma unused FormattedGameTextForAll
	#pragma unused SetPlayerFormattedChatBubble
	#pragma unused SendRepeatedClientMessage
	#pragma unused SendRepeatedClientMessageToAll
	#pragma unused SendDistancedClientMessage
	#pragma unused GetPlayerLanguage
	#pragma unused SetPlayerLanguage
	#pragma unused SendJoinMessage
	#pragma unused SendLeaveMessage
	#pragma unused SetPlayerSexAction
	#pragma unused ResetPlayerArmour
	#pragma unused SpawnUser
	#pragma unused Heal
	#pragma unused HealAll
	#pragma unused RemoveAllFromVehicle
	#pragma unused IsVehicleInRangeOfPoint
	#pragma unused GetPlayerNameEx
	#pragma unused Crash
	#pragma unused CrashAll
	#pragma unused IsPlayerInZone
	#pragma unused CreatePlayerExplosion
	#pragma unused EjectPlayerFromVehicle
	#pragma unused GetPlayerLastVehicleID
	#pragma unused SendMultilangualClientMessage
	#pragma unused SendSMultilangualClientMessage
	#pragma unused ShowPlayerInfoDialog
	#pragma unused ShowPlayerInputDialog
	#pragma unused ShowPlayerListDialog
//***************************************************//
	#pragma unused PlayerSpawning
//---------------------------------------------------//

//-----< INCLUDEs >-----//
	#include <a_samp>
//----------------------//

//----------------------< FORWARDs >----------------------//
	forward OnPlayerLanguageChange(playerid,language);
//--------------------------------------------------------//

//-------------< NEWs >-------------//
	new LanguageFXF[MAX_PLAYERS];
	new pLastVehicle[MAX_PLAYERS];
//----------------------------------//

//-------------------: Clear Server Chat :-----------------//
	ClearChatForAll()
	{
		for (new i = 0;i < 100; i++)
		{
			SendClientMessageToAll(0xFFFFFFAA," ");
		}
	}
//---------------------------------------------------------//

//-------------------: Clear From Player :-----------------//
	ClearChatForPlayer(playerid)
	{
		for (new i = 0;i < 100; i++)
		{
			SendClientMessage(playerid,0xFFFFFFAA," ");
		}
	}
//---------------------------------------------------------//

//---------------< GetPlayerNameEx >---------------//
	 /***************** ~ NOTE ~ ********************/
    /* 	  	This function removes the '_' 	       */
   /* 	     between two names. Example:	      */
  /* 	   'Gokhan_Akin' to 'Gokhan Akin'	     */
 /* 	   Credits to Carlito's RolePlay	    */
/***********************************************/
	GetPlayerNameEx(playerid)
	{
		new string[24];
		GetPlayerName(playerid,string,24);
		new str[24];
		strmid(str,string,0,strlen(string),24);
		for(new i = 0; i < MAX_PLAYER_NAME; i++)
		{
			if (str[i] == '_') str[i] = ' ';
		}
	}
//-------------------------------------------------//

//---------------------< SendMultilangualClientMessage >----------------------//
	SendMultilangualClientMessage(playerid, color, lngmsg1[], lngmsg2[])
	{
		if(LanguageFXF[playerid] == 1)
		{
			SendClientMessage(playerid, color, lngmsg2);
		}
		else
		{
			SendClientMessage(playerid, color, lngmsg1);
		}
	}
//---------------------------------------------------------------------------//

//----------------< SendSMultilangualClientMessage >----------------//
	SendSMultilangualClientMessage(color, lngmsg1[], lngmsg2[])
	{
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(LanguageFXF[i] == 1)
			{
				SendClientMessage(i, color, lngmsg2);
			}
			else
			{
				SendClientMessage(i, color, lngmsg1);
			}
		}
	}
//----------------------------------------------------------------------//

//-------------------: Send Join Message To All :-----------------//
	SendJoinMessage(color, language)
	{
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			new joiner[MAX_PLAYER_NAME];
			new string[64];
			GetPlayerName(i, joiner, sizeof(joiner));
			if(language == 1)
			{
				format(string, sizeof(string), "%s ist dem Server Beigetreten!", joiner);
			}
			else
			{
				format(string, sizeof(string), "%s has joined the server !", joiner);
			}
			SendClientMessageToAll(color, string);
		}
	}
//----------------------------------------------------------------//

//-------------------: Send Leave Message To All :-----------------//
	SendLeaveMessage(color, language)
	{
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			new leaver[MAX_PLAYER_NAME];
			new string[100];
			GetPlayerName(i, leaver, sizeof(leaver));
			if(language == 1)
			{
				format(string, sizeof(string), "%s hat den Server verlassen.", leaver);
			}
			else
			{
				format(string, sizeof(string), "%s has left the server.", leaver);
			}
			SendClientMessageToAll(color, string);
		}
	}
//----------------------------------------------------------------//

//-----------------: Ejecting player from vehicle :---------------//
	    /***************** ~ NOTE ~ ********************/
	   /* 	  	I seen posts on the samp forum.	      */
	  /* 	     This function is getting the	     */
     /* 	   vehicle ID from players vehicle	    */
    /* 	   before removing him from his 	       */
   /* 	   		  current vehicle. 	    		  */
  /* 	   	It saves the vehicle id as 	    	 */
 /* 	   	  pLastVehicle[playerid] 	    	*/
/***********************************************/
	EjectPlayerFromVehicle(playerid)
	{
		pLastVehicle[playerid] = GetPlayerVehicleID(playerid);
		RemovePlayerFromVehicle(playerid);
	}
	GetPlayerLastVehicleID(playerid)
	{
		return pLastVehicle[playerid];
	}
//----------------------------------------------------------------//

//-----------------: Set Money From Player :---------------//
	SetPlayerCash(playerid,money)
	{
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid,money);
	}
//---------------------------------------------------------//

//-----------------: Remove All From Vehicle :---------------//
	RemoveAllFromVehicle()
	{
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerInAnyVehicle(i))
			{
				RemovePlayerFromVehicle(i);
			}
		}
	}
//---------------------------------------------------------//

//----------------------------------------------: Eazy Dialogs :--------------------------------------------//
								 /***************** ~ NOTE ~ ********************/
							    /* 	  	   I made this function for guys,	   */
							   /* 	     they don't know the dialog 	      */
							  /* 	 styles. Easy functions...      	     */
							 /***********************************************/
	ShowPlayerInfoDialog(playerid, dialogid, caption[], info[], button1[], button2[])
	{
		ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, caption, info, button1, button2);
	}
	ShowPlayerInputDialog(playerid, dialogid, caption[], info[], button1[], button2[])
	{
		ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, caption, info, button1, button2);
	}
	ShowPlayerListDialog(playerid, dialogid, caption[], listitems[], button1[], button2[])
	{
		ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, caption, listitems, button1, button2);
	}
//----------------------------------------------------------------------------------------------------------//

//--------------------< Is Vehicle In Range Of Point >--------------------//
	IsVehicleInRangeOfPoint(vehicleid, Float:radi, Float:x, Float:y, Float:z)
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetVehiclePos(vehicleid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
		return 1;
	}
//------------------------------------------------------------------------//

//-----------------: Reset Players Armour :---------------//
	ResetPlayerArmour(playerid)
	{
		SetPlayerArmour(playerid, 0);
	}
//---------------------------------------------------------//

//----------------------------: Remove Player's World Bounds :-------------------------//
	RemovePlayerWorldBounds(playerid)
	{
		SetPlayerWorldBounds(playerid,20000.0000,-20000.0000,20000.0000,-20000.0000);
	}
//-------------------------------------------------------------------------------------//

//----------------------------: Spawn Player (fixxed version) :------------------------//
			/********************* NOTE ****************************/
		   /* 		I used a timer to spawn the player,			  */
		  /* 		'cause RemovePlayerFromVehicle is			 */
		 /*		 only an animation (like a bug).				*/
	    /* 		 When i use direct 'SpawnPlayer',			   */
	   /* 	   the player will not spawn(he dies)...		  */
	  /* 		 This function is maybe slower as			 */
	 /* 	  SpawnPlayer, but better as nothing ;)			*/
	/*******************************************************/
	SpawnUser(playerid)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			RemovePlayerFromVehicle(playerid);
			SetTimerEx("PlayerSpawning",2000,0,"i",playerid);
		}
	}
	PlayerSpawning(playerid)
	{
		SpawnPlayer(playerid);
	}
//-------------------------------------------------------------------------------------//

//--------------------------------------: Crash Player :------------------------------------//
	Crash(playerid)
	{
		if(IsPlayerConnected(playerid))
		{
			new Float:X,Float:Y,Float:Z;
			GetPlayerPos(playerid,X,Y,Z);
			new crasher = CreatePlayerObject(playerid,666666,X,Y,Z,0,0,0);
			DestroyPlayerObject(playerid, crasher);
		}
	}
//------------------------------------------------------------------------------------------//

//--------------------------------------: Crash Player :------------------------------------//
	CrashAll()
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				new Float:X,Float:Y,Float:Z;
				GetPlayerPos(i,X,Y,Z);
				new crasher = CreatePlayerObject(i,666666,X,Y,Z,0,0,0);
				DestroyPlayerObject(i, crasher);
			}
		}
	}
//------------------------------------------------------------------------------------------//

//---------------------------------------: Sex Actions :------------------------------------//
	SetPlayerSexAction(playerid, sexaction, id)
	{
		new wank;
		new hardslap;
		new blowjob;
		if(sexaction == wank)
		{
			switch(id)
			{
				case '0': ApplyAnimation(playerid,"PAULNMAC","wank_in",4.1,0,1,1,1,1);
				case '1': ApplyAnimation(playerid,"PAULNMAC","wank_loop",4.1,0,1,1,1,1);
				case '2': ApplyAnimation(playerid,"PAULNMAC","wank_out",4.1,0,1,1,1,1);
			}
		}
		if(sexaction == hardslap)
		{
			switch(id)
			{
				case 0: ApplyAnimation(playerid,"SNM","SPANKING_IDLEW",4.1,0,1,1,1,1);
				case 1: ApplyAnimation(playerid,"SNM","SPANKING_IDLEP",4.1,0,1,1,1,1);
				case 2: ApplyAnimation(playerid,"SNM","SPANKINGW",4.1,0,1,1,1,1);
				case 3: ApplyAnimation(playerid,"SNM","SPANKINGP",4.1,0,1,1,1,1);
				case 4: ApplyAnimation(playerid,"SNM","SPANKEDW",4.1,0,1,1,1,1);
				case 5: ApplyAnimation(playerid,"SNM","SPANKEDP",4.1,0,1,1,1,1);
				case 6: ApplyAnimation(playerid,"SNM","SPANKING_ENDW",4.1,0,1,1,1,1);
				case 7: ApplyAnimation(playerid,"SNM","SPANKING_ENDP",4.1,0,1,1,1,1);
			}
		}
		if(sexaction == blowjob)
		{
			switch(id)
			{
				case 0: ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_START_P",4.1,0,1,1,1,1);
				case 1: ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_START_W",4.1,0,1,1,1,1);
				case 2: ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_LOOP_P",4.1,0,1,1,1,1);
				case 3: ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_LOOP_W",4.1,0,1,1,1,1);
				case 4: ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_END_P",4.1,0,1,1,1,1);
				case 5: ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_END_W",4.1,0,1,1,1,1);
				case 6: ApplyAnimation(playerid,"BLOWJOBZ","BJ_STAND_START_P",4.1,0,1,1,1,1);
				case 7: ApplyAnimation(playerid,"BLOWJOBZ","BJ_STAND_START_W",4.1,0,1,1,1,1);
				case 8: ApplyAnimation(playerid,"BLOWJOBZ","BJ_STAND_LOOP_P",4.1,0,1,1,1,1);
				case 9: ApplyAnimation(playerid,"BLOWJOBZ","BJ_STAND_LOOP_W",4.1,0,1,1,1,1);
				case 10: ApplyAnimation(playerid,"BLOWJOBZ","BJ_STAND_END_P",4.1,0,1,1,1,1);
				case 11: ApplyAnimation(playerid,"BLOWJOBZ","BJ_STAND_END_W",4.1,0,1,1,1,1);
			}
		}
	}
//------------------------------------------------------------------------------------------//

//---------------: Kill Player :-------------//
	Kill(playerid)
	{
		SetPlayerHealth(playerid,0);
	}
//-------------------------------------------//

//-----------------: Kill All :--------------//
	KillAll()
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			SetPlayerHealth(i,0);
		}
	}
//-------------------------------------------//

//---------------: Heal Player :-------------//
	Heal(playerid)
	{
		SetPlayerHealth(playerid,100.0);
	}
//-------------------------------------------//

//-----------------: Heal All :--------------//
	HealAll()
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			SetPlayerHealth(i,100.0);
		}
	}
//-------------------------------------------//

//------------------: Set Map Name :----------------//
	SetMapName(string[])
	{
		format(string,32,"mapname %s",string);
		SendRconCommand(string);
	}
//--------------------------------------------------//

//------------------------: Send Formatted Client Message :---------------------//
	SendFormattedClientMessage(playerid, color, message[], {Float,_}:...)
	{
		new ffstring[256];
		format(ffstring, 128, message);
		SendClientMessage(playerid, color, ffstring);
	}
//------------------------------------------------------------------------------//

//-----------------: Send Formatted Client Message To All :--------------//
	SendFormattedClientMessageToAll(color, message[], {Float,_}:...)
	{
		new ffstring[256];
		format(ffstring, 128, message);
		SendClientMessageToAll(color, ffstring);
	}
//-----------------------------------------------------------------------//

//-----------------: Create an explosion on player :--------------//
	CreatePlayerExplosion(playerid, type, Float:Radius)
	{
		if(IsPlayerConnected(playerid))
		{
			new Float:ExpX, Float:ExpY, Float:ExpZ;
			GetPlayerPos(playerid, ExpX, ExpY, ExpZ);
			CreateExplosion(ExpX, ExpY, ExpZ, type, Radius);
		}
	}
//----------------------------------------------------------------//

//-------------------------: Formatted Game Text For Player :----------------------//
	FormattedGameTextForPlayer(playerid, string[], time, style, {Float,_}:...)
	{
		format(string, 128, string);
		GameTextForPlayer(playerid, string, time, style);
	}
//---------------------------------------------------------------------------------//

//---------------------------: Formatted Game Text For All :-----------------------//
	FormattedGameTextForAll(string[], time, style, {Float,_}:...)
	{
		format(string, 128, string);
		GameTextForAll(string, time, style);
	}
//---------------------------------------------------------------------------------//

//--------------------------------------: Formatted Chat Bubble For Player :----------------------------------//
	SetPlayerFormattedChatBubble(playerid, text[], color, Float:drawdistance, expiretime, {Float,_}:...)
	{
		new ffstring[256];
		format(ffstring, 16, text);
		SetPlayerChatBubble(playerid, text, color, Float:drawdistance, expiretime);
	}
//------------------------------------------------------------------------------------------------------------//

//----------------------: Send Repeated Client Message :------------------//
	SendRepeatedClientMessage(playerid, color, repeating, message[])
	{
		for (new i = 0;i < repeating; i++)
		{
			SendClientMessage(playerid,color,message);
		}
	}
//------------------------------------------------------------------------//

//-----------------: Send Repeated Client Message To All :-------------//
	SendRepeatedClientMessageToAll(color, repeating, message[])
	{
		for (new i = 0;i < repeating; i++)
		{
			SendClientMessageToAll(color,message);
		}
	}
//---------------------------------------------------------------------//

//----------------------------------: Slap :---------------------------//
	Slap(playerid)
	{
		new Float:shealth;
		new Float:slx, Float:sly, Float:slz;
		GetPlayerHealth(playerid, shealth);
		SetPlayerHealth(playerid, shealth-5);
		GetPlayerPos(playerid, slx, sly, slz);
		SetPlayerPos(playerid, slx, sly, slz+5);
		PlayerPlaySound(playerid, 1130, slx, sly, slz+5);
	}
//---------------------------------------------------------------------//

//--------------------------------: Slap All :--------------------------//
	SlapAll()
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			new Float:shealth;
			new Float:slx, Float:sly, Float:slz;
			GetPlayerHealth(i, shealth);
			SetPlayerHealth(i, shealth-5);
			GetPlayerPos(i, slx, sly, slz);
			SetPlayerPos(i, slx, sly, slz+5);
			PlayerPlaySound(i, 1130, slx, sly, slz+5);
		}
	}
//---------------------------------------------------------------------//

//---------------: Ban all players on the Server :-------------//
	BanAll()
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			Ban(i);
		}
	}
//-------------------------------------------------------------//

//-----------------: Kick all players on the server :--------------//
	KickAll()
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			Kick(i);
		}
	}
//-----------------------------------------------------------------//

//--------------------: Load a FilterScript :----------------//
	FilterScriptInit(fsname)
	{
	    new string[64];
	    format(string,sizeof(string),"loadfs %s",fsname);
		SendRconCommand(string);
		#pragma unused fsname
	}
//-----------------------------------------------------------//

//-------------------: Unload a FilterScript :----------------//
	FilterScriptExit(fsname)
	{
	    new string[64];
	    format(string,sizeof(string),"unloadfs %s",fsname);
		SendRconCommand(string);
		#pragma unused fsname
	}
//------------------------------------------------------------//

//-------------------: Reload a FilterScript :----------------//
	FilterScriptReload(fsname)
	{
	    new string[64];
	    format(string,sizeof(string),"reloadfs %s",fsname);
		SendRconCommand(string);
		#pragma unused fsname
	}
//-----------------------------------------------------------//

//----------------------: Set-/GetPlayerLanguage :----------------------//
	SetPlayerLanguage(playerid,languageid)
	{
		LanguageFXF[playerid] = languageid;
		CallLocalFunction("OnPlayerLanguageChange","i",playerid);
	}
//-------->
	GetPlayerLanguage(playerid)
	{
		return LanguageFXF[playerid];  
	}						   
//----------------------------------------------------------------------//

//----------------------------------------------------: IsPlayerInZone :--------------------------------------------------//
	IsPlayerInZone(playerid, Float:minX, Float:minY, Float:maxX, Float:maxY)
	{
	    new Float:ZoneX, Float:ZoneY, Float:ZoneZ;
		GetPlayerPos(playerid, ZoneX, ZoneY, ZoneZ);
		if((ZoneX >= minX && ZoneX <= maxX) && (ZoneY >= minY && ZoneY <= maxY) && ZoneZ <= 500)
		{
			return 1;
		}
		return 1;
	}
//------------------------------------------------------------------------------------------------------------------------//

//-----------------------------------------------------------------------: Send Distanced Client Message :-----------------------------------------------------------------------//
	SendDistancedClientMessage(playerid, Float:radi, message[], col1,col2,col3,col4,col5)
	{
		if(IsPlayerConnected(playerid))
		{
			new Float:posx, Float:posy, Float:posz;
			new Float:oldposx, Float:oldposy, Float:oldposz;
			new Float:tempposx, Float:tempposy, Float:tempposz;
			GetPlayerPos(playerid, oldposx, oldposy, oldposz);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, message);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, message);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, message);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, message);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, message);
					}
				}
			}
		}
	}
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//