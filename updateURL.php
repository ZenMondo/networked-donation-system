<?php require('header.inc'); ?>
<?php
$_GET{'uuid'} = mysql_real_escape_string($_GET{'uuid'});
$_GET{'url'} = mysql_real_escape_string($_GET{'url'});

$updatequery = "UPDATE `acsnho2_sl`.`kiosk` SET  URL = '" . $_GET{'url'} . "',  active = '1' WHERE UUID = '" . $_GET{'uuid'} . "'";

mysql_query($updatequery) or die ("Update Failed");



?>
<?php require('footer.inc'); ?>