	<div id="smallbox" style="padding: 5px 15px 5px 15px;">
	<b><font size="4">Very Important Player (VIP) - $15 one time donation</font></b>
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
			echo("<p>The account was not found, start over again (<a class='neflink' href='/vip'>Get NEF VIP</a>).</p>");
			$stmt->free_result();
			$stmt->close();
		}
		else
		{
			$stmt->bind_result($player, $vip, $id);
			$stmt->fetch();
			$stmt->free_result();
			$stmt->close();
			
			?>
			<p>You can donate using PayPal or your phone. After the donation was completed your reward will be set automatically.</p>
			<div align="center">
			You are donating for <a class="neflink" href="/players/<?php echo($player); ?>"><?php echo($player); ?></a> (Account ID: <?php echo($id); ?>).<br><br>
			<div style="display: table;">
			<div style="vertical-align: middle; display: table-cell; padding-right: 10px;">
			<b><font size="2">PayPal / Credit Card</font></b>
			<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
			<input type="hidden" name="cmd" value="_xclick">
			<input type="hidden" name="business" value="ZY67WE2LE7T78">
			<input type="hidden" name="lc" value="US">
			<input type="hidden" name="currency_code" value="USD">
			<input type="hidden" name="button_subtype" value="services">
			<input type="hidden" name="item_name" value="New Evolution Freeroam VIP">
			<input type="hidden" name="item_number" value="NEF-VIP">
			<input type="hidden" name="amount" value="15"/>
			<input type="hidden" name="no_note" value="1">
			<input type="hidden" name="no_shipping" value="1">
			<input type="hidden" name="rm" value="1">
			<input type="hidden" name="return" value="http://nefserver.net/vip-complete">
			<input type="hidden" name="cancel_return" value="http://nefserver.net/vip">
			<input type="hidden" name="bn" value="PP-BuyNowBF:btn_buynow_LG.gif:NonHosted">
			<input type="hidden" name="notify_url" value="http://nefserver.net/gateway/notify_paypal.php">
			<input type="hidden" name="custom" value="<?php echo($player); ?>">
			<input type="image" src="https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
			<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
			</form>
			</div>
			
 			<div style="vertical-align: middle; display: table-cell; padding-left: 10px;">
			<b><font size="2">PayGol (Phone)</font></b>
			
			<form name="pg_frm" method="post" action="https://www.paygol.com/pay" >
			   <input type="hidden" name="pg_serviceid" value="55506">
			   <input type="hidden" name="pg_currency" value="USD">
			   <input type="hidden" name="pg_name" value="New Evolution Freeroam VIP">
			   <input type="hidden" name="pg_custom" value="">
			   <input type="hidden" name="pg_price" value="15">
			   <input type="hidden" name="pg_return_url" value="http://www.nefserver.net/vip-complete/">
			   <input type="hidden" name="pg_cancel_url" value="http://nefserver.net/vip/">
			   <input type="image" name="pg_button" src="https://www.paygol.com/micropayment/buttons/en/white.png" border="0" alt="Make payments with PayGol: the easiest way!" title="Make payments with PayGol: the easiest way!" >    
			</form>
			
			</div>
			</div>
			</div>
			<?php
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
		echo("<p>The account was not found, start over again (<a class='neflink' href='/vip'>Get NEF VIP</a>).</p>");
	}
	?>
	</div>