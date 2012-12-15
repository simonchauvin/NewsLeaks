<?php
include 'config.php';session_start();if (isset($_GET['page'])){	if ($_GET['page'] == 'lang')	{		include 'includes/lang.php';	}}
?>
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
            <div id="menu_content">		<?php		if (isset($_SESSION['lang']))		{			if ($_SESSION['lang'] == '0')			{		?>				<a class="home" href="index.php&#63;page=home">Home</a>				<a class="blog" href="http://www.newsleaks-game.com/blog/">Blog</a>				<a class="login" href="index.php&#63;page=login">Login</a>				<a class="signup" href="index.php&#63;page=signup">Sign Up</a>				<a class="overview" href="index.php&#63;page=overview">Overview</a>				<a class="trailer" href="index.php&#63;page=trailer">Trailer</a>				<a class="play" href="index.php&#63;page=play">Play</a>				<a class="contact" href="index.php&#63;page=contact">Contact</a>				<a class="lang" href="index.php&#63;page=lang&#38;lang=1">Version fran&ccedil;aise</a>		<?php			}			else if ($_SESSION['lang'] == '1')			{		?>				<a class="home" href="index.php&#63;page=home">Accueil</a>				<a class="blog" href="http://newsleaks.blog.lemonde.fr/">Blog</a>				<a class="login" href="index.php&#63;page=login">Connexion</a>				<a class="signup" href="index.php&#63;page=signup">Inscription</a>				<a class="overview" href="index.php&#63;page=overview">R&eacute;sum&eacute;</a>				<a class="trailer" href="index.php&#63;page=trailer">Trailer</a>				<a class="play" href="index.php&#63;page=play">Jouer</a>				<a class="contact" href="index.php&#63;page=contact">Contact</a>				<a class="lang" href="index.php&#63;page=lang&#38;lang=0">English version</a>		<?php			}		}		else		{			$_SESSION['lang'] = '0';		?>			<a class="home" href="index.php&#63;page=home">Home</a>			<a class="blog" href="http://www.newsleaks-game.com/blog/">Blog</a>			<a class="login" href="index.php&#63;page=login">Login</a>			<a class="signup" href="index.php&#63;page=signup">Sign Up</a>			<a class="overview" href="index.php&#63;page=overview">Overview</a>			<a class="trailer" href="index.php&#63;page=trailer">Trailer</a>			<a class="play" href="index.php&#63;page=play">Play</a>			<a class="contact" href="index.php&#63;page=contact">Contact</a>			<a class="lang" href="index.php&#63;page=lang&#38;lang=1">Version fran&ccedil;aise</a>		<?php		}		?>
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
				}				else if ($_GET['page'] == 'signup')				{										include 'includes/signup.php';								}				else if ($_GET['page'] == 'signup_action')								{										include 'includes/signup_action.php';				}									
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
	</div>	<?php	if (!isset($_GET['page']) || $_GET['page'] != 'play')	{	?>		<div id="menu_right">			<p>			  <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" width="200" height="350" id="hitplay" align="middle">				<param name="allowScriptAccess" value="sameDomain" />				<param name="movie" value="http://s1.lemde.fr/mmpub/edt/flash/20110517/1517242_a194_hitplay_blog.swf" />				<param name="quality" value="high" />				<param name="bgcolor" value="#FFFFFF" />				<param name="flashvars" value="id_blog=17" />				<embed flashvars="id_blog=17" src="http://s1.lemde.fr/mmpub/edt/flash/20110517/1517242_a194_hitplay_blog.swf" quality="high" bgcolor="#FFFFFF" width="200" height="350" id="hitplay" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer_fr" />			  </object>			</p>		</div>	<?php	}	?>
	<div id="footer">&copy; Copyright 2011 - All Rights Reserved - <a href="mailto:chauvin.simon@gmail.com">NewsLeaks Team</a></div>
</body>
</html>