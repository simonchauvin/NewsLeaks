package 
{
	import org.flixel.FlxGame;
	
	[SWF(width = "1024", height = "768", backgroundColor = "#000000")]
	 [Frame(factoryClass="Preloader")]
	
	/**
	 * Main class launching the game
	 * @author Simon Chauvin
	 */
	public class Newsleaks extends FlxGame 
	{
		/**
		 * 
		 */
		public function Newsleaks()
		{
			super(1024, 768, MenuState, 1);
		}
		
	}
	
}