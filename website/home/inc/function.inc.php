<?php

function secondsToTime($seconds)
{
    // extract hours
    $hours = floor($seconds / (60 * 60));
 
    // extract minutes
    $divisor_for_minutes = $seconds % (60 * 60);
    $minutes = floor($divisor_for_minutes / 60);
 
    // extract the remaining seconds
    $divisor_for_seconds = $divisor_for_minutes % 60;
    $seconds = ceil($divisor_for_seconds);
 
    // return the final array
    $obj = array(
        "h" => (int) $hours,
        "m" => (int) $minutes,
        "s" => (int) $seconds,
    );
    return $obj;
}

function GetRankByLevel($level)
{
	$string = "Player";
	switch($level)
	{
		case 1:
			$string = "Junior Administrator";
			break;
		case 2:
			$string = "General Administrator";
			break;
		case 3:
			$string = "Senior Administrator";
			break;
		case 4:
			$string = "Head Administrator";
			break;
		case 5:
			$string = "Executive Administrator";
			break;
	}
	return $string;
}

function msg($msg)
{
	echo "<div id='smallbox'>$msg</div>"; 
}

?>