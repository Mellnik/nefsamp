/*
					///////////////////////////////////////////////////
					////                                           ////
					////          tAxI's ADVANCED VEHICLE          ////
					////             STREAMER/COMMANDS             ////
					////                                           ////
					////     COPYRIGHT: RELEASED UNDER the GNU     ////
					////                 LICENCE                   ////
					////                                           ////
					///////////////////////////////////////////////////


    tAxI's Advanced Vehicle Streamer/Commands - INC Package for SA-MP Multiplayer Modification
    of Grand Theft Auto - San Andreas.

    Copyright (C) 2008  Chris Johnstone (tAxI/Necrioss)
	-=<:: Credits to On_Top_Non_Stop for SetStreamVehicleHealth ::>=-

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.

=============================================================================================
THIS CODE IS DESIGNED AS A REPLACEMENT FOR THE DEFAULT VEHICLE COMMANDS INCLUDED WITH YOUR
SA-MP SERVER INSTALLATION. THE COMMANDS ARE BASED AROUND STREAMER TECHNOLOGY DEVELOPED BY
tAxI aka Necrioss (Chris Johnstone) AND ANY ATTEMPTS TO CLAIM THE DESIGN OF THE CODE CONTAINED
WITHIN THIS FILE WILL BE PERSUED RIGOROUSLY

THE CODE REPLACES THE DEFAULT VEHICLE MANAGEMENT SYSTEM WITH STREAMED VEHICLE PROTOCOLS WHICH
ALLOW CODERS TO EXCEED THE DEFAULT LIMITATIONS OF SA-MP WHILST AT THE SAME TIME OFFERING MORE
ADVANCED VEHICLE FUNCTIONS SUCH AS AUTOMATIC MODSAVING (WHEN PLAYERS MOD THEIR VEHICLES IN A
MOD GARAGE IT WILL SAVE AND THE VEHICLE WILL RESPAWN WITH THE SAVED MODS IN PLACE). THE SYSTEM
ALSO OFFERS AN AUTOMATIC CLEANUP OF ABANDONED VEHICLES - ANY VEHICLE SITTING IDLE FOR 5 MINUTES
AFTER USE WILL BE AUTOMATICALLY RESPAWNED.
=============================================================================================

native tAxI_OnGameModeInit()
native tAxI_OnVehicleDeath(vehicleid)
native tAxI_OnPlayerEnterVehicle(playerid,vehicleid)
native tAxI_OnPlayerExitVehicle(vehicleid)
native tAxI_OnVehicleMod(vehicleid,componentid)
native tAxI_OnVehicleRespray(vehicleid,color1,color2)
native tAxI_OnVehiclePaintjob(vehicleid,paintjobid)
native tAxI_OnVehicleSpawn(vehicleid)
native tAxI_OnPlayerKeyStateChange(playerid,newkeys)
native tAxI_OnPlayerStateChange(playerid,newstate,oldstate)
native SetBikeAntiFallForPlayer(playerid,bool:toggle)
native ToggleAutoModSave(bool:toggle)
native CreateStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2)
native DestroyStreamVehicle(vstreamid)
native SetStreamVehicleToRespawn(vstreamid)
native CreateTempStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2)
native GetPlayerVehicleStreamID(playerid)
native GetVehicleStreamID(vehicleid)
native GetVehicleStreamModel(vstreamid)
native GetStreamVehicleID(vstreamid)
native SetStreamVehiclePos(vstreamid,Float:x,Float:y,Float:z,Float:a)
native SetVehicleStreamSpawnInfo(vstreamid,vmodel,Float:x,Float:y,Float:z,Float:a,color1,color2)
native ForceStreamVehicleSpawn(vstreamid,Float:x,Float:y,Float:z,Float:a,worldid,interiorid,objective,UseSavedMods)
native ChangeStreamVehiclePaintjob(vstreamid,paintjobid)
native ChangeStreamVehicleColor(vstreamid,col1,col2)
native AddStreamVehicleMod(vstreamid,componentid)
native SetStreamVehicleParamsForPlayer(vstreamid,playerid,objective,doorslocked);
native LinkStreamVehicleToInterior(vstreamid,interiorid)
native SetStreamVehicleVirtualWorld(vstreamid,world)
native GetStreamVehicleVirtualWorld(vstreamid)
native ImportModsFromFile(const savefile[])
native ExportModsToFile(const savefile[])
native GetStreamVehiclePos(vstreamid,&Float:Xpos,&Float:Ypos,&Float:Zpos)
native GetStreamVehicleZAngle(vstreamid,&Float:Angle)
native PutPlayerInStreamVehicle(playerid,vstreamid,seatnum)
native SetStreamVehicleHealth(vstreamid,Float:health)

=============================================================================================
*/

new spoiler[20][0] = {
	{1000},
	{1001},
	{1002},
	{1003},
	{1014},
	{1015},
	{1016},
	{1023},
	{1058},
	{1060},
	{1049},
	{1050},
	{1138},
	{1139},
	{1146},
	{1147},
	{1158},
	{1162},
	{1163},
	{1164}
};

new nitro[3][0] = {
    {1008},
    {1009},
    {1010}
};

new fbumper[23][0] = {
    {1117},
    {1152},
    {1153},
    {1155},
    {1157},
    {1160},
    {1165},
    {1167},
    {1169},
    {1170},
    {1171},
    {1172},
    {1173},
    {1174},
    {1175},
    {1179},
    {1181},
    {1182},
    {1185},
    {1188},
    {1189},
    {1192},
    {1193}
};

new rbumper[22][0] = {
    {1140},
    {1141},
    {1148},
    {1149},
    {1150},
    {1151},
    {1154},
    {1156},
    {1159},
    {1161},
    {1166},
    {1168},
    {1176},
    {1177},
    {1178},
    {1180},
    {1183},
    {1184},
    {1186},
    {1187},
    {1190},
    {1191}
};

new exhaust[28][0] = {
    {1018},
    {1019},
    {1020},
    {1021},
    {1022},
    {1028},
    {1029},
    {1037},
    {1043},
    {1044},
    {1045},
    {1046},
    {1059},
    {1064},
    {1065},
    {1066},
    {1089},
    {1092},
    {1104},
    {1105},
    {1113},
    {1114},
    {1126},
    {1127},
    {1129},
    {1132},
    {1135},
    {1136}
};

new bventr[2][0] = {
    {1042},
    {1044}
};

