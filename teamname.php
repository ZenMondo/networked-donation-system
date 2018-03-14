<?php require('header.inc'); ?>
<?php
$_GET{'team'} = mysql_real_escape_string($_GET{'team'});

$teamquery = "SELECT teamName FROM teams WHERE teamID = '" . $_GET{'team'} . "'";

$team = mysql_query ($teamquery) or die ("Team Query Failed");

$teamname = mysql_result($team, 0);

if($teamname)
{
	print($teamname);
}
else
{
	print("<br />");
}
?>
<?php require('footer.inc'); ?>