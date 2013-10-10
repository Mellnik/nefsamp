/*
# 				Cez-Account  v1.0
#		(c)  Copyright 2008 - 2009 Cezar Mihail Ignat
#
#	Requires:  DracoBlue's DJson  -  (c) Copyright 2008 DracoBlue
#				http://cgarage.blogspot.com/
#
*/
#if defined _cezacc_included
  #endinput
#endif

#define _cezacc_included

#include <djson>

stock num_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++) {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

stock AccountExists(nickname[]) {
  return djIsSet("accounts.cez",nickname,true);
}


stock AccountRemove(nickname[]) {
  return djUnset("accounts.cez",nickname);
}

stock AccountSetInt(nickname[],key[],value) {
  new str[255];
  format(str, sizeof(str), "%s/%s", nickname, key); 
  return djSetInt("accounts.cez", str, value);
}

stock AccountSetFloat(nickname[],key[],Float:value) {
  new str[255];
  format(str, sizeof(str), "%s/%s", nickname, key); 
  return djSetFloat("accounts.cez", str, value);
}

stock AccountSet(nickname[],key[],value[]) {
  new str[255];
  format(str, sizeof(str), "%s/%s", nickname, key); 
  return djSet("accounts.cez", str, value);
}

stock AccountGet(nickname[],key[]) {
  new str[255];
  format(str, sizeof(str), "%s/%s", nickname, key); 
  return dj("accounts.cez", str);
}

stock Float:AccountGetFloat(nickname[],key[]) {
  new str[255];
  format(str, sizeof(str), "%s/%s", nickname, key); 
  return djFloat("accounts.cez",str);
}

stock AccountGetInt(nickname[],key[]) {
  new str[255];
  format(str, sizeof(str), "%s/%s", nickname, key); 
  return djInt("accounts.cez",str);
}

stock AccountCheckLogin(nickname[],pwd[]) {
  new str[255];
  format(str, sizeof(str), "%s/password", nickname); 
  if (djInt("accounts.cez",str) == num_hash(pwd)) return true;
  return false;
}


stock AccountCreate(nickname[],pwd[]) {
  if (AccountExists(nickname)) return false;
  new str[255];
  format(str, sizeof(str), "%s/password", nickname); 
  djSetInt("accounts.cez",str,num_hash(pwd));
  return true;
}