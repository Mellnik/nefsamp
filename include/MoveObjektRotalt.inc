#include <a_samp>
forward MoveObjektRot(oid,Float:rx, Float:ry, Float:rz, geschw);
forward MoveRot(oid,Float:rx, Float:ry, Float:rz, geschw, Float:dx, Float:dy, Float:dz);
public MoveObjektRot(oid,Float:rx, Float:ry, Float:rz, geschw) {
	new Float:x, Float:y, Float:z, Float:dx, Float:dy, Float:dz;
	GetObjectRot(oid,x,y,z);
	dx=(rx-x)/geschw;
	dy=(ry-y)/geschw;
	dz=(rz-z)/geschw;
	SetObjectRot(oid,x+dx,y+dy,z+dz);
	geschw--;
	SetTimerEx("MoveRot",50,0,"dfffdfff",oid,rx,ry,rz,geschw,dx,dy,dz);
	return 1;
}
public MoveRot(oid,Float:rx, Float:ry, Float:rz, geschw, Float:dx, Float:dy, Float:dz) {
	new Float:x, Float:y, Float:z;
	GetObjectRot(oid,x,y,z);
	SetObjectRot(oid,x+dx,y+dy,z+dz);
	geschw--;
	if(geschw>=1) {
	SetTimerEx("MoveRot",50,0,"dfffdfff",oid,rx,ry,rz,geschw,dx,dy,dz); }
	return 1;
}