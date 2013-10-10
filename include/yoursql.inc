/*
	YourSQL Library by Gamer931215
	MYSQL Simplified in pawn
	V1.2b Release ©2011

	native yoursql_connect(host[],user[],table[],password[])
	native yoursql_insert(table[],values[])
	native yoursql_receive(table[],identifier[])
	native yoursql_update(table[],updater[],identifier[])
	native yoursql_delete(table[],identifier[])
	native yoursql_countrows(strquery)
	native yoursql_escape_string(str[]);
	native yoursql_close();
*/
#include <a_samp>
#include <a_mysql>
new connection = -1;

#if defined FILTERSCRIPT

	public OnFilterScriptExit()
	{
		mysql_close(connection);
		return 1;
	}
	#if defined _ALS_OnFilterScriptExit
    	#undef OnFilterScriptExit
	#else
	    #define _ALS_OnFilterScriptExit
	#endif
	#define OnFilterScriptExit yoursql_OnFilterScriptExit
	forward yoursql_OnFilterScriptExit();

#else

	public OnGameModeExit()
	{
		mysql_close(connection);
		return 1;
	}
	#if defined _ALS_OnGameModeExit
    	#undef OnGameModeExit
	#else
	    #define _ALS_OnGameModeExit
	#endif
	#define OnGameModeExit yoursql_OnGameModeExit
	forward yoursql_OnGameModeExit();

#endif

stock yoursql_connect(host[],user[],table[],password[])
{
	printf("yoursql => Connecting to %s...",host);
	connection = mysql_connect(host,user,table,password);
	if(mysql_ping(connection) == 1)
	{
	    printf("yoursql => Connection to %s succesfully established! (Connection ID %i).",host,connection);
	} else {
	    printf("yoursql => Connection to %s failed!",host);
	}
	return 0;
}

stock yoursql_close()
{
	mysql_close(connection);
}

stock yoursql_insert(table[],type[],{Float,_}:...)
{
	new query[312],values[256];
	for(new i = 0;i<numargs();i++)
	{
	    switch(type[i])
	    {
	        case 's':
	        {
				new result[130];
				for(new a= 0;getarg(i +2,a) != 0;a++)
				{
				    result[a] = getarg(i +2,a);
				}
				if(!strlen(values))
				{
				    format(values,sizeof values,"'%s'",result);
				} else format(values,sizeof values,"%s, '%s'",values,result);
	        }

	        case 'i':
	        {
	            new result = getarg(i +2);
				if(!strlen(values))
				{
				    format(values,sizeof values,"%i",result);
				} else format(values,sizeof values,"%s, %i",values,result);
	        }

	        case 'f':
	        {
				new Float:result = Float:getarg(i +2);
				if(!strlen(values))
				{
				    format(values,sizeof values,"%f",result);
				} else format(values,sizeof values,"%s, %f",values,result);
	        }
	    }
	}
    format(query,sizeof query,"INSERT INTO %s (%s) VALUES (%s)",table,GetStructure(table),values);
    new result = mysql_query(query,-1,-1,connection);
    if(result == 0)
    {
        printf("yoursql => ERROR! Could not execute query: %s",query);
    }
    return result;
}

stock yoursql_update(table[],updater[],identifier[])
{
	new query[256];format(query,sizeof query,"UPDATE %s SET %s WHERE %s",table,updater,identifier);
    new result = mysql_query(query,-1,-1,connection);
    if(result == 0)
    {
        printf("yoursql => ERROR! Could not execute query: %s",query);
    }
    return result;
}

stock yoursql_delete(table[],identifier[])
{
	new query[128];format(query,sizeof query,"DELETE FROM %s WHERE %s",table,identifier);
    new result = mysql_query(query,-1,-1,connection);
    if(result == 0)
    {
        printf("yoursql => ERROR! Could not execute query: %s",query);
    }
    return result;
}

stock yoursql_receive(table[],identifier[])
{
	new query[320];format(query,sizeof query,"SELECT * FROM %s WHERE %s",table,identifier);
	new result = mysql_query(query,-1,-1,connection);
	mysql_store_result(connection);

	if(mysql_fetch_row_format(query,"|",connection))
	{
        mysql_free_result(connection);
        return query;
	}
    if(result == 0)
    {
        printf("yoursql => ERROR! Could not execute query: %s",query);
    }
	return query;
}

stock yoursql_escape_string(str[])
{
	new string[256];
	mysql_real_escape_string(str,string);
	return string;
}

stock yoursql_countrows(strquery[])
{
    new query[96];format(query,sizeof query,"%s",strquery);
	if(mysql_query(query,-1,-1,connection) == 0) return printf("yoursql => ERROR! Could not execute query: %s",query);
	mysql_store_result(connection);
	new result = mysql_num_rows(connection);
	mysql_free_result(connection);
	return result;
}

stock GetStructure(table[])
{
	new query[96];format(query,sizeof query,"SHOW FIELDS FROM %s",table);
	if(!mysql_query(query,-1,-1,connection))
	{
	    printf("yoursql => ERROR! Could not execute query: %s",query);
	}
	mysql_store_result(connection);

	new temp[32],result[96];
    while(mysql_retrieve_row(connection))
    {
        mysql_fetch_field_row(temp,"Field",connection);

        if(!strlen(result))
        {
            format(result,sizeof result,"`%s`",temp);
        } else {
        	format(result,sizeof result,"%s,`%s`",result,temp);
		}
    }
	mysql_free_result(connection);
	return result;
}
