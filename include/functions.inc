stock getstrspc(string[], argument, searcher=' ') {
	new length = strlen(string), arg, result[30], index;
	for (new i = 0; i < length; i++) {
		if (string[i] == searcher || i == length || string[i + 1] == 10) {
			arg++;
			if (arg == argument + 1) {
				result[i-index] = EOS;
				return result;
			} else if (arg == argument)
				index = i+1;
		} else if (arg == argument)
	        	result[i - index] = string[i];
	}
	return result;
}

stock PlayerName(playerid) {
	new name[255];
	GetPlayerName(playerid, name, 255);
	return name;
}

stock Float:GetDistanceToCar(playerid,carid) {
	new Float:x1,Float:y1,Float:z1,Float:x3,Float:y3,Float:z3;
	if (!IsPlayerConnected(playerid)) {
		return -1.00;
	}
	GetPlayerPos(playerid,x1,y1,z1);
	GetVehiclePos(carid,x3,y3,z3);
	return floatsqroot(floatpower(floatabs(floatsub(x3,x1)),2)+floatpower(floatabs(floatsub(y3,y1)),2)+floatpower(floatabs(floatsub(z3,z1)),2));
}

stock Float:GetDistanceBetweenPlayers(p1,p2)
	{
	new Float:x1,Float:y1,Float:z1,Float:x3,Float:y3,Float:z3;
	if (!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
		{
		return -1.00;
		}
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x3,y3,z3);
	return floatsqroot(floatpower(floatabs(floatsub(x3,x1)),2)+floatpower(floatabs(floatsub(y3,y1)),2)+floatpower(floatabs(floatsub(z3,z1)),2));
	}

stock GetClosestCar(playerid)
{
	if (!IsPlayerConnected(playerid))
		{
	    return -1;
		}
	new Float:prevdist = 100000.000;
	new prevcar;
	for (new carid = 0; carid < MAX_VEHICLES; carid++)
		{
 		new Float:dist = GetDistanceToCar(playerid,carid);
		if ((dist < prevdist))
			{
			prevdist = dist;
			prevcar = carid;
   			}
		}
	return prevcar;
}

stock GetClosestPlayer(p1)
	{
	new i,Float:dis,Float:dis2,player;
	player = -1;
	dis = 99999.99;
	for (i=0;i<MAX_PLAYERS;i++)
		{
		if (i != p1)
			{
			dis2 = GetDistanceBetweenPlayers(i,p1);
			if (dis2 < dis && dis2 != -1.00)
				{
				dis = dis2;
				player = i;
				}
			}
		}
	return player;
}

stock IsPlayerInCircle(playerid,Float:x,Float:y,radius)
	{
	if(GetPlayerDistanceToPoint6666(playerid,x,y) < radius)
		{
		return 1;
		}
	return 0;
}

stock GetPlayerDistanceToPoint6666(playerid,Float:x,Float:y)
	{
	new Float:x1,Float:y1,Float:z1;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(Float:x,x1)),2)+floatpower(floatabs(floatsub(Float:y,y1)),2));
	return floatround(tmpdis);
}

stock GetVehicleWithinDistance( playerid, Float:x1, Float:y1, Float:z1, Float:dist, &veh){
	new near=-1;
	for(new i = 1; i < MAX_VEHICLES; i++){
		if(GetVehicleModel(i) > 0){
			if(GetPlayerVehicleID(playerid) != i ){
	        	new Float:x, Float:y, Float:z;
	        	new Float:x3, Float:y3, Float:z3;
				GetVehiclePos(i, x, y, z);
				x3 = x1 - x; y3 = y1 - y; z3 = z1 - z;
				new Float:vDist = (x3*x3+y3*y3+z3*z3);
				if( vDist < dist){
					near = i;
					veh = near;
				}
			}
		}
	}
}

stock IsABicycle(vehicleid)
{
	new model = GetVehicleModel(vehicleid);
	switch(model)
	{
		case 481,509,510: return 1;
		default: return 0;
	}
	return 1;
}

stock IsABoat(vehicleid)
{
	new model = GetVehicleModel(vehicleid);
	switch(model)
	{
		case 430,446,452,453,454,472,473,484,493,595: return 1;
		default: return 0;
	}
	return 1;
}

stock IsABike(vehicleid)
{
	new model = GetVehicleModel(vehicleid);
	switch(model)
	{
		case 471,448,461,462,463,468,521,522,523,581,586: return 1;
		default: return 0;
	}
	return 1;
}

