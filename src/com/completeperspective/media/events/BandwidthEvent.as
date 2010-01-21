package com.completeperspective.media.events
{
	import com.completeperspective.media.players.*;
	import com.completeperspective.media.model.*;
	
	import flash.events.*;

	public class BandwidthEvent extends Event
	{
		// Playlist Events
		public static const THUMBNAIL_RECEIVED : String = "thumbnailReceived";
		public static const BANDWIDTH_RECEIVED : String = "bandwidthReceived";
		
		//  Code version 
		public static const VERSION : String = "1.0.0";
		
		public var data : Object;
		
		public function BandwidthEvent(type:String, thumb : Object = null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			data = thumb;
		}
		
		override public function clone():Event
		{
			return new BandwidthEvent( type, data, bubbles, cancelable );
		}
		
		override public function toString():String
		{
			return "[BandwidthEvent " + VERSION + " ]";
		}
		
	}
}