new bventl[2][0] = {
    {1043},
    {1045}
};

new bscoop[4][0] = {
	{1004},
	{1005},
	{1011},
	{1012}
};

new rscoop[13][0] = {
    {1006},
    {1032},
    {1033},
    {1035},
    {1038},
    {1053},
    {1054},
    {1055},
    {1061},
    {1067},
    {1068},
    {1088},
    {1091}
};

new lskirt[21][0] = {
    {1007},
    {1026},
    {1031},
    {1036},
    {1039},
    {1042},
    {1047},
    {1048},
    {1056},
    {1057},
    {1069},
    {1070},
    {1090},
    {1093},
    {1106},
    {1108},
    {1118},
    {1119},
    {1133},
    {1122},
    {1134}
};

new rskirt[21][0] = {
    {1017},
    {1027},
    {1030},
    {1040},
    {1041},
    {1051},
    {1052},
    {1062},
    {1063},
    {1071},
    {1072},
    {1094},
    {1095},
    {1099},
    {1101},
    {1102},
    {1107},
    {1120},
    {1121},
    {1124},
    {1137}
};

new hydraulics[1][0] = {
    {1087}
};

new base[1][0] = {
    {1086}
};

new rbbars[2][0] = {
    {1109},
    {1110}
};

new fbbars[2][0] = {
    {1115},
    {1116}
};

new wheels[17][0] = {
    {1025},
    {1073},
    {1074},
    {1075},
    {1076},
    {1077},
    {1078},
    {1079},
    {1080},
    {1081},
    {1082},
    {1083},
    {1084},
    {1085},
    {1096},
    {1097},
    {1098}
};

new lights[2][0] = {
	{1013},
	{1024}
};

#define MAX_MODEL_NUMBER 211
#define MAX_STREAM_VEHICLES 3000
#define MAX_ACTIVE_VEHICLES 690
#define MAX_ACTIVE_PICKUPS 250
#define MAX_ACTIVE_MODELS 65
#define MAX_SECTORS 256
#define MAX_SECTOR_VEHICLES 200
#define RED 0xFF0000AA
#define BLUE 0x0000BBAA
#define GREEN 0x0AFF0AAA
#define KEY_EXIT_VEHICLE	16
#define MOD_FILE_TEMPLATE "%s.vmf"

new Float:tmpx[MAX_STREAM_VEHICLES];
new Float:tmpy[MAX_STREAM_VEHICLES];
new Float:tmpz[MAX_STREAM_VEHICLES];
new Float:tmpa[MAX_STREAM_VEHICLES];
new tmpworld[MAX_STREAM_VEHICLES];
new tmpinterior[MAX_STREAM_VEHICLES];
new tmpobjective[MAX_STREAM_VEHICLES];
new tmpmod[MAX_STREAM_VEHICLES];
new vehcount = 0;
new Vstreamcount = 0;
new vehused[MAX_ACTIVE_VEHICLES];
new avstream[MAX_ACTIVE_VEHICLES];
new SectorVehicles[MAX_SECTORS][MAX_SECTOR_VEHICLES];
new SectorVehicleCount[MAX_SECTORS];
new vSecActive[MAX_SECTORS];
new bool:Automodsave;
new registered[MAX_ACTIVE_VEHICLES];
new Abandoned[MAX_ACTIVE_VEHICLES];
new atimer[MAX_ACTIVE_VEHICLES];
new antifall[MAX_PLAYERS];
new cmdoff[MAX_PLAYERS];
new lastv[MAX_PLAYERS];

enum vInfo
{
	limbo,
	model,
	Float:x_spawn,
	Float:y_spawn,
	Float:z_spawn,
 	Float:za_spawn,
 	color_1,
 	color_2,
	spawned,
	idnum,
 	valid,
	mod1,
	mod2,
	mod3,
	mod4,
	mod5,
	mod6,
	mod7,
	mod8,
	mod9,
	mod10,
	mod11,
	mod12,
	mod13,
	mod14,
	mod15,
	mod16,
	mod17,
	paintjob,
 	temporary,
 	worldid,
 	intid,
 	destroyed,
 	fspawn,
 	id_prev_used,
};

new VehicleInfo[MAX_STREAM_VEHICLES][vInfo];


enum pI
{
	obj,
	dlock
};

new PlI[MAX_PLAYERS][MAX_STREAM_VEHICLES][pI];

forward InitiateSectorSystem();
forward SectorScan();
forward ModVehicle(streamid);
forward DeathProcess(vehicleid);
forward RemoveTempVehicle(vehicleid);
forward ConvertVehicleToStream(vehicleid);
forward ResetAbandonedVehicle(vstreamid);
forward SafeForceSpawn(vstreamid);

stock String_Split(const strsrc[], strdest[][], delimiter)
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

stock ImportModsFromFile(const savefile[])
{
    new file_name[256],File:file_ref,file_string[256];
    new SplitDiv[20][50],blank[256],mess_string[256];
    new file_count = 0;
	format(file_name,sizeof(file_name),MOD_FILE_TEMPLATE,savefile);
	file_ref = fopen(file_name, io_read);
	if(fexist(file_name)) {
        while(fread(file_ref, blank, sizeof blank)) {
            file_count++;
        }
        fclose(file_ref);
		if (file_ref) {
	    	for(new streamid = 1;streamid<=file_count;streamid++) {
   				if(VehicleInfo[streamid][valid] == 1) {
		   	 		fread(file_ref, file_string);
					String_Split(file_string, SplitDiv, ',');
					VehicleInfo[streamid][color_1] = strval(SplitDiv[0]);
					VehicleInfo[streamid][color_2] = strval(SplitDiv[1]);
					VehicleInfo[streamid][mod1] = strval(SplitDiv[2]);
					VehicleInfo[streamid][mod2] = strval(SplitDiv[3]);
					VehicleInfo[streamid][mod3] = strval(SplitDiv[4]);
					VehicleInfo[streamid][mod4] = strval(SplitDiv[5]);
					VehicleInfo[streamid][mod5] = strval(SplitDiv[6]);
					VehicleInfo[streamid][mod6] = strval(SplitDiv[7]);
					VehicleInfo[streamid][mod7] = strval(SplitDiv[8]);
					VehicleInfo[streamid][mod8] = strval(SplitDiv[9]);
					VehicleInfo[streamid][mod9] = strval(SplitDiv[10]);
					VehicleInfo[streamid][mod10] = strval(SplitDiv[11]);
					VehicleInfo[streamid][mod11] = strval(SplitDiv[12]);
					VehicleInfo[streamid][mod12] = strval(SplitDiv[13]);
					VehicleInfo[streamid][mod13] = strval(SplitDiv[14]);
					VehicleInfo[streamid][mod14] = strval(SplitDiv[15]);
					VehicleInfo[streamid][mod15] = strval(SplitDiv[16]);
					VehicleInfo[streamid][mod16] = strval(SplitDiv[17]);
					VehicleInfo[streamid][mod17] = strval(SplitDiv[18]);
					VehicleInfo[streamid][paintjob] = strval(SplitDiv[19]);
					Modvehicle(streamid);
				}
			}
		}
		fclose(file_ref);
		format(mess_string,sizeof(mess_string),"** FILE PROCESSED: All saved vehicle mods successfully loaded and applied from mods file, %s.vmf **",filename);
		SentClientMessageToAll(GREEN, mess_string);
	}
	else {
	    format(mess_string,sizeof(mess_string),"** FILE ERROR: Could not find the specified vehicle mods file, %s.vmf **",filename);
		SentClientMessageToAll(RED, mess_string);
	}
}

