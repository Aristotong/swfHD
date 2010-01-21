package com.completeperspective.media.events
{
	import com.completeperspective.media.players.*;
	
	import flash.display.*;
	import flash.events.*;

	public class MediaPlayerEvent extends Event
	{
		//  Code version 
		public static const VERSION : String = "1.0.0";
		
		public static const BUFFERING : String = "buffering";
		public static const BUFFERED : String = "buffered";
		
		public static const PLAYING : String  = "playing";
		public static const PAUSED : String = "paused";
		public static const FINISHED : String = "finished";
		
		public static const SHOW_PLAYLIST_VIEW : String = "showPlaylistView";
		
		public var data : Object
		
		public function MediaPlayerEvent(type:String, p_data : Object = null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			data = p_data;
		}
		
		override public function clone():Event
		{
			return new MediaPlayerEvent( type, data, bubbles, cancelable );
		}
		
		override public function toString():String
		{
			return "[MediaPlayerEvent " + VERSION + " ]";
		}
		
	}
}