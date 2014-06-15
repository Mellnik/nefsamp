<?php

if(!in_array($_SERVER['REMOTE_ADDR'], array('109.70.3.48', '109.70.3.146', '109.70.3.58'))) 
{
	header("HTTP/1.0 403 Forbidden");
	die("Error: Unknown IP");
}

$dbuser	= "nefserver";
$dbpass	= "t2t0.SZth-zTruhJpR(7ucr8?u";
$dbname	= "nefserver";
$connect = mysql_connect("127.0.0.1", $dbuser, $dbpass);
$select	= mysql_select_db($dbname, $connect);

$message_id	= $_GET['message_id'];
$service_id	= $_GET['service_id'];
$shortcode = $_GET['shortcode'];
$keyword = $_GET['keyword'];
$message = mysql_real_escape_string($_GET['message']);
$sender	= $_GET['sender'];
$operator = $_GET['operator'];
$country = $_GET['country'];
$custom	= mysql_real_escape_string($_GET['custom']);
$points	= $_GET['points'];
$price	= $_GET['price'];
$currency = $_GET['currency'];

$mysql_result = mysql_query("SELECT `vip` FROM `accounts` WHERE `name` = '$custom' LIMIT 1;");
$num_rows = mysql_num_rows($mysql_result);

if($num_rows == 0)
{
	mysql_query("INSERT INTO `viporder` VALUES (NULL, '$message', '$custom', '$price', 2, 'USER_NOT_FOUND');");
	return 0;
}

while($row = mysql_fetch_array($mysql_result))
{
	if($row['VIP'] == 1)
	{
		mysql_query("INSERT INTO `viporder` VALUES (NULL, '$message', '$custom', '$price', 2, 'USER_ALREADY_VIP');");	
		return 0;
	}
}

mysql_query("INSERT INTO `queue` VALUES (NULL, 7, UNIX_TIMESTAMP(), '$custom,$price');");
mysql_query("INSERT INTO `viporder` VALUES (NULL, '$message', '$custom', '$price', 2, 'NONE');");
?>