stock ExportModsToFile(const savefile[])
{
	new file_name[256],File:file_ref,file_string[256],mess_string[256];
	format(file_name,sizeof(file_name),MOD_FILE_TEMPLATE,savefile);
    file_ref = fopen(file_name, io_write);
    for(new streamid = 1;streamid<=vehcount;streamid++) {
		format(file_string, sizeof(file_string), "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
		VehicleInfo[streamid][color_1],
		VehicleInfo[streamid][color_2],
		VehicleInfo[streamid][mod1],
		VehicleInfo[streamid][mod2],
		VehicleInfo[streamid][mod3],
		VehicleInfo[streamid][mod4],
		VehicleInfo[streamid][mod5],
		VehicleInfo[streamid][mod6],
		VehicleInfo[streamid][mod7],
		VehicleInfo[streamid][mod8],
		VehicleInfo[streamid][mod9],
		VehicleInfo[streamid][mod10],
		VehicleInfo[streamid][mod11],
		VehicleInfo[streamid][mod12],
		VehicleInfo[streamid][mod13],
		VehicleInfo[streamid][mod14],
		VehicleInfo[streamid][mod15],
		VehicleInfo[streamid][mod16],
		VehicleInfo[streamid][mod17],
		VehicleInfo[streamid][paintjob]
		);
		fwrite(file_ref, file_string);
	}
	fclose(file_ref);
	format(mess_string,sizeof(mess_string),"** FILE CREATED: All vehicle mods successfully saved to the file, %s.vmf **",filename);
	return SentClientMessageToAll(BLUE, mess_string);
}

stock UpdateVehicleParams(vstreamid)
{
	new ttxp[2];
    if(VehicleInfo[vstreamid][spawned] == 1) {
    	for(new i = 0;i<MAX_PLAYERS;i++) {
    	    ttxp[0] = PlI[i][vstreamid][obj];
    	    ttxp[1] = PlI[i][vstreamid][dlock];
			SetVehicleParamsForPlayer(VehicleInfo[vstreamid][idnum],i,ttxp[0],ttxp[1]);
		}
	}
	return 1;
}

stock LinkStreamVehicleToInterior(vstreamid,interiorid)
{
    VehicleInfo[vstreamid][intid] = interiorid;
	if(VehicleInfo[vstreamid][spawned] == 1) {
	    LinkVehicleToInterior(VehicleInfo[vstreamid][idnum],interiorid);
	}
	return 1;
}

stock SetStreamVehicleParamsForPlayer(vstreamid,playerid,objective,doorslocked)
{
	PlI[playerid][vstreamid][obj] = objective;
	PlI[playerid][vstreamid][dlock] = doorslocked;
 	if(VehicleInfo[vstreamid][spawned] == 1) {
		SetVehicleParamsForPlayer(VehicleInfo[vstreamid][idnum],playerid,objective,doorslocked);
	}
	return 1;
}

stock SetStreamVehicleVirtualWorld(vstreamid,world)
{
	VehicleInfo[vstreamid][worldid] = world;
	if(VehicleInfo[vstreamid][spawned] == 1) {
	    SetVehicleVirtualWorld(VehicleInfo[vstreamid][idnum],world);
	}
	return 1;
}

stock GetVehicleSpawnSector(streamid)
{
    new xsec = floatround(((VehicleInfo[streamid][x_spawn] +4000) / 500), floatround_floor);
	new ysec = floatround(((VehicleInfo[streamid][y_spawn] +4000) / 500), floatround_floor);
	return (xsec * 16) + ysec;
}

stock GetPlayerSector(playerid)
{
	new Float:pos[3];
	if(IsPlayerConnected(playerid)) {
		GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
		new xsec = floatround(((pos[0] +4000) / 500), floatround_floor);
		new ysec = floatround(((pos[1] +4000) / 500), floatround_floor);
		return (xsec * 16) + ysec;
	}
	return 999;
}

public SectorScan()
{
    new psec[MAX_PLAYERS];
    for(new i = 0;i<MAX_SECTORS;i++) {
		vSecActive[i] = 0;
	}
    for(new i = 0;i<MAX_PLAYERS;i++) {
        if(IsPlayerConnected(i)) {
			psec[i] = GetPlayerSector(i);
   			if(vSecActive[psec[i]] == 0) {
			    vSecActive[psec[i]] = 1;
			}
			if(vSecActive[psec[i]+1] == 0) {
	    		vSecActive[psec[i]+1] = 1;
			}
			if(vSecActive[psec[i]-1] == 0) {
			    vSecActive[psec[i]-1] = 1;
			}
			if(vSecActive[psec[i]-15] == 0) {
			    vSecActive[psec[i]-15] = 1;
			}
			if(vSecActive[psec[i]-16] == 0) {
			    vSecActive[psec[i]-16] = 1;
			}
			if(vSecActive[psec[i]-17] == 0) {
	    		vSecActive[psec[i]-17] = 1;
			}
			if(vSecActive[psec[i]+15] == 0) {
			    vSecActive[psec[i]+15] = 1;
			}
			if(vSecActive[psec[i]+16] == 0) {
			    vSecActive[psec[i]+16] = 1;
			}
			if(vSecActive[psec[i]+17] == 0) {
			    vSecActive[psec[i]+17] = 1;
			}
    		StreamProcess(i,psec[i],psec[i]+1,psec[i]-1,psec[i]+15,psec[i]-15,psec[i]+16,psec[i]-16,psec[i]+17,psec[i]-17);

		}
	}
	CleanupVehicles();
}

