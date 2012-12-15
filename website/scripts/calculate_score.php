<?php
include 'db_connect.php';
include 'parameters.php';

//Retrieve the current day
$response = $bdd->query('SELECT currentday FROM newslist');
$day = 0;
while ($data = $response->fetch())
{
	$day = $data['currentday'];
}
$response->closeCursor();

//Récupération des news qui ont été valués aujourd'hui
$resp_valuation = $bdd->query('SELECT news, value, player FROM valuation WHERE day = "' . $day . '"');
$news = 0;
$value = 0;
$player = 0;
while ($data_valuation = $resp_valuation->fetch())
{
	$news = $data_valuation['news'];
	$value = $data_valuation['value'];
	$player = $data_valuation['player'];
	
	//Récupération de la news parente de la news courante
	$resp_news = $bdd->query('SELECT follow FROM ' . $news_table . ' WHERE id = "' . $news . '"');
	$follow = 0;
	while ($data_news = $resp_news->fetch())
	{
		if ($data_news['follow'] != 0)
		{
			$follow = $data_news['follow'];
		}
	}
	$resp_news->closeCursor();
	
	//Récupération du score du joueur courant
	$resp_player = $bdd->query('SELECT score FROM player WHERE id = "' . $player . '"');
	$score = 0;
	while ($data_player = $resp_player->fetch())
	{
		$score = $data_player['score'];
	}
	$resp_player->closeCursor();
	
	//If the news follows another one then retrieve the value of that news at the days before and add it up
	//And calculate the time between now and the day of the follow, make the score decrease each day
	if ($follow != 0)
	{
		//Récupération des news qui ont été valués aujourd'hui
		$resp_follow = $bdd->query('SELECT value, day FROM ' . $news_table . ' WHERE id = "' . $follow . '"');
		$follow_value = 0;
		while ($data_follow = $resp_valuation->fetch())
		{
			$follow_value = $data_follow['value'];
			$follow_day = $data_follow['day'];
		}
		
		$elapsed_time = $day - $follow_day;
		
		//Calcul du score du joueur courant
		if ($elapsed_time == 0)
		{
			$score += $value + $follow_value;
		}
		else
		{
			$score += (1 / $elpased_time) * $follow_value;
		}
	}
	//If the news does not follow another one then add its value to the coeff times the number of players to select the news
	else if ($follow == 0)
	{
		//Compter le nombre de joueur ayant selectionnné cette news
		$resp_counter = $bdd->query('SELECT COUNT(player) AS counter FROM valuation WHERE news = "' . $news . '" AND day = "' . $day . '"');
		$nbr_players = 0;
		while ($data_counter = $resp_counter->fetch())
		{
			$nbr_players = $data_counter['counter'];
		}
		$resp_counter->closeCursor();
		
		//Calcul du score du joueur courant
		$score += $value + $coef_scoring * $nbr_players;
	}
	//Update of the player's score
	$bdd->exec('UPDATE player SET score = "' . $score . '" WHERE id = "' . $player . '"');
}
$resp_valuation->closeCursor();
?>