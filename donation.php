<?php require('header.inc'); ?>
<?php
/* Clean Imput */
$_GET{'amount'} = mysql_real_escape_string($_GET{'amount'});
$_GET{'team'} = mysql_real_escape_string($_GET{'team'});
$_GET{'sponsor'} = mysql_real_escape_string($_GET{'sponsor'});
$_GET{'owner'} = mysql_real_escape_string($_GET{'owner'});
$_GET{'region'} = mysql_real_escape_string($_GET{'region'});
$_GET{'position'} = mysql_real_escape_string($_GET{'position'});
$_GET{'uuid'} = mysql_real_escape_string($_GET{'uuid'});
$_GET{'kioskname'} = mysql_real_escape_string($_GET{'kioskname'});

$insertquery =  "INSERT INTO `acsnho2_sl`.`donation` (`donationID`, `donationAmount`, `teamNumber`, `sponsor`, `timestamp`, `kioskowner`, `region`, `position`, `UUID`, `kioskname`) VALUES (NULL, '" . $_GET{'amount'} . "', '" . $_GET{'team'} . "', '" . $_GET{'sponsor'} . "', NOW(), '" . $_GET{'owner'} . "', '" . $_GET{'region'} . "', '" . $_GET{'position'} . "', '" . $_GET{'uuid'} . "', '" . $_GET{'kioskname'} . "')";

//print $insertquery;

mysql_query($insertquery) or die ("Update Failed");

/* HTTP PUSH TO TEAM KIOSKS */

//First get team total
$totalquery = "SELECT sum(donationAmount) donationTotal FROM donation WHERE teamnumber = '" . $_GET{'team'} . "'";

$totallist = mysql_query($totalquery) or die ("total query failed");

$total = mysql_result($totallist, 0);

$urlquery = "SELECT * FROM kiosk WHERE teamnumber = '" . $_GET{'team'} . "' AND active = '1'";

$urllist = mysql_query($urlquery) or die ("url query failed");

while($url = mysql_fetch_array($urllist, MYSQL_ASSOC))
{
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL,  $url['URL'] . "/?msg=update&data=" . $total );
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); //output to string
	$output = curl_exec($ch); 
	curl_close($ch); 
	//print($url['URL']. "/?msg=update&data=" . $total );
	
	
	if($output != "Hello World") //Kiosk did not repsond
	
	{
		$updatequery = "UPDATE `acsnho2_sl`.`kiosk` SET  active = '0' WHERE URL = '" . $url['URL'] . "'";
	
		mysql_query($updatequery) or die ("update query failed");
	}
	
	}



?>
<?php require('footer.inc'); ?>