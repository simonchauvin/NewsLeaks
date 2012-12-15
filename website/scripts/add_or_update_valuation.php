<?php
include 'db_connect.php';

//Retrieve the datas sent by the flash app
$news = $_POST['news'];
$value = $_POST['value'];
$player = $_POST['player'];

//Retrieve the current day
$response = $bdd->query('SELECT currentday FROM newslist');
$day = 0;
while ($data = $response->fetch())
{
	$day = $data['currentday'];
}
$response->closeCursor();

//Find the number of valuations already made by the player for that news and for the current day
$response = $bdd->query('SELECT COUNT(*) AS valuationsCounter, value FROM valuation WHERE news = "' . $news . '" AND player = "' . $player .'" AND day = "' . $day . '"');
$count = 0;
$value_in_db = 0;
while ($data = $response->fetch())
{
	$count = $data['valuationsCounter'];
	$value_in_db = $data['value'];
}
$response->closeCursor();

//If no valuation then insert a new line in the table
//Otherwise update the value for that news and that player
if ($count == 0)
{
	$bdd->exec('INSERT INTO valuation(news, value, player, day) VALUES("' . $news . '", "' . $value . '", "' . $player . '", "'. $day . '")');
}
else
{
	$bdd->exec('UPDATE valuation SET value = "' . $value . '" WHERE news = "' . $news . '" AND player = "' . $player . '" AND day = "' . $day . '"');
}

echo 'return=ok';
?>