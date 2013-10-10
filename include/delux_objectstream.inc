/*  Object Streamer
 *
 *  Copyright 2008, Einstein
 *	Copyright 2008, delux-host
 */

 
#define MAX_STREAM_OBJECTS 5000
#define MAX_TO_STREAM_OBJECTS 145
#define STANDART_STREAM_DISTANCE 150
#define MAX_STREAM_FILES

forward ObjectStreamProcess();

new ObjectToStreamID = 0;
new ObjectToStreamM[MAX_STREAM_OBJECTS];
new Float:ObjectToStreamX[MAX_STREAM_OBJECTS];
new Float:ObjectToStreamY[MAX_STREAM_OBJECTS];
new Float:ObjectToStreamZ[MAX_STREAM_OBJECTS];
new Float:ObjectToStreamRX[MAX_STREAM_OBJECTS];
new Float:ObjectToStreamRY[MAX_STREAM_OBJECTS];
new Float:ObjectToStreamRZ[MAX_STREAM_OBJECTS];
new ObjectToStreamVD[MAX_PLAYERS][MAX_STREAM_OBJECTS];
new ObjectToStreamPD[MAX_PLAYERS][MAX_STREAM_OBJECTS];
new ObjectToStreamOR[MAX_PLAYERS][MAX_STREAM_OBJECTS];
new ObjectToStreamPO[MAX_PLAYERS];
new ObjectToStreamFID = 0;
new ObjectToStreamFO[MAX_STREAM_FILES][2];

stock CreateObjectToStream(modelid, Float:x, Float:y, Float:z, Float:rX, Float:rY, Float:rZ)
	{
	ObjectToStreamM[ObjectToStreamID] = modelid;
	ObjectToStreamX[ObjectToStreamID] = x;
	ObjectToStreamY[ObjectToStreamID] = y;
	ObjectToStreamZ[ObjectToStreamID] = z;
	ObjectToStreamRX[ObjectToStreamID] = rX;
	ObjectToStreamRY[ObjectToStreamID] = rY;
	ObjectToStreamRZ[ObjectToStreamID] = rZ;
	for(new playerid=0; playerid<GetMaxPlayers(); playerid++)
	    {
		ObjectToStreamVD[playerid][ObjectToStreamID] = STANDART_STREAM_DISTANCE;
		}
 	ObjectToStreamID++;
 	return ObjectToStreamID-1;
	}

stock CreatePlayerObjectToStream(playerid, modelid, Float:x, Float:y, Float:z, Float:rX, Float:rY, Float:rZ)
	{
	ObjectToStreamM[ObjectToStreamID] = modelid;
	ObjectToStreamX[ObjectToStreamID] = x;
	ObjectToStreamY[ObjectToStreamID] = y;
	ObjectToStreamZ[ObjectToStreamID] = z;
	ObjectToStreamRX[ObjectToStreamID] = rX;
	ObjectToStreamRY[ObjectToStreamID] = rY;
	ObjectToStreamRZ[ObjectToStreamID] = rZ;
	ObjectToStreamVD[playerid][ObjectToStreamID] = STANDART_STREAM_DISTANCE;
 	ObjectToStreamID++;
 	for(new players=0; players<GetMaxPlayers(); players++)
 	    {
        ObjectToStreamPD[players][streamobjectid] = -1;
        }
    ObjectToStreamPD[playerid][streamobjectid] = 0;
 	return ObjectToStreamID-1;
	}

stock  DestroyObjectToStream(streamobjectid)
	{
	for(new playerid=0; playerid<GetMaxPlayers(); playerid++)
	    {
	    if(ObjectToStreamPD[playerid][streamobjectid] == 1 && IsPlayerConnected(playerid))
	        {
	        DestroyPlayerObject(playerid, ObjectToStreamOR[playerid][streamobjectid]);
	        ObjectToStreamPD[playerid][streamobjectid] = 0;
	        ObjectToStreamPO[playerid]--;
	        }
		}
	ObjectToStreamX[streamobjectid] = 0;
	ObjectToStreamY[streamobjectid] = 0;
	ObjectToStreamZ[streamobjectid] = -1000000;
	}

