	<?php
	if(!isset($_GET['player']))
	{
		?>
		
		<form class="form" role="form" method="get" action="/bans" accept-charset="UTF-8">
			<b>Search for ban:</b> <input type="text" name="player" size="30">
			<input type="submit" value=" Go -> ">
		</form>
		<br>
		<table class="neftable" style='min-width: 100%;'>
			<caption>Last rulebreakers</caption>

			<tr>
			<th>Player</th><th>Admin</th><th>Reason</th><th>Expires</th><th>Date</th>
			</tr>
			
			<?php
			
				$query = $mysqli->query("SELECT * FROM `bans` ORDER BY `Date` DESC LIMIT 50;");
				$bans = $query->num_rows;
				
				for(; $row = $query->fetch_assoc();)
				{
					$player = $row['PlayerName'];
					$admin = $row['AdminName'];
					$reason = $row['Reason'];
					$date = date("d.m.Y H:i:s", $row['Date']);
					
					if($row['lift'] == 0) {
						$duration = "Permanent";
					} else {
						$duration = date("d.m.Y H:i:s", $row['lift']);
					}
					
					$contents = "";
					$contents .= "<tr>";
					$contents .= "<td><a class='neflink' href='/bans/$player'>$player</a></td>";
					$contents .= "<td><a class='neflink' href='/bans/$admin'>$admin</a></td>";
					$contents .= "<td>$reason</td>";
					$contents .= "<td>$duration</td>";
					$contents .= "<td>$date</td>";
					$contents .= "</tr>";
					echo $contents;
				}
				?>
		</table>
		<?php
	}
	else
	{
		$player = trim($_GET['player']);
		
		if(strlen($player) > 22 || strlen($player) < 3)
		{
			msg("Player not found or invalid.");
		}
		else
		{
			$stmt = $mysqli->prepare("SELECT * FROM bans WHERE PlayerName = ?;");
			
			$stmt->bind_param("s", $player);
			$stmt->execute();
			$stmt->store_result();
			
			if($stmt->num_rows == 0)
			{
				msg("Player is not banned.");
				
				$stmt->free_result();
				$stmt->close();
			}
			else
			{
				$stmt->bind_result($id, $playername, $adminname, $reason, $lift, $date);
				$stmt->fetch();
				$stmt->free_result();
				$stmt->close();
				
				?>
				<font face="Oswald" size="20"><?php echo "$player"; ?></font>
				<table class="neftable" style="min-width: 100%;">
					<tr>
						<th colspan="3">Information</th>
					</tr>
					<tr>
				<?php
				$display = $lift == 0 ? "Permanent" : date("d.m.Y H:i:s", $lift);
				echo "<tr><td>Ban ID:</td><td width='70%'>$id</td></tr>";
				echo "<tr><td>Player profile:</td><td width='70%'><a class='neflink' href='/players/$playername'>$playername</a></td></tr>";
				echo "<tr><td>Banned by:</td><td width='70%'>$adminname</td></tr>";
				echo "<tr><td>Reason:</td><td width='70%'>$reason</td></tr>";
				echo "<tr><td>Expires:</td><td width='70%'>$display</td></tr>";
				echo "<tr><td>Banned on:</td><td width='70%'>".date("d.m.Y H:i:s", $date)."</td></tr>";
				
				?>
					</tr>
				</table>
				<?php
			}
		}
	}
	?>