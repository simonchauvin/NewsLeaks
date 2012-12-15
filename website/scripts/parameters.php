<?php
if (isset($_SESSION['lang']))
{
	if ($_SESSION['lang'] == '2')
	{
		$news_table = 'news_fr';
		
		$newslist_url = './newslist_fr.xml';
		$lang = '2';
		
		//Retrieve RSS paramters
		$url_rss = 'http://www.lemonde.fr/rss/une.xml';
		$limit   = 999999;
	}
	else if ($_SESSION['lang'] == '1')
	{
		$news_table = 'news_en';
		
		$newslist_url = './newslist_en.xml';
		$lang = '1';
		
		//Retrieve RSS paramters
		$url_rss = 'http://feeds.reuters.com/reuters/topNews?format=xml';
		$limit   = 999999;
	}
}
else
{
	$news_table = 'news_en';
	
	$newslist_url = './newslist_en.xml';
	$lang = '1';
	
	//Retrieve RSS paramters
	$url_rss = 'http://feeds.reuters.com/reuters/topNews?format=xml';
	$limit   = 999999;
}

//Database names of the tables
$newslist_table = 'news';
$player_table = 'news';
$valuation_table = 'news';

//Misc parameters
$coef_scoring = 0.1;

?>