stock CleanupVehicles()
{
	for(new i = 1;i<Vstreamcount;i++) {
		if(VehicleInfo[i][fspawn] == 0){
			if(VehicleInfo[i][spawned] == 1 && vehused[VehicleInfo[i][idnum]] == 0 && PlayersClose(VehicleInfo[i][x_spawn],VehicleInfo[i][y_spawn],VehicleInfo[i][z_spawn],300) == 0) {
				VehicleInfo[i][spawned] = 0;
				DestroyVehicle(VehicleInfo[i][idnum]);
				if(Abandoned[VehicleInfo[i][idnum]] == 1) {
					Abandoned[VehicleInfo[i][idnum]] = 0;
					KillTimer(atimer[VehicleInfo[i][idnum]]);
				}
				registered[VehicleInfo[i][idnum]] = 0;
				vehused[VehicleInfo[i][idnum]] = 0;
				Vstreamcount--;
				VehicleInfo[i][idnum] = 0;
	    	}
		}
	}
}

stock StreamProcess(playerid,v1,v2,v3,v4,v5,v6,v7,v8,v9)
{
    new p,i;
    new sec[9];
    sec[0] = v1;
    sec[1] = v2;
    sec[2] = v3;
    sec[3] = v4;
    sec[4] = v5;
    sec[5] = v6;
    sec[6] = v7;
    sec[7] = v8;
    sec[8] = v9;
    for(new k = 0;k<8;k++) {
        i = sec[k];
        if(vSecActive[i] == 1) {
    		for(new j = 1;j<=SectorVehicleCount[i];j++) {
        		p = SectorVehicles[i][j];
        		if(VehicleInfo[p][limbo] == 0 && VehicleInfo[p][valid] == 1 && VehicleInfo[p][spawned] == 0 && PlayerClose(playerid,VehicleInfo[p][x_spawn],VehicleInfo[p][y_spawn],VehicleInfo[p][z_spawn],300) == 1) {
						if(Vstreamcount < MAX_ACTIVE_VEHICLES) {
			        		if(IsModelActive(VehicleInfo[p][model]) == 0) {
			           		 	if(CountModels() < MAX_ACTIVE_MODELS) {
			           		 		VehicleInfo[p][fspawn] = 0;
			           		 	    VehicleInfo[p][spawned] = 1;
			           		 	    VehicleInfo[p][destroyed] = 0;
									VehicleInfo[p][idnum] = CreateVehicle(VehicleInfo[p][model], VehicleInfo[p][x_spawn], VehicleInfo[p][y_spawn], VehicleInfo[p][z_spawn], VehicleInfo[p][za_spawn], VehicleInfo[p][color_1], VehicleInfo[p][color_2],20000);
                                    registered[VehicleInfo[p][idnum]] = 1;
									avstream[VehicleInfo[p][idnum]] = p;
									SetTimerEx("ModVehicle",100,0,"i",p);
									if(VehicleInfo[p][worldid] > 0) {
					    				SetVehicleVirtualWorld(VehicleInfo[p][idnum],VehicleInfo[p][worldid]);
									}
         							if(VehicleInfo[p][intid] > 0) {
									    LinkVehicleToInterior(VehicleInfo[p][idnum],VehicleInfo[p][intid]);
									}
									UpdateVehicleParams(p);
									Vstreamcount++;
								}
							}
							else {
							    VehicleInfo[p][fspawn] = 0;
							    VehicleInfo[p][spawned] = 1;
							    VehicleInfo[p][destroyed] = 0;
					 	   		VehicleInfo[p][idnum] = CreateVehicle(VehicleInfo[p][model], VehicleInfo[p][x_spawn], VehicleInfo[p][y_spawn], VehicleInfo[p][z_spawn], VehicleInfo[p][za_spawn], VehicleInfo[p][color_1], VehicleInfo[p][color_2],20000);
                                registered[VehicleInfo[p][idnum]] = 1;
								avstream[VehicleInfo[p][idnum]] = p;
								SetTimerEx("ModVehicle",100,0,"i",p);
								if(VehicleInfo[p][worldid] > 0) {
    								SetVehicleVirtualWorld(VehicleInfo[p][idnum],VehicleInfo[p][worldid]);
        						}
								if(VehicleInfo[p][intid] > 0) {
			    					LinkVehicleToInterior(VehicleInfo[p][idnum],VehicleInfo[p][intid]);
								}
								UpdateVehicleParams(p);
								Vstreamcount++;
							}
						}
				}
			}
    	}
 	}
}

stock GetPointSector(Float:x,Float:y)
{
	new xsec = floatround(((x +4000) / 500), floatround_floor);
	new ysec = floatround(((y +4000) / 500), floatround_floor);
	return (xsec * 16) + ysec;
}

public ModVehicle(streamid)
{
	if(VehicleInfo[streamid][mod1] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod1]);}
	}
	if(VehicleInfo[streamid][mod2] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod2]);}
	}
	if(VehicleInfo[streamid][mod3] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod3]);}
	}
	if(VehicleInfo[streamid][mod4] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod4]);}
	}
	if(VehicleInfo[streamid][mod5] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod5]);}
	}
	if(VehicleInfo[streamid][mod6] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod6]);}
	}
	if(VehicleInfo[streamid][mod7] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod7]);}
	}
	if(VehicleInfo[streamid][mod8] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod8]);}
	}
	if(VehicleInfo[streamid][mod9] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod9]);}
	}
	if(VehicleInfo[streamid][mod10] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod10]);}
	}
	if(VehicleInfo[streamid][mod11] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod11]);}
	}
	if(VehicleInfo[streamid][mod12] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod12]);}
	}
	if(VehicleInfo[streamid][mod13] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod13]);}
	}
	if(VehicleInfo[streamid][mod14] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod14]);}
	}
	if(VehicleInfo[streamid][mod15] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod15]);}
	}
	if(VehicleInfo[streamid][mod16] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod16]);}
	}
	if(VehicleInfo[streamid][mod17] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod17]);}
	}
	if(VehicleInfo[streamid][color_1] > -1 || VehicleInfo[streamid][color_2] > -1) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {ChangeVehicleColor(VehicleInfo[streamid][idnum],VehicleInfo[streamid][color_1],VehicleInfo[streamid][color_2]);}
 	}
	if(VehicleInfo[streamid][paintjob] > -1) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][limbo] == 0) {ChangeVehiclePaintjob(VehicleInfo[streamid][idnum],VehicleInfo[streamid][paintjob]);}
 	}
}

