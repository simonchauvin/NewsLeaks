package  
{
	/**
	 * All the parameters of the game contained in a singleton
	 * @author Simon Chauvin
	 */
	public final class Parameters 
	{
		public static var rssUrl:String;
		
		public static var player:Player;
		
		public static var days:int;
		
		public static var nextDayCountdown:Number;
		
		public static var urlDomain:String = "http://www.newsleaks-game.com";
		
		/**
		 * 
		 */
		public function Parameters() 
		{
			
		}
		
		/**
		 * Get the news list file
		 * @return the file that matches the current language
		 */
		public static function getNewsListFile():String
		{
			var lang:int = player.getLang();
			var url:String;
			if (lang == Glossary.FRENCH)
			{
				url = urlDomain + "/newslist_fr.xml";
			}
			else if (lang == Glossary.ENGLISH)
			{
				url = urlDomain + "/newslist_en.xml";
			}
			else
			{
				url = urlDomain + "/newslist_en.xml";
			}
			return url;
		}
		
		/**
		 * 
		 * @param	rssUrl
		 */
		public static function setRssUrl(rssUrl:String):void
		{
			Parameters.rssUrl = rssUrl;
		}
		
	}

}