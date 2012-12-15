package  
{
	import flash.xml.XMLNode;
	import flash.xml.XMLTag;
	import org.flixel.FlxG;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	
	/**
	 * Class used to load and parse the xml file containing the news
	 * @author Simon Chauvin
	 */
	public class XMLParser 
	{
		/**
		 * Loader of xml
		 */
		private var loader:URLLoader;
		
		/**
		 * Url of the xml file to load and parse
		 */
		private var xmlUrl:String;
		
		/**
		 * Data of the xml file in an array
		 */
		private var newsArray:Array;
		
		/**
		 * 
		 */
		public function XMLParser(xmlUrl:String) 
		{
			this.xmlUrl = xmlUrl;
		}
		
		/**
		 * Called when user presses the button to load feed
		 * @param	xmlUrl
		 */
		public function loadXML():void
		{
			loader = new URLLoader();
			
			//request pointing to feed
			var request:URLRequest = new URLRequest(xmlUrl);
			request.method = URLRequestMethod.POST;
			
			//listen for when the data loads
			loader.addEventListener(Event.COMPLETE, onDataLoad);
			
			//listen for error events
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			//load the feed data
			loader.load(request);
		}

		/**
		 * Called once the data has loaded from the feed
		 * @param	e
		 */
		private function onDataLoad(e:Event):void
		{
			//Parse the raw string data from the feed
			parse(new XML(URLLoader(e.target).data));
		}
		
		/**
		 * Parse the raw data into the data array
		 * @return
		 */
		public function parse(data:XML):void
		{
			newsArray = new Array();
			var parentList:XMLList = data.children();
			var length:int = parentList.length();
			for (var i:int = 0; i < length; i++)
			{
				var childList:XMLList = parentList[i].children();
				newsArray.push(new News(childList[0].text(), childList[1].text(), childList[2].text(), childList[3].text(), childList[4].text()));
			}
		}
		
		/**
		 * 
		 * @param	data
		 */
		private function writeOutput(data:String):void
		{
			FlxG.log(data + "\n");
		}

		/**
		 * 
		 * @param	e
		 */
		private function onIOError(e:IOErrorEvent):void
		{
			writeOutput("IOError : " + e.text);
		}

		/**
		 * 
		 * @param	e
		 */
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			writeOutput("SecurityError : " + e.text);
		}
		
		/**
		 * Get the parsed data of the xml file
		 * @return
		 */
		public function getParsedData():Array
		{
			return newsArray;
		}
		
	}

}