package com.completeperspective.media.events
{
	import com.completeperspective.media.players.*;
	import com.completeperspective.media.model.*;
	
	import flash.events.*;

	public class MetadataEvent extends Event
	{
		// Playlist Events
		public static const METADATA_RECEIVED : String = "metadataReceived";
		
		//  Code version 
		public static const VERSION : String = "1.0.0";
		
		public var data : Object;
		
		public function MetadataEvent(type:String, metadata : Object, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			data = metadata;
		}
		
		override public function clone():Event
		{
			return new MetadataEvent( type, data, bubbles, cancelable );
		}
		
		override public function toString():String
		{
			return "[MetadataEvent " + VERSION + " ]";
		}
		
	}
}