<div id="login_content">
	<p>
		<h3>Login</h3>
		<?php
		include 'db_connect.php';
		
		$login = htmlentities($_POST['login']);
		$password = htmlentities($_POST['password']);
		$req = $bdd->prepare('SELECT id, lang FROM player WHERE login = :login AND password = :password');
		$req->execute(array('login' => $login, 'password' => $password));
		$exist = false;
		$id = 0;
		$lang = 1;
		while ($data = $req->fetch())
		{
			$exist = true;
			$id = $data['id'];
			$lang = $data['lang'];
		}
		$req->closeCursor();
		if ($exist == true)
		{
			$_SESSION['id'] = $id;
			$_SESSION['login'] = $login;
			$_SESSION['lang'] = $lang;
		?>
			<p>
				You are now logged in as <?php echo $_SESSION['login'] ?>. Play now ? : <a href="index.php&#63;page=play">Yes</a>
			</p>
		<?php
		}
		else
		{
		?>
			<p>
				The login and/or password that you provided does not match the ones we have in the database.
			</p>
		<?php
		}
		?>
	</p>
</div>