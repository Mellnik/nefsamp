	<?php
	$gang = trim($_GET['gang']);
	
	if(strlen($gang) > 20 || strlen($gang) < 4)
	{
		msg("Gang not registered or invalid.");
	}
	else
	{
	
	}
	
	?>