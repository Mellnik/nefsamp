////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Credits:
// Script erstellt von Prepear

#define MAX_BAEUME 100 // Maximale Anzahl von Weihnachtsbäumen

enum eBaum {
	ID, Float:BaumX, Float:BaumY, Float:BaumZ, nErstellt
};
new Baum[MAX_BAEUME][eBaum];

stock AddBaum(playerid) {
	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid, a);
	for(new i = 0; i < sizeof(Baum); i++) {
  	    if(Baum[i][nErstellt] == 0) {
		    Baum[i][BaumX] = x;
		    Baum[i][BaumY] = y;
		    Baum[i][BaumZ] = z - 0.7;
		    Baum[i][nErstellt] = 1;
		    Baum[i][ID] = CreateObject(19076, x, y - 0.7, z - 1, 0.0, 0.0, a - 90.0);
		    return 1;
		}
	}
	return 0;
}
stock RemoveBaum(playerid) {
   	for(new i = 0; i < sizeof(Baum); i++) {
		if(IsPlayerInRangeOfPoint(playerid, 3, Baum[i][BaumX], Baum[i][BaumY], Baum[i][BaumZ])) {
			if(Baum[i][nErstellt] == 1) {
				Baum[i][nErstellt] = 0;
    			Baum[i][BaumX] = 0.0;
		        Baum[i][BaumY] = 0.0;
	         	Baum[i][BaumZ] = 0.0;
           		DestroyObject(Baum[i][ID]);
             	return 1;
  	        }
  	    }
  	}
   	return 0;
}