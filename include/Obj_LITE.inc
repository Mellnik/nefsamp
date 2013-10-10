/*  Object Streamer RC 3
 *  10.06.2008
 *  
 *  (c) Copyright 2008, Einstein
 *
 */
 
 /*
native CreateObjectToStream(modelid, Float:x, Float:y, Float:z, Float:rX, Float:rY, Float:rZ);
native DestroyObjectToStream(streamobjectid);
native GetCurrentPosObjectToStream(streamobjectid, &Float:x, &Float:y, &Float:z);
native SetObjectPosToStream(streamobjectid, Float:x, Float:y, Float:z);
native SetObjectRotToStream(streamobjectid, Float:rX, Float:rY, Float:rZ);
native StreamObject_OnGameModeInit();
native StreamObject_OnGameModeExit();
native StreamObject_OnPlayerDisconnect(playerid);
 */


#define MAX_STREAM_OBJECTS 10000

forward ObjectCheck(playerid);

new ObjectCount[MAX_PLAYERS];
new haveobject[MAX_PLAYERS][MAX_STREAM_OBJECTS];
new ID;
new modelid2[MAX_STREAM_OBJECTS];
new Float:x2[MAX_STREAM_OBJECTS];
new Float:y2[MAX_STREAM_OBJECTS];
new Float:z2[MAX_STREAM_OBJECTS];
new Float:rX2[MAX_STREAM_OBJECTS];
new Float:rY2[MAX_STREAM_OBJECTS];
new Float:rZ2[MAX_STREAM_OBJECTS];
new ViewDistance2[MAX_STREAM_OBJECTS];
new objectres[MAX_PLAYERS][MAX_STREAM_OBJECTS];
new timertokill;

//From the Samp Forums: Usual Functions, Edited by Me

stock IsPlayerInBall(playerid,Float:x,Float:y,Float:z,radius)
	{
	if(GetPlayerDistanceToPoint(playerid,x,y,z) < radius)
		{
		return 1;
		}
	return 0;
}


stock GetPlayerDistanceToPoint(playerid,Float:x,Float:y,Float:z)
	{
	new Float:x1,Float:y1,Float:z1;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(Float:x,x1)),2)+floatpower(floatabs(floatsub(Float:y,y1)),2)+floatpower(floatabs(floatsub(Float:z,z1)),2));
	return floatround(tmpdis);
}

//ObjectStreamer Functions
stock CreateObjectToStream(modelid, Float:x, Float:y, Float:z, Float:rX, Float:rY, Float:rZ)
	{
	modelid2[ID] = modelid;
	x2[ID] = Float:x;
	y2[ID] = Float:y;
	z2[ID] = Float:z;
	rX2[ID] = Float:rX;
	rY2[ID] = Float:rY;
	rZ2[ID] = Float:rZ;
	ViewDistance2[ID] = 142;
	ID++;
	return ID-1;
	}

stock DestroyObjectToStream(streamobjectid)
	{
	modelid2[streamobjectid] = 0;
	x2[streamobjectid] = 0;
	y2[streamobjectid] = 0;
	z2[streamobjectid] = -1000;
	rX2[streamobjectid] = 0;
	rY2[streamobjectid] = 0;
	rZ2[streamobjectid] = 0;
	ViewDistance2[streamobjectid] = 0;
	for(new i=0; i<MAX_PLAYERS; i++)
		{
		if(haveobject[i][streamobjectid] == 1)
			{
			DestroyPlayerObject(i, objectres[i][streamobjectid]);
			}
		haveobject[i][streamobjectid] = -1;
		}
	}

stock GetCurrentPosObjectToStream(streamobjectid, &Float:x, &Float:y, &Float:z)
	{
	x = x2[streamobjectid];
	y = y2[streamobjectid];
	z = z2[streamobjectid];
	}
	
stock SetObjectPosToStream(streamobjectid, Float:x, Float:y, Float:z)
	{
	for(new i=0; i<MAX_PLAYERS; i++)
		{
		if(haveobject[i][streamobjectid] == 1)
			{
			SetPlayerObjectPos(i, objectres[i][streamobjectid], x, y, z);
			}
		}
	x2[streamobjectid] = x;
	y2[streamobjectid] = y;
	z2[streamobjectid] = z;
	}

stock SetObjectRotToStream(streamobjectid, Float:rX, Float:rY, Float:rZ)
	{
	for(new i=0; i<MAX_PLAYERS; i++)
		{
		if(haveobject[i][streamobjectid] == 1)
			{							
			SetPlayerObjectRot(i, objectres[i][streamobjectid], rX, rY, rZ);
			}
		}
	rX2[streamobjectid] = Float:rX;
	rY2[streamobjectid] = Float:rY;
	rZ2[streamobjectid] = Float:rZ;
	}						
					
stock StreamObject_OnGameModeInit()
	{
	timertokill = SetTimer("ObjectCheck", 542, 1);
	}

stock StreamObject_OnPlayerDisconnect(playerid)
	{
	for(new k=0; k<ID; k++)
		{
		haveobject[playerid][k] = 0;
		objectres[playerid][k] = -1;
		}
	}

stock StreamObject_OnGameModeExit()
	{
	KillTimer(timertokill);
	}	

public ObjectCheck()
	{
	for(new i=0; i<GetMaxPlayers(); i++)
		{
		if(IsPlayerConnected(i))
			{
			for(new objects=0; objects<ID; objects++)
				{
				if(IsPlayerInBall(i,x2[objects], y2[objects],z2[objects], ViewDistance2[objects]))
					{
					if(ObjectCount[i] < 142)
						{
						if(haveobject[i][objects] == 0)
							{
							objectres[i][objects] = CreatePlayerObject(i, modelid2[objects], x2[objects], y2[objects], z2[objects], rX2[objects], rY2[objects], rZ2[objects]);
							ObjectCount[i]++;
							haveobject[i][objects] = 1;
							}
						}
					}
				else
					{
					if(haveobject[i][objects] == 1)
						{
						DestroyPlayerObject(i, objectres[i][objects]);
						ObjectCount[i]--;
						haveobject[i][objects] = 0;
						}
					}
				}
			}	
		}	
	return 1;
	}

