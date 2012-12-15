package  
{
	import flash.events.MouseEvent;
	import flash.net.NetStreamInfo;
	import org.flixel.FlxButton;
	import org.flixel.FlxCamera;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	
	/**
	 * Class that represents a typical NewsLeaks button
	 * @author Simon Chauvin
	 */
	public class NewsLeaksButton extends FlxButton
	{
		/**
		 * Buttons images
		 */
		private var normalImg:Class;
		private var highlightImg:Class;
		
		/**
		 * Animation frames and framerate
		 */
		private var framesAnimation:Array;
		private var frameRateAnimation:int;
		
		/**
		 * Parameters of the onClick methods
		 */
		private var params:Array;
		
		/**
		 * Whether this is an animated highlight button or not
		 */
		private var animated:Boolean;
		
		
		/**
		 * Constructor of button
		 * @param	x
		 * @param	y
		 * @param	label
		 * @param	onClick
		 * @param	params
		 * @param	normalImg
		 * @param	highlightImg
		 * @param	width
		 * @param	height
		 * @param	animated
		 */
		public function NewsLeaksButton(x:Number = 0, y:Number = 0, label:String = null, size:int = 16, color:uint = 0x000000, alignment:String = null, onClick:Function = null, params:Array = null, normalImg:Class = null, highlightImg:Class = null, width:int = 0, height:int = 0, animated:Boolean = false)
		{
			super(x, y, label, onClick, onOver, onOut);
			loadGraphic(normalImg, false, false, width, height);
			this.params = params;
			this.normalImg = normalImg;
			this.highlightImg = highlightImg;
			this.animated = animated;
			this.label = new FlxText(x, y, width, label);
			this.label.setFormat("Arial", size, color, alignment);
		}
		
		/**
		 * Check before the update of the button
		 */
		override public function preUpdate():void
		{
			if(!_initialized)
			{
				if(FlxG.stage != null)
				{
					FlxG.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpNewsLeaks);
					_initialized = true;
				}
			}
			
			super.preUpdate();
		}
		
		/**
		 * Update the button
		 */
		override public function update():void
		{
			super.update();
		}
		
		/**
		 * Basic button update logic
		 */
		override protected function updateButton():void
		{
			//Figure out if the button is highlighted or pressed or what
			// (ignore checkbox behavior for now).
			if(FlxG.mouse.visible)
			{
				if(cameras == null)
					cameras = FlxG.cameras;
				var camera:FlxCamera;
				var i:uint = 0;
				var l:uint = cameras.length;
				var offAll:Boolean = true;
				while(i < l)
				{
					camera = cameras[i++] as FlxCamera;
					FlxG.mouse.getWorldPosition(camera,_point);
					if(overlapsPoint(_point,true,camera))
					{
						offAll = false;
						if(FlxG.mouse.justPressed())
							status = PRESSED;
						if(status == NORMAL)
						{
							status = HIGHLIGHT;
							if(_onOver != null)
								_onOver();
						}
					}
				}
				if(offAll)
				{
					if((status != NORMAL) && (_onOut != null))
						_onOut();
					status = NORMAL;
				}
			}
		
			//Then if the label and/or the label offset exist,
			// position them to match the button.
			if(label != null)
			{
				label.x = x;
				label.y = y;
			}
			if(labelOffset != null)
			{
				label.x += labelOffset.x;
				label.y += labelOffset.y;
			}
			
			if (!animated)
			{
				//Then pick the appropriate frame of animation
				if((status == HIGHLIGHT) && _onToggle)
					frame = NORMAL;
				else
					frame = status;
			}
		}
		
		/**
		 * Define the format of the label's button
		 * @param	font
		 * @param	size
		 * @param	color
		 * @param	alignment
		 * @param	shadowColor
		 */
		public function setLabelFormat(font:String=null, size:int=8, color:uint=0xffffff, alignment:String=null, shadowColor:uint=0):void
		{
			label.setFormat(font, size, color, alignment, shadowColor);
		}
		
		/**
		 * Set the animation frames and framerate
		 * @param	frames
		 * @param	frameRate
		 */
		public function setAnimation(frames:Array, frameRate:int):void
		{
			this.framesAnimation = frames;
			this.frameRateAnimation = frameRate;
		}
		
		/**
		 * When the button has been clicked
		 * @param	event
		 */
		public function onMouseUpNewsLeaks(event:MouseEvent):void
		{
			if (exists && visible && active && (status == PRESSED) && (_onClick != null))
				_onClick.apply(null, params);
		}
		
		/**
		 * When the mouse is over the button
		 */
		public function onOver():void
		{
			if (highlightImg != null)
				loadGraphic(highlightImg, animated, true, width, height);
			if (animated)
			{
				addAnimation("highlight", framesAnimation, frameRateAnimation, false);
				play("highlight");
			}
			label.color = 0xffffff;
		}
		
		/**
		 * When the mouse is not on the button
		 */
		public function onOut():void
		{
			if (normalImg != null)
				loadGraphic(normalImg, animated, false, width, height);
			label.color = 0x000000;
		}
		
	}

}