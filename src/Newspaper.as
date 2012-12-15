package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import flash.net.URLVariables;
	import org.flixel.FlxText;
	
	
	/**
	 * Newspaper page
	 * @author Simon Chauvin
	 */
	public class Newspaper extends FlxState
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
		[Embed(source = '../assets/backgrounds/newspaper.png')] protected var ImgNewspaper:Class;
		[Embed(source = '../assets/backgrounds/title.png')] protected var ImgTitle:Class;
		[Embed(source = '../assets/menus/news_header.png')] protected var ImgNewsHeader:Class;
		
		/**
		 * Buttons
		 */
		[Embed(source = '../assets/buttons/exit_button_normal.png')] protected var ImgExitButtonNormal:Class;
		[Embed(source = '../assets/buttons/exit_button_highlight.png')] protected var ImgExitButtonHighlight:Class;
		
		/**
		 * Sounds
		 */
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'NEW_SELECTED_01')] public var SndClick:Class;
		
		/**
		 * Gateway to the php scripts
		 */
		private var gateway:Gateway;
		
		/**
		 * Player's display
		 */
		private var playerName:FlxText;
		private var playerScore:FlxText;
		
		/**
		 * 
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
			
			//Retrieve valuations
			var variables:URLVariables = new URLVariables();
			variables.player = Parameters.player.getId().toString();
			gateway = new Gateway(Parameters.urlDomain + "/get_valuations.php ", variables);
			gateway.send();
			
			//Background stuff
			var background:FlxSprite = new FlxSprite(0, 0, ImgBackground);
			add(background);
			var foreground:FlxSprite = new FlxSprite(0, 0, ImgForeground);
			add(foreground);
			var title:FlxSprite = new FlxSprite(163, FlxG.height - 56, ImgTitle);
			add(title);
			
			var newspaper:FlxSprite = new FlxSprite(0, 0, ImgNewspaper);
			add(newspaper);
			
			var newspaperHeader:FlxSprite = new FlxSprite(FlxG.width / 2 - 160, 0, ImgNewsHeader);
			add(newspaperHeader);
			var newspaperLabel:FlxText = new FlxText(FlxG.width / 2 - 160, 20, 321, Glossary.NEWSPAPER[Glossary.currentLanguage]);
			newspaperLabel.setFormat("Arial", 32, 0xffffff, "center");
			add(newspaperLabel);
			
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
			
			var exitButton:NewsLeaksButton = new NewsLeaksButton(62, 630, Glossary.EXIT[Glossary.currentLanguage], 12, 0x000000, "center", exit, null, ImgExitButtonNormal, ImgExitButtonHighlight, 63, 71, true);
			exitButton.setAnimation([0, 1, 2, 3, 4, 5, 6, 7, 8], 18);
			add(exitButton);
		}
		
		/**
		 * Update the state
		 */
		override public function update():void
		{
			super.update();
			
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
				
				var news:News = null;
				news = Parameters.player.getChosenFrontPage();
				if (news != null)
				{
					var frontPageNewsLabel:FlxText = new FlxText(80, 90, 902, news.getTitle());
					frontPageNewsLabel.setFormat("Arial", 38, 0x000000, "center");
					add(frontPageNewsLabel);
					
					frontPageNewsLabel = new FlxText(80, 220, 902, news.getDescription());
					frontPageNewsLabel.setFormat("Arial", 15, 0x000000, "center");
					add(frontPageNewsLabel);
					
					frontPageNewsLabel = new FlxText(80, 300, 902, news.getLink());
					frontPageNewsLabel.setFormat("Arial", 15, 0x000000, "center");
					add(frontPageNewsLabel);
				}
				
				news = Parameters.player.getChosenSecondPage();
				if (news != null)
				{
					var secondPageNewsLabel:FlxText = new FlxText(62, 380, 580, news.getTitle());
					secondPageNewsLabel.setFormat("Arial", 24, 0x000000, "left");
					add(secondPageNewsLabel);
					
					secondPageNewsLabel = new FlxText(62, 460, 560, news.getDescription());
					secondPageNewsLabel.setFormat("Arial", 15, 0x000000, "left");
					add(secondPageNewsLabel);
					
					secondPageNewsLabel = new FlxText(62, 520, 560, news.getLink());
					secondPageNewsLabel.setFormat("Arial", 15, 0x000000, "center");
					add(secondPageNewsLabel);
				}
				
				news = Parameters.player.getChosenThirdPage();
				if (news != null)
				{
					var thirdPageNewsLabel:FlxText = new FlxText(660, 380, 250, news.getTitle());
					thirdPageNewsLabel.setFormat("Arial", 24, 0x000000, "left");
					add(thirdPageNewsLabel);
					
					thirdPageNewsLabel = new FlxText(660, 460, 250, news.getDescription());
					thirdPageNewsLabel.setFormat("Arial", 15, 0x000000, "left");
					add(thirdPageNewsLabel);
					
					thirdPageNewsLabel = new FlxText(660, 580, 250, news.getLink());
					thirdPageNewsLabel.setFormat("Arial", 15, 0x000000, "center");
					add(thirdPageNewsLabel);
				}
			}
			
			//Countdown before the next day
			nextDayCountdownLabel.text = Glossary.DAY_END[Glossary.currentLanguage] + " : " + time.getNextDayCountdownString();
		}
		
		/**
		 * Cancel the valuations and go back to the main page
		 */
		public function exit():void
		{
			FlxG.play(SndClick);
			Parameters.player.emptyValuationsList();
			FlxG.switchState(new PlayState());
		}
		
	}
}