stock MoveObjectToStream(streamobjectid, Float:moveX, Float:moveY, Float:moveZ, Float:moveSpeed)
	{
	ObjectToStreamX[ObjectToStreamID] = moveX;
	ObjectToStreamY[ObjectToStreamID] = moveY;
	ObjectToStreamZ[ObjectToStreamID] = moveZ;
	for(new playerid=0; playerid<GetMaxPlayers(); playerid++)
	    {
		if(ObjectToStreamPD[playerid][streamobjectid] == 1 && IsPlayerConnected(playerid))
		    {
		    MovePlayerObject(playerid, ObjectToStreamOR[playerid][streamobjectid], moveX, moveY, moveZ, moveSpeed);
		    }
		}
	}

stock SetObjectPosToStream(streamobjectid, Float:X, Float:Y, Float:Z)
	{
	ObjectToStreamX[ObjectToStreamID] = X;
	ObjectToStreamY[ObjectToStreamID] = Y;
	ObjectToStreamZ[ObjectToStreamID] = Z;
	for(new playerid=0; playerid<GetMaxPlayers(); playerid++)
	    {
		if(ObjectToStreamPD[playerid][streamobjectid] == 1 && IsPlayerConnected(playerid))
		    {
		    SetPlayerObjectPos(playerid, ObjectToStreamOR[playerid][streamobjectid], X, Y, Z);
		    }
		}
	}

stock SetObjectRotToStream(streamobjectid, Float:RX, Float:RY, Float:RZ)
	{
	ObjectToStreamRX[ObjectToStreamID] = RX;
	ObjectToStreamRY[ObjectToStreamID] = RY;
	ObjectToStreamRZ[ObjectToStreamID] = RZ;
	for(new playerid=0; playerid<GetMaxPlayers(); playerid++)
	    {
		if(ObjectToStreamPD[playerid][streamobjectid] == 1 && IsPlayerConnected(playerid))
		    {
		    SetPlayerObjectPos(playerid, ObjectToStreamOR[playerid][streamobjectid], RX, RY, RZ);
		    }
		}
	}

stock GetObjectPosToStream(streamobjectid, &Float:X, &Float:Y, &Float:Z)
	{
	X = ObjectToStreamX[stremobjectid];
	Y = ObjectToStreamY[stremobjectid];
	Z = ObjectToStreamZ[stremobjectid];
	}

stock GetObjectRotToStream(streamobjectid, &Float:RX, &Float:RY, &Float:RZ)
	{
	RX = ObjectToStreamX[stremobjectid];
	RY = ObjectToStreamY[stremobjectid];
	RZ = ObjectToStreamZ[stremobjectid];
	}

stock SetGlobalViewDistanceToStream(Viewdistance)
	{
	for(new playerid=0; playerid<GetMaxPlayers(); playerid++)
	    {
    	for(new streamobjectid=0; streamobjectid<ObjectToStreamID; streamobjectid++)
		    {
	     	ObjectToStreamVD[playerid][streamobjectid] = Viewdistance;
		    }
		}
	}

stock SetGlobalPViewDistanceToStream(playerid, Viewdistance)
	{
	for(new streamobjectid=0; streamobjectid<ObjectToStreamID; streamobjectid++)
	    {
	    ObjectToStreamVD[playerid][streamobjectid] = Viewdistance;
		}
	}

stock SetObjectViewDistanceToStreamEx(streamobjectidMIN, streamobjectidMAX, Viewdistance)
	{
	for(new playerid=0; playerid<GetMaxPlayers(); playerid++)
	    {
    	for(new streamobjectid=streamobjectidMIN; streamobjectid<streamobjectidMAX; streamobjectid++)
		    {
		    ObjectToStreamVD[playerid][streamobjectid] = ViewDistance;
		    }
		}
	}


