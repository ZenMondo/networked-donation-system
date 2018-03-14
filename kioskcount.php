<?php require('header.inc'); ?>
<?php

$kioskquery = "SELECT * FROM kiosk";

$kiosklist = mysql_query($kioskquery) or die ("kioskquery failed");

$kiosknum = mysql_num_rows($kiosklist);

$activequery = "SELECT * FROM kiosk WHERE active = 1";

$activelist = mysql_query($activequery) or die ("activequery failed");

$activenum = mysql_num_rows($activelist);

$inactivequery = "SELECT * FROM kiosk WHERE active = 0";

$inactivelist = mysql_query($inactivequery) or die ("inactivequery failed");

$inactivenum = mysql_num_rows($inactivelist);

print("<H1>Kiosk / Vendor Totals</h1>");
print("<B> Total Kiosk / Vendors: </b>" . $kiosknum . "<BR>\n");
print("<B> Active: </b>" . $activenum . "<BR>\n");
print("<B> Inactive: </b>" . $inactivenum . "<BR>\n");


?>
<?php require('footer.inc'); ?>