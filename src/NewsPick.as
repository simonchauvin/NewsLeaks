package  
{
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import org.flixel.FlxButton;
	import org.flixel.FlxObject;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.net.URLVariables;
	
	/**
	 * This class is used for the news pick gameplay
	 * @author Simon Chauvin
	 */
	public class NewsPick extends FlxState
	{
		/**
		 * Fonts
		 */
		[Embed(source = "../assets/fonts/arial.ttf", fontFamily = "arial", embedAsCFF = "false")] public var FontArial:String;
		
		/**
		 * Background
		 */
		[Embed(source = '../assets/backgrounds/background.png')] protected var ImgBackground:Class;
		[Embed(source = '../assets/backgrounds/foreground.png')] protected var ImgForeground:Class;
		[Embed(source = '../assets/backgrounds/title.png')] protected var ImgTitle:Class;
		[Embed(source = '../assets/menus/news_header.png')] protected var ImgNewsHeader:Class;
		
		/**
		 * Buttons
		 */
		[Embed(source = '../assets/buttons/tiny_button_highlight.png')] protected var ImgTinyButtonHighlight:Class;
		[Embed(source = '../assets/buttons/large_button_highlight.png')] protected var ImgLargeButtonHighlight:Class;
		[Embed(source = '../assets/buttons/large_button_normal.png')] protected var ImgLargeButtonNormal:Class;
		[Embed(source = '../assets/buttons/page_button_normal.png')] protected var ImgPageButtonNormal:Class;
		[Embed(source = '../assets/buttons/page_button_highlight.png')] protected var ImgPageButtonHighlight:Class;
		[Embed(source = '../assets/buttons/news_button_normal.png')] protected var ImgNewsButtonNormal:Class;
		[Embed(source = '../assets/buttons/news_button_highlight.png')] protected var ImgNewsButtonHighlight:Class;
		[Embed(source = '../assets/buttons/exit_button_normal.png')] protected var ImgExitButtonNormal:Class;
		[Embed(source = '../assets/buttons/exit_button_highlight.png')] protected var ImgExitButtonHighlight:Class;
		[Embed(source = '../assets/buttons/increase_button_normal.png')] protected var ImgIncreaseButtonNormal:Class;
		[Embed(source = '../assets/buttons/increase_button_highlight.png')] protected var ImgIncreaseButtonHighlight:Class;
		[Embed(source = '../assets/buttons/decrease_button_normal.png')] protected var ImgDecreaseButtonNormal:Class;
		[Embed(source = '../assets/buttons/decrease_button_highlight.png')] protected var ImgDecreaseButtonHighlight:Class;
		
		/**
		 * News selected
		 */
		[Embed(source = '../assets/menus/news_selected.png')] protected var ImgNewsSelected:Class;
		
		/**
		 * Sounds
		 */
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'PLUS_01')] public var SndIncrease:Class;
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'MINUS_01')] public var SndDecrease:Class;
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'NEXT_PAGE_01')] public var SndNextPage:Class;
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'PREVIOUS_PAGE_01')] public var SndPreviousPage:Class;
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'NEW_SELECTED_01')] public var SndSelectNews:Class;
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'SAVE_QUIT_01')] public var SndSave:Class;
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'CANCEL_01')] public var SndCancel:Class;
		
		/**
		 * Possible news values
		 */
		internal static const FRONT_PAGE_VALUE:int = 5;
		internal static const SECOND_PAGE_VALUE:int = 3;
		internal static const THIRD_PAGE_VALUE:int = 1;
		
		/**
		 * Array of news available
		 */
		private var newsList:Array;
		
		/**
		 * 
		 */
		private var page:Array;
		
		/**
		 * Boolean used to know if the first news have been loaded
		 */
		private var firstLoaded:Boolean;
		
		/**
		 * 
		 */
		private var selectedNews:News;
		
		private var newsSelected:FlxSprite;
		private var newsTitle:FlxText;
		private var newsDescription:FlxText;
		private var newsLink:NewsLeaksLink;
		private var increaseValueButton:NewsLeaksButton;
		private var decreaseValueButton:NewsLeaksButton;
		
		/**
		 * 
		 */
		private var newsSelectedValue:FlxText;
		
		/**
		 * Current value of the selected news
		 */
		private var currentValuation:int;
		
		/**
		 * Previous valuation of the news before the player updates its value
		 */
		private var previousValuation:int;
		
		/**
		 * Current page viewed by the player
		 */
		private var currentPage:int;
		
		/**
		 * The label of the current value of the news
		 */
		private var valuationLabel:FlxText;
		
		/**
		 * Internal variable used to know the last news loaded plus one
		 */
		private var lastIndexLoaded:int;
		
		/**
		 * Gateway to the php files
		 */
		private var gateway:Gateway;
		
		/**
		 * Player's display
		 */
		private var playerName:FlxText;
		private var playerScore:FlxText;
		
		/**
		 * Time class used to retrieve the current time
		 */
		private var time:Time;
		
		/**
		 * Days passing by
		 */
		private var daysLabel:FlxText;
		
		/**
		 * Countdown before the next day in secondes
		 */
		private var nextDayCountdownLabel:FlxText;
		
		
		/**
		 * Create method, intitialize the state
		 */
		override public function create():void
		{
			time = new Time();
			add(time);
			
			//Initialization
			currentPage = 0;
			firstLoaded = false;
			newsList = NewsList.getNewsList();
			lastIndexLoaded = 0;
			currentValuation = 0;
			
			var background:FlxSprite = new FlxSprite(0, 0, ImgBackground);
			add(background);
			var foreground:FlxSprite = new FlxSprite(0, 0, ImgForeground);
			add(foreground);
			var title:FlxSprite = new FlxSprite(163, FlxG.height - 56, ImgTitle);
			add(title);
			
			playerName = new FlxText(520, 713, 300, Glossary.PLAYER_NAME[Glossary.currentLanguage] + " : " + Parameters.player.getLogin());
			playerName.setFormat("Arial", 18, 0x000000, "left");
			add(playerName);
			
			playerScore = new FlxText(520, 733, 300, Glossary.PLAYER_SCORE[Glossary.currentLanguage] + " : " + Parameters.player.getScore());
			playerScore.setFormat("Arial", 18, 0x000000, "left");
			add(playerScore);
			
			daysLabel = new FlxText(700, 713, 135, Glossary.DAYS[Glossary.currentLanguage] + " : " + time.getDays());
			daysLabel.setFormat("Arial", 18, 0x000000, "left");
			add(daysLabel);
			
			nextDayCountdownLabel = new FlxText(700, 733, 360, Glossary.DAY_END[Glossary.currentLanguage] + " : " + time.getNextDayCountdownString());
			nextDayCountdownLabel.setFormat("Arial", 18, 0x000000, "left");
			add(nextDayCountdownLabel);
			
			var newsHeader:FlxSprite = new FlxSprite(FlxG.width / 2 - 160, 0, ImgNewsHeader);
			add(newsHeader);
			
			var newsLabel:FlxText = new FlxText(FlxG.width / 2 - 160, 20, 321, Glossary.NEWS[Glossary.currentLanguage]);
			newsLabel.setFormat("Arial", 32, 0xffffff, "center");
			add(newsLabel);
			
			var variables:URLVariables = new URLVariables();
			variables.player = Parameters.player.getId().toString();
			gateway = new Gateway(Parameters.urlDomain + "/get_valuations.php ", variables);
			gateway.send();
			
			//Buttons
			var previousPage:NewsLeaksButton = new NewsLeaksButton(60, 480, Glossary.PREVIOUS_PAGE[Glossary.currentLanguage], 12, 0x000000, "center", goToPreviousPage, null, ImgPageButtonNormal, ImgPageButtonHighlight, 184, 31, true);
			previousPage.setAnimation([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 24);
			previousPage.facing = FlxObject.LEFT;
			add(previousPage);
			var nextPage:NewsLeaksButton = new NewsLeaksButton(780, 480, Glossary.NEXT_PAGE[Glossary.currentLanguage], 12, 0x000000, "center", goToNextPage, null, ImgPageButtonNormal, ImgPageButtonHighlight, 184, 31, true);
			nextPage.setAnimation([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 24);
			add(nextPage);
			var cancel:NewsLeaksButton = new NewsLeaksButton(62, 630, Glossary.CANCEL[Glossary.currentLanguage], 12, 0x000000, "left", cancel, null, ImgExitButtonNormal, ImgExitButtonHighlight, 63, 71, true);
			cancel.setAnimation([0, 1, 2, 3, 4, 5, 6, 7, 8], 18);
			add(cancel);
			var saveAndQuit:NewsLeaksButton = new NewsLeaksButton(892, 630, Glossary.SAVE_QUIT[Glossary.currentLanguage], 12, 0x000000, "right", saveAndQuit, null, ImgExitButtonNormal, ImgExitButtonHighlight, 63, 71, true);
			saveAndQuit.setAnimation([0, 1, 2, 3, 4, 5, 6, 7, 8], 18);
			add(saveAndQuit);
		}
		
		/**
		 * Update the state
		 */
		override public function update():void
		{
			super.update();
			
			if (!firstLoaded && newsList != null && newsList.length > 0)
			{
				firstLoaded = true;
				page = new Array(Math.ceil(newsList.length / 24));
				displayNews();
			}
			
			//Retrieve the data on valuations
			if (gateway != null)
			{
				var data:String = gateway.getResult();
				if (data != null)
				{
					var elements:Array = data.split("valuations:")[1].split(";");
					for (var i:int = 0; i < elements.length; i++)
					{
						if (elements[i].length > 0)
						{
							var keyAndValue:Array = elements[i].split("=");
							var newsId:int = keyAndValue[0];
							var value:int = keyAndValue[1];
							Parameters.player.addAValuation(new Valuation(newsId, value, "+", Parameters.player.getId(), true));
						}
					}
					gateway = null;
				}
			}
			
			//Countdown before the next day
			nextDayCountdownLabel.text = Glossary.DAY_END[Glossary.currentLanguage] + " : " + time.getNextDayCountdownString();
			
			//TODO put title in front
			//sort("y", ASCENDING);
		}
		
		/**
		 * Save the valuations made by the player
		 */
		public function saveValuations():void
		{
			var valuationsList:Array = Parameters.player.getValuationsList();
			for (var i:int = 0; i < valuationsList.length; i++)
			{
				var valuation:Valuation = valuationsList[i];
				if (!valuation.isInSync())
				{
					valuation.setInSync(true);
					var variables:URLVariables = new URLVariables();
					
					if (valuation.getOperation() == "+")
					{
						variables.news = valuation.getNewsId().toString();
						variables.value = valuation.getValue().toString();
						variables.player = valuation.getPlayerId().toString();
						gateway = new Gateway(Parameters.urlDomain + "/scripts/add_or_update_valuation.php", variables);
					}
					else
					{
						FlxG.log("ça passe dans le moins, donc supprime des data !");
						variables.news = valuation.getNewsId().toString();
						variables.player = valuation.getPlayerId().toString();
						gateway = new Gateway(Parameters.urlDomain + "/scripts/remove_valuation.php", variables);
					}
					
					gateway.send();
				}
			}
		}
		
		/**
		 * Displaying the news in a nice and sorted way
		 */
		public function displayNews():void
		{
			var xCoord:int = 62;
			var yCoord:int = 68;
			var pageFull:Boolean = false;
			var news:News = null;
			var i:int = lastIndexLoaded;
			page[currentPage] = new Array();
			while (!pageFull && i < newsList.length)
			{
				news = newsList[i];
				if (news != null)
				{
					var newsButton:NewsLeaksButton = new NewsLeaksButton(xCoord, yCoord, news.getTitle(), 12, 0x000000, "center", showANews, [news], ImgNewsButtonNormal, ImgNewsButtonHighlight, 150, 100);
					add(newsButton);
					
					page[currentPage].push(newsButton);
					
					if (xCoord >= (FlxG.width - (newsButton.width + 62)))
					{
						xCoord = 62;
						yCoord += newsButton.height;
						
						if (yCoord >= 462)
						{
							yCoord = 62;
							pageFull = true;
						}
					}
					else
						xCoord += newsButton.width;
					i++;
				}
			}
			lastIndexLoaded = i;
		}
		
		/**
		 * 
		 * @param	news
		 */
		public function updateValuationUp(news:News):void
		{
			currentValuation = Parameters.player.retrieveValue(news);
			FlxG.log("current valuation before increase : " + currentValuation);
			previousValuation = currentValuation;
			if (currentValuation == SECOND_PAGE_VALUE && !Parameters.player.isFrontPageChosen())
			{
				currentValuation = FRONT_PAGE_VALUE;
				valuationLabel.text = Glossary.FRONT_PAGE_LABEL[Glossary.currentLanguage];
				Parameters.player.unChoseSecondPage();
				Parameters.player.choseFrontPage();
			}
			
			if (currentValuation == THIRD_PAGE_VALUE && !Parameters.player.isSecondPageChosen())
			{
				currentValuation = SECOND_PAGE_VALUE;
				valuationLabel.text = Glossary.SECOND_PAGE_LABEL[Glossary.currentLanguage];
				Parameters.player.unChoseThirdPage();
				Parameters.player.choseSecondPage();
			}
			else if (currentValuation == THIRD_PAGE_VALUE && !Parameters.player.isFrontPageChosen())
			{
				currentValuation = FRONT_PAGE_VALUE;
				valuationLabel.text = Glossary.FRONT_PAGE_LABEL[Glossary.currentLanguage];
				Parameters.player.unChoseThirdPage();
				Parameters.player.choseFrontPage();
			}
			
			if (currentValuation == 0 && !Parameters.player.isThirdPageChosen())
			{
				currentValuation = THIRD_PAGE_VALUE;
				valuationLabel.text = Glossary.THIRD_PAGE_LABEL[Glossary.currentLanguage];
				Parameters.player.choseThirdPage();
			}
			else if (currentValuation == 0 && !Parameters.player.isSecondPageChosen())
			{
				currentValuation = SECOND_PAGE_VALUE;
				valuationLabel.text = Glossary.SECOND_PAGE_LABEL[Glossary.currentLanguage];
				Parameters.player.choseSecondPage();
			}
			else if (currentValuation == 0 && !Parameters.player.isFrontPageChosen())
			{
				currentValuation = FRONT_PAGE_VALUE;
				valuationLabel.text = Glossary.FRONT_PAGE_LABEL[Glossary.currentLanguage];
				Parameters.player.choseFrontPage();
			}
		}
		
		/**
		 * 
		 * @param	news
		 */
		public function updateValuationDown(news:News):void
		{
			currentValuation = Parameters.player.retrieveValue(news);
			FlxG.log("current valuation before decrease : " + currentValuation);
			previousValuation = currentValuation;
			
			if (currentValuation == THIRD_PAGE_VALUE)
			{
				currentValuation = 0;
				valuationLabel.text = Glossary.NOT_VALUED[Glossary.currentLanguage];
				Parameters.player.unChoseThirdPage();
			}
			
			if (currentValuation == SECOND_PAGE_VALUE && !Parameters.player.isThirdPageChosen())
			{
				currentValuation = THIRD_PAGE_VALUE;
				valuationLabel.text = Glossary.THIRD_PAGE_LABEL[Glossary.currentLanguage];
				Parameters.player.unChoseSecondPage();
				Parameters.player.choseThirdPage();
			}
			else if (currentValuation == SECOND_PAGE_VALUE)
			{
				currentValuation = 0;
				valuationLabel.text = Glossary.NOT_VALUED[Glossary.currentLanguage];
				Parameters.player.unChoseSecondPage();
			}
			
			if (currentValuation == FRONT_PAGE_VALUE && !Parameters.player.isSecondPageChosen())
			{
				currentValuation = SECOND_PAGE_VALUE;
				valuationLabel.text = Glossary.SECOND_PAGE_LABEL[Glossary.currentLanguage];
				Parameters.player.unChoseFrontPage();
				Parameters.player.choseSecondPage();
			}
			else if (currentValuation == FRONT_PAGE_VALUE && !Parameters.player.isThirdPageChosen())
			{
				currentValuation = THIRD_PAGE_VALUE;
				valuationLabel.text = Glossary.THIRD_PAGE_LABEL[Glossary.currentLanguage];
				Parameters.player.unChoseFrontPage();
				Parameters.player.choseThirdPage();
			}
			else if (currentValuation == FRONT_PAGE_VALUE)
			{
				currentValuation = 0;
				valuationLabel.text = Glossary.NOT_VALUED[Glossary.currentLanguage];
				Parameters.player.unChoseFrontPage();
			}
		}
		
		/**
		 * Display a news and related information
		 * @param	news to be dispayed
		 */
		public function showANews(news:News):void
		{
			FlxG.play(SndSelectNews);
			
			//Remove previous news selected
			remove(newsSelected);
			remove(newsTitle);
			remove(newsDescription);
			remove(newsLink);
			remove(newsSelectedValue);
			remove(valuationLabel);
			remove(increaseValueButton);
			remove(decreaseValueButton);
			
			//Display the new one
			newsSelected = new FlxSprite(FlxG.width / 2 - 224, 468, ImgNewsSelected)
			add(newsSelected);
			
			newsTitle = new FlxText(newsSelected.x + 12, newsSelected.y + 15, newsSelected.width - 110, news.getTitle());
			newsTitle.setFormat("Arial", 18, 0xffffff, "left");
			add(newsTitle);
			
			newsDescription = new FlxText(newsSelected.x + 12, newsSelected.y + 80, newsSelected.width - 24, news.getDescription());
			newsDescription.setFormat("Arial", 14, 0xffffff, "left");
			add(newsDescription);
			
			newsLink = new NewsLeaksLink(newsSelected.x + 12, newsSelected.y + 150, news.getLink(), 449, 30);
			newsLink.setLabelFormat("Arial", 10, 0xffffff, "center");
			add(newsLink);
			
			newsSelectedValue = new FlxText(newsSelected.x + 190, newsSelected.y + 200, newsSelected.width - 60, "Valeur : " + news.getValue().toString());
			newsSelectedValue.setFormat("Arial", 20, 0xffffff, "center");
			add(newsSelectedValue);
			
			currentValuation = 0;
			
			valuationLabel = new FlxText(newsSelected.x + 90, newsSelected.y + 200, newsSelected.width - 60, Glossary.NOT_VALUED[Glossary.currentLanguage]);
			valuationLabel.setFormat("Arial", 18, 0xffffff, "left");
			add(valuationLabel);
			
			currentValuation = Parameters.player.retrieveValue(news);
			if (currentValuation == FRONT_PAGE_VALUE)
			{
				previousValuation = FRONT_PAGE_VALUE;
				valuationLabel.text = Glossary.FRONT_PAGE_LABEL[Glossary.currentLanguage];
			}
			else if (currentValuation == SECOND_PAGE_VALUE)
			{
				previousValuation = SECOND_PAGE_VALUE;
				valuationLabel.text = Glossary.SECOND_PAGE_LABEL[Glossary.currentLanguage];
			}
			else if (currentValuation == THIRD_PAGE_VALUE)
			{
				previousValuation = THIRD_PAGE_VALUE;
				valuationLabel.text = Glossary.THIRD_PAGE_LABEL[Glossary.currentLanguage];
			}
			
			increaseValueButton = new NewsLeaksButton(newsSelected.x + 12, newsSelected.y + 200, null, 16, 0x000000, null, increaseValue, [news], ImgIncreaseButtonNormal, ImgIncreaseButtonHighlight, 28, 28);
			add(increaseValueButton);
			decreaseValueButton = new NewsLeaksButton(newsSelected.x +48, newsSelected.y + 200, null, 0, 0x000000, null, decreaseValue, [news], ImgDecreaseButtonNormal, ImgDecreaseButtonHighlight, 28, 28);
			add(decreaseValueButton);
		}
		
		/**
		 * Method that display the next page
		 */
		public function goToNextPage():void
		{
			FlxG.play(SndNextPage);
			if (page != null && (currentPage + 1) < page.length)
			{
				var newsButtons:Array = page[currentPage];
					for (var i:int = 0; i < newsButtons.length; i++)
						newsButtons[i].kill();
				
				if (page[currentPage + 1] != null)
				{
					currentPage++;
					
					newsButtons = page[currentPage];
					for (i = 0; i < newsButtons.length; i++)
						newsButtons[i].reset(newsButtons[i].x, newsButtons[i].y);
				}
				else
				{
					if (newsList != null && newsList.length > 0)
					{
						currentPage++;
						displayNews();
					}
				}
			}
		}
		
		/**
		 * Method that display the previous page
		 */
		public function goToPreviousPage():void
		{
			FlxG.play(SndPreviousPage);
			if (page != null && (currentPage - 1) >= 0)
			{
				var newsButtons:Array = page[currentPage];
					for (var i:int = 0; i < newsButtons.length; i++)
						newsButtons[i].kill();
				
				if (page[currentPage - 1] != null)
				{
					currentPage--;
					
					newsButtons = page[currentPage];
					for (i = 0; i < newsButtons.length; i++)
						newsButtons[i].reset(newsButtons[i].x, newsButtons[i].y);
				}
				else
				{
					if (newsList != null && newsList.length > 0)
					{
						currentPage--;
						displayNews();
					}
				}
			}
		}
		
		/**
		 * Increase the value of a news
		 * @param	news
		 */
		public function increaseValue(news:News):void
		{
			FlxG.play(SndIncrease);
			updateValuationUp(news);
			var valuation:int = currentValuation - previousValuation;
			if (valuation > 0)
				Parameters.player.addAValuation(new Valuation(news.getId(), currentValuation, "+", Parameters.player.getId(), false));
			FlxG.log("Valuations list : " + Parameters.player.getValuationsList());
			previousValuation = 0;
			currentValuation = 0;
		}
		
		/**
		 * Decrease the value of a news
		 * @param	news
		 */
		public function decreaseValue(news:News):void
		{
			FlxG.play(SndDecrease);
			updateValuationDown(news);
			var valuation:int = previousValuation - currentValuation;
			if (valuation > 0)
			{
				if (valuation != previousValuation)
					Parameters.player.addAValuation(new Valuation(news.getId(), currentValuation, "+", Parameters.player.getId(), false));
				else
					Parameters.player.removeAValuation(news.getId());
			}
			
			FlxG.log("Valuations list : " + Parameters.player.getValuationsList());
			previousValuation = 0;
			currentValuation = 0;
		}
		
		/**
		 * Save the valuations and go back to the main page
		 */
		public function saveAndQuit():void
		{
			FlxG.play(SndSave);
			saveValuations();
			Parameters.player.emptyValuationsList();
			FlxG.switchState(new PlayState());
		}
		
		/**
		 * Cancel the valuations and go back to the main page
		 */
		public function cancel():void
		{
			FlxG.play(SndCancel);
			Parameters.player.emptyValuationsList();
			FlxG.switchState(new PlayState());
		}
		
		/**
		 * Set the news list
		 * @param	newsList
		 */
		public function setNewsList(newsList:Array):void
		{
			this.newsList = newsList;
		}
		
	}

}