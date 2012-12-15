<?php
include 'db_connect.php';

//Retrieve the datas sent by the flash app
$news = $_POST['news'];
$player = $_POST['player'];

//Retrieve the current day
$response = $bdd->query('SELECT currentday FROM newslist');
$day = 0;
while ($data = $response->fetch())
{
	$day = $data['currentday'];
}
$response->closeCursor();

//Delete the associated line
$response = $bdd->exec('DELETE FROM valuation WHERE news = "' . $news . '" AND player = "' . $player . '" AND day = "'. $day . '"');
?>