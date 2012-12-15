<?php
include 'db_connect.php';
include 'parameters.php';

$newslist_file = new DOMDocument('1.0', 'utf-8');
$newslist_file->preserveWhiteSpace = false;
$newslist_file->formatOutput = true;
$newslist_file->load($newslist_url);
$newslist = $newslist_file->documentElement;

//Select only the news that comes from the current day and that are not already in the news xml file
//And gives them the value 1 (starting value)
$response = $bdd->query('SELECT id, title, description, link, day, value FROM ' . $news_table . ' WHERE day > (SELECT currentDay FROM newslist) and value = "0"');
$dataFound = false;
$day;
while ($data = $response->fetch())
{
	$descriptionProperStr = explode(".<", html_entity_decode($data['description']));
	
	$value = intval($data['value']) + 1;
	$news = $newslist_file->createElement('news');
	$id = $newslist_file->createElement('id');
	$id_content = $newslist_file->createTextNode($data['id']);
	$title = $newslist_file->createElement('title');
	$title_content = $newslist_file->createTextNode($data['title']);
	$description = $newslist_file->createElement('description');
	$description_content = $newslist_file->createTextNode($descriptionProperStr[0]);
	$link = $newslist_file->createElement('link');
	$link_content = $newslist_file->createTextNode(html_entity_decode($data['link']));
	$value_element = $newslist_file->createElement('value');
	$value_content = $newslist_file->createTextNode($value);
	
	//Appending the contents of the news
	$id->appendChild($id_content);
	$news->appendChild($id);
	$title->appendChild($title_content);
	$news->appendChild($title);
	$description->appendChild($description_content);
	$news->appendChild($description);
	$link->appendChild($link_content);
	$news->appendChild($link);
	$value_element->appendChild($value_content);
	$news->appendChild($value_element);
	$newslist->appendChild($news);
	
	$day = $data['day'];
	$dataFound = true;
	
	$bdd->exec('UPDATE ' . $news_table . ' SET value = "1" WHERE id = "' . $data['id'] . '"');
}

//Si de nouvelles news ont été chargées dans le fichier
if ($dataFound)
{
	$bdd->exec('UPDATE newslist SET currentDay = "' . $day . '", lastupdate = "' . time() . '"');
	
	//Update the day of the newslist
	$newslist->setAttribute('day', $day);
	
	//Save the file now updated
	$newslist_file->save($newslist_url);
}

$response->closeCursor();
?>