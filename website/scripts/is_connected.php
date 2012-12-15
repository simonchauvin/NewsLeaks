<?php
session_start();
if (isset($_SESSION['id']) && isset($_SESSION['login']))
{
	echo 'id=' . $_SESSION['id'] . ';login=' . $_SESSION['login'] . ';lang=' . $_SESSION['lang'];
}
else
{
	echo 'id=0;login=null;lang=0';
}
?>