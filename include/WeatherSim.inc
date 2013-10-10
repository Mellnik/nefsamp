//----------------------------------------
//-- vovo4ka SA:MP Weather Simulator 1.0 -
//----- e-mail: vladleu@rambler.ru  ------
//----------------------------------------
//-- Include makes the weather more realistic
//-- 
//-- How to use :
//-- OnGameModeInit paste:
/* for (new i=0; i<MAX_CYC; i++) // <---- OnGameModeInit
	{
	CycloneInit(i);
	}
SetTimer("CycloneProcess",30000,true); // moves cyclones
	
SetWeatherTime(12,00); // default time
	
SetTimer("UpdateWeather",10000,true); // weather updates players timer
*/
// 
//-------- after each change of time in the script call:
/*
SetWeatherTime(YourTime_H, YourTime_M);
UpdateWeather(); 
*/



// See demo for example

//--------------------------------------------------
#if defined WeatherSim
	#endinput
#endif
#define WeatherSim

#define MAX_CYC 5 // Maximum of clouds on map    8 - very cloudly;

#define WEAT_GREEN 0x1
#define WEAT_CITY 0x2
#define WEAT_DESERT 0x4
#define WEAT_LV 0x8
#define WEAT_MOUNT 0x10
#define WEAT_RAIN 0x20
#define WEAT_CLOUDS1 0x40
#define WEAT_CLOUDS2 0x80
#define WEAT_CLOUDS3 0x100
//----------------------------
enum Cyc_E
{
x,y,
lx,ly,
Float:power
}
//---------------------------
// Constant weather.

// Weather patterns. You can change it to make more realistic weather
// Every 2 numbers means half of hour.
// For example weather id 12 -> 00:00 am		12 - > 00:30 am		15 -> 1:00 am
new weat_city[48]= 
{12,12,15,15,66,66,12,12,61,58,63,28,28,28,6,11,11,11,11,11,11,11,2,2,14,14,
14,14,34,34,34,34,1,1,1,1,17,17,17,17,18,18,2,1,1,0,3,3};
new weat_green[48]=
{1,1,54,1,1,1,9,1,61,58,63,28,28,28,6,11,11,11,11,11,11,11,2,2,14,14,
14,14,34,34,34,34,1,1,1,1,17,17,17,17,18,18,2,1,1,0,3,3};
new weat_desert[48]=
{1,1,1,1,1,19,1,1,61,61,58,28,28,28,18,11,11,11,11,11,11,11,2,2,14,14,
14,14,34,34,34,34,1,1,1,1,17,17,17,17,25,25,2,1,1,0,3,19};
new weat_lv[48]=
{12,12,15,15,66,66,12,12,61,58,28,28,28,28,18,11,11,11,11,11,11,11,2,2,14,14,
14,14,34,34,34,34,1,1,1,1,17,17,17,17,18,18,2,1,1,0,3,3};

// Dynamic clouds and rain

new Cyclone[MAX_CYC][Cyc_E]; // Clouds data

new Weat_th, Weat_tm; // Current time. Must be synchronized with player clock!!!

new weat_zone[40][40]= // Weather Map
{ // Terrain type 1 - forest  2 - city  4 - desert  8 - LV (desert+city)
// Mountains - mask 10h  - a barrier for cyclone
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,17,17,17,17,17,17,17,17,17,17,20,20,20,20,20,20,20,20,20,20,20,24,24,24,24,24,24,24,24,24,1,1,1,1,1},
{1,1,1,1,1,17,1,1,1,1,1,1,1,4,4,4,4,4,4,4,4,4,4,4,4,4,8,8,8,8,8,8,8,8,24,1,1,1,1,1},
{1,1,1,1,1,17,1,1,1,1,1,1,1,17,1,4,4,4,4,4,4,4,4,4,4,8,8,8,8,8,8,8,8,8,24,1,1,1,1,1},
{1,1,1,1,1,17,1,1,1,1,1,1,1,17,1,4,4,4,20,4,4,4,4,4,4,8,8,8,8,8,8,8,8,8,24,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,20,4,4,4,4,20,4,4,4,20,4,8,8,8,8,8,8,8,8,8,8,24,1,1,1,1,1},
{1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,17,4,4,20,4,4,4,20,4,8,8,8,8,8,8,8,8,8,8,24,1,1,1,1,1},
{1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,17,4,4,20,4,4,4,20,4,8,8,8,8,8,8,8,8,8,8,24,1,1,1,1,1},
{1,1,1,1,1,1,2,2,2,2,2,2,2,1,1,17,4,4,20,4,4,4,20,4,4,8,8,8,8,8,8,8,8,8,24,1,1,1,1,1},
{1,1,1,1,1,2,2,2,2,2,2,2,2,1,1,17,4,4,20,4,4,4,4,4,4,8,8,8,8,8,8,8,8,8,24,1,1,1,1,1},
{1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,1,1,1,4,4,20,20,4,4,4,8,8,8,8,8,8,8,8,8,24,1,1,1,1,1},
{1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,1,1,1,4,4,4,4,4,4,8,8,8,8,8,8,8,8,8,8,24,1,1,1,1,1},
{1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,4,4,4,8,8,8,8,8,8,8,8,8,24,1,1,1,1,1},
{1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,17,17,1,17,17,17,17,1,1,1,1,1,1,1},
{1,1,1,1,1,1,1,2,2,1,1,2,2,2,1,1,1,1,1,1,1,1,1,1,18,18,2,2,2,2,2,2,2,2,2,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,17,17,17,17,17,1,1,1,1,1,2,18,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1},
{1,1,1,1,1,17,17,17,1,1,1,1,1,1,1,1,17,1,1,1,1,2,18,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1},
{1,1,1,1,1,17,1,1,1,1,1,1,1,1,1,1,17,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1},
{1,1,1,1,1,17,1,1,1,1,1,1,1,1,1,1,17,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1},
{1,1,1,1,1,17,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1},
{1,1,1,1,1,17,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,17,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,17,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,17,17,17,1,17,1,17,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
};

