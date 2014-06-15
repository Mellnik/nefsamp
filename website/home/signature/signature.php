<?php
header("Content-Type: image/gif");

include("../inc/mysql.inc.php");
include("../inc/functions.inc.php");

$user = trim($_REQUEST['user']);

$stmt = $mysqli->prepare("SELECT `money`, `bank`, `level`, `score`, `kills`, `deaths`, `time`, `gangid`, `wanteds` FROM `accounts` WHERE `name` = ?;");
$stmt->bind_param("s", $user);
$stmt->execute();
$stmt->store_result();

if($stmt->num_rows == 1)
{
	$stmt->bind_result($money, $bank, $level, $score, $kills, $deaths, $time, $gangid, $wanteds);
	$stmt->fetch();
	$stmt->close();
	
	$money = number_format($money);
	$bank = number_format($bank);
	$time /= 3600;
	
	if($gangid != 0)
	{
		$query = $mysqli->query("SELECT `GangTag` FROM `gangs` WHERE `ID` = $gangid;");
		$row = $query->fetch_row();
		
		$gangid = $row[0];
	}
	else $gangid = "---";

	$img = imagecreatefrompng("img/samp00.png");

	$white = imagecolorallocate($img, 204, 204, 204);
	$width = imagesx($img);
	$height = imagesy($img);
	$font = 3;

	imagestring($img, $font, "108", $height-88, $user, $white);
	imagestring($img, $font, "315", $height-67, $score, $white);
	imagestring($img, $font, "320", $height-53, $money, $white);
	imagestring($img, $font, "320", $height-39, $bank, $white);
	imagestring($img, $font, "465", $height-67, $kills, $white);
	imagestring($img, $font, "465", $height-53, $deaths, $white);
	imagestring($img, $font, "315", $height-25, floor($time)."h", $white);
	imagestring($img, $font, "465", $height-39, $gangid, $white);
	imagestring($img, $font, "465", $height-25, $wanteds, $white);
	imagepng($img);
	imagedestroy($img);
}
?>