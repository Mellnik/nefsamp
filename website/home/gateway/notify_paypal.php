<?php
$req = 'cmd=_notify-validate';

foreach($_POST as $key => $value)
{
    if(get_magic_quotes_gpc())
    {
        $_POST[$key] = stripslashes($value);
        $value = stripslashes($value);
    }
    $value = urlencode($value);
    $req .= "&$key=$value";
}

$url = "https://www.paypal.com/cgi-bin/webscr";
//$url = "https://www.sandbox.paypal.com/cgi-bin/webscr";

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_FAILONERROR, 1);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_TIMEOUT, 3);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, $req);
$result = curl_exec($ch);
curl_close($ch);

$dbuser	= "nefserver";
$dbpass = "t2t0.SZth-zTruhJpR(7ucr8?u";
$dbname	= "nefserver";
$connect = mysql_connect("localhost", $dbuser, $dbpass);
$select	= mysql_select_db($dbname, $connect);

$txn_id = mysql_real_escape_string($_POST['txn_id']);
$item_num = mysql_real_escape_string($_POST['item_number']);
$receiver = mysql_real_escape_string($_POST['custom']);
$payment = mysql_real_escape_string($_POST['mc_gross']);
$payment_status = $_POST['payment_status'];

if(strcmp($result, "VERIFIED") == 0) {
	if($item_num == "NEF-VIP") {
		if($payment >= 14) {
			if(strcmp($payment_status, "Completed")) {
				mysql_query("INSERT INTO `viporder` VALUES (NULL, '$txn_id', '$receiver', '$payment', 1, 'NOT_COMPLETE');");
				return 0;
			}
			
			$mysql_result = mysql_query("SELECT `vip` FROM `accounts` WHERE `name` = '$receiver' LIMIT 1;");
			$num_rows = mysql_num_rows($mysql_result);
			
			if($num_rows == 0) {
				mysql_query("INSERT INTO `viporder` VALUES (NULL, '$txn_id', '$receiver', '$payment', 1, 'USER_NOT_FOUND');");
				return 0;
			}
			
			while($row = mysql_fetch_array($mysql_result)) {
				if($row['VIP'] == 1) {
					mysql_query("INSERT INTO `viporder` VALUES (NULL, '$txn_id', '$receiver', '$payment', 1, 'USER_ALREADY_VIP');");	
					return 0;
				}
			}
			
			$mysql_result = mysql_query("SELECT `ID` FROM `viporder` WHERE `txn_id` = '$txn_id';");
			$num_rows = mysql_num_rows($mysql_result);
			
			if($num_rows != 0) {
				mysql_query("INSERT INTO `viporder` VALUES (NULL, '$txn_id', '$receiver', '$payment', 1, 'TXN_ID_EXIST');");
				return 0;
			}
			
			mysql_query("INSERT INTO `queue` VALUES (NULL, 7, UNIX_TIMESTAMP(), '$receiver,$payment');");
			mysql_query("INSERT INTO `viporder` VALUES (NULL, '$txn_id', '$receiver', '$payment', 1, 'NONE');");
		}
	} else {
		$total_credits = 0;
		$vip_bonus = 0;

		if(strcmp($payment_status, "Completed")) {
			mysql_query("INSERT INTO `creditsorder` VALUES (NULL, '$txn_id', '$receiver', $total_credits, '$payment', 1, 'NOT_COMPLETE');");
			return 0;
		}
		
		if($item_num == "GC-0000") $total_credits = 0;
		else if ($item_num == "GC-5000") $total_credits = 5000;
		else if ($item_num == "GC-10000") $total_credits = 10250;
		else if ($item_num == "GC-25000") $total_credits = 26000;
		else if ($item_num == "GC-50000") $total_credits = 53000;
		else $total_credits = 0;

		if($total_credits == 0) {
			mysql_query("INSERT INTO `creditsorder` VALUES (NULL, '$txn_id', '$receiver', $total_credits, '$payment', 1, 'UNKNOWN_ITEM_NUMBER');");
			return 0;
		}
		
		$mysql_result = mysql_query("SELECT `vip` FROM `accounts` WHERE `name` = '$receiver' LIMIT 1;");
		$num_rows = mysql_num_rows($mysql_result);
		
		if($num_rows == 0) {
			mysql_query("INSERT INTO `creditsorder` VALUES (NULL, '$txn_id', '$receiver', $total_credits, '$payment', 1, 'USER_NOT_FOUND');");
			return 0;
		}
		
		while($row = mysql_fetch_array($mysql_result)) {
			if($row['vip'] == 1) {
				if ($item_num == "GC-5000") $vip_bonus = 250;
				else if ($item_num == "GC-10000") $vip_bonus = 500;
				else if ($item_num == "GC-25000") $vip_bonus = 1500;
				else if ($item_num == "GC-50000") $vip_bonus = 5000;		
			} else {
				$vip_bonus = 0;
			}
		}
		
		$mysql_result = mysql_query("SELECT `ID` FROM `creditsorder` WHERE `txn_id` = '$txn_id';");
		$num_rows = mysql_num_rows($mysql_result);
		
		if($num_rows != 0) {
			mysql_query("INSERT INTO `creditsorder` VALUES (NULL, '$txn_id', '$receiver', $total_credits, '$payment', 1, 'TXN_ID_EXISTS');");
			return 0;
		}
		
		$total_credits += $vip_bonus;
		
		mysql_query("INSERT INTO `queue` VALUES (NULL, 1, UNIX_TIMESTAMP(), '$receiver,$total_credits,$payment');");
		mysql_query("INSERT INTO `creditsorder` VALUES (NULL, '$txn_id', '$receiver', $total_credits, '$payment', 1, 'NONE');");
	}
}
else 
{
	mysql_query("INSERT INTO `viporder` VALUES (NULL, '$txn_id', '$receiver', '$payment', 1, 'RESPONSE_INVALID');");
}
?>