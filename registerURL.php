<? require('header.inc'); ?>
<?
/* Clean Imput */
$_GET{'uuid'} = htmlspecialchars($_GET{'uuid'});
$_GET{'uuid'} = addslashes($_GET{'uuid'});
$_GET{'url'} = htmlspecialchars($_GET{'url'});
$_GET{'url'} = addslashes($_GET{'url'});

$insertquery = "INSERT INTO `acsnho2_SL`.`httpINtest` (`ID`, `UUID`, `URL`) VALUES (NULL, '" . $_GET{'uuid'} ." ', '" . $_GET{'url'} ." ');";

/* print $updatequery; */

 mysql_query($insertquery) or die ("Update Failed");

print $_GET{'url'};


?>
<? require('footer.inc'); ?>
