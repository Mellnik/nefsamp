/*
native StartStreaming()
native SetVehicleUsed(vehicleid,bool:toggle)
native ResetVehicleStream(vehicleid)
native ResetVehicleStreamCar(vehicleid)
native CreateStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2,spawn_distance)
native CreateTempStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2,spawn_distance)
native GetPlayerVehicleStreamID(playerid)
native GetVehicleStreamID(vehicleid)
native SetVehicleStreamPos(vstreamid,Float:x,Float:y,Float:z,Float:a)
native SetVehicleStreamModel(vstreamid,model)
native ChangeStreamVehiclePaintjob(vstreamid,paintjobid)
native ChangeStreamVehicleColor(vstreamid,col1,col2)
native AddStreamVehicleComponent(vstreamid,componentid)
native CreateStreamMapIcon(markermodel,Float:x,Float:y,Float:z,Float:spawn_distance);
native ChangeMapIconModel(streamid,newmodel)
native CreateStreamPickup(model,ptype,Float:x,Float:y,Float:z,Float:spawn_distance);
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

#define MAX_MODEL_NUMBER 212
#define MAX_STREAM_VEHICLES 2500
#define MAX_ACTIVE_VEHICLES 695
#define MAX_ACTIVE_PICKUPS 250
#define MAX_ACTIVE_MODELS 68
#define MAX_ACTIVE_MM_ICONS 32
#define P_LIMIT 2500
#define MM_LIMIT 2500

new Vstreamcount = 0;
new vehused[MAX_ACTIVE_VEHICLES];
new MMstreamcount[MAX_PLAYERS];
new MIactive[MAX_PLAYERS][MM_LIMIT];
new MIidnum[MAX_PLAYERS][MM_LIMIT];
new PUstreamcount = 0;
new avstream [MAX_ACTIVE_VEHICLES];
new pickupcount = 0;
new mmcount = 0;

enum mmapinfo
{
	mmodel,
	Float:mx_spawn,
	Float:my_spawn,
	Float:mz_spawn,
	Float:mspawndist,
	mvalid,
};
new MapIconInfo[MM_LIMIT][mmapinfo];

enum PInfo
{
	model,
	Float:x_spawn,
	Float:y_spawn,
	Float:z_spawn,
	spawned,
	spawndist,
	idnum,
	valid,
	type,
};
new PickupInfo[P_LIMIT][PInfo];

enum vInfo
{
	limbo,
	fspawn,
	reset,
	model,
	Float:x_spawn,
	Float:y_spawn,
	Float:z_spawn,
 	Float:za_spawn,
 	color_1,
 	color_2,
	vused,
	spawned,
	idnum,
	Float:spawndist,
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
 	modding,
 	temporary,
};

new VehicleInfo[MAX_STREAM_VEHICLES][vInfo];
new vehcount = 0;

forward vehiclestreamer();
forward pickupstreamer();
forward minimapstreamer();
forward DeathProcess(vehicleid);
forward ModVehicle(streamid);
forward DeathProcess2(vehicleid);

stock StartStreaming()
{
    SetTimer("vehiclestreamer",100,1);
	SetTimer("minimapstreamer",100,1);
	SetTimer("pickupstreamer",100,1);
}

public vehiclestreamer()
{
    for(new i = 1;i<vehcount;i++) {
		if(VehicleInfo[i][limbo] == 0 && VehicleInfo[i][valid] == 1) {
			if(VehicleInfo[i][spawned] == 0 && PlayersInRangeV(i,VehicleInfo[i][spawndist]) == 1) {
			    if(Vstreamcount < MAX_ACTIVE_VEHICLES) {
			        if(IsModelActive(VehicleInfo[i][model]) == 0) {
			            if(CountModels(vehcount) < MAX_ACTIVE_MODELS) {
							VehicleInfo[i][idnum] = CreateVehicle(VehicleInfo[i][model], VehicleInfo[i][x_spawn], VehicleInfo[i][y_spawn], VehicleInfo[i][z_spawn], VehicleInfo[i][za_spawn], VehicleInfo[i][color_1], VehicleInfo[i][color_2],20000);
							avstream[VehicleInfo[i][idnum]] = i;
							SetTimerEx("ModVehicle",100,0,"i",i);
							VehicleInfo[i][spawned] = 1;
							Vstreamcount++;
						}
					}
					else if(IsModelActive(VehicleInfo[i][model]) == 1) {
					    VehicleInfo[i][idnum] = CreateVehicle(VehicleInfo[i][model], VehicleInfo[i][x_spawn], VehicleInfo[i][y_spawn], VehicleInfo[i][z_spawn], VehicleInfo[i][za_spawn], VehicleInfo[i][color_1], VehicleInfo[i][color_2],20000);
						avstream[VehicleInfo[i][idnum]] = i;
						SetTimerEx("ModVehicle",100,0,"i",i);
						VehicleInfo[i][spawned] = 1;
						Vstreamcount++;
					}
				}
			}
			else if(VehicleInfo[i][spawned] == 1 && PlayersInRangeV(i,VehicleInfo[i][spawndist]) == 0 && vehused[VehicleInfo[i][idnum]] == 0) {
     			DestroyVehicle(VehicleInfo[i][idnum]);
				VehicleInfo[i][spawned] = 0;
				vehused[VehicleInfo[i][idnum]] = 0;
				Vstreamcount--;
				VehicleInfo[i][idnum] = 0;
			}
		}
	}
}

public pickupstreamer()
{
    for(new i = 0;i<pickupcount;i++) {
		if(PickupInfo[i][spawned] == 0 && PickupInfo[i][valid] == 1) {
			if(PlayersInRangePU(i,PickupInfo[i][spawndist]) == 1) {
			    if(PUstreamcount < MAX_ACTIVE_PICKUPS) {
						PickupInfo[i][idnum] = CreatePickup(PickupInfo[i][model],2, PickupInfo[i][x_spawn], PickupInfo[i][y_spawn], PickupInfo[i][z_spawn]);
						PickupInfo[i][spawned] = 1;
						PUstreamcount++;
				}
			}
		}
		else if(PlayersInRangePU(i,PickupInfo[i][spawndist]) == 0) {
		    DestroyPickup(PickupInfo[i][idnum]);
			PickupInfo[i][spawned] = 0;
			PUstreamcount--;
			PickupInfo[i][idnum] = -1;
		}
	}
}

public minimapstreamer()
{
	for(new j = 0;j<MAX_PLAYERS;j++) {
 		if(IsPlayerConnected(j)) {
			for(new K = 1;K<mmcount;K++) {
			    if(MapIconInfo[K][mvalid] == 1) {
					if(MIactive[j][K] == 0) {
					   	if(MMstreamcount[j] < MAX_ACTIVE_MM_ICONS) {
							if(IsPlayerClose(j,MapIconInfo[K][mx_spawn],MapIconInfo[K][my_spawn],MapIconInfo[K][mz_spawn],MapIconInfo[K][mspawndist]) == 1) {
								SetPlayerMapIcon(j,MIidnum[j][K],MapIconInfo[K][mx_spawn],MapIconInfo[K][my_spawn],MapIconInfo[K][mz_spawn],MapIconInfo[K][mmodel],1);
								MMstreamcount[j]++;
								MIactive[j][K] = 1;
							}
						}
					}
					else if(IsPlayerClose(j,MapIconInfo[K][mx_spawn],MapIconInfo[K][my_spawn],MapIconInfo[K][mz_spawn],MapIconInfo[K][mspawndist]) == 0) {
						RemovePlayerMapIcon(j,MIidnum[j][K]);
						MIactive[j][K] = 0;
						MMstreamcount[j]--;
					}
				}
			}
		}
	}
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

public DeathProcess2(vehicleid)
{
	new i = GetVehicleStreamID(vehicleid);
	DestroyVehicle(vehicleid);
	VehicleInfo[i][fspawn] = 0;
	vehused[vehicleid] = 0;
	VehicleInfo[i][limbo] = 0;
	VehicleInfo[i][valid] = 0;
	return 1;
}

public DeathProcess(vehicleid)
{
	new i = GetVehicleStreamID(vehicleid);
	DestroyVehicle(vehicleid);
	VehicleInfo[i][idnum] = CreateVehicle(VehicleInfo[i][model], VehicleInfo[i][x_spawn], VehicleInfo[i][y_spawn], VehicleInfo[i][z_spawn], VehicleInfo[i][za_spawn], VehicleInfo[i][color_1], VehicleInfo[i][color_2],20000);
    avstream[VehicleInfo[i][idnum]] = i;
 	SetTimerEx("ModVehicle",100,0,"i",i);
	VehicleInfo[i][fspawn] = 0;
	vehused[vehicleid] = 0;
	VehicleInfo[i][limbo] = 0;
	return 1;
}

stock PlayersInRangeV(streamid,Float:MAX)
{
	for(new i = 0;i<MAX_PLAYERS;i++) {
   	    if(IsPlayerConnected(i)) {
   	        new Float:PPos[3];
  			GetPlayerPos(i, PPos[0], PPos[1], PPos[2]);
			if (PPos[0] >= floatsub(VehicleInfo[streamid][x_spawn], MAX) && PPos[0] <= floatadd(VehicleInfo[streamid][x_spawn], MAX)
			&& PPos[1] >= floatsub(VehicleInfo[streamid][y_spawn], MAX) && PPos[1] <= floatadd(VehicleInfo[streamid][y_spawn], MAX)
			&& PPos[2] >= floatsub(VehicleInfo[streamid][z_spawn], MAX) && PPos[2] <= floatadd(VehicleInfo[streamid][z_spawn], MAX))
			{
				return 1;
			}
		}
	}
	return 0;
}

stock PlayersInRangePU(streamid,Float:MAX)
{
	for(new i = 0;i<MAX_PLAYERS;i++) {
   	    if(IsPlayerConnected(i)) {
   	        new Float:PPos[3];
  			GetPlayerPos(i, PPos[0], PPos[1], PPos[2]);
			if (PPos[0] >= floatsub(PickupInfo[streamid][x_spawn], MAX) && PPos[0] <= floatadd(PickupInfo[streamid][x_spawn], MAX)
			&& PPos[1] >= floatsub(PickupInfo[streamid][y_spawn], MAX) && PPos[1] <= floatadd(PickupInfo[streamid][y_spawn], MAX)
			&& PPos[2] >= floatsub(PickupInfo[streamid][z_spawn], MAX) && PPos[2] <= floatadd(PickupInfo[streamid][z_spawn], MAX))
			{
				return 1;
			}
		}
	}
	return 0;
}

stock CreateStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2,Float:spawn_distance)
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
			VehicleInfo[i][spawndist] = spawn_distance;
			VehicleInfo[i][valid] = 1;
			VehicleInfo[i][idnum] = 0;
			VehicleInfo[i][paintjob] = -1;
			VehicleInfo[i][temporary] = 0;
			vehcount++;
			return i;
		}
	}
	return 0;
}

stock CreateTempStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2,Float:spawn_distance)
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
			VehicleInfo[i][spawndist] = spawn_distance;
			VehicleInfo[i][valid] = 1;
			VehicleInfo[i][idnum] = 0;
			VehicleInfo[i][paintjob] = -1;
			VehicleInfo[i][temporary] = 1;
			vehcount++;
			return i;
		}
	}
	return 0;
}

stock SetVehicleStreamPos(vstreamid,Float:x,Float:y,Float:z,Float:a)
{
	if(VehInfo[vstreamid][valid] == 1) {
	    VehInfo[vstreamid][x_spawn] = x;
	    VehInfo[vstreamid][y_spawn] = y;
	    VehInfo[vstreamid][z_spawn] = z;
	    VehInfo[vstreamid][za_spawn] = a;
	    return 1;
	}
	return 0;
}

stock SetVehicleStreamModel(vstreamid,smodel)
{
	if(VehInfo[vstreamid][valid] == 1) {
	    VehInfo[vstreamid][model] = smodel;
	    return 1;
	}
	return 0;
}

stock ChangeStreamVehiclePaintjob(vstreamid,paintjobid)
{
    if(VehInfo[vstreamid][valid] == 1) {
        VehInfo[vstreamid][paintjob] = paintjobid;
        if(VehInfo[vstreamid][spawned] == 1) {
            ChangeVehiclePaintjob(VehInfo[vstreamid][idnum],paintjobid);
        }
        return 1;
    }
    return 0;
}

stock ChangeStreamVehicleColor(vstreamid,col1,col2)
{
    if(VehInfo[vstreamid][valid] == 1) {
        VehInfo[vstreamid][color_1] = col1;
        VehInfo[vstreamid][color_2] = col2;
        if(VehInfo[vstreamid][spawned] == 1) {
            ChangeVehicleColor(VehInfo[vstreamid][idnum],col1,col2);
        }
        return 1;
    }
    return 0;
}

stock AddStreamVehicleComponent(vstreamid,componentid)
{
	if(VehInfo[vstreamid][valid] == 1) {
	    for(new s=0; s<20; s++) {
   			if(componentid == spoiler[s][0]) {
   				VehInfo[vstreamid][mod1] = componentid;
   	   		}
		}
		for(new s=0; s<3; s++) {
			if(componentid == nitro[s][0]) {
				VehInfo[vstreamid][mod2] = componentid;
    		}
		}
		for(new s=0; s<23; s++) {
			if(componentid == fbumper[s][0]) {
					VehInfo[vstreamid][mod3] = componentid;
    		}
		}
		for(new s=0; s<22; s++) {
			if(componentid == rbumper[s][0]) {
				VehInfo[vstreamid][mod4] = componentid;
	  		}
		}
		for(new s=0; s<28; s++) {
			if(componentid == exhaust[s][0]) {
				VehInfo[vstreamid][mod5] = componentid;
     		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == bventr[s][0]) {
				VehInfo[vstreamid][mod6] = componentid;
	   		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == bventl[s][0]) {
				VehInfo[vstreamid][mod7] = componentid;
   			}
		}
		for(new s=0; s<4; s++) {
			if(componentid == bscoop[s][0]) {
				VehInfo[vstreamid][mod8] = componentid;
			}
		}
		for(new s=0; s<13; s++) {
			if(componentid == rscoop[s][0]) {
				VehInfo[vstreamid][mod9] = componentid;
   			}
		}
		for(new s=0; s<21; s++) {
			if(componentid == lskirt[s][0]) {
				VehInfo[vstreamid][mod10] = componentid;
    		}
		}
		for(new s=0; s<21; s++) {
			if(componentid == rskirt[s][0]) {
				VehInfo[vstreamid][mod11] = componentid;
   			}
		}
		for(new s=0; s<1; s++) {
			if(componentid == hydraulics[s][0]) {
				VehInfo[vstreamid][mod12] = componentid;
    		}
		}
		for(new s=0; s<1; s++) {
			if(componentid == base[s][0]) {
				VehInfo[vstreamid][mod13] = componentid;
    		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == rbbars[s][0]) {
				VehInfo[vstreamid][mod14] = componentid;
     		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == fbbars[s][0]) {
				VehInfo[vstreamid][mod15] = componentid;
     		}
		}
		for(new s=0; s<17; s++) {
			if(componentid == wheels[s][0]) {
				VehInfo[vstreamid][mod16] = componentid;
    		}
		}
		for(new s=0; s<2; s++) {
			if(componentid == lights[s][0]) {
				VehInfo[vstreamid][mod17] = componentid;
	  		}
		}
	    if(VehInfo[vstreamid][spawned] == 1) {
	        AddVehicleComponent(VehInfo[vstreamid][vidnum],componentid);
	    }
	    return 1;
	}
	return 0;
}

stock CreateStreamPickup(modelid,ptype,Float:x,Float:y,Float:z,Float:spawn_distance)
{
	for(new i = 0;i<B_LIMIT;i++) {
	    if(PickupInfo[i][valid] == 0) {
			PickupInfo[i][model] = modelid;
			PickupInfo[i][x_spawn] = x;
			PickupInfo[i][y_spawn] = y;
   			PickupInfo[i][z_spawn] = z;
			PickupInfo[i][type] = ptype;
			PickupInfo[i][idnum] = -1;
			PickupInfo[i][valid] = 1;
			PickupInfo[i][spawndist] = spawn_distance;
			pickupcount++;
			return i;
		}
	}
	return 0;
}

stock GetPickupStreamID(pickupid)
{
	for(new i = 0;i<B_LIMIT;i++) {
		if(pickupid == PickupInfo[i][idnum]) {
   			return i;
		}
	}
	return -1;
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

stock IsPlayerClose(playerid,Float:x,Float:y,Float:z,Float:MAX)
{
	new Float:PPos[3];
	GetPlayerPos(playerid, PPos[0], PPos[1], PPos[2]);
	if (PPos[0] >= floatsub(x, MAX) && PPos[0] <= floatadd(x, MAX)
	&& PPos[1] >= floatsub(y, MAX) && PPos[1] <= floatadd(y, MAX)
	&& PPos[2] >= floatsub(z, MAX) && PPos[2] <= floatadd(z, MAX))
	{
		return 1;
	}
	return 0;
}

stock CreateStreamMapIcon(markermodel,Float:x,Float:y,Float:z,Float:spawn_distance)
{
	for(new i = 1;i<B_LIMIT;i++) {
		if(MapIconInfo[i][mvalid] == 0) {
			MapIconInfo[i][mmodel] = markermodel;
			for(new j=0;j<MAX_PLAYERS;j++) {
				MIidnum[j][i] = i;
			}
			MapIconInfo[i][mx_spawn] = x;
			MapIconInfo[i][my_spawn] = y;
			MapIconInfo[i][mz_spawn] = z;
			MapIconInfo[i][mspawndist] = spawn_distance;
			MapIconInfo[i][mvalid] = 1;
			mmcount++;
			return i;
		}
	}
	return 0;
}

stock ChangeMapIconModel(streamid,newmodel)
{
	for(new i = 0;i<MAX_PLAYERS;i++) {
	    if(IsPlayerConnected(i)) {
			new iconid = MIidnum[i][streamid];
    		MapIconInfo[streamid][mmodel] = newmodel;
    		if(MIactive[i][streamid] == 1) {
        		RemovePlayerMapIcon(i,iconid);
				SetPlayerMapIcon(i,iconid,MapIconInfo[streamid][mx_spawn],MapIconInfo[streamid][my_spawn],MapIconInfo[streamid][mz_spawn],MapIconInfo[streamid][mmodel],1);
			}
		}
	}
}

stock ResetVehicleStream(vehicleid)
{

	new i;VehicleInfo[GetVehicleStreamID(vehicleid)][limbo] = 1;
	if(VehicleInfo[i][temporary] == 1) {
		SetTimerEx("DeathProcess2",10000,0,"x",vehicleid);
	}
	else {
		SetTimerEx("DeathProcess",10000,0,"x",vehicleid);
	}
}

stock ResetVehicleStreamCar(vehicleid)
{

	new i;VehicleInfo[GetVehicleStreamID(vehicleid)][limbo] = 1;
	if(VehicleInfo[i][temporary] == 1) {
		SetTimerEx("DeathProcess2",300000,0,"x",vehicleid);
	}
	else {
		SetTimerEx("DeathProcess",300000,0,"x",vehicleid);
	}
}

stock CountModels(maxstream)
{
	new modelcount = 0;
	new modelcounted[MAX_STREAM_VEHICLES];
	for(new i = 1;i<=maxstream;i++) {
        if(VehicleInfo[i][spawned] == 1) {
                if(modelcounted[VehicleInfo[i][idnum]] == 0) {
                modelcount++;
                modelcounted[VehicleInfo[i][idnum]] = 1;
            }
        }
    }
    return modelcount;
}

stock IsModelActive(vmodel)
{
    for(new i = 1;i<=vehcount;i++) {
        if(VehicleInfo[i][spawned] == 1) {
            if(VehicleInfo[i][model] == vmodel) {
                return 1;
            }
        }
    }
    return 0;
}