forward CycloneProcess();
forward UpdateWeather();
//---------------
public CycloneProcess()
{ // moving cyclone
new i,j;
new cyc_x, cyc_y, cyc_lx, cyc_ly;
for (new k=0; k<MAX_CYC; k++)
	{
	cyc_x=Cyclone[k][x];
	cyc_y=Cyclone[k][y];
	cyc_lx=Cyclone[k][lx];
	cyc_ly=Cyclone[k][ly];
	if (random(10)>1) 
		{
		i=cyc_x-cyc_lx;
		j=cyc_y-cyc_ly;
		}
		else
		{
		i=-random(3)+1;
		j=-random(3)+1;
		if (abs(i)==abs(j))
			{
			i=1;
			j=0;
			}
		}
	i=cyc_x+i;
	j=cyc_y+j;
	if ((i>6)&&(i<33)&&(j>6)&&(j<33)&&(weat_zone[j][i]&WEAT_MOUNT==0))
		{
		cyc_lx=cyc_x;
		cyc_ly=cyc_y;
		cyc_x=i;
		cyc_y=j;
		}
		else
		{
		cyc_lx=cyc_x;
		cyc_ly=cyc_y;
		while (!((i>6)&&(i<33)&&(j>6)&&(j<33)&&(weat_zone[j][i]&WEAT_MOUNT==0)))
		{
		i=-random(3)+1;
		j=-random(3)+1;
		if (abs(i)==abs(j))
			{
			i=1;
			j=0;
			}
		i=cyc_x+i;
		j=cyc_y+j;
		}
		cyc_x=i;
		cyc_y=j;
		}
	CycloneClear(k);
	if (Cyclone[k][power]<0)
		{
		CycloneInit(k);
		}
		else
		Cyclone[k][power]=Cyclone[k][power]-0.12;	
	Cyclone[k][x]=cyc_x;
	Cyclone[k][y]=cyc_y;
	Cyclone[k][lx]=cyc_lx;
	Cyclone[k][ly]=cyc_ly;
	CycloneDraw(k);
	}
return 1;
}
//---------------
CycloneInit(cyc_num)
{ // Cyclone spawn
if (random(2)==1)
	Cyclone[cyc_num][x]=6+random(8);
	else
	Cyclone[cyc_num][x]=25+random(8);
Cyclone[cyc_num][y]=16+random(15);
if ((Cyclone[cyc_num][x]<20))
	{
	Cyclone[cyc_num][lx]=1;
	Cyclone[cyc_num][ly]=0;
	}
	else
	{
	Cyclone[cyc_num][lx]=-1;
	Cyclone[cyc_num][ly]=0;
	}
Cyclone[cyc_num][power]=2+random(floatround(floatsin(Weat_th/3.66)*3)+8);
CycloneDraw(cyc_num);
return 1;
}
//---------------
CycloneDraw(cyc_num)
{ // mark weather map
new Float:cyc_power=Cyclone[cyc_num][power];
new cyc_x, cyc_y;
cyc_x = Cyclone[cyc_num][x];
cyc_y = Cyclone[cyc_num][y];

if (cyc_power>10.0)
	{
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_RAIN,1);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_RAIN,2);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_RAIN,3);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS3,4);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS2,5);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS1,6);
	}
	else
if (cyc_power>8.0)
	{
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_RAIN,1);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_RAIN,2);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS3,3);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS3,4);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS2,5);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS1,6);
	}
	else
if (cyc_power>5.0)
	{
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_RAIN,1);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_RAIN,2);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS3,3);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS2,4);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS1,5);
	}
	else
if (cyc_power>4.0)
	{
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_RAIN,1);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_RAIN,2);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS2,3);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS1,4);
	}
	else
if (cyc_power>3.0)
	{
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_RAIN,1);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS3,2);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS2,3);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS1,4);
	}
	else
