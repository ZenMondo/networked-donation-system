<?php require('header.inc'); ?>
<?php
$teamquery = "SELECT * FROM teams ORDER BY teamName";

$teamlist = mysql_query($teamquery) or die ("team query failed");

$teamnum = mysql_num_rows($teamlist);

print "There are " . $teamnum . " teams registered for the 2010 Second Life Relay For Life";

print("<TABLE border=\"1\"><TR><TD><B>TEAM NAME</b></td><td><B>TEAM NUMBER</b></td></tr>");

while($team = mysql_fetch_array($teamlist,  MYSQL_ASSOC))
{
	print("<TR><TD>" . $team['teamName'] . "</td><TD>" . $team['teamID'] . "</td></tr>");
}

print("</table>");
print("</body>");
?>
<?php require('footer.inc'); ?>