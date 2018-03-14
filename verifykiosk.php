<?php require('header.inc'); ?>
<?php

$_GET{'uuid'} = mysql_real_escape_string($_GET{'uuid'});

$kioskquery = "SELECT * FROM kiosk WHERE UUID = '" . $_GET{'uuid'} . "'";

$kiosklist = mysql_query($kioskquery) or die("Kiosk Query Failed");

while($kiosk = mysql_fetch_array($kiosklist, MYSQL_ASSOC))
{
	print("<CENTER>");
	print("<h1>2010 RFL of SL Verify Kiosk Page</h1><P>");

	print("Kiosk Name: " . $kiosk['kioskname'] . "<BR>");
	print("UUID: " . $kiosk['UUID'] . "<BR>");
	print("Kiosk Owner: " . $kiosk['kioskowner'] . "<BR>");
	print("Region: " . $kiosk['region'] . "<BR>");
	print("Position: " . $kiosk['position'] . "<BR>");

	print("<FORM ACTION=\"verifyphrase.php\" METHOD=\"POST\">");
	print("<B>Enter a Verification Phrase into this Form:</b><BR>");
	print("<B>It will be echoed by your Verfied Kiosk in World</b><BR>");
	print("<INPUT TYPE=\"TEXT\" NAME =\"Phrase\" MAXLENGTH=128 SIZE=40>");
	print("<INPUT TYPE=\"HIDDEN\" NAME =\"URL\" VALUE=\"" . $kiosk['URL'] . "\">");
	print("<BR>");
	print("<INPUT TYPE=\"SUBMIT\" NAME=\"VERIFY\" VALUE=\"VERIFY\">");
	print("</form>");
}


?>
<?php require('footer.inc'); ?>