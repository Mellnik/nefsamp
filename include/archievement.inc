new PlayerText:ArchievementDraws[MAX_PLAYERS][5];

forward CreateArchievementDraws(playerid);
public CreateArchievementDraws(playerid)
{
	ArchievementDraws[playerid][1] = CreatePlayerTextDraw(playerid,318.000000, 342.000000, "Box");
	PlayerTextDrawAlignment(playerid,ArchievementDraws[playerid][1], 2);
	PlayerTextDrawBackgroundColor(playerid,ArchievementDraws[playerid][1], 255);
	PlayerTextDrawFont(playerid,ArchievementDraws[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid,ArchievementDraws[playerid][1], 0.000000, 8.900001);
	PlayerTextDrawColor(playerid,ArchievementDraws[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid,ArchievementDraws[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid,ArchievementDraws[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid,ArchievementDraws[playerid][1], 1);
	PlayerTextDrawUseBox(playerid,ArchievementDraws[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid,ArchievementDraws[playerid][1], 96);
	PlayerTextDrawTextSize(playerid,ArchievementDraws[playerid][1], 0.000000, 650.000000);

	ArchievementDraws[playerid][2] = CreatePlayerTextDraw(playerid,0.000000, 320.000000, "Achievement Freigeschaltet");
	PlayerTextDrawBackgroundColor(playerid,ArchievementDraws[playerid][2], 255);
	PlayerTextDrawFont(playerid,ArchievementDraws[playerid][2], 0);
	PlayerTextDrawLetterSize(playerid,ArchievementDraws[playerid][2], 0.500000, 3.000000);
	PlayerTextDrawColor(playerid,ArchievementDraws[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid,ArchievementDraws[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid,ArchievementDraws[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid,ArchievementDraws[playerid][2], 1);

	ArchievementDraws[playerid][3] = CreatePlayerTextDraw(playerid,1.000000, 351.000000, "~g~Einstieg in diesem Server");
	PlayerTextDrawBackgroundColor(playerid,ArchievementDraws[playerid][3], 255);
	PlayerTextDrawFont(playerid,ArchievementDraws[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid,ArchievementDraws[playerid][3], 0.290000, 1.100000);
	PlayerTextDrawColor(playerid,ArchievementDraws[playerid][3], -1);
	PlayerTextDrawSetOutline(playerid,ArchievementDraws[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid,ArchievementDraws[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid,ArchievementDraws[playerid][3], 1);

	ArchievementDraws[playerid][4] = CreatePlayerTextDraw(playerid,1.000000, 375.000000, "Hier steht dann spaeter der inhalt, wenn denn einer da ist :D");
	PlayerTextDrawBackgroundColor(playerid,ArchievementDraws[playerid][4], 255);
	PlayerTextDrawFont(playerid,ArchievementDraws[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid,ArchievementDraws[playerid][4], 0.310000, 1.699999);
	PlayerTextDrawColor(playerid,ArchievementDraws[playerid][4], -1);
	PlayerTextDrawSetOutline(playerid,ArchievementDraws[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid,ArchievementDraws[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid,ArchievementDraws[playerid][4], 1);
}

stock GiveArchievement(playerid,name[],text[],money)
{
	PlayerTextDrawSetString(playerid,ArchievementDraws[playerid][3],name);
	PlayerTextDrawSetString(playerid,ArchievementDraws[playerid][4],text);
	
	PlayerTextDrawShow(playerid,ArchievementDraws[playerid][1]);
	PlayerTextDrawShow(playerid,ArchievementDraws[playerid][2]);
	PlayerTextDrawShow(playerid,ArchievementDraws[playerid][3]);
	PlayerTextDrawShow(playerid,ArchievementDraws[playerid][4]);
	
	SetTimerEx("ArchOff",7000,0,"i",playerid);
	PlayAudioStreamForPlayer(playerid,"http://The-Roleplay-Network.de/Sounds/FortschrittDone.mp3");
	
	if(money != 0)
	{
		GivePlayerMoney(playerid,money);
	}
}

forward ArchOff(playerid);
public ArchOff(playerid)
{	
	PlayerTextDrawHide(playerid,ArchievementDraws[playerid][1]);
	PlayerTextDrawHide(playerid,ArchievementDraws[playerid][2]);
	PlayerTextDrawHide(playerid,ArchievementDraws[playerid][3]);
	PlayerTextDrawHide(playerid,ArchievementDraws[playerid][4]);
}