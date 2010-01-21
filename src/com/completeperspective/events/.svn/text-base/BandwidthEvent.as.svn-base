package com.completeperspective.events
{
	import flash.events.*;

	public class BandwidthEvent extends Event
	{
		// Playlist Events
		public static const INIT : String = "thumbnailReceived";
		public static const COMPLETE : String = "bandwidthReceived";
		
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