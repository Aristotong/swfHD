package com.completeperspective.events
{
	import flash.events.Event;
	
	public class PlaylistEvent extends Event
	{
		public static const VERSION : String = "1.0.0";
		
		public static const INIT : String = "Playlist.Initialize";
		public static const COMPLETE : String = "Playlist.Complete";
				
		private var _data : Object;
		
		public function PlaylistEvent(type:String, data : Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		public function get data() : Object
		{
			return _data;
		}
		
		override public function clone() : Event
		{
			return new PlaylistEvent( type, _data, bubbles, cancelable );
		}
		
		override public function toString() : String
		{
			return "[PlaylistEvent " + VERSION + " ]: ";
		}
	}
}