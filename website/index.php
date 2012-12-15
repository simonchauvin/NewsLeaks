<?php
include 'config.php';

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>NewsLeaks - A multiplayer game about journalism</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="language" content="en" />
	<meta name="description" content="NewsLeaks is a multiplayer facebook game about journalism" />
	<meta name="keywords" content="NewsLeaks" />
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery.lightbox-0.5.js"></script>
	<script type="text/javascript" src="js/main.js"></script>
	<link rel="stylesheet" type="text/css" href="css/design.css" media="screen"/>
	<link rel="stylesheet" type="text/css" href="css/jquery.lightbox-0.5.css" media="screen" />
	<!--<link rel='shortcut icon' href="/images/favicon.ico" />-->
</head>
<body>
    <div id="background">
        <div id="header">
            <a href="index.php&#63;page=home"><span class="logo"><img alt="NewsLeaks" title="NewsLeaks" src="images/header.png" width="1000px" border="0"/></span></a>
        </div>
        <div id="menu">
            <div id="menu_content">
            </div>
        </div>
        <div id="content">
		<?php
			if (isset($_GET['page']))
			{
				if ($_GET['page'] == 'home')
				{
					include 'includes/home.php';
				}
				else if ($_GET['page'] == 'login')				
				{					
					include 'includes/login.php';				
				}
				else if ($_GET['page'] == 'login_action')				
				{					
					include 'includes/login_action.php';
				}
				else if ($_GET['page'] == 'overview')				
				{					
					include 'includes/overview.php';				
				}				
				else if ($_GET['page'] == 'trailer')				
				{					
					include 'includes/trailer.php';				
				}				
				else if ($_GET['page'] == 'play')			
				{					
					include 'includes/play.php';		
				}
				else if ($_GET['page'] == 'contact')			
				{
					include 'includes/contact.php';		
				}
				else				
				{
					include 'includes/home.php';		
				}
			}
			else
			{
				include 'includes/home.php';
			}
		?>
	</div>
	<div id="footer">&copy; Copyright 2011 - All Rights Reserved - <a href="mailto:chauvin.simon@gmail.com">NewsLeaks Team</a></div>
</body>
</html>