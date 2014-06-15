	<!--<div id="box">-->
		<table class="neftable" style='min-width: 50%;'>
			<caption>Most playing time</caption>

			<tr>
			<th>#</th><th>Player</th><th>Time</th>
			</tr>

			<?php

				$query = $mysqli->query("SELECT `name`, `time` FROM `accounts` ORDER BY `time` DESC LIMIT 20;");
				
				for($id = 1; $row = $query->fetch_assoc(); $id++)
				{
					$name = $row['name'];
					$time = secondsToTime($row['time']);
					
					$contents = "";
					$contents .= "<tr>";
					$contents .= "<td>$id</td>";
					$contents .= "<td><a class='neflink' href='/players/$name'>$name</a></td>";
					$contents .= "<td>".$time['h']." hours, ".$time['m']." minutes and ".$time['s']." seconds</td>";
					$contents .= "</tr>";
					echo $contents;
				}
			
			?>
		</table>
		<br>
		<div style="display: table;">
			<div style="vertical-align: middle; display: table-cell;">
			<table class="neftable">
				<caption>Most kills</caption>

				<tr>
				<th>#</th><th>Player</th><th>Kills</th>
				</tr>
				
				<?php
								
					$query = $mysqli->query("SELECT `name`, `kills` FROM `accounts` ORDER BY `kills` DESC LIMIT 20;");
					
					for($id = 1; $row = $query->fetch_assoc(); $id++)
					{
						$player = $row['name'];
						$kills = $row['kills'];
						
						$contents = "";
						$contents .= "<tr>";
						$contents .= "<td>$id</td>";
						$contents .= "<td><a class='neflink' href='/players/$player'>$player</a></td>";
						$contents .= "<td>$kills</td>";
						$contents .= "</tr>";
						echo $contents;
					}
				?>
			</table>	
			</div>
			<div style="vertical-align: middle; display: table-cell;">
			<table class="neftable">
				<caption>Most deaths</caption>

				<tr>
				<th>#</th><th>Player</th><th>Deaths</th>
				</tr>
				
				<?php
								
					$query = $mysqli->query("SELECT `name`, `deaths` FROM `accounts` ORDER BY `deaths` DESC LIMIT 20;");
					
					for($id = 1; $row = $query->fetch_assoc(); $id++)
					{
						$player = $row['name'];
						$deaths = $row['deaths'];
						
						$contents = "";
						$contents .= "<tr>";
						$contents .= "<td>$id</td>";
						$contents .= "<td><a class='neflink' href='/players/$player'>$player</a></td>";
						$contents .= "<td>$deaths</td>";
						$contents .= "</tr>";
						echo $contents;
					}
				?>
			</table>	
			</div>
			<div style="vertical-align: middle; display: table-cell;">
			<table class="neftable">
				<caption>Most Score</caption>

				<tr>
				<th>#</th><th>Player</th><th>Score</th>
				</tr>
				
				<?php
								
					$query = $mysqli->query("SELECT `name`, `score` FROM `accounts` ORDER BY `score` DESC LIMIT 20;");
					
					for($id = 1; $row = $query->fetch_assoc(); $id++)
					{
						$player = $row['name'];
						$score = $row['score'];
						
						$contents = "";
						$contents .= "<tr>";
						$contents .= "<td>$id</td>";
						$contents .= "<td><a class='neflink' href='/players/$player'>$player</a></td>";
						$contents .= "<td>$score</td>";
						$contents .= "</tr>";
						echo $contents;
					}
				?>
			</table>	
			</div>
			<div style="vertical-align: middle; display: table-cell;">
			<table class="neftable">
				<caption>Most Bank Credit</caption>

				<tr>
				<th>#</th><th>Player</th><th>Credit</th>
				</tr>
				
				<?php
								
					$query = $mysqli->query("SELECT `name`, `bank` FROM `accounts` ORDER BY `bank` DESC LIMIT 20;");
					
					for($id = 1; $row = $query->fetch_assoc(); $id++)
					{
						$player = $row['name'];
						$bank = number_format($row['bank']);
						
						$contents = "";
						$contents .= "<tr>";
						$contents .= "<td>$id</td>";
						$contents .= "<td><a class='neflink' href='/players/$player'>$player</a></td>";
						$contents .= "<td>$$bank</td>";
						$contents .= "</tr>";
						echo $contents;
					}
				?>
			</table>	
			</div>
		</div>
		<br>
		<table class="neftable" style='min-width: 75%;'>
			<caption>Last 10 rulebreakers</caption>

			<tr>
			<th>Player</th><th>Admin</th><th>Reason</th><th>Expires</th><th>Date</th>
			</tr>
			
			<?php
			
				$query = $mysqli->query("SELECT * FROM `bans` ORDER BY `Date` DESC LIMIT 10;");
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
					$contents .= "<td><a class='neflink' href='/players/$player'>$player</a></td>";
					$contents .= "<td><a class='neflink' href='/players/$admin'>$admin</a></td>";
					$contents .= "<td>$reason</td>";
					$contents .= "<td>$duration</td>";
					$contents .= "<td>$date</td>";
					$contents .= "</tr>";
					echo $contents;
				}
				?>
		</table>
	<!--</div>-->