package  
{
	/**
	 * Class representing the object valuation to be sent to the database
	 * @author Simon Chauvin
	 */
	public class Valuation 
	{
		/**
		 * 
		 */
		public var newsId:int;
		
		/**
		 * 
		 */
		private var value:int;
		
		/**
		 * 
		 */
		private var operation:String;
		
		/**
		 * 
		 */
		private var playerId:int;
		
		/**
		 * 
		 */
		private var alreadySent:Boolean;
		
		/**
		 * Whether the valuation is the same on the server or not
		 */
		private var inSync:Boolean;
		
		/**
		 * 
		 */
		public function Valuation(newsId:int, value:int, operation:String, playerId:int, inSync:Boolean) 
		{
			this.newsId = newsId;
			this.value = value;
			this.operation = operation;
			this.playerId = playerId;
			this.inSync = inSync;
		}
		
		/**
		 * 
		 */
		public function getNewsId():int
		{
			return newsId;
		}
		
		/**
		 * 
		 */
		public function getValue():int
		{
			return value;
		}
		
		/**
		 * 
		 */
		public function setValue(value:int):void
		{
			this.value = value;
		}
		
		/**
		 * 
		 */
		public function getOperation():String
		{
			return operation;
		}
		
		/**
		 * 
		 * @param	operation
		 */
		public function setOperation(operation:String):void
		{
			this.operation = operation;
		}
		
		/**
		 * 
		 */
		public function getPlayerId():int
		{
			return playerId;
		}
		
		/**
		 * 
		 */
		public function isInSync():Boolean
		{
			return inSync;
		}
		
		/**
		 * 
		 */
		public function setInSync(inSync:Boolean):void
		{
			this.inSync = inSync;
		}
		
	}

}