public RemoveTempVehicle(vehicleid)
{
	new i = GetVehicleStreamID(vehicleid);
	DestroyVehicle(vehicleid);
	vehused[vehicleid] = 0;
	VehicleInfo[i][limbo] = 0;
	VehicleInfo[i][valid] = 0;
	return 1;
}

public DeathProcess(vehicleid)
{
	new i = GetVehicleStreamID(vehicleid);
	if(VehicleInfo[i][destroyed] == 1) {
	    VehicleInfo[i][valid] = 0;
	    DestroyVehicle(vehicleid);
	    return 1;
	}
	DestroyVehicle(vehicleid);
	VehicleInfo[i][idnum] = CreateVehicle(VehicleInfo[i][model], VehicleInfo[i][x_spawn], VehicleInfo[i][y_spawn], VehicleInfo[i][z_spawn], VehicleInfo[i][za_spawn], VehicleInfo[i][color_1], VehicleInfo[i][color_2],20000);
    if(VehicleInfo[i][worldid] > 0) {
    	SetVehicleVirtualWorld(VehicleInfo[i][idnum],VehicleInfo[i][worldid]);
	}
	if(VehicleInfo[i][intid] > 0) {
		LinkVehicleToInterior(VehicleInfo[i][idnum],VehicleInfo[i][intid]);
	}
	UpdateVehicleParams(i);
	avstream[VehicleInfo[i][idnum]] = i;
 	SetTimerEx("ModVehicle",100,0,"i",i);
	vehused[vehicleid] = 0;
	VehicleInfo[i][limbo] = 0;
	return 1;
}

public SafeForceSpawn(vstreamid)
{
	new i = vstreamid;
	if(VehicleInfo[i][spawned] == 1) {
		VehicleInfo[i][spawned] = 0;
		DestroyVehicle(VehicleInfo[i][idnum]);
		if(Abandoned[VehicleInfo[i][idnum]] == 1) {
			Abandoned[VehicleInfo[i][idnum]] = 0;
			KillTimer(atimer[VehicleInfo[i][idnum]]);
		}
		registered[VehicleInfo[i][idnum]] = 0;
		vehused[VehicleInfo[i][idnum]] = 0;
		Vstreamcount--;
		VehicleInfo[i][idnum] = 0;
   	}
	ForceStreamVehicleSpawn(i,tmpx[i],tmpy[i],tmpz[i],tmpa[i],tmpworld[i],tmpinterior[i],tmpobjective[i],tmpmod[i]);
	return 1;
}

stock PlayerClose(playerid,Float:x,Float:y,Float:z,Float:MAX)
{
	new Float:PPos[3];
	if(IsPlayerConnected(playerid)) {
			GetPlayerPos(playerid, PPos[0], PPos[1], PPos[2]);
			if (PPos[0] >= floatsub(x, MAX) && PPos[0] <= floatadd(x, MAX)
			&& PPos[1] >= floatsub(y, MAX) && PPos[1] <= floatadd(y, MAX)
			&& PPos[2] >= floatsub(z, MAX) && PPos[2] <= floatadd(z, MAX))
			{
				return 1;
			}
	}
	return 0;
}

stock PlayersClose(Float:x,Float:y,Float:z,Float:MAX)
{
	new Float:PPos[3];
	for(new i = 0;i<MAX_PLAYERS;i++) {
		if(IsPlayerConnected(i)) {
			GetPlayerPos(i, PPos[0], PPos[1], PPos[2]);
			if (PPos[0] >= floatsub(x, MAX) && PPos[0] <= floatadd(x, MAX)
			&& PPos[1] >= floatsub(y, MAX) && PPos[1] <= floatadd(y, MAX)
			&& PPos[2] >= floatsub(z, MAX) && PPos[2] <= floatadd(z, MAX))
			{
				return 1;
			}
		}
	}
	return 0;
}

public InitiateSectorSystem()
{
	SetTimer("SectorScan",1000,1);
	return 1;
}

stock UpdateVehicleSectorInfo()
{
    new secnum;
	for(new i = 0;i<MAX_SECTORS;i++) {
	    SectorVehicleCount[i] = 0;
	}
   	for(new i = 1;i<MAX_STREAM_VEHICLES;i++) {
	    if(VehicleInfo[i][valid] == 1) {
			secnum = GetVehicleSpawnSector(i);
			SectorVehicleCount[secnum]++;
			SectorVehicles[secnum][SectorVehicleCount[secnum]] = i;
		}
	}
	return 1;
}

stock CreateStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2)
{
	for(new i = 1;i<MAX_STREAM_VEHICLES;i++) {
	    if(VehicleInfo[i][valid] == 0) {
			VehicleInfo[i][model] = modelid;
			VehicleInfo[i][x_spawn] = x;
			VehicleInfo[i][y_spawn] = y;
			VehicleInfo[i][z_spawn] = z;
			VehicleInfo[i][za_spawn] = a;
			VehicleInfo[i][color_1] = col1;
			VehicleInfo[i][color_2] = col2;
			VehicleInfo[i][valid] = 1;
			VehicleInfo[i][idnum] = 0;
			VehicleInfo[i][paintjob] = -1;
			VehicleInfo[i][temporary] = 0;
			if(VehicleInfo[i][id_prev_used] == 0) {
			    vehcount++;
			}
			UpdateVehicleSectorInfo();
			return i;
		}
	}
	return 0;
}

