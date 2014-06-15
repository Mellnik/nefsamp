	<!--<div id="box">-->
		<table class="neftable" style='min-width: 100%;'>
			<caption>NEF Staff</caption>

			<tr>
			<th>Name</th><th>Level</th><th>Join date</th><th>Last login</th>
			</tr>
			
			<?php
			
				$query = $mysqli->query("SELECT `name`, `level`, `regdate`, `lastlogin` FROM `accounts` WHERE `level` > 0 ORDER BY `level` DESC;");
				
				for(; $row = $query->fetch_assoc();)
				{
					$player = $row['name'];
					$level = $row['level'];
					$jd = date("d.m.Y H:i:s", $row['regdate']);
					$ll = date("d.m.Y H:i:s", $row['lastlogin']);
					
					$contents = "";
					$contents .= "<tr>";
					$contents .= "<td><a class='neflink' href='/players/$player'>$player</a></td>";
					$contents .= "<td>$level</td>";
					$contents .= "<td>$jd</td>";
					$contents .= "<td>$ll</td>";
					$contents .= "</tr>";
					echo $contents;
				}
				?>
		</table>
	<!--</div>-->