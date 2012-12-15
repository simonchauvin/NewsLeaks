<?php
include 'db_connect.php';

//Select only the news that comes from the current day
$response = $bdd->query('SELECT currentday, lastupdate FROM newslist');
$day = 0;
$lastupdate = 0;
while ($data = $response->fetch())
{
	$day = $data['currentday'];
	$lastupdate = $data['lastupdate'];
}
$response->closeCursor();

$time_before_update = 86400 - (time() - $lastupdate);

echo 'day=' . $day . ',nextupdate=' . $time_before_update;

?>