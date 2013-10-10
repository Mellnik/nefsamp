/*-----------------------------------------------------------------------------------------------------------------
								Radio Include
		
	Copyright HolyCrap © 2008

	Functions:
		NextTrack(playerid);
		PrevTrack(playerid);
		TurnRadioOn(playerid);
		TurnRadioOff(playerid);
	Event Handlers:
		SetChannelChanged(const publicname[]);
		SetOnRadioOff(const publicname[]);
		SetOnRadioOn(const publicname[]);

	License:
	Things You May Not Do:
		- to copy the work;
		- to issue copies of the work to the public (see section 18);
		- to perform, show or play the work in public (see section 19);
		- to broadcast the work or include it in a cable programme service (see section 20);
	Exepept:
	    - You Got Permission From Me Or The Goverment
-----------------------------------------------------------------------------------------------------------------------*/

#include <a_samp>

forward NextTrack(playerid);
forward PrevTrack(playerid);
forward TurnRadioOn(playerid);
forward TurnRadioOff(playerid);

forward GetCurrentTrack(playerid);
forward SetChannelChanged(const publicname[]);
forward SetOnRadioOff(const publicname[]);
forward SetOnRadioOn(const publicname[]);

new ChannelsStart[7] = {1062, 1068, 1076, 1097, 1183, 1185, 1187};
new ChannelsStop[7]  = {1063, 1069, 1077, 1098, 1184, 1186, 1188};

new RadioOn[MAX_PLAYERS] = 0;
new Currentplaying[MAX_PLAYERS] = 0;

new ChannelChangedVar[256];
new OnRadioOffVar[256];
new OnRadioOnVar[256];

public NextTrack(playerid)
{
	if(RadioOn[playerid])
	{
		PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0.0);
		PlayerPlaySound(playerid, ChannelsStop[Currentplaying[playerid]], 0.0, 0.0, 0.0);
		if(Currentplaying[playerid] == 6) { Currentplaying[playerid] = 0; }
		else { Currentplaying[playerid]++; }
		PlayerPlaySound(playerid, ChannelsStart[Currentplaying[playerid]], 0.0, 0.0, 0.0);
		CallChannelChanged(playerid, Currentplaying[playerid]);
		return 1;
	}
	return 0;
}

public PrevTrack(playerid)
{
	if(RadioOn[playerid])
	{
	    PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0.0);
		PlayerPlaySound(playerid, ChannelsStop[Currentplaying[playerid]], 0.0, 0.0, 0.0);
		if(Currentplaying[playerid] == 0) { Currentplaying[playerid] = 6; }
		else { Currentplaying[playerid]--; }
		PlayerPlaySound(playerid, ChannelsStart[Currentplaying[playerid]], 0.0, 0.0, 0.0);
		CallChannelChanged(playerid, Currentplaying[playerid]);
		return 1;
	}
	return 0;
}

public TurnRadioOn(playerid)
{
	CallOnRadioOn(playerid);
	RadioOn[playerid] = true;
	Currentplaying[playerid] = 0;
	PlayerPlaySound(playerid, ChannelsStart[Currentplaying[playerid]], 0.0, 0.0, 0.0);
}

public TurnRadioOff(playerid)
{
	CallOnRadioOff(playerid);
	RadioOn[playerid] = false;
	PlayerPlaySound(playerid, ChannelsStop[Currentplaying[playerid]], 0.0, 0.0, 0.0);
	Currentplaying[playerid] = 0;
}

public SetChannelChanged(const publicname[])
{
	return format(ChannelChangedVar, 255, publicname);
}

public SetOnRadioOff(const publicname[])
{
	return format(OnRadioOffVar, 255, publicname);
}

public SetOnRadioOn(const publicname[])
{
	return format(OnRadioOnVar, 255, publicname);
}

CallChannelChanged(playerid, newchannelid)
{
	return CallRemoteFunction(ChannelChangedVar, "dd", playerid, newchannelid);
}

CallOnRadioOff(playerid)
{
 	return CallRemoteFunction(OnRadioOffVar, "d", playerid);
}

CallOnRadioOn(playerid)
{
	return CallRemoteFunction(OnRadioOnVar, "d", playerid);
}

public GetCurrentTrack(playerid)
{
	if(RadioOn[playerid]) { return Currentplaying[playerid]; }
 	else { return -1; }
}

stock Set(const string[])
{
	new str[256];
	format(str, 255, string);
	return str;
}

stock GetTrackName(channelid)
{
	new error[256];
	format(error, 5, "error");
    if(channelid < 0 || channelid > 6) { return error; }
	switch(channelid)
	{
		case 0: { format(error, 255, "Gogo Track"); }
		case 1: { format(error, 255, "Dual Track"); }
		case 2: { format(error, 255, "Bee Track"); }
		case 3: { format(error, 255, "Award Track"); }
		case 4: { format(error, 255, "Driving Award Track"); }
		case 5: { format(error, 255, "Bike Award Track"); }
		case 6: { format(error, 255, "Pilot Award Track"); }
	}
	return error;
}
