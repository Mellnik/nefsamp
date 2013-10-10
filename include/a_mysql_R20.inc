/**
 * MySQL plugin R20
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

// mysql_fetch_row(destination)
#define mysql_fetch_row(%1) mysql_fetch_row_format(%1,"|")

// mysql_next_row()
#define mysql_next_row() mysql_retrieve_row()

// mysql_get_field(fieldname, destination)
#define mysql_get_field(%1,%2) mysql_fetch_field_row(%2,%1)

// mysql_query_callback(index, query[], callback[], extraid, connectionHandle)
#define mysql_query_callback(%1,%2,%3,%4,%5) \
	mysql_function_query(%5,%2,false,%3,"siii",%2,%1,%4,%5)

// mysql_query(query[], resultid, extraid, connectionHandle)
#define mysql_query(%1,%2,%3,%4) \
	mysql_function_query(%4,%1,false,"OnQueryFinish","siii",%1,%2,%3,%4)

// ismysqlnull(string[])
#define ismysqlnull(%1) \
	(strcmp(%1,"NULL",false)==0)



// Natives.
native enable_mutex(bool:enable);
native mysql_debug(enable = 1); //deprecated, use mysql_log instead
native mysql_log(loglevel);
native mysql_connect(const host[], const user[], const database[], const password[], port = 3306);
native mysql_reconnect(connectionHandle = 1);
native mysql_close(connectionHandle = 1);
native mysql_ping(connectionHandle = 1);
native mysql_stat(destination[], connectionHandle = 1, max_len=sizeof(destination));
native mysql_reload(connectionHandle = 1);
native mysql_get_charset(destination[], connectionHandle = 1, max_len=sizeof(destination));
native mysql_set_charset(charset[], connectionHandle = 1);
native mysql_real_escape_string(const source[], destination[], connectionHandle = 1, max_len=sizeof(destination));
native mysql_format(connectionHandle, output[], len, format[], {Float,_}:...);
native mysql_warning_count(connectionHandle = 1);
native mysql_errno(connectionHandle = 1);
native mysql_function_query(connectionHandle, query[], bool:cache, callback[], format[], {Float,_}:...);
native mysql_affected_rows(connectionHandle = 1);
native mysql_insert_id(connectionHandle = 1);
native mysql_store_result(connectionHandle = 1);
native mysql_free_result(connectionHandle = 1);
native mysql_num_rows(connectionHandle = 1);
native mysql_num_fields(connectionHandle = 1);
native mysql_field_count(connectionHandle = 1);
native mysql_retrieve_row(connectionHandle = 1);
native mysql_data_seek(offset, connectionHandle = 1);
native mysql_fetch_field(number, destination[], connectionHandle = 1, max_len=sizeof(destination));
native mysql_fetch_field_row(destination[], const fieldname[], connectionHandle = 1, max_len=sizeof(destination));
native mysql_fetch_row_format(destination[], const delimiter[] = "|", connectionHandle = 1, max_len=sizeof(destination));

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

// Forward declarations.
forward OnQueryError(errorid, error[], callback[], query[], connectionHandle);