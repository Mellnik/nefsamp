#include <a_samp>

forward PlayerToMPoint(Float:radi, playerid, Float:x, Float:y, Float:z);

forward PlayerObjectDisplayCheck();

#define MAX_MSTREAM_OBJECTS
#define SICHTWEITE 300

enum MObjectinfo
{
	Objmodel,
	Float:ObjX,
	Float:ObjY,
	Float:ObjZ,
	Float:ObjrX,
	Float:ObjrY,
	Float:ObjrZ
}

new Object[MAX_MSTREAM_OBJECTS][MObjectinfo];

OnInit()
{
	SetTimer("PlayerObjectDisplayCheck",500,true);
	print("MObjects by Maercell wurde geladen!!!");
}


stock CreateMObject(modelid,Float:X,Float:Y,Float:Z,Float:rX,Float:rY,Float:rZ)
{
	for(new id=0; id<MAX_PLAYERS; id++)
	for(new obj=0; obj<MAX_MSTREAM_OBJECTS; obj++
	{
		Object[obj][Objmodel] = modelid;
		Object[obj][Float:ObjX] = Float:X;
		Object[obj][Float:ObjY] = Float:Y;
		Object[obj][Float:ObjZ] = Float:Z;
		Object[obj][Float:ObjrX] = Float:rX;
		Object[obj][Float:ObjrY] = Float:rY;
		Object[obj][Float:ObjrZ] = Float:rZ;
		
^		CreatePlayerObject(id,Object[obj][Objmodel],
				      Object[obj][Float:ObjX],
                                      Object[obj][Float:ObjY],
				      Object[obj][Float:ObjZ],
			 	      Object[obj][Float:ObjrX],
			 	      Object[obj][Float:ObjrY],
			 	      Object[obj][Float:ObjrZ]);
	}
}



public PlayerToMPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}