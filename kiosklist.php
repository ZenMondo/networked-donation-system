<?php require('header.inc'); ?>
<?php

$kioskquery = "SELECT * FROM kiosk";

$kiosklist = mysql_query($kioskquery) or die ("kioskquery failed");

$kiosknum = mysql_num_rows($kiosklist);

$activequery = "SELECT * FROM kiosk LEFT JOIN teams ON teams.teamID = kiosk.teamnumber WHERE active = '1' ORDER BY teamName, kioskOwner, region";

$activelist = mysql_query($activequery) or die ("activequery failed");

$activenum = mysql_num_rows($activelist);

$inactivequery = "SELECT * FROM kiosk WHERE active = '0'";

$inactivelist = mysql_query($inactivequery) or die ("inactivequery failed");

$inactivenum = mysql_num_rows($inactivelist);

print("<H1>Kiosk / Vendor Totals</h1>");
print("<B> Total Kiosk / Vendors: </b>" . $kiosknum . "<BR>\n");
print("<B> Active: </b>" . $activenum . "<BR>\n");
print("<B> Inactive: </b>" . $inactivenum . "<BR>\n");
print("<P>\n");

print("<TABLE BORDER=\"1\"><TR><TD><B>Team Name</b></td><TD><B>Kiosk Owner</b></td><TD><B>Region</b></td><TD><B>Coordinates</b></td></tr>");

while($active = mysql_fetch_array($activelist, MYSQL_ASSOC))
{
	print("<TR><TD>" . $active['teamName'] . "</td><TD>" . $active['kioskowner'] . "</td><TD>" . $active['region'] . "</td><TD>"  . $active['position'] . "</td></tr>");
}



?>
<?php require('footer.inc'); ?>