if (cyc_power>1.0)
	{
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_RAIN,1);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS2,2);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS1,3);
	}
	else
	{
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS2,1);
	CycloneZoneDraw(cyc_x,cyc_y,WEAT_CLOUDS1,2);
	}	
return 1;
}
//---------------
CycloneClear(cyc_num)
{
new Float:cyc_power=Cyclone[cyc_num][power];
new cyc_x, cyc_y;
cyc_x = Cyclone[cyc_num][x];
cyc_y = Cyclone[cyc_num][y];

if (cyc_power>8.0)
	{
	CycloneZoneClear(cyc_x,cyc_y,1);
	CycloneZoneClear(cyc_x,cyc_y,2);
	CycloneZoneClear(cyc_x,cyc_y,3);
	CycloneZoneClear(cyc_x,cyc_y,4);
	CycloneZoneClear(cyc_x,cyc_y,5);
	CycloneZoneClear(cyc_x,cyc_y,6);
	}
	else
if (cyc_power>5.0)
	{
	CycloneZoneClear(cyc_x,cyc_y,1);
	CycloneZoneClear(cyc_x,cyc_y,2);
	CycloneZoneClear(cyc_x,cyc_y,3);
	CycloneZoneClear(cyc_x,cyc_y,4);
	CycloneZoneClear(cyc_x,cyc_y,5);
	}
	else
if (cyc_power>3.0)
	{
	CycloneZoneClear(cyc_x,cyc_y,1);
	CycloneZoneClear(cyc_x,cyc_y,2);
	CycloneZoneClear(cyc_x,cyc_y,3);
	CycloneZoneClear(cyc_x,cyc_y,4);
	}
	else
if (cyc_power>1.0)
	{
	CycloneZoneClear(cyc_x,cyc_y,1);
	CycloneZoneClear(cyc_x,cyc_y,2);
	CycloneZoneClear(cyc_x,cyc_y,3);
	}
	else
	{
	CycloneZoneClear(cyc_x,cyc_y,1);
	CycloneZoneClear(cyc_x,cyc_y,2);
	}	
return 1;
}
//---------------
CycloneZoneDraw(px,py,val,range)
{
range=range-1;
for (new i=-range; i<=range; i++)
	{
	weat_zone[py+range][i+px]|=val;
	weat_zone[py-range][i+px]|=val;
	weat_zone[py+i][px-range]|=val;
	weat_zone[py+i][px+range]|=val;
	}
return 1;
}

CycloneZoneClear(px,py,range)
{
range=range-1;
for (new i=-range; i<=range; i++)
	{
	weat_zone[py+range][i+px]&=31;
	weat_zone[py-range][i+px]&=31;
	weat_zone[py+i][px-range]&=31;
	weat_zone[py+i][px+range]&=31;
	}
return 1;
}
//--------------
public UpdateWeather()
{ // call this every 10-15 sec
for (new i=0; i<MAX_PLAYERS; i++)
	{
	if (IsPlayerConnected(i))
		SetPlayerWeatherEx(i);
	}
return 1;
}
//---------------
SetWeatherTime(Hour, Minute) // doesn't change server time. Needs to calculate the weather id
{
Weat_th = Hour;
Weat_tm = Minute;
return 1;
}
//---------------
SetPlayerWeatherEx(playerid)
{ // If the players are in different places the weather for them may differ
new minut=Weat_th*2+Weat_tm/30;
new weath;
new cell;
new Float:px,
 Float:py,
 Float:pz;
GetPlayerPos(playerid, px, py, pz);
new px2,py2;
px2=floatround(px);
py2=floatround(py);
px2=(px2+4000)/200-1;
py2=(py2+4000)/200-1;
if (px2<0) px2=0;
 else
 if (px2>39) px2=39;
if (py2<0) py2=0;
 else
 if (py2>39) py2=39;
py2=39-py2;
cell = weat_zone[py2][px2];
if (cell&WEAT_RAIN==WEAT_RAIN)
	weath=8;
	else
if (cell&WEAT_CLOUDS3==WEAT_CLOUDS3)
	{
	if ((Weat_th<21)&&(Weat_th>1))
		weath=31;
		else
		weath=20;
	}
	else
if (cell&WEAT_CLOUDS2==WEAT_CLOUDS2)
	{
	if ((Weat_th<21)&&(Weat_th>1))
		weath=30;
		else
		weath=20;
	}
	else
if (cell&WEAT_CLOUDS1==WEAT_CLOUDS1)
	weath=7;
	else
if (cell&WEAT_CITY==WEAT_CITY)
	weath=weat_city[minut];
	else
if (cell&WEAT_GREEN==WEAT_GREEN)
	weath=weat_green[minut];
	else
if(cell&WEAT_LV==WEAT_LV)
	weath=weat_lv[minut];
	else
if (cell&WEAT_DESERT==WEAT_DESERT)
	weath=weat_desert[minut];

SetPlayerWeather(playerid, weath);
	
return 1;
}
//------
abs(a)
{
if (a>=0) return a;
else return -a;
}
//------