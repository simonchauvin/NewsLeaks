package  
{
	import org.flixel.FlxG;
	
	/**
	 * Class representing a player
	 * @author Simon Chauvin
	 */
	public class Player 
	{
		/**
		 * Id that uniquely identifies the player
		 */
		private var id:int;
		
		/**
		 * Username and login
		 */
		private var login:String;
		
		/**
		 * Username and login
		 */
		private var lang:int;
		
		/**
		 * Points earned by the player
		 */
		private var score:int;
		
		/**
		 * The list of valuations that the player did
		 */
		private var valuationsList:Array;
		
		/**
		 * The remaining values that the player has for the day
		 */
		private var remainingValues:int;
		
		/**
		 * Whether a news has already been attributed to a page
		 */
		private var frontPageChosen:Boolean;
		private var secondPageChosen:Boolean;
		private var thirdPageChosen:Boolean;
		
		
		/**
		 * 
		 */
		public function Player(id:int, login:String, lang:int, score:int)
		{
			this.id = id;
			this.login = login;
			this.lang = lang;
			this.score = score;
			this.valuationsList = new Array();
			this.remainingValues = 9;
			this.frontPageChosen = false;
			this.secondPageChosen = false;
			this.thirdPageChosen = false;
			
			Glossary.currentLanguage = lang;
		}
		
		/**
		 * Retrieve the value associated with a news that a player may have or may have not valued
		 * @param	news selected
		 * @return the value of the news, > 0 if the news has a value
		 */
		public function retrieveValue(news:News):int
		{
			var value:int = 0;
			for each(var valuation:Valuation in valuationsList)
			{
				if (news.getId() == valuation.getNewsId())
				{
					value = valuation.getValue();
				}
			}
			return value;
		}
		
		/**
		 * Add a valuation to the list
		 * Check if a a valuation have already been done on the same news
		 * Add or remove value if necessary
		 * Keep only one valuation per news, always positive
		 * @param	valuation to be added
		 */
		public function addAValuation(valuation:Valuation):void
		{
			switch (valuation.getValue())
			{
				case 1:
					choseThirdPage();
					break;
				case 3:
					choseSecondPage();
					break;
				case 5:
					choseFrontPage();
					break;
			}
			var valuationAlreadyExists:Boolean = false;
			for each(var oldValuation:Valuation in valuationsList)
			{
				if (oldValuation.getNewsId() == valuation.getNewsId())
				{
					oldValuation = valuation;
					oldValuation.setInSync(false);
					valuationAlreadyExists = true;
				}
			}
			
			if (!valuationAlreadyExists)
				valuationsList.push(valuation);
		}
		
		/**
		 * Remove the valuation associated with the given news id
		 * @param	newsId
		 */
		public function removeAValuation(newsId:int):void
		{
			for each(var valuation:Valuation in valuationsList)
			{
				if (newsId == valuation.getNewsId())
				{
					FlxG.log("valuation to remove : " + valuation.getNewsId());
					FlxG.log("valuation to remove : " + valuation.getValue());
					FlxG.log("valuation to remove : " + valuation.getOperation());
					switch (valuation.getValue())
					{
						case 1:
							unChoseThirdPage();
							break;
						case 3:
							unChoseSecondPage();
							break;
						case 5:
							unChoseFrontPage();
							break;
					}
			
					valuation.setValue(0);
					valuation.setOperation("-");
					valuation.setInSync(false);
					
					FlxG.log("valuation removed : " + valuation.getNewsId());
					FlxG.log("valuation removed : " + valuation.getValue());
					FlxG.log("valuation removed : " + valuation.getOperation());
				}
			}
			
			/*var valuation:Valuation = null;
			for (var i:int = 0; i < valuationsList.length; i++)
			{
				valuation = valuationsList.shift();
				if (valuation.getNewsId() != newsId)
					valuationsList.push(valuation);
				else
					break;
			}*/
		}
		
		/**
		 * 
		 */
		public function emptyValuationsList():void
		{
			valuationsList = new Array();
			remainingValues = 9;
			this.frontPageChosen = false;
			this.secondPageChosen = false;
			this.thirdPageChosen = false;
		}
		
		/**
		 * 
		 * @return
		 */
		public function isFrontPageChosen():Boolean
		{
			return frontPageChosen;
		}
		
		/**
		 * 
		 * @return
		 */
		public function isSecondPageChosen():Boolean
		{
			return secondPageChosen;
		}
		
		/**
		 * 
		 * @return
		 */
		public function isThirdPageChosen():Boolean
		{
			return thirdPageChosen;
		}
		
		/**
		 * 
		 * @param	score
		 */
		public function setScore(score:int):void
		{
			this.score = score;
		}
		
		/**
		 * 
		 */
		public function choseFrontPage():void
		{
			frontPageChosen = true;
		}
		
		/**
		 * 
		 */
		public function choseSecondPage():void
		{
			secondPageChosen = true;
		}
		
		/**
		 * 
		 */
		public function choseThirdPage():void
		{
			thirdPageChosen = true;
		}
		
		/**
		 * 
		 */
		public function unChoseFrontPage():void
		{
			frontPageChosen = false;
		}
		
		/**
		 * 
		 */
		public function unChoseSecondPage():void
		{
			secondPageChosen = false;
		}
		
		/**
		 * 
		 */
		public function unChoseThirdPage():void
		{
			thirdPageChosen = false;
		}
		
		/**
		 * 
		 */
		public function getChosenFrontPage():News
		{
			var newsId:int = 0;
			for each(var valuation:Valuation in valuationsList)
			{
				if (valuation.getValue() == 5)
					newsId = valuation.getNewsId();
			}
			
			var newsToReturn:News = null;
			if (newsId != 0)
			{
				for each(var news:News in NewsList.getNewsList())
				{
					if (newsId == news.getId())
					{
						newsToReturn = news;
					}
				}
			}
			
			return newsToReturn;
		}
		
		/**
		 * 
		 */
		public function getChosenSecondPage():News
		{
			var newsId:int = 0;
			for each(var valuation:Valuation in valuationsList)
			{
				if (valuation.getValue() == 3)
					newsId = valuation.getNewsId();
			}
			
			var newsToReturn:News = null;
			if (newsId != 0)
			{
				for each(var news:News in NewsList.getNewsList())
				{
					if (newsId == news.getId())
					{
						newsToReturn = news;
					}
				}
			}
			
			return newsToReturn;
		}
		
		/**
		 * 
		 */
		public function getChosenThirdPage():News
		{
			var newsId:int = 0;
			for each(var valuation:Valuation in valuationsList)
			{
				if (valuation.getValue() == 1)
					newsId = valuation.getNewsId();
			}
			
			var newsToReturn:News = null;
			if (newsId != 0)
			{
				for each(var news:News in NewsList.getNewsList())
				{
					if (newsId == news.getId())
					{
						newsToReturn = news;
					}
				}
			}
			
			return newsToReturn;
		}
		
		/**
		 * 
		 * @return
		 */
		public function getRemainingValues():int
		{
			return remainingValues;
		}
		
		/**
		 * 
		 * @return
		 */
		public function getId():int
		{
			return id;
		}
		
		/**
		 * 
		 * @return
		 */
		public function getLogin():String
		{
			return login;
		}
		
		/**
		 * 
		 * @return
		 */
		public function getLang():int
		{
			return lang;
		}
		
		/**
		 * 
		 * @return
		 */
		public function getScore():int
		{
			return score;
		}
		
		/**
		 * 
		 * @return
		 */
		public function getValuationsList():Array
		{
			return valuationsList;
		}

	}

}