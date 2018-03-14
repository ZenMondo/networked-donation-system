<?php require('header.inc'); ?>
<?php
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL,  $_POST{'URL'} . "/?msg=verify&data=" . rawurlencode($_POST{'Phrase'}) ); 
curl_exec($ch); 
curl_close($ch); 
//print($_GET{'url'}. "/?msg=update&data=" . $total );
?>
<?php require('footer.inc'); ?>