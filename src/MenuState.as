package  
{
	import flash.display.Sprite;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.net.URLVariables;
	import org.flixel.system.FlxPreloader;
	
	/**
	 * Main menu of the game
	 * @author Simon Chauvin
	 */
	public class MenuState extends FlxState
	{
		/**
		 * Fonts
		 */
		[Embed(source = "../assets/fonts/arial.ttf", fontFamily = "arial", embedAsCFF = "false")] public var FontArial:String;
		
		/**
		 * Intro spritesheet
		 */
		[Embed(source = '../assets/menus/intro.png')] protected var ImgIntro:Class;
		
		/**
		 * Title
		 */
		[Embed(source = '../assets/menus/title.png')] protected var ImgTitle:Class;
		
		/**
		 * Background
		 */
		[Embed(source = '../assets/backgrounds/background.png')] protected var ImgBackground:Class;
		
		/**
		 * Sounds
		 */
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'BUSH_01')] public var SndBush1:Class;
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'BUSH_02')] public var SndBush2:Class;
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'CHE_GUEVARA_01')] public var SndChe1:Class;
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'DE_GAULLE_01')] public var SndGaulle1:Class;
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'DE_GAULLE_02')] public var SndGaulle2:Class;
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'HITLER_01')] public var SndHitler1:Class;
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'JACKSON_01')] public var SndJackson1:Class;
		[Embed(source = '../assets/sfx/sfx.swf', symbol = 'KING_01')] public var SndKing1:Class;
		
		/**
		 * Title to display when the animation is finished
		 */
		private var title:FlxSprite;
		
		/**
		 * Title animation 
		 */
		private var intro:FlxSprite;
		
		/**
		 * Sub title
		 */
		private var text:FlxText;
		
		/**
		 * Gateway to the php files
		 */
		private var gatewayLogin:Gateway;
		private var gatewayValuations:Gateway;
		private var gatewayScore:Gateway;
		
		/**
		 * Sound emitted at the entry in the game
		 */
		private var welcomeSound:FlxSound;
		
		/**
		 * Create the menu
		 */
		override public function create():void
		{
			//Display background
			var background:FlxSprite = new FlxSprite(0, 0, ImgBackground);
			add(background);
			
			//Display title anim and welcome text
			title = new FlxSprite(FlxG.width / 2 - 206, FlxG.height / 2 - 200, ImgTitle);
			add(title);
			title.visible = false;
			intro = new FlxSprite(FlxG.width / 2 - 206, FlxG.height / 2 - 200);
			intro.loadGraphic(ImgIntro, true, false, 413, 297);
			intro.addAnimation("default", [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 21, 21, 21, 22, 22, 23, 23, 24, 24, 25, 25, 26, 26, 27, 28], 20, false);
			add(intro);
			text = new FlxText(0, (FlxG.height / 2) + 150, FlxG.width, Glossary.WELCOME[Glossary.currentLanguage]);
			text.setFormat("Arial", 16, 0x000000, "center");
			text.alignment = "center";
			add(text);
			
			//Play intro anim
			intro.play("default");
			
			var temp:Number = Math.random()
			if (temp >= 0 && temp < 0.125)
				welcomeSound = FlxG.play(SndBush1);
			else if (temp >= 0.125 && temp < 0.25)
				welcomeSound = FlxG.play(SndBush1);
			else if (temp >= 0.25 && temp < 0.375)
				welcomeSound = FlxG.play(SndChe1);
			else if (temp >= 0.375 && temp < 0.5)
				welcomeSound = FlxG.play(SndGaulle1);
			else if (temp >= 0.5 && temp < 0.625)
				welcomeSound = FlxG.play(SndGaulle2);
			else if (temp >= 0.625 && temp < 0.75)
				welcomeSound = FlxG.play(SndHitler1);
			else if (temp >= 0.75 && temp < 0.875)
				welcomeSound = FlxG.play(SndJackson1);
			else if (temp >= 0.875)
				welcomeSound = FlxG.play(SndKing1);
			
			FlxG.mouse.show();
			
			//TODO add english and qwerty controls and language and change rss according to the language
		}
		
		/**
		 * Update the menu
		 */
		override public function update():void
		{
			super.update();
			
			if (intro.finished)
				title.visible = true;
				
			if (FlxG.keys.justPressed("ENTER") || FlxG.mouse.pressed())
			{
				welcomeSound.fadeOut(5);
				
				//TODO uncomment for the version on the server
				gatewayLogin = new Gateway(Parameters.urlDomain + "/is_connected.php", null);
				gatewayLogin.send();
				
				//TODO remove for the version on the server
				//Parameters.player = new Player(2, "offline", 0, 0);
				
				text.text = Glossary.LOADING[Glossary.currentLanguage] + "...";
			}
			
			var data:String;
			var variables:URLVariables;
			if (gatewayLogin != null)
			{
				data = gatewayLogin.getResult();
				if (data != null)
				{
					var id:int = data.split("id=")[1].split(";")[0];
					if (id != 0)
					{
						var login:String = data.split("login=")[1].split(";")[0];
						var lang:int = data.split("lang=")[1];
						Parameters.player = new Player(id, login, lang, 0);
						
						//TODO uncomment for the version on the server
						variables = new URLVariables();
						variables.player = id.toString();
						gatewayValuations = new Gateway(Parameters.urlDomain + "/get_valuations.php ", variables);
						gatewayValuations.send();
					}
					gatewayLogin = null;
				}
				//TODO comment for the version on the server
				/*variables = new URLVariables();
				variables.player = Parameters.player.getId().toString();
				gatewayValuations = new Gateway(Parameters.urlDomain + "/get_valuations.php ", variables);
				gatewayValuations.send();*/
			}
			
			//Retrieve the valuations of the player
			if (gatewayValuations != null)
			{
				data = gatewayValuations.getResult();
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
					gatewayValuations = null;
					
					variables = new URLVariables();
					variables.player = Parameters.player.getId().toString();
					gatewayScore = new Gateway(Parameters.urlDomain + "/get_score.php ", variables);
					gatewayScore.send();
				}
			}
			
			//Retrieve score
			if (gatewayScore != null)
			{
				data = gatewayScore.getResult();
				if (data != null)
				{
					var score:int = data.split("score:")[1];
					if (score != 0)
					{
						Parameters.player.setScore(score);
					}
					gatewayScore = null;
					
					FlxG.switchState(new PlayState());
				}
			}
		}
	}
}