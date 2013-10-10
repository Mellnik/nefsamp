/* Vehicle Owner Ship INC by BlackFoX_UD_

	o Easy & Fast Special Vehicles
	o With Team & Owner String
	o Save Tunes , Paint & Colors...
	o Easy to Create own Vehicle Owner Ship


	-= (c) 2010 By BlackFoX_UD_ =-


native createFlagVehicle(fmodel,Float:fx,Float:fy,Float:fz,Float:fa,fowner[],fteam,fcolor0 = -1,fcolor1 = -1,price = 0,fpaint = 0,flocked = 0);
native killFlagVehicle(vehicleid);
native isVehicleLocked(vehicleid);
native setVehicleLock(vehicleid,lock);
native getVehicleColors(vehicleid,color0,color1);
native setVehicleColors(vehicleid,color0,color1);
native getVehiclePaint(vehicleid);
native setVehiclePaint(vehicleid,paintjob);
native setVehicleOwner(vehicleid,const nname[]);
native getVehicleOwner(vehicleid);
native setVehicleTeam(vehicleid,const nname[])
native getVehicleTeam(vehicleid);
native setVehiclePosition(vehicleid,Float:achseX,Float:achseY,Float:achseZ,Float:achseA);
native getVehiclePosition(vehicleid,&Float:achseX,&Float:achseY,&Float:achseZ,&Float:achseA);
native getVehicleFlagID(vehicleid);
native setVehiclePrice(vehicleid,price);
native getVehiclePrice(vehicleid);
native renewVehicle(vehicleid);
native doTuneVehicle(flagid);
native isFlagVehicle(vehicleid);
native doLoadVehicles(const byfile[]);
native doSaveVehicles(const byfile[]);



	-=* CREDITS *=-

	BlackFoX_UD_ 		( Das Skript )
	Compu Phase         ( Pawn & strtok )
	Rockstar Games      ( Das Spiel )
	Sa-mp Entwickler    ( Multiplayer Mod )

	!!Credits nicht Löschen - DO NOT REMOVE ANY CREDITS!!


	Bei Fragen zum Skript eMail : Slyfer1@googlemail.com
	
	
	** CHANGES 28. + 29 Jan 2009 & ****************
	*                                             *
	*   Vehicle Loader ( Fixed )                  *
	*   Vehicle Price can be set                  *
	*   New Callback to Check the Vehicle Changes *
	*   Team Replaced with Integer Value          *
	*   Vehicles can be Reloaded from Cache
	*                                             *
	***********************************************

*/
forward OnChangeFlagVehicles(flagid,vehicleid);
#define MAX_OWNER_NAME MAX_PLAYER_NAME
#define MAX_FLAG_VEHICLE 270 
#define gSTR_MAX 128
#define INVALID_FLAG_ID (MAX_FLAG_VEHICLE+1)
#define VALID_FORMAT 25 // Klammern die der Linie Mininmal vorhanden sein müssen
//#define CHECK_FORMAT ( Auskommentieren falls gebraucht , checkt wie viele Klammern in der Linie vorhanden sind damit Fehler vermieden werden können sprich alle Werte müssen vorhanden sein)

new v_Cached;
enum vclass
{
	flag_model,
	Float:flag_x,
	Float:flag_y,
	Float:flag_z,
	Float:flag_a,
	flag_color0,
	flag_color1,
	flag_paint,
	flag_team,
	flag_owner[MAX_OWNER_NAME],
	flag_locked,
	flag_mod0,
	flag_mod1,
	flag_mod2,
	flag_mod3,
	flag_mod4,
	flag_mod5,
	flag_mod6,
	flag_mod7,
	flag_mod8,
	flag_mod9,
	flag_mod10,
	flag_mod11,
	flag_mod12,
	flag_mod13,
	flag_rid,
	flag_price
}
new FLAG_VEHICLE[MAX_FLAG_VEHICLE][vclass];

