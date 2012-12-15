package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	
	
	/**
	 * State of the game when the player is let free in the world
	 * @author Simon Chauvin
	 */
	public class FreeRoaming extends PlayState
	{
		/**
		 * Player's avatar spritesheet
		 */
		[Embed(source = '../assets/player/avatar.png')] protected var ImgAvatar:Class;
		
		/**
		 * Player's avatar
		 */
		private var avatar:FlxSprite
		
		/**
		 * 
		 */
		override public function create():void
		{
			super.create();
			
			avatar = new FlxSprite(150, 150);
			avatar.loadGraphic(ImgAvatar, true, false, 32, 32);
			avatar.addAnimation("idle", [2]);
			avatar.addAnimation("walk", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 20, true);
			add(avatar);
		}
		
		/**
		 * 
		 */
		override public function update():void 
		{
			super.update();
			
			if (FlxG.keys.UP)
			{
				avatar.play("walk");
				avatar.y = avatar.y - (50 * FlxG.elapsed);
			}
			else if (FlxG.keys.DOWN)
			{
				avatar.play("walk");
				avatar.y = avatar.y + (50 * FlxG.elapsed);
			}
			else if (FlxG.keys.LEFT)
			{
				avatar.play("walk");
				avatar.x = avatar.x - (50 * FlxG.elapsed);
			}
			else if (FlxG.keys.RIGHT)
			{
				avatar.play("walk");
				avatar.x = avatar.x + (50 * FlxG.elapsed);
			}
			else
			{
				avatar.play("idle");
			}
			
		}
		
	}

}