package swfhd.model
{
	import com.completeperspective.media.Playlist;
	import com.completeperspective.media.IPlaylist;
	import com.completeperspective.events.PlaylistEvent;
	
	import flash.events.*;
	import flash.net.*;

	/**
	 * Holds a reference to all models in the media player application
	 * 
	 * @author Adam Colpitts
	 * @version 1.0
	 * @created 02-Aug-2008 16:28:14
	 */
	public class SwfHDModelLocator extends EventDispatcher
	{
		private var _playlist : Playlist;
		
		// Singleton instance
		static private var _instance : SwfHDModelLocator;
		
	    /**
		 * Components use ModelLocator.getInstance() to obtain a reference to this Singelton
		 * 
		 * @return ModelLocator
		 */
		public static function getInstance() : SwfHDModelLocator
		{
			if( SwfHDModelLocator._instance == null ) {
				SwfHDModelLocator._instance = new SwfHDModelLocator( new SingletonEnforcer() );
			}
			return SwfHDModelLocator._instance;
		}
		
		public function SwfHDModelLocator( enforcer : SingletonEnforcer )
		{
			init();
		}
		
		private function init() : void
		{
			_playlist = new Playlist();
			_playlist.addEventListener( PlaylistEvent.COMPLETE, onPlaylistLoaded );
		}
		
		/**
		 * Loads the smartphone RSS Template
		 */
		public function loadPlaylist( url : String ) : void
		{
			_playlist.load( new URLRequest( url ) );
			dispatchEvent( new PlaylistEvent( PlaylistEvent.INIT, _playlist ) );		
		}
		
		private function onPlaylistLoaded( e : PlaylistEvent ) : void
		{
			_playlist = e.data as Playlist;
			
			dispatchEvent( new PlaylistEvent( PlaylistEvent.COMPLETE, _playlist ) );
		}
		
		/**
		 * Returns a reference to the smartphone information that is loaded in the system.
		 *
		 * @return SmartphoneModel
		 */
		public function get playlist() : Playlist
		{
			return _playlist;
		}

	}//end PlayerController

}


class SingletonEnforcer{}