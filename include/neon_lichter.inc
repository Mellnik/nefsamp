// Neon

new babm[MAX_VEHICLES];
new babm2[MAX_VEHICLES];
new bubm[MAX_VEHICLES] = 0;

stock AddNeonLightToVehicle(vehicleid,color)
{
	new kkk = GetVehicleModel(vehicleid);
	if(kkk == 509 || kkk ==  481 || kkk ==  510 || kkk == 462 || kkk ==  448 || kkk ==  581 || kkk == 522 || kkk ==  461 || kkk ==  521 || kkk ==  523 || kkk ==  463 || kkk ==  586 || kkk ==  468 || kkk ==  471) return 1; 

	if(bubm[vehicleid] == 1) DestroyObject(babm[vehicleid]);
	if(bubm[vehicleid] == 1) DestroyObject(babm2[vehicleid]);
	
	
	new boja;

	if(color < 0 || color > 4) return 1;
	if(color == 0) boja = 18652;
	if(color == 1) boja = 18648;
	if(color == 2) boja = 18647;
	if(color == 3) boja = 18649;
	if(color == 4) boja = 18651;


	babm[vehicleid] = CreateObject(boja,0,0,0,0,0,0);
	AttachObjectToVehicle(babm[vehicleid],vehicleid,-0.808, 0.0001, -0.65, 0.0, 0.0, -0.00001);
	babm2[vehicleid] = CreateObject(boja,0,0,0,0,0,0);
	AttachObjectToVehicle(babm2[vehicleid],vehicleid,0.808, 0.0001, -0.65, 0.0, 0.0, -0.00001);
	bubm[vehicleid] = 1;
	return 1;
}

stock AddNeonLightToVehicleEx(vehicleid,color1,color2)
{
	new kkk = GetVehicleModel(vehicleid);
	if(kkk == 509 || kkk ==  481 || kkk ==  510 || kkk == 462 || kkk ==  448 || kkk ==  581 || kkk == 522 || kkk ==  461 || kkk ==  521 || kkk ==  523 || kkk ==  463 || kkk ==  586 || kkk ==  468 || kkk ==  471) return 1; 

	if(bubm[vehicleid] == 1) DestroyObject(babm[vehicleid]);
	if(bubm[vehicleid] == 1) DestroyObject(babm2[vehicleid]);
	
	new boja,boja2;

	if(color1 < 0 || color1 > 4) return 1;
	if(color1 == 0) boja = 18652;
	if(color1 == 1) boja = 18648;
	if(color1 == 2) boja = 18647;
	if(color1 == 3) boja = 18649;
	if(color1 == 4) boja = 18651;

	

	if(color2 < 0 || color2 > 4) return 1;
	if(color2 == 0) boja2 = 18652;
	if(color2 == 1) boja2 = 18648;
	if(color2 == 2) boja2 = 18647;
	if(color2 == 3) boja2 = 18649;
	if(color2 == 4) boja2 = 18651;


	babm[vehicleid] = CreateObject(boja,0,0,0,0,0,0);
	AttachObjectToVehicle(babm[vehicleid],vehicleid,-0.808, 0.0001, -0.65, 0.0, 0.0, -0.00001);
	babm2[vehicleid] = CreateObject(boja2,0,0,0,0,0,0);
	AttachObjectToVehicle(babm2[vehicleid],vehicleid,0.808, 0.0001, -0.65, 0.0, 0.0, -0.00001);
	bubm[vehicleid] = 1;
	return 1;
}

stock RemoveNeonLightFromVehicle(vehicleid)
{¸
new kkk = GetVehicleModel(vehicleid);
if(kkk == 509 || kkk ==  481 || kkk ==  510 || kkk == 462 || kkk ==  448 || kkk ==  581 || kkk == 522 || kkk ==  461 || kkk ==  521 || kkk ==  523 || kkk ==  463 || kkk ==  586 || kkk ==  468 || kkk ==  471) return 1; 

if(bubm[vehicleid] == 0) return 1;
if(bubm[vehicleid] == 1) DestroyObject(babm[vehicleid]);
if(bubm[vehicleid] == 1) DestroyObject(babm2[vehicleid]);
bubm[vehicleid] = 0;
return 1;
}