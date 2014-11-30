	<?php
	$gang = trim($_GET['gang']);
	
	if(strlen($gang) > 20 || strlen($gang) < 4)
	{
		msg("Gang not registered or invalid.");
	}
	else
	{
		$stmt = $mysqli->prepare("SELECT gangs.* FROM gangs WHERE gname = ?;");
		
		$stmt->bind_param("s", $gang);
		$stmt->execute();
		$stmt->store_result();
		
		if($stmt->num_rows == 0)
		{
			msg("Gang not registered or invalid.");
			
			$stmt->free_result();
			$stmt->close();
		}
		else
		{
			$stmt->bind_result($id, $gname, $gtag, $gscore, $gcolor, $gcar, $gtop, $date);
			$stmt->fetch();
			$stmt->free_result();
			$stmt->close();
			
			?>
			<font face="Oswald" size="20"><?php echo "[$gtag] $gname"; ?></font>
			<table class="neftable" style="min-width: 100%;">
				<tr>
					<th colspan="3">Stats</th>
				</tr>
				<tr>
			<?php
			
			echo "<tr><td>Tag:</td><td width='70%'>$gtag</td></tr>";
			echo "<tr><td>Score:</td><td width='70%'>$gscore</td></tr>";
			echo "<tr><td>Score (last 7 days):</td><td width='70%'>$gtop</td></tr>";
			echo "<tr><td>Date founded:</td><td width='70%'>".date("d.m.Y H:i:s", $date)."</td></tr>";
			echo "<tr><td>Vehicle:</td><td width='70%'><img src='http://weedarr.wdfiles.com/local--files/veh/$gcar.png' alt='car'></td></tr>";
			
			?>
				</tr>
			</table>
			<?php
			
			
			?>
			<br>
			<table class="neftable" style="min-width: 100%;">
				<tr>
					<th colspan="3">Members</th>
				</tr>
				<tr>
			<?php
			
			$q = $mysqli->query("SELECT `name`, `gangrank` FROM `accounts` WHERE `gangid` = $id ORDER BY `gangrank` DESC;");
			
			for(;$r = $q->fetch_row();)
			{
				echo "<tr><td>".$r[0]."</td><td width='70%'>".GetGangRankByLevel($r[1])."</td></tr>";
			}
			
			?>
				</tr>
			</table>
			<?php
		}
	}
	
	?>