<div id="login_content">
	<p>
		<h3>Login</h3>
		<?php
			if (isset($_SESSION['id']) && isset($_SESSION['login']))
			{
		?>
				<p>You are already logged in.</p>
		<?php
			}
			else
			{
		?>
				<form action="index.php&#63;page=login_action" method="post">
					Login : <input type="text" name="login" />
					<br />
					Password : <input type="password" name="password" />
					<br />
					<input type="submit" value="Connect" />
				</form>
		<?php
			}
		?>
	</p>
</div>