<?php
session_start();
if (isset($_SESSION['id']) && isset($_SESSION['login']))
{
	$_SESSION = array();
	session_destroy();
?>
	<p>
		You are now logged out. Please foolow this link to connect again : <a href="index.php&#63;page=login">Login</a>
	</p>
<?php
}
?>