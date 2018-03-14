<?php require('header.inc'); ?>
<?php
/* Clean Imput */
$_GET{'team'} = mysql_real_escape_string($_GET{'team'});
$_GET{'url'} = mysql_real_escape_string($_GET{'url'});

$totalquery = "SELECT sum(donationAmount) donationTotal FROM donation WHERE teamnumber = '" . $_GET{'team'} . "'";

$totallist = mysql_query($totalquery) or die ("total query failed");

$total = mysql_result($totallist, 0);

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL,  $_GET{'url'} . "/?msg=update&data=" . $total ); 
curl_exec($ch); 
curl_close($ch); 
print($_GET{'url'}. "/?msg=update&data=" . $total );



?>
<?php require('footer.inc'); ?>