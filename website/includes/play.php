<?php
if (isset($_SESSION['id']) && isset($_SESSION['login']))
{
?>
	<div id="play" width="1024" height="768">
		 <OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0" WIDTH="1024" HEIGHT="768" id="newsleaks_game">
			<PARAM NAME=movie VALUE="Newsleaks.swf">
			<PARAM NAME="PLAY" VALUE="true">
			<PARAM NAME="LOOP" VALUE="false">
			<PARAM NAME=quality VALUE=high>
			<PARAM NAME=bgcolor VALUE=#000000>
			<PARAM NAME="SCALE" value="noborder">
			<EMBED src="Newsleaks.swf" quality="high" bgcolor="#000000" WIDTH="1024" HEIGHT="768" PLAY="true" LOOP="false" NAME="Newsleaks" ALIGN="" TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer">
			</EMBED>
		</OBJECT>
	</div>
<?php
}
else
{
?>
	<p>You must be logged in for playing. Please foolow this link to connect : <a href="index.php&#63;page=login">Login</a></p>
<?php
}
?>