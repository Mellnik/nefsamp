////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Credits:
// Script erstellt von Stas
// Offizieller Scripter der Xtreme - RolePlay - Community
// www.xtreme-roleplay.eu
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Einstellungen
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define MAX_BLITZER 15 // Maximale Anzahl von Blitzern
#define BLITZER_TIMER_INTERVALL 500 // Intervall für das Blitzen (in Milliesekunden)
#define BLITZER_PAUSE 2 // Anzahl der Minuten, in denen der Spieler nicht mehr geblitzt werden kann
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// globale Variablen
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum eBlitzer {
	ID, Float:BlitzerX, Float:BlitzerY, Float:BlitzerZ, Radius, Geschwindigkeit, Erstellt
};
new Blitzer[MAX_BLITZER][eBlitzer];
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CallBacks
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
forward Blitzer_Timer();
public Blitzer_Timer() {
    new save, strafe, speed;
 	for (new playerid = 0; playerid < MAX_PLAYERS; playerid++) {
 	    save = GetPVarInt(playerid, "BlitzPause");
		if(save > 0) {
			save--;
			SetPVarInt(playerid, "BlitzPause", save);
			continue;
		}
 		if(!IsPlayerInAnyVehicle(playerid) || IsPlayerNPC(playerid)) continue;
		for(new i = 0; i < sizeof(Blitzer); i++) {
			if(Blitzer[i][Erstellt] == 1) {
			    if(IsPlayerInRangeOfPoint(playerid, Blitzer[i][Radius], Blitzer[i][BlitzerX], Blitzer[i][BlitzerY], Blitzer[i][BlitzerZ])) {
					speed = ErmittleGeschwindigkeit(playerid,true);
					if(speed > Blitzer[i][Geschwindigkeit]) {
						new string[128];
						// Einstellen des Momentes, in dem der Spieler kein weiteres mal geblitzt werden kann
						SetPVarInt(playerid, "BlitzPause", (BLITZER_TIMER_INTERVALL * BLITZER_PAUSE * 60) / 1000);
						// Strafe für Spieler
						strafe = (speed*2) - Blitzer[i][Geschwindigkeit];
						PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0.0);
					   	GivePlayerMoney(playerid, -strafe);
						// Text für Spieler
						SendClientMessage(playerid, 0xFF6347AA,"Du wurdest wegen zu hoher Geschwindigkeit geblitzt!");
						format(string,sizeof(string), "Du bist %d km/h gefahren und musst $%d Bußgeld bezahlen.", speed, strafe);
						SendClientMessage(playerid, 0xFF6347AA, string);
					}
				}
			}
		}
	}
	return 1;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Funktionen
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
stock AddBlitzer(playerid,speed,radius) {
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid,x,y,z);
	for(new i = 0; i < sizeof(Blitzer); i++) {
  	    if(Blitzer[i][Erstellt] == 0) {
			Blitzer[i][BlitzerX] = x + 1.0;
		    Blitzer[i][BlitzerY] = y + 1.0;
		    Blitzer[i][BlitzerZ] = z;
		    Blitzer[i][Geschwindigkeit] = speed;
		    Blitzer[i][Radius] = radius;
		    Blitzer[i][Erstellt] = 1;
		    Blitzer[i][ID] = CreateObject(1278, x + 1.0, y + 1.0, z, 0.0, 0.0, 10);
		    return 1;
		}
	}
	return 0;
}
stock RemoveBlitzer(playerid) {
   	for(new i = 0; i < sizeof(Blitzer); i++) {
	   if(Blitzer[i][Erstellt] == 1) {
			if(IsPlayerInRangeOfPoint(playerid, Blitzer[i][eRadius], Blitzer[i][BlitzerX], Blitzer[i][BlitzerY], Blitzer[i][BlitzerZ])) {
				Blitzer[i][Erstellt] = 0;
    			Blitzer[i][BlitzerX] = 0.0;
		        Blitzer[i][BlitzerY] = 0.0;
	         	Blitzer[i][BlitzerZ] = 0.0;
           		DestroyObject(Blitzer[i][ID]);
             	return 1;
  	        }
  	    }
  	}
   	return 0;
}
stock RemoveAllBlitzer() {
   	for(new i = 0; i < sizeof(Blitzer); i++) {
		if(Blitzer[i][Erstellt] == 1) {
			Blitzer[i][Erstellt] = 0;
			Blitzer[i][BlitzerX] = 0.0;
   			Blitzer[i][BlitzerY] = 0.0;
     		Blitzer[i][BlitzerZ] = 0.0;
    		DestroyObject(Blitzer[i][ID]);
  	    }
  	}
   	return 0;
}
stock CountBlitzer() {
   	new anzahl = 0;
	for(new i = 0; i < sizeof(Blitzer); i++) {
		if(Blitzer[i][Erstellt] == 1) anzahl++;
  	}
   	return anzahl;
}
stock ErmittleGeschwindigkeit(playerid,bool:kmh) {
    new Float:x,Float:y,Float:z,Float:rtn;
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),x,y,z); else GetPlayerVelocity(playerid,x,y,z);
    rtn = floatsqroot(x*x+y*y+z*z);
    return kmh?floatround(rtn * 100 * 1.61):floatround(rtn * 100);
}
