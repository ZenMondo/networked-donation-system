<?php require('header.inc'); ?>
<?php
/* Clean Imput */
$_GET{'uuid'} = mysql_real_escape_string($_GET{'uuid'});
$_GET{'region'} = mysql_real_escape_string($_GET{'region'});
$_GET{'position'} = mysql_real_escape_string($_GET{'position'});
$_GET{'team'} = mysql_real_escape_string($_GET{'team'});
$_GET{'owner'} = mysql_real_escape_string($_GET{'owner'});
$_GET{'kioskname'} = mysql_real_escape_string($_GET{'kioskname'});

//Check UUID to see if already registered

$uuidquery = "SELECT * FROM kiosk WHERE UUID ='" . $_GET{'uuid'} . "'";

$uuidcheck = mysql_query($uuidquery);
$kiosk = mysql_fetch_array($uuidcheck, MYSQL_ASSOC);

if($kiosk["UUID"] == $_GET{'uuid'}) //Already registered
{
	$updatequery = "UPDATE `acsnho2_sl`.`kiosk` SET `region` = '" . $_GET{'region'} . "', `position` = '" . $_GET{'position'} . "', `teamnumber` = '" . $_GET{'team'} . "', `kioskname` = '". $_GET{'kioskname'} . "' WHERE `kiosk`.`UUID` = '" .$_GET{'uuid'} ."' LIMIT 1";

	//print $updatequery;

	mysql_query($updatequery) or die ("Update Failed");
}

else{

	$insertquery = "INSERT INTO `acsnho2_sl`.`kiosk` (`kioskID`, `UUID`, `region`, `position`, `teamnumber`, `kioskowner`, `kioskname`, `URL`, `active`) VALUES (NULL, '" . $_GET{'uuid'} ."', '" . $_GET{'region'} ."', '" . $_GET{'position'} . "', '" . $_GET{'team'} . "', '" . $_GET{'owner'} . "', '" . $_GET{'kioskname'} .  "', 'http://127.0.0.1', '0');";

	// print $insertquery; 

	mysql_query($insertquery) or die ("Insert Failed");
}

?>
<?php require('footer.inc'); ?>
