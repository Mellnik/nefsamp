/**
 * MySQL plugin R31
 */

#if defined mysql_included
	#endinput
#endif
#define mysql_included

/**
 * Common error codes
 *
 * Client: http://dev.mysql.com/doc/refman/5.1/en/error-messages-client.html
 * Server: http://dev.mysql.com/doc/refman/5.1/en/error-messages-server.html
 */

#define ER_DBACCESS_DENIED_ERROR 		1044
#define ER_ACCESS_DENIED_ERROR 			1045
#define ER_UNKNOWN_TABLE 				1109
#define ER_SYNTAX_ERROR 				1149
#define CR_SERVER_GONE_ERROR 			2006
#define CR_SERVER_LOST 					2013
#define CR_COMMAND_OUT_OF_SYNC 			2014
#define CR_SERVER_LOST_EXTENDED 		2055

enum e_LogLevel {
	LOG_NONE = 0,
	LOG_ERROR = 1,
	LOG_WARNING = 2,
	LOG_DEBUG = 4
};

enum e_LogType {
	LOG_TYPE_TEXT = 1,
	LOG_TYPE_HTML = 2
};


#define mysql_insert_id cache_insert_id
#define mysql_affected_rows cache_affected_rows
#define mysql_warning_count cache_warning_count
#define mysql_real_escape_string mysql_escape_string

// cache_get_field
#define cache_get_field(%0) cache_get_field_name(%0)

// mysql_function_query(conHandle, query[], bool:cache, callback[], format[], {Float,_}:...);
#define mysql_function_query(%0,%1,%2,%3,"%4"%5) mysql_tquery(%0,%1,%3,#%4%5)

// mysql_fetch_row(destination)
#define mysql_fetch_row(%1) mysql_fetch_row_format(%1,"|")

// mysql_next_row()
#define mysql_next_row() mysql_retrieve_row()

// mysql_get_field(fieldname, destination)
#define mysql_get_field(%1,%2) mysql_fetch_field_row(%2,%1)

// ismysqlnull(string[])
#define ismysqlnull(%1) \
	(strcmp(%1,"NULL",false)==0)



// Natives
native mysql_log(loglevel = LOG_ERROR | LOG_WARNING, logtype = LOG_TYPE_TEXT);
native mysql_connect(const host[], const user[], const database[], const password[], port = 3306, bool:autoreconnect = true);
native mysql_close(connectionHandle = 1, bool:wait = true);
native mysql_reconnect(connectionHandle = 1);

native mysql_errno(connectionHandle = 1);
native mysql_escape_string(const source[], destination[], connectionHandle = 1, max_len=sizeof(destination));
native mysql_format(connectionHandle, output[], len, format[], {Float,_}:...);
native mysql_tquery(connectionHandle, query[], callback[], format[], {Float,_}:...);
/*
native mysql_function_query(conHandle, query[], bool:cache, callback[], format[], {Float,_}:...); //DEPRECATED
*/

native mysql_stat(destination[], connectionHandle = 1, max_len=sizeof(destination));
native mysql_get_charset(destination[], connectionHandle = 1, max_len=sizeof(destination));
native mysql_set_charset(charset[], connectionHandle = 1);



// Cache functions.
native cache_get_data(&num_rows, &num_fields, connectionHandle = 1);
native cache_get_field_name(field_index, destination[], connectionHandle = 1, max_len=sizeof(destination));

native cache_get_row(row, idx, destination[], connectionHandle = 1, max_len=sizeof(destination));
native cache_get_row_int(row, idx, connectionHandle = 1);
native Float:cache_get_row_float(row, idx, connectionHandle = 1);

native cache_get_field_content(row, const field_name[], destination[], connectionHandle = 1, max_len=sizeof(destination));
native cache_get_field_content_int(row, const field_name[], connectionHandle = 1);
native Float:cache_get_field_content_float(row, const field_name[], connectionHandle = 1);

native cache_save(connectionHandle = 1);
native cache_delete(cacheID, connectionHandle = 1);
native cache_set_active(cacheID, connectionHandle = 1);

native cache_affected_rows(connectionHandle = 1);
native cache_insert_id(connectionHandle = 1);
native cache_warning_count(connectionHandle = 1);


