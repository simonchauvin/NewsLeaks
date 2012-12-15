package  
{
	/**
	 * Class representing a news
	 * @author Simon Chauvin
	 */
	public class News
	{
		/**
		 * Used to identify a news precisely
		 */
		public var id:int;
		private var title:String;
		private var description:String;
		private var link:String;
		
		/**
		 * Addition of all the points earned by this news
		 * This attribute is public in order to allow the sorting
		 */
		public var value:int;
		
		/**
		 * 
		 * @param	title
		 * @param	description
		 * @param	link
		 */
		public function News(id:int, title:String, description:String, link:String, value:int) 
		{
			this.id = id;
			this.title = title;
			this.description = description;
			this.link = link;
			this.value = value;
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
		public function getTitle():String
		{
			return title;
		}
		
		/**
		 * 
		 * @return
		 */
		public function getDescription():String
		{
			return description;
		}
		
		/**
		 * 
		 * @return
		 */
		public function getLink():String
		{
			return link;
		}
		
		/**
		 * Get the current value of the news
		 * @return
		 */
		public function getValue():int
		{
			return value;
		}
		
	}

}