<?php
include './lastRSS.php';
include 'db_connect.php';
include 'parameters.php';

//Getting the day of the last update
$day = '';
$lastupdate = 0;
$response = $bdd->query('SELECT currentDay, lastupdate FROM newslist');
while ($data = $response->fetch())
{
	$day = $data['currentDay'];
	$lastupdate = $data['lastupdate'];
}
$response->closeCursor();

//Retrieve the current time of the update
$current_time = time();

//In case the table is empty
if ($day == '')
{
	$day = 0;
	$bdd->exec('INSERT INTO newslist(currentDay, lastupdate) VALUES("' . $day . '", "' . $current_time . '")');
}

/* //Update the current day into the newslist table and thus of the game
if (($current_time - $lastupdate) >= 86400)
{
	$day++;
	$bdd->exec('UPDATE newslist SET currentDay = "' . $day . '", lastupdate = "' . $current_time . '"');
} */

//The day of the retrieve of news is one day more than the one in the game (and in the xml news file)
$day++;

//Creation of a lastRSS object
$rss = new lastRSS;
//Options lastRSS
$rss->cache_dir   = './cache'; // caching folder
$rss->cache_time  = 3600;      // update frequency of cache (in seconds) corresponds to the length of an in game day
$rss->date_format = 'd/m';     // date format
$rss->CDATA       = 'content'; // remove CDATA and keeping their content
//RSS reading
if ($rs = $rss->get($url_rss))
{
	$req = $bdd->prepare('INSERT INTO ' . $news_table . '(title, description, link, day) VALUES(:title, :description, :link, :day)');
	
	//TODO remove special characters and html tags
	//Find a solution for handling images
	
	//Create the content
	for($i = 0; $i < $limit; $i++)
	{
		if ($rs['items'] != '' && $rs['items'][$i] != '')
		{
			try
			{
				$req->execute(array('title' => $rs['items'][$i]['title'], 'description' => $rs['items'][$i]['description'], 'link' => $rs['items'][$i]['link'], 'day' => $day));
			}
			catch(Exception $e)
			{
				echo 'Erreur : '.$e->getMessage();
			}
		}
	}
}
else 
{
  die ('RSS not found');
}
?>