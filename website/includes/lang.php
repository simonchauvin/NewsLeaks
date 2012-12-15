<?php
$lang = htmlentities($_GET['lang']);

$_SESSION['lang'] = $lang;

header("Location: http://www.newsleaks-game.com/");
exit;
?>