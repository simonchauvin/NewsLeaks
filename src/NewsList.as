package  
{
	import org.flixel.FlxG;
	
	
	/**
	 * Singleton representing the list of news
	 * @author Simon Chauvin
	 */
	public class NewsList 
	{
		/**
		 * The only instance that can exist
		 */
		private static var instance:NewsList = null;
		
		/**
		 * 
		 */
		private static var newsList:Array;
		
		
		/**
		 * Delete the constructor by making it empty
		 */
		public function NewsList() { }
		
		/**
		 * Get the instance of NewsList if on exist, otherwise create it
		 * @return
		 */
		public static function getInstance():NewsList
		{
			if (instance == null)
				instance = new NewsList();
			return instance;
		}
		
		/**
		 * 
		 */
		public function sort():void
		{
			if (newsList != null && newsList.length > 0)
				newsList.sortOn(["value"], Array.DESCENDING);
		}
		
		/**
		 * 
		 * @param	newsList
		 */
		public static function setNewsList(newsList:Array):void
		{
			NewsList.newsList = newsList;
		}
		
		/**
		 * 
		 * @return
		 */
		public static function getNewsList():Array
		{
			return NewsList.newsList;
		}
	}

}