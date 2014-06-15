	<div id="smallbox" style="padding: 5px 15px 5px 15px;">
	<b><font size="4">Gold Credits (GC) - one time donation</font></b>
	<br>
	<?php
	if(isset($_POST['account_name']))
	{	
		$player = trim($_POST['account_name']);
		$stmt = $mysqli->prepare("SELECT `name`, `vip`, `id` FROM `accounts` WHERE `name` = ?;");
		$stmt->bind_param("s", $player);
		$stmt->execute();
		$stmt->store_result();
		
		if($stmt->num_rows == 0)
		{
			echo("<p>The account was not found, start over again (<a class='neflink' href='/gc'>Get NEF GC</a>).</p>");
			$stmt->free_result();
			$stmt->close();
		}
		else
		{
			$stmt->bind_result($player, $vip, $id);
			$stmt->fetch();
			$stmt->free_result();
			$stmt->close();
			
			if(!isset($_POST['gc_amount']))
			{
				echo("<p>Invalid GC amount, start over again (<a class='neflink' href='/gc'>Get NEF GC</a>).</p>");
			}
			else
			{
				$item_name = "";
				$item_number = "";
				$price = 0;
				switch($_POST['gc_amount'])
				{
					case "5k":
					{
						$item_name = "5,000GC";
						$item_number = "GC-5000";
						$price = 3;
						break;
					}
					case "10k":
					{
						$item_name = "10,000GC";
						$item_number = "GC-10000";
						$price = 6;
						break;
					}
					case "25k":
					{
						$item_name = "25,000GC";
						$item_number = "GC-25000";
						$price = 12;
						break;
					}
					case "50k":
					{
						$item_name = "50,000GC";
						$item_number = "GC-50000";
						$price = 24;
						break;
					}
				}
				
				if($item_name == "")
				{
					echo("<p>Invalid GC amount, start over again (<a class='neflink' href='/gc'>Get NEF GC</a>).</p>");
				}
				else
				{
					?>
					<p>After the donation was completed your reward will be set automatically.</p>
					<div align="center">
						You are donating for <a class="neflink" href="/players/<?php echo($player); ?>"><?php echo($player); ?></a> (Account ID: <?php echo($id); ?>).
						<br><br>
						<b><font size="2">PayPal / Credit Card</font></b>
						<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
						<input type="hidden" name="cmd" value="_xclick">
						<input type="hidden" name="business" value="ZY67WE2LE7T78">
						<input type="hidden" name="lc" value="US">
						<input type="hidden" name="item_name" value="<?php echo($item_name); ?>">
						<input type="hidden" name="item_number" value="<?php echo($item_number); ?>">
						<input type="hidden" name="amount" value="<?php echo($price); ?>">
						<input type="hidden" name="button_subtype" value="services">
						<input type="hidden" name="custom" value="<?php echo($player); ?>">
						<input type="hidden" name="no_note" value="1">
						<input type="hidden" name="no_shipping" value="1">
						<input type="hidden" name="rm" value="1">
						<input type="hidden" name="return" value="http://nefserver.net/gc-complete">
						<input type="hidden" name="cancel_return" value="http://nefserver.net/gc">
						<input type="hidden" name="currency_code" value="USD">
						<input type="hidden" name="bn" value="PP-BuyNowBF:btn_buynowCC_LG.gif:NonHosted">
						<input type="hidden" name="notify_url" value="http://nefserver.net/gateway/notify_paypal.php">
						<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_buynowCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
						<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
						</form>
						
					</div>
					<?php
				}
			}
		}
		?>
		<br>
		<font size="2">
		By using this service, you agree:<br>
		a) That your payment rests as a donation in all cases.<br>
		b) That charge backs or payment cancellations may result in a suspension of your account or service.<br>
		c) That refunds can only be claimed within 24 hours.<br>
		</font>
		<?php
	}
	else
	{
		echo("<p>The account was not found, start over again (<a class='neflink' href='/gc'>Get NEF GC</a>).</p>");
	}
	?>
	</div>