package
{
	import com.completeperspective.events.*;
	import flash.events.EventDispatcher;

	public class FMSClient extends EventDispatcher
	{
		 public function onBWCheck(... rest):Number {
				return 0;
		 }
			
		 public function onBWDone(... rest):void {
				var p_bw:Number;
				if (rest.length > 0) p_bw = rest[0];
				// do something here
				// when the bandwidth check is complete
				trace("bandwidth = " + p_bw + " Kbps.");
				dispatchEvent( new BandwidthEvent( BandwidthEvent.COMPLETE, p_bw ) );

		}
	   
		public function onMetaData(info:Object):void {
			
			for( var prop : String in info )
			{
				trace( prop + ": " + info[prop] );
			}
			trace("Metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
		}
		
		public function onPlayStatus(info:Object):void {
			switch (info.code) {
				case "NetStream.Play.Complete":
					trace("The stream has completed");
					break;
			}
		}
	}
}