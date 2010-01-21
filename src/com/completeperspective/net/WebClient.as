package
{
	import com.completeperspective.events.*;
	import flash.events.EventDispatcher;

	public class WebClient extends EventDispatcher
	{
		public function onMetaData(info:Object):void {
			
			for( var prop : String in info )
			{
				trace( prop + ": " + info[prop] );
			}
			trace("Metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
		}
		
		public function onPlayStatus(info:Object):void {
			
			trace ( "[WebClient]: " + info.code );
			
		}
	}
}