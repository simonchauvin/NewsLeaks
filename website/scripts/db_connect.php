<?php
//Connection to the database
try
{
	$pdo_options[PDO::ATTR_ERRMODE] = PDO::ERRMODE_EXCEPTION;
	$pdo_options[PDO::MYSQL_ATTR_INIT_COMMAND] = "SET NAMES utf8";
	$bdd = new PDO('mysql:host=mysql5-22.perso;dbname=streamgastuff', 'streamgastuff', 'wellStream', $pdo_options);
}
catch (Exception $e)
{
	die('Erreur : ' . $e->getMessage());
}
?>