stock DestroyStreamVehicle(vstreamid)
{
    VehicleInfo[vstreamid][destroyed] = 1;
    VehicleInfo[vstreamid][valid] = 0;
    VehicleInfo[vstreamid][id_prev_used] = 1;
    VehicleInfo[vstreamid][mod1] = 0;
    VehicleInfo[vstreamid][mod2] = 0;
    VehicleInfo[vstreamid][mod3] = 0;
    VehicleInfo[vstreamid][mod4] = 0;
    VehicleInfo[vstreamid][mod5] = 0;
    VehicleInfo[vstreamid][mod6] = 0;
    VehicleInfo[vstreamid][mod7] = 0;
    VehicleInfo[vstreamid][mod8] = 0;
    VehicleInfo[vstreamid][mod9] = 0;
    VehicleInfo[vstreamid][mod10] = 0;
    VehicleInfo[vstreamid][mod11] = 0;
    VehicleInfo[vstreamid][mod12] = 0;
    VehicleInfo[vstreamid][mod13] = 0;
    VehicleInfo[vstreamid][mod14] = 0;
    VehicleInfo[vstreamid][mod15] = 0;
    VehicleInfo[vstreamid][mod16] = 0;
    VehicleInfo[vstreamid][mod17] = 0;
    VehicleInfo[vstreamid][paintjob] = -1;
	if(VehicleInfo[vstreamid][spawned] == 1) {
    	SetVehicleToRespawn(VehicleInfo[vstreamid][idnum]);
    	SetVehicleVirtualWorld(VehicleInfo[vstreamid][idnum],9)
    	SetTimerEx("DeathProcess",6000,0,"x",VehicleInfo[vstreamid][idnum]);
	}
	UpdatevehicleSectorInfo();
    return 1;
}

stock SetStreamVehicleToRespawn(vstreamid)
{
	if(VehicleInfo[vstreamid][spawned] == 1 && vehused[VehicleInfo[vstreamid][idnum]] == 1) {
		SetVehicleToRespawn(VehicleInfo[vstreamid][idnum]);
		SetVehicleVirtualWorld(VehicleInfo[vstreamid][idnum],9);
		SetTimerEx("DeathProcess",4500,0,"x",VehicleInfo[vstreamid][idnum]);
	}
	else if(VehicleInfo[vstreamid][spawned] == 1 && vehused[VehicleInfo[vstreamid][idnum]] == 0) {
		SetVehicleToRespawn(VehicleInfo[vstreamid][idnum]);
		SetTimerEx("ModVehicle",150,0,"i",vstreamid);
	}
	return 1;
}

stock CreateTempStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2)
{
	for(new i = 1;i<MAX_STREAM_VEHICLES;i++) {
	    if(VehicleInfo[i][valid] == 0) {
			VehicleInfo[i][model] = modelid;
			VehicleInfo[i][x_spawn] = x;
			VehicleInfo[i][y_spawn] = y;
			VehicleInfo[i][z_spawn] = z;
			VehicleInfo[i][za_spawn] = a;
			VehicleInfo[i][color_1] = col1;
			VehicleInfo[i][color_2] = col2;
			VehicleInfo[i][valid] = 1;
			VehicleInfo[i][idnum] = 0;
			VehicleInfo[i][paintjob] = -1;
			VehicleInfo[i][temporary] = 1;
			if(VehicleInfo[i][id_prev_used] == 0) {
			    vehcount++;
			}
			UpdateVehicleSectorInfo();
			return i;
		}
	}
	return 0;
}

stock SetVehicleStreamSpawnInfo(vstreamid,vmodel,Float:x,Float:y,Float:z,Float:a,color1,color2)
{
	if(VehicleInfo[vstreamid][valid] == 1) {
	    VehicleInfo[vstreamid][model] = vmodel;
	    VehicleInfo[vstreamid][x_spawn] = x;
	    VehicleInfo[vstreamid][y_spawn] = y;
	    VehicleInfo[vstreamid][z_spawn] = z;
	    VehicleInfo[vstreamid][za_spawn] = a;
	    VehicleInfo[vstreamid][color_1] = color1;
	    VehicleInfo[vstreamid][color_2] = color2;
	    UpdateVehicleSectorInfo();
	    return 1;
	}
	return 0;
}

stock ForceStreamVehicleSpawn(vstreamid,Float:x,Float:y,Float:z,Float:a,world_id,interiorid,objective,UseSavedMods)
{
	new p = vstreamid;
	VehicleInfo[p][fspawn] = 1;
    if(VehicleInfo[p][valid] == 1) {
		if(VehicleInfo[p][spawned] == 0) {
			if(Vstreamcount < MAX_ACTIVE_VEHICLES) {
				if(IsModelActive(VehicleInfo[p][model]) == 0) {
	      		 	if(CountModels() < MAX_ACTIVE_MODELS) {
	   		 	    	VehicleInfo[p][spawned] = 1;
	    		 	    VehicleInfo[p][destroyed] = 0;
						VehicleInfo[p][idnum] = CreateVehicle(VehicleInfo[p][model], x, y, z, a, VehicleInfo[p][color_1], VehicleInfo[p][color_2],20000);
	   					registered[VehicleInfo[p][idnum]] = 1;
						avstream[VehicleInfo[p][idnum]] = p;
						if(UseSavedMods == 1) {
							SetTimerEx("ModVehicle",100,0,"i",p);
						}
						if(world_id > 0) {
		    				SetVehicleVirtualWorld(VehicleInfo[p][idnum],world_id);
						}
						if(interiorid > 0) {
		    				LinkVehicleToInterior(VehicleInfo[p][idnum],interiorid);
						}
						for(new s=0; s<MAX_PLAYERS; s++) {
						    SetVehicleParamsForPlayer(VehicleInfo[p][idnum],s,objective,0);
						}
						Vstreamcount++;
					}
				}
				else {
	   				VehicleInfo[p][spawned] = 1;
				    VehicleInfo[p][destroyed] = 0;
	 	   			VehicleInfo[p][idnum] = CreateVehicle(VehicleInfo[p][model], x, y, z, a, VehicleInfo[p][color_1], VehicleInfo[p][color_2],20000);
	       			registered[VehicleInfo[p][idnum]] = 1;
					avstream[VehicleInfo[p][idnum]] = p;
					SetTimerEx("ModVehicle",100,0,"i",p);
					if(world_id > 0) {
						SetVehicleVirtualWorld(VehicleInfo[p][idnum],world_id);
					}
					if(interiorid > 0) {
		    			LinkVehicleToInterior(VehicleInfo[p][idnum],interiorid);
					}
					for(new s=0; s<MAX_PLAYERS; s++) {
	    				SetVehicleParamsForPlayer(VehicleInfo[p][idnum],s,objective,0);
					}
					Vstreamcount++;
				}
			}
		}
		else {
		    tmpx[p] = x;
		    tmpy[p] = y;
		    tmpz[p] = z;
		    tmpa[p] = a;
		    tmpworld[p] = world_id;
		    tmpinterior[p] = interiorid;
		    tmpobjective[p] = objective;
		    tmpmod[p] = UseSavedMods;
		    SetVehicleToRespawn(VehicleInfo[p][idnum]);
		    SetVehicleVirtualWorld(VehicleInfo[p][idnum],99);
			SetTimerEx("SafeForceSpawn",3000,0,"i",p);
		}
	}
}

