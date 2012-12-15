<?php
include 'db_connect.php';
//Retrieve the data sent by the flash app
$player = $_POST['player'];
//Retrieve the current day
$response = $bdd->query('SELECT currentday FROM newslist');
$day = 0;
while ($data = $response->fetch())
{
	$day = $data['currentday'];
}
$response->closeCursor();
//Retrieve the valuations made by the player for the current day
$array = array();
$response = $bdd->query('SELECT news, value FROM valuation WHERE player = "' . $player . '" AND day = "' . $day . '"');
$news = 0;
$value = 0;
while ($data = $response->fetch())
{
	$news = $data['news'];
	$value = $data['value'];
	$array[$news] = $value;
}
$response->closeCursor();

//Send the valuations back to the client app
$valuations = "";
foreach($array as $key => $element)
{
	$valuations = $valuations . $key . '=' . $element . ';';
}
echo 'valuations:' . $valuations;
?>