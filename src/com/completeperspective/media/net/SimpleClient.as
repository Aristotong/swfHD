package com.completeperspective.media.net
{
	import com.completeperspective.media.events.*;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class SimpleClient extends EventDispatcher
	{
		public function SimpleClient()
		{
		}
		
		public function onMetaData( data : Object ) : void
		{
			trace( "Video Duration: " + data.duration );
			
			dispatchEvent( new MetadataEvent( MetadataEvent.METADATA_RECEIVED, data ) );
		}
		
	}
}