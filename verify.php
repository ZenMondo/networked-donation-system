<? require('header.inc'); ?>
<?

$_GET{'uuid'} = mysql_real_escape_string($_GET{'uuid'});

$kioskquery = "SELECT * FROM kiosk WHERE UUID = '" . $_GET{'uuid'} . "'";

$kiosklist = mysql_query($kioskquery) or die("Kiosk Query Failed").

while($kiosk - mysql_fetch_array($kiosklist, MYSQL_ASSOC))
{
	print("<CENTER>");
	print("<h1>2010 RFL of SL Verify Kiosk Page</h1><P>");

	print("Kiosk Name: " . $kiosk['kioskname'] . "<BR>");
	print("UUID: " . $kisok['UUID'] . "<BR>");
	print("Kiosk Owner: " . $kiosk['kioskowner'] . "<BR>");
	print("Region: " . $kiosk['region'] . "<BR>");
	print("Position: " . $kiosk['position'] . "<BR>");


}


?>
<? require('footer.inc'); ?>