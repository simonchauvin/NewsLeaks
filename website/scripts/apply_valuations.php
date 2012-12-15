<?php
include 'db_connect.php';
include 'parameters.php';

$newslist_file = new DOMDocument('1.0', 'utf-8');
$newslist_file->formatOutput = true;
$newslist_file->preserveWhiteSpace = false;

//Loading extern file
$newslist_file->load($newslist_url);

//Retrieve the current day
$response = $bdd->query('SELECT currentday FROM newslist');
$day = 0;
while ($data = $response->fetch())
{
	$day = $data['currentday'];
}
$response->closeCursor();

//Retrieve all valuations
$response = $bdd->query('SELECT news, value, player FROM valuation WHERE day = "' . $day .'"');
$news = 0;
$value = 0;
$player = 0;
while ($data = $response->fetch())
{
	$news = $data['news'];
	$value = $data['value'];
	$player = $data['player'];
	
	//Retrieve the current value of the news
	$newsTable = $bdd->query('SELECT value FROM ' . $news_table . ' WHERE id = "' . $news . '"');
	$oldValue = 0;
	while ($values = $newsTable->fetch())
	{
		$oldValue = $data['value'];
	}
	
	$value = intval($value) + intval($oldValue);
	
	//Update the value of the news with the valuation found
	$bdd->exec('UPDATE ' . $news_table . ' SET value = "' . $value . '" WHERE id = "' . $news . '"');
	
	$newsTable->closeCursor();
	
	$news_file = $newslist_file->getElementsByTagName("news");
	foreach($news_file as $element)
	{
		$news_file_id = $element->getElementsByTagName("id")->item(0)->firstChild->nodeValue;
		//If the news from the bdd match then update the news in the file too
		if (intval($news_file_id) == intval($news))
		{
			$element->getElementsByTagName("value")->item(0)->firstChild->nodeValue = $value;
		}
	}
	
	//Save the newslist file now updated
	$newslist_file->save($newslist_url);
}
$response->closeCursor();
?>