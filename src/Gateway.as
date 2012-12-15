package  
{
	import org.flixel.FlxG;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLVariables;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	
	/**
	 * Class used to access php files and retrieve or send data
	 * @author Simon Chauvin
	 */
	public class Gateway 
	{
		/**
		 * Url of the php file
		 */
		private var url:String;
		
		/**
		 * Variables to send
		 */
		private var variables:URLVariables
		
		/**
		 * Data retrieved from the php file
		 */
		private var result:String;
		
		/**
		 * 
		 * @param	url
		 * @param	variables
		 */
		public function Gateway(url:String, variables:URLVariables) 
		{
			this.url = url;
			this.variables = variables;
			result = null;
		}
		
		/**
		 * Send data
		 */
		public function send():void
		{
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;
			request.data = variables;
			
			var loader:URLLoader = new URLLoader(request);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			loader.load(request);
		}
		
		/**
		 * When the request has been completed
		 * @param	event
		 */
		public function onComplete(event:Event):void
		{
			result = event.target.data;
		}
		
		/**
		 * In case of error
		 * @param	e
		 */
		private function onIOError(e:IOErrorEvent):void
		{
			FlxG.log("IOError : " + e.text);
		}

		/**
		 * When a security error is detected
		 * @param	e
		 */
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			FlxG.log("SecurityError : " + e.text);
		}
		
		/**
		 * Retrieve the data resulting from the call to the php file
		 * @return
		 */
		public function getResult():String
		{
			return result;
		}
	}

}