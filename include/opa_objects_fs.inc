/****************************************

 #######   ########  ########
#       #  #      #  #      #
#       #  #      #  #      #
#       #  #      #  #      #  #####
#       #  ########  ########  #
#       #  #         #      #  #####
#       #  #         #      #      #
 #######   #         #      #  #####
 
 >> OBJECTSTREAMER   <<
 >> VERSION 3.0.1    <<
 >> FILTERSCRIPT INC <<

*****************************************
Use the standard functions and:
native RotateObject(objectid,Float:rX,Float:rY,Float:rZ,time);
native IsObjectStreamedIn(objectid,forplayerid);
native WaitForMap(playerid);
****************************************/
#include <a_samp>
#if defined _opa_obj_included
#endinput
#endif
#define _opa_obj_included
#pragma library opa_obj
forward opa_obj_OnFilterScriptInit();
forward remoteExit();
forward remoteNumber(opa1);
forward OnObjectStreamIn(objectid,forplayerid);
forward OnObjectStreamOut(objectid,forplayerid);
new opaEnte;
public OnFilterScriptInit()
{
    print("\n...Opas Objectstremer loading [2/2]...\n");
	CallRemoteFunction("remoteConnectFS"," ");
	CallLocalFunction("opa_obj_OnFilterScriptInit"," ");
}
public remoteExit()
{
	opaEnte=0;
}
public remoteNumber(opa1)
{
	opaEnte=opa1;
}
stock opaCreateObject(opa1,Float:opa2,Float:opa3,Float:opa4,Float:opa5,Float:opa6,Float:opa7,opa8=-1)
{
	if(!CallRemoteFunction("remoteObject","dffffff",opa1,opa2,opa3,opa4,opa5,opa6,opa7))return -1;
	if(opa8!=-1)CallRemoteFunction("remoteVirtual","dd",opaEnte-1,opa8);
	return opaEnte-1;
}
stock SetObjectVirtualWorld(opa1,opa2)return CallRemoteFunction("remoteVirtual","dd",opa1,opa2);
stock opaMoveObject(opa1,Float:opa2,Float:opa3,Float:opa4,Float:opa5)return CallRemoteFunction("remoteMove","dffff",opa1,opa2,opa3,opa4,opa5);
stock opaSetObjectPos(opa1,Float:opa2,Float:opa3,Float:opa4)return CallRemoteFunction("remoteSetPos","dfff",opa1,opa2,opa3,opa4);
stock opaSetObjectRot(opa1,Float:opa2,Float:opa3,Float:opa4)return CallRemoteFunction("remoteSetRot","dfff",opa1,opa2,opa3,opa4);
stock opaDestroyObject(opa1)return CallRemoteFunction("remoteDestroy","d",opa1);
stock opaStopObject(opa1)return CallRemoteFunction("remoteStop","d",opa1);
stock CreateObjectEx(opa1,Float:opa2,Float:opa3,Float:opa4,Float:opa5,Float:opa6,Float:opa7)
{
    CallRemoteFunction("remoteObjectEx"," ");
	return CreateObject(opa1,opa2,opa3,opa4,opa5,opa6,opa7);
}
stock MoveObjectEx(opa1,Float:opa2,Float:opa3,Float:opa4,Float:opa5)return MoveObject(opa1,opa2,opa3,opa4,opa5);
stock SetObjectPosEx(opa1,Float:opa2,Float:opa3,Float:opa4)return SetObjectPosEx(opa1,opa2,opa3,opa4);
stock SetObjectRotEx(opa1,Float:opa2,Float:opa3,Float:opa4)return SetObjectRot(opa1,opa2,opa3,opa4);
stock DestroyObjectEx(opa1)
{
    CallRemoteFunction("remoteDestroyEx"," ");
	return DestroyObject(opa1);
}
stock StopObjectEx(opa1)return StopObjectEx(opa1);
stock WaitForMap(opa1)return CallRemoteFunction("remoteMakeWait","d",opa1);
stock IsObjectStreamedIn(opa1,opa2)return CallRemoteFunction("remoteIsStreamed","dd",opa1,opa2);
stock RotateObject(opa1,Float:opa2,Float:opa3,Float:opa4,opa5)return CallRemoteFunction("remoteMoveRot","dfffd",opa1,opa2,opa3,opa4,opa5);
#define CreateObject opaCreateObject
#define MoveObject opaMoveObject
#define SetObjectPos opaSetObjectPos
#define SetObjectRot opaSetObjectRot
#define DestroyObject opaDestroyObject
#define StopObject opaStopObject
#define OnFilterScriptInit opa_obj_OnFilterScriptInit
