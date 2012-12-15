package  
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	
	
	/**
	 * Class responsible for handling time
	 * @author Simon Chauvin
	 */
	public class Time extends FlxBasic
	{
		/**
		 * 
		 */
		public static var days:int;
		
		/**
		 * 
		 */
		public static var nextDayCountdown:Number;
		
		/**
		 * 
		 */
		public static var nextDayCountdownString:String;
		
		/**
		 * Gateway to the php files
		 */
		private var gateway:Gateway;
		
		
		/**
		 * 
		 */
		public function Time() 
		{
			gateway = new Gateway(Parameters.urlDomain + "/retrieve_day_info.php ", null);
			gateway.send();
		}
		
		/**
		 * Update time
		 */
		override public function update():void
		{
			super.update();
			
			//Retrieve the time from the server
			if (gateway != null)
			{
				var data:String = gateway.getResult();
				if (data != null)
				{
					days = data.split("day=")[1].split(",")[0];
					nextDayCountdown = data.split("day=")[1].split(",")[1].split("nextupdate=")[1];
					if (days != 0)
						gateway = null;
				}
			}
			
			//Update the countdown before the next day
			//TODO when day ends retrieve new info from server
			nextDayCountdown -= FlxG.elapsed;
			var secondes:Number = nextDayCountdown % 3600;
			nextDayCountdownString = new String((Math.floor(nextDayCountdown / 3600)).toString() + ":" + (Math.floor(secondes / 60)).toString() + ":" + (Math.floor(secondes % 60)));
		}
		
		/**
		 * 
		 * @return
		 */
		public function getDays():int
		{
			return days;
		}
		
		/**
		 * 
		 * @return
		 */
		public function getNextDayCountdownString():String
		{
			return nextDayCountdownString;
		}
		
	}

}