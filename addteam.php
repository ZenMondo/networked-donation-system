<?php
require('header.inc');

if($_POST{'teamname'})
{
	$_POST{'teamname'} = mysql_real_escape_string($_POST{'teamname'});
	
	$insertquery = "INSERT INTO `teams`(`teamID`, `teamName`) VALUES (NULL, '" . $_POST{'teamname'} . "')";

	mysql_query($insertquery) or die ("Insert Query Failed.");
	
	$keyval=mysql_insert_id();
	
	print($_POST{'teamname'} . " added as team: " . $keyval);
}

?>
<P>
<FORM METHOD=POST>
<B>TeamName: </b> <INPUT TYPE=TEXT NAME="teamname"  MAXLENGTH=256 SIZE=40>
<INPUT TYPE=SUBMIT NAME="Add Team" VALUE="addteam">  
</form>


<?php
require('footer.inc');
?>