stock SetStreamVehiclePos(vstreamid,Float:x,Float:y,Float:z,Float:a)
{
	if(VehicleInfo[vstreamid][valid] == 1) {
	    if(VehicleInfo[vstreamid][spawned] == 1) {
	        SetVehiclePos(VehicleInfo[vstreamid][idnum],x,y,z);
	        SetVehicleZAngle(VehicleInfo[vstreamid][idnum],a);
	        return 1;
	    }
	}
	return 0;
}

stock ChangeStreamVehiclePaintjob(vstreamid,paintjobid)
{
    if(VehicleInfo[vstreamid][valid] == 1) {
        VehicleInfo[vstreamid][paintjob] = paintjobid;
        if(VehicleInfo[vstreamid][spawned] == 1) {
            ChangeVehiclePaintjob(VehicleInfo[vstreamid][idnum],paintjobid);
        }
        return 1;
    }
    return 0;
}

stock ChangeStreamVehicleColor(vstreamid,col1,col2)
{
    if(VehicleInfo[vstreamid][valid] == 1) {
        VehicleInfo[vstreamid][color_1] = col1;
        VehicleInfo[vstreamid][color_2] = col2;
        if(VehicleInfo[vstreamid][spawned] == 1) {
            ChangeVehicleColor(VehicleInfo[vstreamid][idnum],col1,col2);
        }
        return 1;
    }
    return 0;
}

stock AddStreamVehicleMod(vstreamid,componentid)
{
	if(VehicleInfo[vstreamid][valid] == 1) {
	    for(new s=0; s<20; s++) {
   			if(componentid == spoiler[s][0]) {
   				VehicleInfo[vstreamid][mod1] = componentid;
   	   		}
		}
		for(new s=0; s<3; s++) {
			if(componentid == nitro[s][0]) {
				VehicleInfo[vstreamid][mod2] = componentid;
    		}
		}
		for(new s=0; s<23; s++) {
			if(componentid == fbumper[s][0]) {
					VehicleInfo[vstreamid][mod3] = componentid;
    		}
		}
		for(new s=0; s<22; s++) {
			if(componentid == rbumper[s][0]) {
				VehicleInfo[vstreamid][mod4] = componentid;
	  		}
		}
		for(new s=0; s<28; s++) {
			if(componentid == exhaust[s][0]) {
				VehicleInfo[vstreamid][mod5] = componentid;
     		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == bventr[s][0]) {
				VehicleInfo[vstreamid][mod6] = componentid;
	   		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == bventl[s][0]) {
				VehicleInfo[vstreamid][mod7] = componentid;
   			}
		}
		for(new s=0; s<4; s++) {
			if(componentid == bscoop[s][0]) {
				VehicleInfo[vstreamid][mod8] = componentid;
			}
		}
		for(new s=0; s<13; s++) {
			if(componentid == rscoop[s][0]) {
				VehicleInfo[vstreamid][mod9] = componentid;
   			}
		}
		for(new s=0; s<21; s++) {
			if(componentid == lskirt[s][0]) {
				VehicleInfo[vstreamid][mod10] = componentid;
    		}
		}
		for(new s=0; s<21; s++) {
			if(componentid == rskirt[s][0]) {
				VehicleInfo[vstreamid][mod11] = componentid;
   			}
		}
		for(new s=0; s<1; s++) {
			if(componentid == hydraulics[s][0]) {
				VehicleInfo[vstreamid][mod12] = componentid;
    		}
		}
		for(new s=0; s<1; s++) {
			if(componentid == base[s][0]) {
				VehicleInfo[vstreamid][mod13] = componentid;
    		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == rbbars[s][0]) {
				VehicleInfo[vstreamid][mod14] = componentid;
     		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == fbbars[s][0]) {
				VehicleInfo[vstreamid][mod15] = componentid;
     		}
		}
		for(new s=0; s<17; s++) {
			if(componentid == wheels[s][0]) {
				VehicleInfo[vstreamid][mod16] = componentid;
    		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == lights[s][0]) {
				VehicleInfo[vstreamid][mod17] = componentid;
	  		}
		}
	    if(VehicleInfo[vstreamid][spawned] == 1) {
	        AddVehicleComponent(VehicleInfo[vstreamid][idnum],componentid);
	    }
	    return 1;
	}
	return 0;
}

stock GetPlayerVehicleStreamID(playerid)
{
	return avstream[GetPlayerVehicleID(playerid)];
}

stock GetVehicleStreamID(vehicleid)
{
	return avstream[vehicleid];
}

stock SetVehicleUsed(vehicleid,bool:toggle)
{
	vehused[vehicleid] = toggle;
	return 1;
}

stock tAxI_OnVehicleDeath(vehicleid)
{
    if(Abandoned[vehicleid] == 1) {
	    Abandoned[vehicleid] = 0;
	 	KillTimer(atimer[vehicleid]);
	}
	VehicleInfo[GetVehicleStreamID(vehicleid)][limbo] = 1;
	if(VehicleInfo[GetVehicleStreamID(vehicleid)][temporary] == 1) {
	    SetTimerEx("RemoveTempVehicle",10000,0,"x",vehicleid);
	}
	else {
		SetTimerEx("DeathProcess",10000,0,"x",vehicleid);
	}
}

stock tAxI_OnGameModeInit()
{
    SetTimer("InitiateSectorSystem",5000,0);
	return 1;
}

stock tAxI_OnPlayerEnterVehicle(playerid,vehicleid)
{
	lastv[playerid] = vehicleid;
	if(Abandoned[vehicleid] == 1) {
	    Abandoned[vehicleid] = 0;
	 	KillTimer(atimer[vehicleid]);
	}
    SetVehicleUsed(vehicleid,true);
	return 1;
}

stock CountModels()
{
	new modelcount = 0;
	new modelcounted[700];
    for(new i = 1;i<MAX_STREAM_VEHICLES;i++) {
        if(VehicleInfo[i][spawned] == 1) {
            if(modelcounted[VehicleInfo[i][model]] == 0) {
                modelcount++;
                modelcounted[VehicleInfo[i][model]] = 1;
            }
        }
    }
    return modelcount;
}

