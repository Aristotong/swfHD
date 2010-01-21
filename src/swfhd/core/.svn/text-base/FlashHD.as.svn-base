package swfhd.core
{
	import com.completeperspective.events.PlaylistEvent;
	
	import swfhd.model.SwfHDModelLocator;
	import swfhd.view.FlashHDView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class FlashHD extends Sprite
	{
		public static const VERSION : String = "1.0.0";
		
		private var _model : SwfHDModelLocator = SwfHDModelLocator.getInstance();
		private var _view : FlashHDView = FlashHDView.getInstance();
			
		public function FlashHD()
		{
			init();
		}
		
		private function init() : void
		{
			trace( this + " initializing..." );
			addChild( _view );
			
			_model.addEventListener( PlaylistEvent.COMPLETE, onPlaylistLoaded );
			_model.addEventListener( PlaylistEvent.INIT, onPlaylistInit );
			_model.loadPlaylist( "http://media.completeperspective.com/playlist/Precip_Channel.xml" );
		}
		
		private function onPlaylistInit( e : PlaylistEvent ) : void
		{
			trace( this + " caught " + e.type );
		}
		
		private function onPlaylistLoaded( e : PlaylistEvent ) : void
		{
			trace( this + " loading view..." );
			
			_view.addEventListener( Event.COMPLETE, onViewReady );
			_view.loadAssets( "http://media.completeperspective.com/skins/swfHD_Default_Skins.swf" );
			
		}
		
		private function onViewReady( e : Event ) : void
		{
			trace( this + "showing playlist view" );
			_view.removeEventListener( Event.COMPLETE, onViewReady );
			_view.showPlaylist( _model.playlist );
						
		}
		
		override public function toString() : String
		{
			return "[FlashHD Player " + VERSION + "]: "; 
		}
	}
}