#if defined MYSQL_USE_YINLINE
	#include <YSI\y_inline.inc>
	
	new g_MySQL_InlineData[500][E_CALLBACK_DATA];
	new g_MySQL_InlineCounter = 0;

	stock MySQL_Internal_SaveInline(callback:CB) {
		new InlineData[E_CALLBACK_DATA];
		if (Callback_Get(CB, InlineData))
		{
			g_MySQL_InlineCounter++;
			g_MySQL_InlineData[g_MySQL_InlineCounter] = InlineData;
		}
	}

	#define mysql_tquery_inline(%0,%1,%2,"%3"%4) \
		MySQL_Internal_SaveInline(%2); \
		mysql_tquery(%0,%1,"FJ37DH3JG_MYSQL_INTERNAL","d"#%3,g_MySQL_InlineCounter%4)


	forward FJ37DH3JG_MYSQL_INTERNAL(...);
	public FJ37DH3JG_MYSQL_INTERNAL(...) {
		new VarArray[32];
		new AddressArray[32];
		for(new i=0; i < numargs()-1; ++i) {
			VarArray[i] = getarg(i+1);
			AddressArray[i] = AMX_GetRelativeAddress(VarArray[i]);
		}
		Callback_Array(g_MySQL_InlineData[getarg(0)], AddressArray);
	}
#endif

// Wrappers for cache functions
stock mysql_reload(connectionHandle = 1) {
	mysql_tquery(connectionHandle, "FLUSH PRIVILEGES", "", "");
	return 1;
}

static RowIndex[20];
static bool:RetrieveRow[20];
stock mysql_store_result(connectionHandle = 1) {
	RowIndex[connectionHandle] = 0;
	RetrieveRow[connectionHandle] = false;
	
}
stock mysql_free_result(connectionHandle = 1) {
	#pragma unused connectionHandle
}
stock mysql_num_rows(connectionHandle = 1) {
	new Rows, Fields;
	cache_get_data(Rows, Fields, connectionHandle);
	return Rows;
}
stock mysql_num_fields(connectionHandle = 1) {
	new Rows, Fields;
	cache_get_data(Rows, Fields, connectionHandle);
	return Fields;
}
stock mysql_retrieve_row(connectionHandle = 1) {
	if(RetrieveRow[connectionHandle] != false)
		RowIndex[connectionHandle]++;
	else
		RetrieveRow[connectionHandle] = true;
	
	if(RowIndex[connectionHandle] >= mysql_num_rows(connectionHandle))
		return 0;
	return 1;
}
stock mysql_data_seek(offset, connectionHandle = 1) {
	new Rows = mysql_num_rows(connectionHandle);
	if(offset < 0)
		offset = 0;
	else if(offset >= Rows)
		offset = Rows-1;
	RowIndex[connectionHandle] = offset;
}
stock mysql_fetch_field(number, destination[], connectionHandle = 1, max_len=sizeof(destination)) {
	strdel(destination, 0, max_len-1);
	return cache_get_field(number, destination, connectionHandle, max_len);
}
stock mysql_fetch_field_row(destination[], const fieldname[], connectionHandle = 1, max_len=sizeof(destination)) {
	strdel(destination, 0, max_len-1);
	new RIDX = RowIndex[connectionHandle];
	cache_get_field_content(RIDX < 0 ? 0 : RIDX, fieldname, destination, connectionHandle, max_len);
}
stock mysql_fetch_row_format(destination[], const delimiter[] = "|", connectionHandle = 1, max_len=sizeof(destination)) {
	strdel(destination, 0, max_len-1);
	new Fields = mysql_num_fields(connectionHandle);
	for(new f=0; f < Fields; f++) {
		if(f != 0) {
			strcat(destination, delimiter, max_len);
			
		}
		new row_val_tmp[512];
		new RIDX = RowIndex[connectionHandle];
		cache_get_row(RIDX < 0 ? 0 : RIDX, f, row_val_tmp, connectionHandle);
		if(f == 0)
			strins(destination, row_val_tmp, 0, max_len);
		else
			strcat(destination, row_val_tmp, max_len);
	}
}



// Forward declarations.
forward OnQueryError(errorid, error[], callback[], query[], connectionHandle);