stock IsModelActive(vmodel)
{
    for(new i = 1;i<vehcount;i++) {
        if(VehicleInfo[i][spawned] == 1) {
            if(VehicleInfo[i][model] == vmodel) {
                return 1;
            }
        }
    }
    return 0;
}

stock tAxI_OnVehicleMod(vehicleid,componentid)
{
	if(Automodsave == true) {
	    AddStreamVehicleMod(GetVehicleStreamID(vehicleid),componentid);
	}
	return 1;
}

stock tAxI_OnVehiclePaintjob(vehicleid,paintjobid)
{
	if(Automodsave == true) {
	    ChangeStreamVehiclePaintjob(GetVehicleStreamID(vehicleid),paintjobid);
	}
	return 1;
}

stock tAxI_OnVehicleRespray(vehicleid,color1,color2)
{
	if(Automodsave == true) {
	    ChangeStreamVehicleColor(GetVehicleStreamID(vehicleid),color1,color2);
	}
	return 1;
}

stock ToggleAutoModSave(bool:toggle)
{
    Automodsave = toggle;
}

stock tAxI_OnVehicleSpawn(vehicleid)
{
	SetTimerEx("ConvertVehicleToStream",50,0,"x",vehicleid);
}

public ConvertVehicleToStream(vehicleid)
{
    if(registered[vehicleid] == 0) {
		new Float:VP[4],VM,VW;
		new vid;
		GetVehiclePos(vehicleid,VP[0],VP[1],VP[2]);
		GetVehicleZAngle(vehicleid,VP[3]);
		VM = GetVehicleModel(vehicleid);
		VW = GetVehicleVirtualWorld(vehicleid);
		DestroyVehicle(vehicleid);
		vid = CreateStreamVehicle(VM,VP[0],VP[1],VP[2],VP[3],0,0);
		SetStreamVehicleVirtualWorld(vid,VW);
	}
}

stock GetStreamVehicleID(vstreamid)
{
	if(VehicleInfo[vstreamid][spawned] == 0) {
	    return 999;
	}
	return VehicleInfo[vstreamid][idnum];
}

stock GetStreamVehicleVirtualWorld(vstreamid)
{
	return VehicleInfo[vstreamid][worldid];
}

stock GetVehicleStreamModel(vstreamid)
{
	return VehicleInfo[vstreamid][model];
}

stock tAxI_OnPlayerStateChange(playerid,newstate,oldstate)
{
	if (oldstate == PLAYER_STATE_DRIVER) {
 		if(antifall[playerid] == 1 && newstate == PLAYER_STATE_ONFOOT) {
    		if(cmdoff[playerid] == 1) {
     			cmdoff[playerid] = 0;
     		}
      		else {
       			PutPlayerInVehicle(playerid,lastv[playerid],0);
			}
       	}
    }
    if (oldstate == PLAYER_STATE_PASSENGER) {
 		if(antifall[playerid] == 1 && newstate == PLAYER_STATE_ONFOOT) {
    		if(cmdoff[playerid] == 1) {
     			cmdoff[playerid] = 0;
     		}
      		else {
       			PutPlayerInVehicle(playerid,lastv[playerid],1);
			}
       	}
    }
}

stock tAxI_OnPlayerExitVehicle(vehicleid)
{
	new v = GetVehicleStreamID(vehicleid);
	Abandoned[vehicleid] = 1;
	atimer[vehicleid] = SetTimerEx("ResetAbandonedVehicle",300000,0,"x",v);
	return 1;
}

public ResetAbandonedVehicle(vstreamid)
{
	if(Abandoned[GetStreamVehicleID(vstreamid)] == 1) {
    	if(VehicleInfo[vstreamid][temporary] == 1) {
		    RemoveTempVehicle(GetStreamVehicleID(vstreamid));
		}
		else {
			DeathProcess(GetStreamVehicleID(vstreamid));
		}
	}
}

stock SetBikeAntiFallForPlayer(playerid,bool:toggle)
{
    if(toggle == true) {
        antifall[playerid] = 1;
        cmdoff[playerid] = 0;
        return SendClientMessage(playerid,BLUE,"Your bike Anti-Fall is now active!");
    }
    if(toggle == false) {
        antifall[playerid] = 0;
        cmdoff[playerid] = 0;
        return SendClientMessage(playerid,RED,"Your bike Anti-Fall is now inactive!");
    }
    return 1;
}

stock tAxI_OnPlayerKeyStateChange(playerid,newkeys)
{
	if(newkeys == KEY_EXIT_VEHICLE) {
		cmdoff[playerid] = 1;
	}
	return 1;
}

stock GetStreamVehiclePos(vstreamid,&Xpos,&Ypos,&Zpos)
{
	if(VehicleInfo[vstreamid][valid] == 1) {
		if(VehicleInfo[vstreamid][spawned] == 1) {
	    	GetVehiclePos(VehicleInfo[vstreamid][idnum],Xpos,Ypos,Zpos);
		}
		else {
            Xpos = VehicleInfo[vstreamid][x_spawn];
            Ypos = VehicleInfo[vstreamid][y_spawn];
            Zpos = VehicleInfo[vstreamid][z_spawn];
		}
	}
	return 0;
}

stock GetStreamVehicleZAngle(vstreamid,&Z_Angle)
{
	if(VehicleInfo[vstreamid][valid] == 1) {
		if(VehicleInfo[vstreamid][spawned] == 1) {
	    	GetVehicleZAngle(VehicleInfo[vstreamid][idnum],Z_Angle);
		}
		else {
            Z_Angle = VehicleInfo[vstreamid][za_spawn];
		}
	}
	return 0;
}


//-----------==<<:: Credits to On_Top_Non_Stop for SetStreamVehicleHealth ::>>==------------//

stock SetStreamVehicleHealth(vstreamid,Float:health)
{
	if(VehicleInfo[vstreamid][valid] == 1) {
	    if(VehicleInfo[vstreamid][spawned] == 1) {
	        SetVehicleHealth(VehicleInfo[vstreamid][idnum],health);
	        return 1;
	    }
	}
	return 0;
}

stock PutPlayerInStreamVehicle(playerid,vstreamid,seatnum)
{
	if(VehicleInfo[vstreamid][valid] == 1) {
	    if(VehicleInfo[vstreamid][spawned] == 1) {
	        PutPlayerInVehicle(playerid,VehicleInfo[vstreamid][idnum],seatnum);
	        return 1;
	    }
	}
	return 0;
}
