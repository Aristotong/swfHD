package com.completeperspective.media
{
	import com.completeperspective.events.PlaylistEvent;
	import com.completeperspective.xml.RSSLoader;
	
	public class Playlist extends RSSLoader implements IPlaylist
	{
		public static const VERSION : String = "1.0.0";
		
		private var _items : Array;	
		private var _length : Number;
		
		public function Playlist()
		{
			_items = new Array();
			init()
		}
		
		private function init() : void
		{
			trace( this + "initializing..." );
		}
		
		/**
		 * Parses MRSS Playlist.
		 */
		public override function parseFeed( rss : XML ) : void
		{
			super.parseFeed( rss );
			
			var media : Namespace = new Namespace( "http://search.yahoo.com/mrss/" );
			var swfhd : Namespace = new Namespace( "http://media.completeperspective.com/players/swfhd" );
						
			var item_elements : XMLList = rss.channel.item;
			
			// iterate through item elements, and build PlaylistItem objects
			for( var i : int = 0; i < item_elements.length(); i++ ) {
				
				var pli : PlaylistItem = new PlaylistItem();
				
				pli.bitrate = Number( item_elements[i].media::content.@bitrate );
				pli.channels = Number( item_elements[i].media::content.@channels );
				pli.description = String( item_elements[i].description );
				pli.duration = Number( item_elements[i].media::content.@duration );
				pli.expression = String( item_elements[i].media::content.@expression );
				pli.fileSize = Number( item_elements[i].media::content.@fileSize );
				pli.framerate = Number( item_elements[i].media::content.@framerate );
				pli.height = Number( item_elements[i].media::content.@height );
				pli.isDefault = Boolean( item_elements[i].media::content.@isDefault );
				pli.lang = String( item_elements[i].media::content.@lang );
				pli.link = String( item_elements[i].link );
				pli.medium = String( item_elements[i].media::content.@medium );
				pli.samplingrate = Number( item_elements[i].media::content.@samplingrate );
				pli.title = String( item_elements[i].title );
				pli.thumbnail = String( item_elements[i].media::thumbnail.@url );
				pli.type = String( item_elements[i].media::content.@type );
				pli.url = String( item_elements[i].media::content.@url );
				pli.width = Number( item_elements[i].media::content.@width );
								
				trace( this + "adding " + pli.title );
				
				// add the PlaylistItem to the _items array
				_items.push( pli );
				
			}
			
			
			dispatchEvent( new PlaylistEvent( PlaylistEvent.COMPLETE, this ) );
		
		}
		
		public function get length() : Number 
		{
			return _items.length;
		}
		
		public function get items() : Array
		{
			return _items;
		}
		
		override public function toString() : String
		{
			return "[Playlist " + VERSION + " ]: ";
		}
	}
}