stock createFlagVehicle(fmodel,Float:fx,Float:fy,Float:fz,Float:fa,fowner[],fteam,fcolor0 = -1,fcolor1 = -1,price = 0,fpaint = 0,flocked = 0)
{
	if(v_Cached >= INVALID_FLAG_ID)return 0;
	FLAG_VEHICLE[v_Cached][flag_model] = fmodel;
	FLAG_VEHICLE[v_Cached][flag_x] = fx;
	FLAG_VEHICLE[v_Cached][flag_y] = fy;
	FLAG_VEHICLE[v_Cached][flag_z] = fz;
	FLAG_VEHICLE[v_Cached][flag_a] = fa;
	FLAG_VEHICLE[v_Cached][flag_team] = fteam;
	strmid(FLAG_VEHICLE[v_Cached][flag_owner],fowner,0,MAX_OWNER_NAME,MAX_OWNER_NAME);
	FLAG_VEHICLE[v_Cached][flag_color0] = fcolor0;
	FLAG_VEHICLE[v_Cached][flag_color1] = fcolor1;
	FLAG_VEHICLE[v_Cached][flag_price] = price;
	FLAG_VEHICLE[v_Cached][flag_paint] = fpaint;
	FLAG_VEHICLE[v_Cached][flag_locked] = flocked;
	FLAG_VEHICLE[v_Cached][flag_rid] = CreateVehicle(FLAG_VEHICLE[v_Cached][flag_model],FLAG_VEHICLE[v_Cached][flag_x],FLAG_VEHICLE[v_Cached][flag_y],FLAG_VEHICLE[v_Cached][flag_z],FLAG_VEHICLE[v_Cached][flag_a],FLAG_VEHICLE[v_Cached][flag_color0],FLAG_VEHICLE[v_Cached][flag_color1],9999999999);
	CallLocalFunction("OnChangeFlagVehicles","ii",v_Cached,FLAG_VEHICLE[v_Cached][flag_rid]);
	v_Cached++;
	return 1;
}
stock killFlagVehicle(vehicleid)
{
	new flag = getVehicleFlagID(vehicleid);
	if(flag==INVALID_FLAG_ID)return 0;
	FLAG_VEHICLE[flag][flag_model] = 0;
	DestroyVehicle(FLAG_VEHICLE[flag][flag_rid]);
	CallLocalFunction("OnChangeFlagVehicles","ii",flag,FLAG_VEHICLE[flag][flag_rid]);
	return 1;
}
stock isVehicleLocked(vehicleid)
{
	new flag = getVehicleFlagID(vehicleid);
	if(flag==INVALID_FLAG_ID)return 0;
	return FLAG_VEHICLE[flag][flag_locked];
}
stock setVehicleLock(vehicleid,lock)
{
	new flag = getVehicleFlagID(vehicleid);
	if(flag==INVALID_FLAG_ID)return 0;
	FLAG_VEHICLE[flag][flag_locked] = lock;
	CallLocalFunction("OnChangeFlagVehicles","ii",flag,FLAG_VEHICLE[flag][flag_rid]);
	return 1;
}
stock getVehicleColors(vehicleid,color0,color1)
{
	new flag = getVehicleFlagID(vehicleid);
	if(flag==INVALID_FLAG_ID)return 0;
	color0 = FLAG_VEHICLE[flag][flag_color0];
	color1 = FLAG_VEHICLE[flag][flag_color1];
	return 1;
}
stock setVehicleColors(vehicleid,color0,color1)
{
	new flag = getVehicleFlagID(vehicleid);
	if(flag==INVALID_FLAG_ID)return 0;
	FLAG_VEHICLE[flag][flag_color0] = color0;
	FLAG_VEHICLE[flag][flag_color1] = color1;
	CallLocalFunction("OnChangeFlagVehicles","ii",flag,FLAG_VEHICLE[flag][flag_rid]);
	return 1;
}
stock getVehiclePaint(vehicleid)
{
	new flag = getVehicleFlagID(vehicleid);
	if(flag==INVALID_FLAG_ID)return 0;
	return FLAG_VEHICLE[flag][flag_paint];
}
stock setVehiclePaint(vehicleid,paintjob)
{
	new flag = getVehicleFlagID(vehicleid);
	if(flag==INVALID_FLAG_ID)return 0;
	FLAG_VEHICLE[flag][flag_paint] = paintjob;
	CallLocalFunction("OnChangeFlagVehicles","ii",flag,FLAG_VEHICLE[flag][flag_rid]);
	return 1;
}
stock setVehicleOwner(vehicleid,const nname[])
{
	new flag = getVehicleFlagID(vehicleid);
	if(flag==INVALID_FLAG_ID)return 0;
	strmid(FLAG_VEHICLE[flag][flag_owner],nname,0,strlen(nname),MAX_OWNER_NAME);
	CallLocalFunction("OnChangeFlagVehicles","ii",flag,FLAG_VEHICLE[flag][flag_rid]);
	return 1;
}
stock getVehicleOwner(vehicleid)
{
    new flag = getVehicleFlagID(vehicleid);
    new eName[MAX_OWNER_NAME];
    format(eName,sizeof eName,"NONE");
    if(flag==INVALID_FLAG_ID)return eName;
    format(eName,sizeof eName,"%s",FLAG_VEHICLE[flag][flag_owner]);
    return eName;
}
stock setVehicleTeam(vehicleid,teamnum)
{
	new flag = getVehicleFlagID(vehicleid);
	if(flag==INVALID_FLAG_ID)return 0;
	FLAG_VEHICLE[flag][flag_team] = teamnum;
	CallLocalFunction("OnChangeFlagVehicles","ii",flag,FLAG_VEHICLE[flag][flag_rid]);
	return 1;
}
stock getVehicleTeam(vehicleid)
{
    new flag = getVehicleFlagID(vehicleid);
    if(flag==INVALID_FLAG_ID)return 0;
    return FLAG_VEHICLE[flag][flag_team];
}
stock setVehiclePrice(vehicleid,price)
{
	new flag = getVehicleFlagID(vehicleid);
    if(flag==INVALID_FLAG_ID)return 0;
    FLAG_VEHICLE[flag][flag_price] = price;
	CallLocalFunction("OnChangeFlagVehicles","ii",flag,FLAG_VEHICLE[flag][flag_rid]);
    return 1;
}
stock getVehiclePrice(vehicleid)
{
	new flag = getVehicleFlagID(vehicleid);
    if(flag==INVALID_FLAG_ID)return 0;
	return FLAG_VEHICLE[flag][flag_price];
}
stock setVehiclePosition(vehicleid,Float:achseX,Float:achseY,Float:achseZ,Float:achseA)
{
	new flag = getVehicleFlagID(vehicleid);
    if(flag==INVALID_FLAG_ID)return 0;
    FLAG_VEHICLE[flag][flag_x] = achseX;
    FLAG_VEHICLE[flag][flag_y] = achseY;
    FLAG_VEHICLE[flag][flag_z] = achseZ;
    FLAG_VEHICLE[flag][flag_a] = achseA;
	CallLocalFunction("OnChangeFlagVehicles","ii",flag,FLAG_VEHICLE[flag][flag_rid]);
    return 1;
}
stock getVehiclePosition(vehicleid,&Float:achseX,&Float:achseY,&Float:achseZ,&Float:achseA)
{
	new flag = getVehicleFlagID(vehicleid);
    if(flag==INVALID_FLAG_ID)return 0;
    achseX = FLAG_VEHICLE[flag][flag_x];
    achseY = FLAG_VEHICLE[flag][flag_y];
    achseZ = FLAG_VEHICLE[flag][flag_z];
    achseA = FLAG_VEHICLE[flag][flag_a];
    return 1;
}
stock getVehicleFlagID(vehicleid)
{
	new i = 0;
	while(i<v_Cached && FLAG_VEHICLE[i][flag_rid]!=vehicleid)i++;
	if(i==v_Cached && FLAG_VEHICLE[i][flag_rid]!=vehicleid)return INVALID_FLAG_ID;
	return i;
}
stock renewVehicle(vehicleid)
{
	new flag = getVehicleFlagID(vehicleid);
    if(flag==INVALID_FLAG_ID)return 0;
    DestroyVehicle(vehicleid);
    FLAG_VEHICLE[flag][flag_rid] = CreateVehicle(FLAG_VEHICLE[flag][flag_model],FLAG_VEHICLE[flag][flag_x],FLAG_VEHICLE[flag][flag_y],FLAG_VEHICLE[flag][flag_z],FLAG_VEHICLE[flag][flag_a],FLAG_VEHICLE[flag][flag_color0],FLAG_VEHICLE[flag][flag_color1],9999999999);
    doTuneVehicle(flag);
	return 1;
}
stock isFlagVehicle(vehicleid)return (getVehicleFlagID(vehicleid)==INVALID_FLAG_ID) ? (0) : (1);
stock doLoadVehicles(const byfile[])
{
	new File:datei = fopen(byfile,io_read),lines[255],indexe;
	if(!datei)return 0;
	while(fread(datei,lines))
	{
	    if(!lines[0])continue;
	    WithoutDirt(lines);
	    #if defined CHECK_FORMAT
	    if(checkFormat(lines)<VALID_FORMAT)
	    {
	        printf("[BFX_VCLASS] : Fehler im Format , Fahrzeug Nummer %i",v_Cached+1);
	        continue;
	    }
	    #endif
	    FLAG_VEHICLE[v_Cached][flag_model] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_x] = floatstr(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_y] = floatstr(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_z] = floatstr(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_a] = floatstr(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_color0] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_color1] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_paint] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_team] = strval(tget(lines,indexe));
	    strmid(FLAG_VEHICLE[v_Cached][flag_owner],tget(lines,indexe),0,MAX_OWNER_NAME,MAX_OWNER_NAME);
	    FLAG_VEHICLE[v_Cached][flag_locked] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_mod0] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_mod1] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_mod2] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_mod3] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_mod4] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_mod5] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_mod6] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_mod7] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_mod8] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_mod9] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_mod10] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_mod11] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_mod12] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_mod13] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_price] = strval(tget(lines,indexe));
	    FLAG_VEHICLE[v_Cached][flag_rid] = CreateVehicle(FLAG_VEHICLE[v_Cached][flag_model],FLAG_VEHICLE[v_Cached][flag_x],FLAG_VEHICLE[v_Cached][flag_y],FLAG_VEHICLE[v_Cached][flag_z],FLAG_VEHICLE[v_Cached][flag_a],FLAG_VEHICLE[v_Cached][flag_color0],FLAG_VEHICLE[v_Cached][flag_color1],9999999999);
		doTuneVehicle(v_Cached);
		indexe = 0;
		v_Cached++;
	}
	fclose(datei);
	return 1;
}
stock doTuneVehicle(flagid)
{
	ChangeVehicleColor(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_color0],FLAG_VEHICLE[flagid][flag_color1]);
	ChangeVehiclePaintjob(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_paint]);
	AddVehicleComponent(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_mod0]);
	AddVehicleComponent(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_mod1]);
	AddVehicleComponent(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_mod2]);
	AddVehicleComponent(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_mod3]);
	AddVehicleComponent(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_mod4]);
	AddVehicleComponent(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_mod5]);
	AddVehicleComponent(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_mod6]);
	AddVehicleComponent(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_mod7]);
	AddVehicleComponent(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_mod8]);
	AddVehicleComponent(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_mod9]);
	AddVehicleComponent(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_mod10]);
	AddVehicleComponent(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_mod11]);
	AddVehicleComponent(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_mod12]);
	AddVehicleComponent(FLAG_VEHICLE[flagid][flag_rid],FLAG_VEHICLE[flagid][flag_mod13]);
	return 1;
}
stock doSaveVehicles(const byfile[])
{
	new File:datei = fopen(byfile,io_write),line[255];
	if(!datei)return 0;
	for(new i = 0;i<v_Cached;i++)
	{
	    if(!FLAG_VEHICLE[i][flag_model])continue;
	    FLAG_VEHICLE[i][flag_mod0] = GetVehicleComponentInSlot(FLAG_VEHICLE[i][flag_rid],0);
	    FLAG_VEHICLE[i][flag_mod1] = GetVehicleComponentInSlot(FLAG_VEHICLE[i][flag_rid],1);
	    FLAG_VEHICLE[i][flag_mod2] = GetVehicleComponentInSlot(FLAG_VEHICLE[i][flag_rid],2);
	    FLAG_VEHICLE[i][flag_mod3] = GetVehicleComponentInSlot(FLAG_VEHICLE[i][flag_rid],3);
	    FLAG_VEHICLE[i][flag_mod4] = GetVehicleComponentInSlot(FLAG_VEHICLE[i][flag_rid],4);
	    FLAG_VEHICLE[i][flag_mod5] = GetVehicleComponentInSlot(FLAG_VEHICLE[i][flag_rid],5);
	    FLAG_VEHICLE[i][flag_mod6] = GetVehicleComponentInSlot(FLAG_VEHICLE[i][flag_rid],6);
	    FLAG_VEHICLE[i][flag_mod7] = GetVehicleComponentInSlot(FLAG_VEHICLE[i][flag_rid],7);
	    FLAG_VEHICLE[i][flag_mod8] = GetVehicleComponentInSlot(FLAG_VEHICLE[i][flag_rid],8);
	    FLAG_VEHICLE[i][flag_mod9] = GetVehicleComponentInSlot(FLAG_VEHICLE[i][flag_rid],9);
	    FLAG_VEHICLE[i][flag_mod10] = GetVehicleComponentInSlot(FLAG_VEHICLE[i][flag_rid],10);
	    FLAG_VEHICLE[i][flag_mod11] = GetVehicleComponentInSlot(FLAG_VEHICLE[i][flag_rid],11);
	    FLAG_VEHICLE[i][flag_mod12] = GetVehicleComponentInSlot(FLAG_VEHICLE[i][flag_rid],12);
	    FLAG_VEHICLE[i][flag_mod13] = GetVehicleComponentInSlot(FLAG_VEHICLE[i][flag_rid],13);
	    format(line,sizeof line,"%d,%f,%f,%f,%f,%d,%d,%d,%d,%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\r\n",
	    FLAG_VEHICLE[i][flag_model],
	    FLAG_VEHICLE[i][flag_x],
	    FLAG_VEHICLE[i][flag_y],
	    FLAG_VEHICLE[i][flag_z],
		FLAG_VEHICLE[i][flag_a],
		FLAG_VEHICLE[i][flag_color0],
		FLAG_VEHICLE[i][flag_color1],
		FLAG_VEHICLE[i][flag_paint],
		FLAG_VEHICLE[i][flag_team],
		FLAG_VEHICLE[i][flag_owner],
		FLAG_VEHICLE[i][flag_locked],
		FLAG_VEHICLE[i][flag_mod0],
		FLAG_VEHICLE[i][flag_mod1],
		FLAG_VEHICLE[i][flag_mod2],
		FLAG_VEHICLE[i][flag_mod3],
		FLAG_VEHICLE[i][flag_mod4],
		FLAG_VEHICLE[i][flag_mod5],
		FLAG_VEHICLE[i][flag_mod6],
		FLAG_VEHICLE[i][flag_mod7],
		FLAG_VEHICLE[i][flag_mod8],
		FLAG_VEHICLE[i][flag_mod9],
		FLAG_VEHICLE[i][flag_mod10],
		FLAG_VEHICLE[i][flag_mod11],
		FLAG_VEHICLE[i][flag_mod12],
		FLAG_VEHICLE[i][flag_mod13],
		FLAG_VEHICLE[i][flag_price]);
		fwrite(datei,line);
	}
	fclose(datei);
	return 1;
}
stock checkFormat(const str[])
{
	new jformat = 0;
	for(new i = 0;i<strlen(str);i++)
	{
	    if(str[i]!=0x2C)continue;
	    jformat++;
	}
	return jformat;
}
stock WithoutDirt(str[])
{
	new ln = strlen(str);
	if(str[ln-2]=='\r')str[ln-2] = '\0';
	if(str[ln-1]=='\n')str[ln-1] = '\0';
}
stock getFlagSlot()
{
	new i = 0;
	while(i<v_Cached && FLAG_VEHICLE[i][flag_model]>0)i++;
	if(i==v_Cached && FLAG_VEHICLE[i][flag_model]>0)return INVALID_FLAG_ID;
	return i;
}
stock strcpy(dest[],const source[])
{
	new jpos;
	while(source[jpos])dest[jpos] = source[jpos];
	return jpos;
}
stock tget(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ','))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ',') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