stock IsACar(vehicleid)
{
	new model = GetVehicleModel(vehicleid);
	switch(model)
	{
		case 481,509,510,430,446,452,453,454,472,473,484,493,595,460,464,476,511,512: return 1;
        	case 513,519,520,539,553,577,592,593,517,425,447,465,469,487,488,497,501,548,563: return 1;
		default: return 0;
	}
	return 1;
}

stock IsAPlane(vehicleid)
{
	new model = GetVehicleModel(vehicleid);
	switch(model)
	{
		case 460,464,476,511..513,519,520,539,553,577,592,593,417,425,447,465: return 1;
		case 469,487,488,497,501,548,563: return 1;
		default: return 0;
	}
	return 1;
}

stock IsVehicleNotAttachable(carid)
{
	switch(GetVehicleModel(carid))
	{
	case 448,461,462,463,468,471,481,509,510,521,522,523,581,586: {return 1;}
	}
	return 0;
}

RMB1(buf[]) {
	new length=strlen(buf);
	new a;
	new s1 = 2;
	new s2 = 3;
   	new s3 = 5;
   	new s4 = 7;
   	new s5 = 9;
   	new s6 = 11;
   	new s7 = 13;
   	new s8 = 17;
   	new s9 = 7919;
   	new s10 = 7907;
   	new s11 = 7901;
   	new s12 = 7883;
   	new s13 = 7879;
   	new s14 = 7877;
   	new s15 = 7873;
   	new s16 = 7867;

    for (a=0; a<length; a++)
    {
        s1 = (s1 + buf[a]) * 65521;
        s2 = (s2 / s1 + buf[a]) * 65521;
        s3 = (s3 * s2 / s1 + buf[a]) * 65521;
        s4 = (s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s5 = (s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s6 = (s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s7 = (s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s8 = (s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s9 = (s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s10 = (s10 * s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s11 = (s11 - s10 * s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s12 = (s12 + s11 - s10 * s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s13 = (s13 / s12 + s11 - s10 * s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s14 = (s14 * s13 / s12 + s11 - s10 * s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s15 = (s15 - s14 * s13 / s12 + s11 - s10 * s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s16 = (s16 + s15 - s14 * s13 / s12 + s11 - s10 * s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
    }
    return (s16 << 128) * s1 * s2 * s3 * s4 * s5 * s6 * s7 + s8 + s9 + s10 + s11 + s12 + s13 + s14 + s15 + s16;
}

stock ValidEmail(email[]) {
  new len=strlen(email);
  new cstate=0;
  new i;
  for(i=0;i<len;i++) {
    if ((cstate==0 || cstate==1) && (email[i]>='A' && email[i]<='Z') || (email[i]>='a' && email[i]<='z')  || (email[i]=='.')  || (email[i]=='-')  || (email[i]=='_'))
    {
    } else {
       // Ok no A..Z,a..z,_,.,-
       if ((cstate==0) &&(email[i]=='@')) {
          // its an @ after the name, ok state=1;
          cstate=1;
       } else {
          // Its stuff which is not allowed
          return false;
       }
    }
  }
  if (cstate<1) return false;
  if (len<6) return false;
  // A toplevel domain has only 3 to 4 signs :-)
  if ((email[len-3]=='.') || (email[len-4]=='.') || (email[len-5]=='.')) return true;
  return false;
}

stock Time() {
  new hour,minute,second;
  new year, month,day;
  gettime(hour, minute, second);
  getdate(year, month, day);
  return mktime(hour,minute,second,day,month,year);
}

stock mktime(hour,minute,second,day,month,year) {
	new timestamp2;

	timestamp2 = second + (minute * 60) + (hour * 3600);

	new days_of_month[12];

	if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) {
			days_of_month = {31,29,31,30,31,30,31,31,30,31,30,31}; // Schaltjahr
		} else {
			days_of_month = {31,28,31,30,31,30,31,31,30,31,30,31}; // keins
		}
	new days_this_year = 0;
	days_this_year = day;
	if(month > 1) { // No January Calculation, because its always the 0 past months
		for(new i=0; i<month-1;i++) {
			days_this_year += days_of_month[i];
		}
	}
	timestamp2 += days_this_year * 86400;

	for(new j=1970;j<year;j++) {
		timestamp2 += 31536000;
		if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) )  timestamp2 += 86400; // Schaltjahr + 1 Tag
	}

	return timestamp2;
}

