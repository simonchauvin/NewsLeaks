package  
{
	import org.flixel.FlxU;
	
	
	/**
	 * Class for handling links
	 * @author Simon Chauvin
	 */
	public class NewsLeaksLink extends NewsLeaksButton 
	{
		//Empty image
		[Embed(source = '../assets/buttons/link_button.png')] protected var ImgLinkButton:Class;
		
		/**
		 * Link URL
		 */
		private var link:String;
		
		/**
		 * 
		 * @param	x
		 * @param	y
		 * @param	link
		 * @param	width
		 * @param	height
		 */
		public function NewsLeaksLink(x:int, y:int, link:String, width:int, height:int) 
		{
			this.link = link;
			super(x, y, link, 16, 0x000000, "center", goToLink, null, ImgLinkButton, null, width, height);
		}
		
		/**
		 * Function that redirect to the target designated by the link
		 */
		public function goToLink():void
		{
			FlxU.openURL(link);
		}
		
		/**
		 * When the mouse is over the button
		 */
		override public function onOver():void
		{
			label.color = 0xffffff;
		}
		
		/**
		 * When the mouse is not over the button
		 */
		override public function onOut():void
		{
			label.color = 0xffffff;
		}
		
	}

}