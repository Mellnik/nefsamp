forward ProxDetector(Float:radi, playerid, string[],col1);
public ProxDetector(Float:radi, playerid, string[],col1)
{
    if(IsPlayerConnected(playerid))
    {
        new Float:posx, Float:posy, Float:posz;
        new Float:oldposx, Float:oldposy, Float:oldposz;
        new Float:tempposx, Float:tempposy, Float:tempposz;
        GetPlayerPos(playerid, oldposx, oldposy, oldposz);
        //radi = 2.0; //Trigger Radius
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
                    SendClientMessage(i, col1, string);
                }
                else
                {
                    SendClientMessage(i, col1, string);
                }
            }
        }
    }//not connected
    return 1;
}
IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}
forward split(const strsrc[], strdest[][], delimiter);
public split(const strsrc[], strdest[][], delimiter)
{
    new i, li;
    new aNum;
    new len;
    while(i <= strlen(strsrc)){
        if(strsrc[i]==delimiter || i==strlen(strsrc)){
            len = strmid(strdest[aNum], strsrc, li, i, 128);
            strdest[aNum][len] = 0;
            li = i+1;
            aNum++;
        }
        i++;
    }
    return 1;
}
stock GetPlayerSpeed(playerid, bool:kmh)
{
    new Float:Vx,Float:Vy,Float:Vz,Float:rtn;
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),Vx,Vy,Vz);
	else GetPlayerVelocity(playerid,Vx,Vy,Vz);
    rtn = floatsqroot(floatabs(floatpower(Vx + Vy + Vz,2)));
    return kmh?floatround(rtn * 100 * 1.7):floatround(rtn * 100);
}
stock IstImGangHaus(playerid)
{
    if(IsPlayerInRangeOfPoint(playerid,2,-2171.0906,645.4135,1057.5938)) { return 1; }
    else if(IsPlayerInRangeOfPoint(playerid,2,-2141.1504,-244.6233,36.5156)) { return 1; }
    else if(IsPlayerInRangeOfPoint(playerid,2,1722.2964,-1673.0160,20.2233)) { return 1; }
    else if(IsPlayerInRangeOfPoint(playerid,2,-2667.2361,1428.0952,906.4609)) { return 1; }
    else if(IsPlayerInRangeOfPoint(playerid,2,488.3319,-81.8619,998.7578)) { return 1; }
    else if(IsPlayerInRangeOfPoint(playerid,2,2817.7200,-1166.3160,1029.1719)) { return 1; }
    else { return 0; }
}
stock PlayerName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}
stock PlayerPlaySoundEx(playerid,soundid) //By Sacky
{
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid,x,y,z);
PlayerPlaySound(playerid,soundid,x,y,z);
}

stock GetName(playerid)
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,Name,sizeof Name);
	return Name;
}



