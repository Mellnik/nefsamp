/* BFX iStream 2.0 (c) by BlackFoX_UD_

	.. Underground Clan ..

native bCreateMapIcon(Float:x,Float:y,Float:z,maptype,color);
native bRemoveMapIcon(id);
*/
forward OnBFXMapIconStreamIn(iconid,forplayerid,erstellt);
forward OnBFXMapIconStreamOut(iconid,forplayerid,erstellt);
stock bCreateMapIcon(Float:x,Float:y,Float:z = (16.7380),maptype,color = 0,interior = 0,virtualworld = 0)return CallRemoteFunction("CreateMapIcon","fffiiii",x,y,z,maptype,color,interior,virtualworld);
stock bRemoveMapIcon(id)return CallRemoteFunction("RemoveMapIcon","i",id);

