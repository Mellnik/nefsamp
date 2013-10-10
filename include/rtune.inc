/* Random Vehicle Tuning Include
 - Copyright © 2008 by Pablo_Borsellino
 -» Author    	: Pablo_Borsellino
 -» Release Date	: 27th September 2011
 -» Description	: Function to tune vehicles randomly
 -» Functions	: - TuneVehicleRandomly(VehicleID);
			  -» Example:
				- public OnPlayerEnterVehicle(playerid,vehicleid,ispassenger)
				- {
				- 	TuneVehicleRandomly(vehicleid);
				-	SendClientMessage(playerid,-1,"Your car has been tuned.");
				- 	return 1;
				- }
 */

//______________________________________________________________________________
#include <a_samp>

//______________________________________________________________________________
#define forEx(%0,%1) for(new %1=0;%1<%0;%1++)

//______________________________________________________________________________
#pragma unused TuneVehicleRandomly

//______________________________________________________________________________
TuneVehicleRandomly(VehicleID)
{
	new Tuningpart[36],Tick=0,Model=GetVehicleModel(VehicleID);
	for(new i=999;i<1194;i++){if(i>=1000&&i<=1993&&GetVehicleUpgrade(Model,i)){Tuningpart[Tick]=i;Tick++;}}
    AddVehicleComponent(VehicleID,randomEx(Tuningpart[0],Tuningpart[1],Tuningpart[2],Tuningpart[3],Tuningpart[4],Tuningpart[5]));
    AddVehicleComponent(VehicleID,randomEx(Tuningpart[6],Tuningpart[7],Tuningpart[8],Tuningpart[9],Tuningpart[0]));
    AddVehicleComponent(VehicleID,randomEx(Tuningpart[11],Tuningpart[12],Tuningpart[13],Tuningpart[14],Tuningpart[15]));
    AddVehicleComponent(VehicleID,randomEx(Tuningpart[16],Tuningpart[17],Tuningpart[18],Tuningpart[19],Tuningpart[20]));
    AddVehicleComponent(VehicleID,randomEx(Tuningpart[20],Tuningpart[21],Tuningpart[22],Tuningpart[23],Tuningpart[24]));
    AddVehicleComponent(VehicleID,randomEx(Tuningpart[26],Tuningpart[27],Tuningpart[28],Tuningpart[29],Tuningpart[30]));
    AddVehicleComponent(VehicleID,randomEx(Tuningpart[30],Tuningpart[31],Tuningpart[32],Tuningpart[33],Tuningpart[34],Tuningpart[35]));
    ChangeVehicleColor(VehicleID,randomEx(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,28,32,41,42,43,44,45,46,47,48,49,50,123,124,125,126,130,131,132,142,144,146,147,148,149,150,141,128,129,130,131,132,142,144,145,1146,147,148,149,150,151,160,165,166,181,182,183,184,185,186,255,252),
								 randomEx(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,28,32,41,42,43,44,45,46,47,48,49,50,123,124,125,126,130,131,132,142,144,146,147,148,149,150,141,128,129,130,131,132,142,144,145,1146,147,148,149,150,151,160,165,166,181,182,183,184,185,186,255,252));
	return 1;
}

