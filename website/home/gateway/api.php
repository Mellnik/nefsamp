<?php
if(!in_array($_SERVER['REMOTE_ADDR'], array('31.204.153.110', '127.0.0.1'))) 
{
	header("HTTP/1.1 403 Forbidden");
	die("Error: Unknown IP");
}

header("Content-Type: text/plain");

define("API_VERSION", "1.0");
$script_access = "ALL_ACCESS_VALID_INDEX";

include("../inc/mysql.inc.php");

switch($_GET['a'])
{
	case "news":
	{
		$query = $mysqli->query("SELECT * FROM `news` ORDER BY `date` DESC LIMIT 1;");
		$row = $query->fetch_row();
		
		$output = "{F0F0F0}";
		$output .= $row[2] . "\n\n";
		$output .= $row[3] . "\n\n{969696}Posted on " . date("F d, Y", $row[4]);
		
		echo strip_tags($output);
		break;
	}
}
?>