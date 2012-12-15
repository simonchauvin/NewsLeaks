package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import flash.xml.XMLDocument;
	import flash.net.URLVariables;
	
	
	/**
	 * Main class of the game, used to initialize the game and update it
	 * @author Simon Chauvin
	 */
	public class PlayState extends FlxState
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
		
		/**
		 * Buttons
		 */
		[Embed(source = '../assets/buttons/tiny_button_normal.png')] protected var ImgTinyButtonNormal:Class;
		[Embed(source = '../assets/buttons/tiny_button_highlight.png')] protected var ImgTinyButtonHighlight:Class;
		[Embed(source = '../assets/buttons/large_button_highlight.png')] protected var ImgLargeButtonHighlight:Class;
		[Embed(source = '../assets/buttons/large_button_normal.png')] protected var ImgLargeButtonNormal:Class;
		
		/**
		 * Sounds
		 */
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'AMBIANCE_07')] public var SndAmbiance7:Class;
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'NEW_SELECTED_01')] public var SndClick:Class;
		
		/**
		 * XML file for storing data on news
		 */
		private var xmlFile:XML;
		
		/**
		 * Parser object used to load and get the data
		 */
		private var xmlParser:XMLParser;
		
		/**
		 * 
		 */
		private var alreadyLoaded:Boolean;
		
		/**
		 * Player's display
		 */
		private var playerName:FlxText;
		private var playerScore:FlxText;
		
		/**
		 * Days passing by
		 */
		private var daysLabel:FlxText;
		
		/**
		 * Countdown before the next day in secondes
		 */
		private var nextDayCountdownLabel:FlxText;
		
		/**
		 * 
		 */
		private var time:Time;
		
		/**
		 * Gateway to the php files
		 */
		private var gateway:Gateway;
		
		
		/**
		 * Initialize the game
		 */
		override public function create():void
		{
			time = new Time();
			add(time);
			
			//Play music
			if (FlxG.music == null)
				FlxG.playMusic(SndAmbiance7, 0.8);
			
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
			
			var button:NewsLeaksButton = new NewsLeaksButton(80, 80, Glossary.NEWS[Glossary.currentLanguage], 20, 0x000000, "center", goToNews, null, ImgTinyButtonNormal, ImgTinyButtonHighlight, 141, 111, true);
			button.setAnimation([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 18);
			add(button);
			
			button = new NewsLeaksButton(480, 80, Glossary.NEWSPAPER[Glossary.currentLanguage], 20, 0x000000, "center", goToNewspaper, null, ImgLargeButtonNormal, ImgLargeButtonHighlight, 263, 131, true);
			button.setAnimation([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 18);
			add(button);
			
			//Retrieving the list of news
			xmlParser = new XMLParser(Parameters.getNewsListFile());
			xmlParser.loadXML();
		}
		
		/**
		 * Update the game
		 */
		override public function update():void
		{
			super.update();
			
			if (!alreadyLoaded && xmlParser != null && xmlParser.getParsedData() != null && xmlParser.getParsedData().length > 0)
			{
				alreadyLoaded = true;
				NewsList.setNewsList(xmlParser.getParsedData());
				NewsList.getInstance().sort();
			}
			
			//Countdown before the next day
			nextDayCountdownLabel.text = Glossary.DAY_END[Glossary.currentLanguage] + " : " + time.getNextDayCountdownString();
			daysLabel.text = Glossary.DAYS[Glossary.currentLanguage] + " : " + time.getDays();
		}
		
		/**
		 * 
		 */
		public function goToNews():void
		{
			FlxG.play(SndClick);
			FlxG.switchState(new NewsPick());
		}
		
		/**
		 * 
		 */
		public function goToNewspaper():void
		{
			FlxG.play(SndClick);
			FlxG.switchState(new Newspaper())
		}
		
	}

}