<?php 
header('Content-type: text/html');
?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>RFL of SL 2010</TITLE>
</HEAD>
<BODY>
<?php

    /* Connecting, selecting database */

    $link = mysql_connect("mysql.virtualrelay.org", "acsnho2_sqluser", "sql737") 
or 
die("Could not connect");

    // print "Connected to MySQL successfully";

    mysql_select_db("acsnho2_sl")  or die("Could not select database");

?>