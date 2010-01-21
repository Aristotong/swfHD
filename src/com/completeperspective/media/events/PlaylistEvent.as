package com.completeperspective.media.events
{
	import com.completeperspective.media.players.*;
	import com.completeperspective.media.model.*;
	
	import flash.events.*;

	public class PlaylistEvent extends Event
	{
		// Playlist Events
		public static const PLAYLIST_INIT : String = "playlistInit";
		public static const PLAYLIST_READY : String = "playlistReady";
		public static const PLAYLIST_NEXT : String = "playlistNext";
		public static const PLAYLIST_PREVIOUS : String = "playlistPrevious";
		
		//  Code version 
		public static const VERSION : String = "1.0.0";
		
		public var playlist : Playlist;
		
		public function PlaylistEvent(type:String, playlist : Playlist, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.playlist = playlist;
		}
		
		override public function clone():Event
		{
			return new PlaylistEvent( type, playlist, bubbles, cancelable );
		}
		
		override public function toString():String
		{
			return "[PlaylistEvent " + VERSION + " ]";
		}
		
	}
}