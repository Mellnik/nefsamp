<?php
define("SQL_HOST", "::1");
define("SQL_USER", "nefserver");
define("SQL_PASS", "t2t0.SZth-zTruhJpR(7ucr8?u");
define("SQL_DATA", "nefserver");

$mysqli = new mysqli(SQL_HOST, SQL_USER, SQL_PASS, SQL_DATA);

if($mysqli->connect_errno)
{
	printf("Connection failed: %s\n", $mysqli->connect_error);
	exit(1);
}
?>