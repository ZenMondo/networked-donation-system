<?php require('header.inc'); ?>
<?php
$urlquery = "SELECT * FROM kiosk";

$urllist = mysql_query($urlquery) or die ("url query failed");

while($url = mysql_fetch_array($urllist, MYSQL_ASSOC))
{
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL,  $url['URL'] . "/?msg=die&data=die"); 
	curl_exec($ch); 
	curl_close($ch); 
	print($url['URL']. "/?msg=die&data=die");
}


?>
<?php require('footer.inc'); ?>