<div id="signup_content">
	<p>
		<h3>Sign Up</h3>
		<?php
		include 'db_connect.php';
		
		$login = htmlentities($_POST['login']);
		$password = htmlentities($_POST['password']);
		$lang = htmlentities($_POST['lang']);
		$req = $bdd->prepare('SELECT id FROM player WHERE login = :login');
		$req->execute(array('login' => $login));
		$exist = false;
		while ($data = $req->fetch())
		{
			$exist = true;
		}
		$req->closeCursor();
		
		if ($exist == true)
		{
		?>
			<p>
				Please choose a different login, this one : <?php echo $login ?> has already been chosen.
			</p>
		<?php
		}
		else
		{
			$req = $bdd->prepare('INSERT INTO player(login, password, score, lang) VALUES(:login, :password, 0, :lang)');
			$req->execute(array('login' => $login, 'password' => $password, 'lang' => $lang));
			
			$req = $bdd->prepare('SELECT id FROM player WHERE login = :login');
			$req->execute(array('login' => $login));
			$exist = false;
			while ($data = $req->fetch())
			{
				$exist = true;
			}
			$req->closeCursor();
			
			if ($exist)
			{
				$_SESSION['id'] = $id;
				$_SESSION['login'] = $login;
				$_SESSION['lang'] = $lang;
			?>
				<p>
					You are now signed up and connected as <?php echo $login ?>.
				</p>
			<?php
			}
			else
			{
				?>
				<p>
					Something went wrong during the process, please do it again or contact <a href="mailto:chauvin.simon@gmail.com">the admin</a>.
				</p>
				<?php
			}
		}
		?>
	</p>
</div>