stock LoadObjectsToStreamFromFile(const filename[])
	{
	new index;
	new File:file_ptr;
	new line[256];
	new var_from_line[64];
	new modelid;
	new Float:X;
	new Float:Y;
	new Float:Z;
	new Float:RX;
	new Float:RY;
	new Float:RZ;
	new loaded;
	new objectidload;

	new strfile[256];
	format(strfile, 256, "%s.delux", filename);
	file_ptr = fopen(strfile,filemode:io_read);
	if(!file_ptr) return false;

	while(fread(file_ptr,line,256) > 0)
		{
	    index = 0;
  		index = token_by_delim(line,var_from_line,'|',index);
  		if(index == (-1)) continue;
  		modelid = strval(var_from_line);
  		index = token_by_delim(line,var_from_line,'|',index+1);
  		if(index == (-1)) continue;
  		X = floatstr(var_from_line);
  		index = token_by_delim(line,var_from_line,'|',index+1);
  		if(index == (-1)) continue;
  		Y = floatstr(var_from_line);
  		index = token_by_delim(line,var_from_line,'|',index+1);
  		if(index == (-1)) continue;
  		Z = floatstr(var_from_line);
  		index = token_by_delim(line,var_from_line,'|',index+1);
  		if(index == (-1)) continue;
  		RX = floatstr(var_from_line);
  		index = token_by_delim(line,var_from_line,'|',index+1);
  		if(index == (-1)) continue;
  		RY = floatstr(var_from_line);
  		index = token_by_delim(line,var_from_line,';',index+1);
  		if(index == (-1)) continue;
  		RZ = floatstr(var_from_line);
		if(loaded == 0) ObjectToStreamFO[ObjectToStreamFID][0] = CreateObjectToStream(modelid, X, Y, Z, RX, RY, RZ);
		else objectidload = CreateObjectToStream(modelid, X, Y, Z, RX, RY, RZ);
		loaded++;
		}

	fclose(file_ptr);
	ObjectToStreamFO[ObjectToStreamFID][1] = objectidload;
	printf("[delux Objectstreamer]Loaded %d objects from file %s", loaded++, filename);
	ObjectToStreamFID++;
	return ObjectToStreamFID-1;
	}

stock UnLoadObjectsToStreamFromFile(streamfileid)
	{
	for(new streamobjectid=ObjectToStreamFO[streamfileid][0]; streamobjectid<ObjectToStreamFO[streamfileid][1]; streamobjectid++)
	    {
	    DestroyObjectToStream(streamobjectid);
	    }
	}

stock delux_main()
	{
	for( ; ; )
		{
		sleep(497);
		ObjectStreamProcess();
		}
	}

stock delux_OnPlayerDisconnect(playerid)
	{
	for(new streamobjectid=0; streamobjectid<ObjectToStreamID; streamobjectid++)
	    {
	    ObjectToStreamPD[playerid][streamobjectid] = 0;
	    }
	}


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

stock token_by_delim(const string[], return_str[], delim, start_index)
	{
	new x=0;
	while(string[start_index] != EOS && string[start_index] != delim)
		{
	    return_str[x] = string[start_index];
	    x++;
	    start_index++;
	    }
	return_str[x] = EOS;
	if(string[start_index] == EOS) start_index = (-1);
	return start_index;
 	}


public ObjectStreamProcess()
	{
	for(new playerid=0; playerid<GetMaxPlayers(); playerid++)
	    {
		for(new streamobjectid=0; streamobjectid<ObjectToStreamID; streamobjectid++)
			{
			if(IsPlayerInBall(playerid, ObjectToStreamX[streamobjectid], ObjectToStreamY[streamobjectid], ObjectToStreamZ[streamobjectid], ObjectToStreamVD[playerid][streamobjectid]) == 1)
			    {
			    if(ObjectToStreamPD[playerid][streamobjectid] == 0)
			        {
			        if(ObjectToStreamPO[playerid] < MAX_TO_STREAM_OBJECTS)
			            {
						ObjectToStreamOR[playerid][streamobjectid] = CreatePlayerObject(playerid, ObjectToStreamM[streamobjectid], ObjectToStreamX[streamobjectid], ObjectToStreamY[streamobjectid], ObjectToStreamZ[streamobjectid], ObjectToStreamRX[streamobjectid], ObjectToStreamRY[streamobjectid], ObjectToStreamRZ[streamobjectid]);
						ObjectToStreamPD[playerid][streamobjectid] = 1;
						ObjectToStreamPO[playerid]++;
						}
			        }
			    }
			else
			    {
			    if(ObjectToStreamPD[playerid][streamobjectid] == 1)
					{
					DestroyPlayerObject(playerid, ObjectToStreamOR[playerid][streamobjectid]);
					ObjectToStreamPD[playerid][streamobjectid] = 0;
					ObjectToStreamPO[playerid]--;
					}
			    }
			}
	    }
	}