//______________________________________________________________________________
GetVehicleUpgrade(VehicleModel,ComponentID){
	switch(VehicleModel){case 400:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1013:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1024:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}
				case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 401:{switch(ComponentID){
				case 1001:{return 1;}case 1003:{return 1;}case 1004:{return 1;}case 1005:{return 1;}case 1006:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1013:{return 1;}case 1017:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}
				case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1142:{return 1;}case 1143:{return 1;}case 1144:{return 1;}
			}}case 404:{switch(ComponentID){
				case 1000:{return 1;}case 1002:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1013:{return 1;}case 1016:{return 1;}case 1017:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}
				case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 405:{switch(ComponentID){
				case 1000:{return 1;}case 1001:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1014:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1023:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}
				case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 410:{switch(ComponentID){
				case 1001:{return 1;}case 1003:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1013:{return 1;}case 1017:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1023:{return 1;}case 1024:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}
				case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}
				case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 415:{switch(ComponentID){
				case 1001:{return 1;}case 1003:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1023:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}
				case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 418:{switch(ComponentID){
				case 1002:{return 1;}case 1006:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1016:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}
				case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 420:{switch(ComponentID){
				case 1001:{return 1;}case 1003:{return 1;}case 1004:{return 1;}case 1005:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1019:{return 1;}case 1021:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}
				case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 421:{switch(ComponentID){
				case 1000:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1014:{return 1;}case 1016:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1023:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}
				case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 422:{switch(ComponentID){
				case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1013:{return 1;}case 1017:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}
				case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 426:{switch(ComponentID){
				case 1001:{return 1;}case 1003:{return 1;}case 1004:{return 1;}case 1005:{return 1;}case 1006:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1019:{return 1;}case 1021:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}
				case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 436:{switch(ComponentID){
				case 1001:{return 1;}case 1003:{return 1;}case 1006:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1013:{return 1;}case 1017:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1022:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}
				case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 439:{switch(ComponentID){
				case 1001:{return 1;}case 1003:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1013:{return 1;}case 1017:{return 1;}case 1023:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}
				case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1142:{return 1;}case 1143:{return 1;}case 1144:{return 1;}case 1145:{return 1;}
			}}case 477:{switch(ComponentID){
				case 1006:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}
				case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 478:{switch(ComponentID){
				case 1004:{return 1;}case 1005:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1012:{return 1;}case 1013:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1022:{return 1;}case 1024:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}
				case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 489:{switch(ComponentID){
				case 1000:{return 1;}case 1002:{return 1;}case 1004:{return 1;}case 1005:{return 1;}case 1006:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1013:{return 1;}case 1016:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1024:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}
				case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}
				case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 491:{switch(ComponentID){
				case 1003:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1014:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1023:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}
				case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1142:{return 1;}case 1143:{return 1;}case 1144:{return 1;}case 1145:{return 1;}
			}}case 492:{switch(ComponentID){
				case 1000:{return 1;}case 1004:{return 1;}case 1005:{return 1;}case 1006:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1016:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}
				case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 496:{switch(ComponentID){
				case 1001:{return 1;}case 1002:{return 1;}case 1003:{return 1;}case 1006:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1011:{return 1;}case 1017:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1023:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}
				case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1142:{return 1;}case 1143:{return 1;}
			}}case 500:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1013:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1024:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}
				case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 516:{switch(ComponentID){
				case 1000:{return 1;}case 1002:{return 1;}case 1004:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1015:{return 1;}case 1016:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}
				case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 517:{switch(ComponentID){
				case 1002:{return 1;}case 1003:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1016:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1023:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}
				case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1142:{return 1;}case 1143:{return 1;}case 1144:{return 1;}case 1145:{return 1;}
			}}case 518:{switch(ComponentID){
				case 1001:{return 1;}case 1003:{return 1;}case 1005:{return 1;}case 1006:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1013:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1020:{return 1;}case 1023:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}
				case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1142:{return 1;}case 1143:{return 1;}case 1144:{return 1;}case 1145:{return 1;}
			}}case 527:{switch(ComponentID){
				case 1001:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1014:{return 1;}case 1015:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}
				case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 529:{switch(ComponentID){
				case 1001:{return 1;}case 1003:{return 1;}case 1006:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1011:{return 1;}case 1012:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1023:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}
				case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 534:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
				case 1100:{return 1;}case 1101:{return 1;}case 1106:{return 1;}case 1122:{return 1;}case 1123:{return 1;}case 1124:{return 1;}case 1125:{return 1;}case 1126:{return 1;}case 1127:{return 1;}case 1178:{return 1;}case 1179:{return 1;}case 1180:{return 1;}case 1185:{return 1;}
			}}case 535:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
				case 1109:{return 1;}case 1110:{return 1;}case 1113:{return 1;}case 1114:{return 1;}case 1115:{return 1;}case 1116:{return 1;}case 1117:{return 1;}case 1118:{return 1;}case 1119:{return 1;}case 1120:{return 1;}case 1121:{return 1;}
			}}case 536:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
				case 1103:{return 1;}case 1104:{return 1;}case 1105:{return 1;}case 1107:{return 1;}case 1108:{return 1;}case 1128:{return 1;}case 1181:{return 1;}case 1182:{return 1;}case 1183:{return 1;}case 1184:{return 1;}
			}}case 540:{switch(ComponentID){
				case 1001:{return 1;}case 1004:{return 1;}case 1006:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1023:{return 1;}case 1024:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}
				case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1142:{return 1;}case 1143:{return 1;}case 1144:{return 1;}case 1145:{return 1;}
			}}case 542:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1014:{return 1;}case 1015:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}
				case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1144:{return 1;}case 1145:{return 1;}
			}}case 546:{switch(ComponentID){
				case 1001:{return 1;}case 1002:{return 1;}case 1004:{return 1;}case 1006:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1023:{return 1;}case 1024:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}
				case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1142:{return 1;}case 1143:{return 1;}case 1144:{return 1;}case 1145:{return 1;}
			}}case 547:{switch(ComponentID){
				case 1000:{return 1;}case 1003:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1016:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}
				case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1142:{return 1;}case 1143:{return 1;}
			}}case 549:{switch(ComponentID){
				case 1001:{return 1;}case 1003:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1011:{return 1;}case 1012:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1023:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}
				case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1142:{return 1;}case 1143:{return 1;}case 1144:{return 1;}case 1145:{return 1;}
			}}case 550:{switch(ComponentID){
				case 1001:{return 1;}case 1003:{return 1;}case 1004:{return 1;}case 1005:{return 1;}case 1006:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1023:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}
				case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1142:{return 1;}case 1143:{return 1;}case 1144:{return 1;}case 1145:{return 1;}
			}}case 551:{switch(ComponentID){
				case 1002:{return 1;}case 1003:{return 1;}case 1005:{return 1;}case 1006:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1016:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1021:{return 1;}case 1023:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}
				case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 558:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1088:{return 1;}case 1089:{return 1;}case 1090:{return 1;}
				case 1091:{return 1;}case 1092:{return 1;}case 1093:{return 1;}case 1094:{return 1;}case 1095:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1163:{return 1;}case 1164:{return 1;}case 1165:{return 1;}case 1166:{return 1;}case 1167:{return 1;}case 1168:{return 1;}
			}}case 559:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1025:{return 1;}case 1065:{return 1;}case 1066:{return 1;}case 1067:{return 1;}case 1068:{return 1;}case 1069:{return 1;}case 1070:{return 1;}case 1071:{return 1;}case 1072:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}
				case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1158:{return 1;}case 1159:{return 1;}case 1160:{return 1;}case 1161:{return 1;}case 1162:{return 1;}case 1173:{return 1;}
			}}case 560:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1025:{return 1;}case 1026:{return 1;}case 1027:{return 1;}case 1028:{return 1;}case 1029:{return 1;}case 1030:{return 1;}case 1031:{return 1;}case 1032:{return 1;}case 1033:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}
				case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1138:{return 1;}case 1139:{return 1;}case 1140:{return 1;}case 1141:{return 1;}case 1169:{return 1;}case 1170:{return 1;}
			}}case 561:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1025:{return 1;}case 1055:{return 1;}case 1056:{return 1;}case 1057:{return 1;}case 1058:{return 1;}case 1059:{return 1;}case 1060:{return 1;}case 1061:{return 1;}case 1062:{return 1;}case 1063:{return 1;}case 1064:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}
				case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1154:{return 1;}case 1155:{return 1;}case 1156:{return 1;}case 1157:{return 1;}
			}}case 562:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1025:{return 1;}case 1034:{return 1;}case 1035:{return 1;}case 1036:{return 1;}case 1037:{return 1;}case 1038:{return 1;}case 1039:{return 1;}case 1040:{return 1;}case 1041:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}
				case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1146:{return 1;}case 1147:{return 1;}case 1148:{return 1;}case 1149:{return 1;}case 1171:{return 1;}case 1172:{return 1;}
			}}case 565:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1025:{return 1;}case 1045:{return 1;}case 1046:{return 1;}case 1047:{return 1;}case 1048:{return 1;}case 1049:{return 1;}case 1050:{return 1;}case 1051:{return 1;}case 1052:{return 1;}case 1053:{return 1;}case 1054:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}
				case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1150:{return 1;}case 1151:{return 1;}case 1152:{return 1;}case 1153:{return 1;}
			}}case 567:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
				case 1102:{return 1;}case 1129:{return 1;}case 1130:{return 1;}case 1131:{return 1;}case 1132:{return 1;}case 1133:{return 1;}case 1186:{return 1;}case 1187:{return 1;}case 1188:{return 1;}case 1189:{return 1;}
			}}case 575:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1025:{return 1;}case 1042:{return 1;}case 1043:{return 1;}case 1044:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}
				case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1099:{return 1;}case 1174:{return 1;}case 1175:{return 1;}case 1176:{return 1;}case 1177:{return 1;}
			}}case 576:{switch(ComponentID){
				case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
				case 1134:{return 1;}case 1135:{return 1;}case 1136:{return 1;}case 1137:{return 1;}case 1190:{return 1;}case 1191:{return 1;}case 1192:{return 1;}case 1193:{return 1;}
			}}case 580:{switch(ComponentID){
				case 1001:{return 1;}case 1006:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1020:{return 1;}case 1023:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}
				case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 585:{switch(ComponentID){
				case 1001:{return 1;}case 1003:{return 1;}case 1006:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1013:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1023:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}
				case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1142:{return 1;}case 1143:{return 1;}case 1144:{return 1;}case 1145:{return 1;}
			}}case 589:{switch(ComponentID){
				case 1000:{return 1;}case 1004:{return 1;}case 1005:{return 1;}case 1006:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1013:{return 1;}case 1016:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1020:{return 1;}case 1024:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}
				case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1144:{return 1;}case 1145:{return 1;}
			}}case 600:{switch(ComponentID){
				case 1004:{return 1;}case 1005:{return 1;}case 1006:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1013:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1020:{return 1;}case 1022:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}
				case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
			}}case 603:{switch(ComponentID){
				case 1001:{return 1;}case 1006:{return 1;}case 1007:{return 1;}case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1017:{return 1;}case 1018:{return 1;}case 1019:{return 1;}case 1020:{return 1;}case 1023:{return 1;}case 1024:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}
				case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}case 1142:{return 1;}case 1143:{return 1;}case 1144:{return 1;}case 1145:{return 1;}
			}}default:{
			switch(ComponentID){case 1008:{return 1;}case 1009:{return 1;}case 1010:{return 1;}case 1025:{return 1;}case 1073:{return 1;}case 1074:{return 1;}case 1075:{return 1;}case 1076:{return 1;}case 1077:{return 1;}case 1078:{return 1;}case 1079:{return 1;}case 1080:{return 1;}case 1081:{return 1;}case 1082:{return 1;}case 1083:{return 1;}case 1084:{return 1;}case 1085:{return 1;}case 1087:{return 1;}case 1096:{return 1;}case 1097:{return 1;}case 1098:{return 1;}
	}}}return 0;
}
randomEx(...)return getarg(random(numargs()));