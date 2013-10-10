	    ////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-//
	   //						 FOXHOUND'S EASY PAYDAY SCRIPT						//
	  //								  FoxPayDay!							   //
	 //					       COPYRIGHT BY FOXHOUND / PSPGAMER					  //
	////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-//

#include <a_samp>

#pragma unused pdtimer
#pragma unused FPD_ret_memcpy

//---------------------------< _-_-_-_-_ >---------------------------//
	  #define PayDaySaveDir "FoxPayDay/%s.fpd" //PayDay Data Save Directory
	  #define pdprotime 60					   //payday pro 60 minutes (minutes)
//-------------------------------------------------------------------//

forward OnPlayerPayDay(playerid);

new pdtimer[MAX_PLAYERS],pdplus[MAX_PLAYERS];

#define SetPlayerPayDayTime(%1,%2) pdplus[%1] = %2
forward GetPlayerPayDayTime(playerid);public GetPlayerPayDayTime(playerid) { return pdplus[playerid]; }
#define StartPayDayTime(%1) pdtimer[%1] = SetTimerEx("pluspdtime",60000,1,"i",%1)
#define StopPayDayTime(%1) KillTimer(pdtimer[%1])
stock pluspdtime(playerid) 
{ 
	new fpd_str_[64],fpd_pname_[MAX_PLAYER_NAME];
	GetPlayerName(playerid,fpd_pname_,sizeof(fpd_pname_));
	format(fpd_str_,sizeof(fpd_str_),PayDaySaveDir,fpd_pname_);
	if(!FPD_dini_Exist(fpd_str_)) { FPD_dini_Create(fpd_str_); }
	pdplus[playerid]+=1;
	if(pdplus[playerid] >= pdprotime)
	{
		CallLocalFunction("OnPlayerPayDay","i",playerid);
		pdplus[playerid] = 0;
	}
	FPD_dini_IntSet(fpd_str_,"PayDayTime",pdplus[playerid]);
}

stock FPD_set(dest[],source[]) {
	new count = strlen(source),i=0; for (i=0;i<count;i++) {
		dest[i]=source[i]; }
	dest[count]=0; }
FPD_ret_memcpy(source[],index=0,numbytes) {
	new tmp[255],i=0; tmp[0]=0; if (index>=strlen(source)) return tmp; if (numbytes+index>=strlen(source)) numbytes=strlen(source)-index; if (numbytes<=0) return tmp; for (i=index;i<numbytes+index;i++) {
		tmp[i-index]=source[i]; if (source[i]==0) return tmp; }
	tmp[numbytes]=0; return tmp; }
stock FPD_equal(str1[],str2[],bool:ignorecase) { if (strlen(str1)!=strlen(str2)) return false; if (strcmp(str1,str2,ignorecase)==0) return true; return false; }
stock FPD_StripNewLine(string[]) { new len = strlen(string); if (string[0]==0) return ; if ((string[len - 1] == '\n') || (string[len - 1] == '\r')) { string[len - 1] = 0; if (string[0]==0) return ; if ((string[len - 2] == '\n') || (string[len - 2] == '\r')) string[len - 2] = 0; } }
stock FPD_dini_Exists(filename[]) { if (fexist(filename)) return true; return false; }
stock FPD_dini_Create(filename[]) { new File:fhnd; if (fexist(filename)) return false; fhnd=fopen(filename,io_write); fclose(fhnd); return true; }
stock FPD_dini_IntSet(filename[],key[],value) { new valuestring[255]; format(valuestring,sizeof(valuestring),"%d",value); return FPD_dini_Set(filename,key,valuestring); }
stock FPD_dini_Set(filename[],key[],value[]) {
	new File:fohnd, File:fwhnd; new bool:wasset=false; new tmpres[255]; if (key[0]==0) return false; format(tmpres,sizeof(tmpres),"%s.part",filename); fohnd=fopen(filename,io_read); if (!fohnd) return false; fremove(tmpres); fwhnd=fopen(tmpres,io_write); while (fread(fohnd,tmpres)) {
		FPD_StripNewLine(tmpres); if ((!wasset)&&(FPD_equal(FPD_dini_PRIVATE_ExtractKey(tmpres),key,true))) { format(tmpres,sizeof(tmpres),"%s=%s",key,value); wasset=true; }
		fwrite(fwhnd,tmpres); fwrite(fwhnd,"\r\n"); }
	if (!wasset) { format(tmpres,sizeof(tmpres),"%s=%s",key,value); fwrite(fwhnd,tmpres); fwrite(fwhnd,"\r\n"); }
	fclose(fohnd); fclose(fwhnd); format(tmpres,sizeof(tmpres),"%s.part",filename); if (fcopytextfile(tmpres,filename)) { return fremove(tmpres); }
	return false; }
stock FPD_dini_PRIVATE_ExtractKey(line[]) { new tmp[255]; tmp[0]=0; if (strfind(line,"=",true)==-1) return tmp; FPD_set(tmp,strlower(FPD_ret_memcpy(line,0,strfind(line,"=",true)))); return tmp; }
stock FPD_dini_PRIVATE_ExtractValue(line[]) {
	new tmp[255]; tmp[0]=0; if (strfind(line,"=",true)==-1) { return tmp; }
	FPD_set(tmp,FPD_ret_memcpy(line,strfind(line,"=",true)+1,strlen(line))); return tmp; }