<?php
include 'db_connect.php';

//Retrieve the data sent by the flash app
$player = $_POST['player'];

$response = $bdd->query('SELECT score FROM player WHERE id = "' . $player . '"');
$score = 0;
while ($data = $response->fetch())
{
	$score = $data['score'];
}
$response->closeCursor();

echo 'score:' . $score;
?>