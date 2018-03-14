<?php
require('header.inc');

$grandtotalquery = "SELECT sum( donationAmount ) donation_total FROM donation";

$grandtotallist = mysql_query($grandtotalquery) or die ("grand total query failed");

$grandtotal = mysql_fetch_array($grandtotallist, MYSQL_ASSOC);

print("<h2> Relay For Life of Second Life has raised: L$" . $grandtotal['donation_total'] . "</h2><P>");


$teamtotalquery = "SELECT donationID, teamName, sum( donationAmount ) team_total FROM donation LEFT JOIN teams ON teams.teamID = donation.teamNumber GROUP BY teamName ORDER BY team_total DESC";

$totallist = mysql_query($teamtotalquery) or die ("team query failed");

print("<TABLE border=\"1\"><TR><TD><B>TEAM NAME</b></td><td><B>TEAM TOTAL</b></td></tr>");

while($total = mysql_fetch_array($totallist,  MYSQL_ASSOC))
{
	print("<TR><TD>" . $total['teamName'] . "</td><TD>L$" . $total['team_total'] . "</td></tr>");
}

print("</table>");


require('footer.inc');
?>
