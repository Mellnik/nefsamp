/**
 * MySQL plugin R26
 */

#if defined mysql_included
	#endinput
#endif
#define mysql_included

/**
 * Common error codes
 *
 * Client: http://dev.mysql.com/doc/refman/5.0/en/error-messages-client.html
 * Server: http://dev.mysql.com/doc/refman/5.0/en/error-messages-server.html
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
native mysql_connect(const host[], const user[], const database[], const password[], port = 3306);
native mysql_close(connectionHandle = 1);
native mysql_reconnect(connectionHandle = 1);

native mysql_real_escape_string(const source[], destination[], connectionHandle = 1, max_len=sizeof(destination));
native mysql_format(connectionHandle, output[], len, format[], {Float,_}:...);
native mysql_tquery(connectionHandle, query[], callback[], format[], {Float,_}:...);
native mysql_function_query(connectionHandle, query[], bool:cache, callback[], format[], {Float,_}:...);

native mysql_stat(destination[], connectionHandle = 1, max_len=sizeof(destination));
native mysql_get_charset(destination[], connectionHandle = 1, max_len=sizeof(destination));
native mysql_set_charset(charset[], connectionHandle = 1);



// Cache functions.
native cache_get_data(&num_rows, &num_fields, connectionHandle = 1);
native cache_get_field(field_index, destination[], connectionHandle = 1, max_len=sizeof(destination));
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
		new tmp[512];
		new RIDX = RowIndex[connectionHandle];
		cache_get_row(RIDX < 0 ? 0 : RIDX, f, tmp, connectionHandle);
		if(f == 0)
			strins(destination, tmp, 0, max_len);
		else
			strcat(destination, tmp, max_len);
	}
}



// Forward declarations.
forward OnQueryError(errorid, error[], callback[], query[], connectionHandle);