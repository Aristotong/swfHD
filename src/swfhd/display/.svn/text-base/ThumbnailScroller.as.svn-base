package swfhd.display
{
	import caurina.transitions.*;
	
	import com.completeperspective.display.*;
	import com.completeperspective.media.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	
	public class ThumbnailScroller extends Sprite
	{
		public static const VERSION : String = "1.0.0";
		
		private var _playlist : Playlist;
		
		private var _container : Sprite;
		private var _forwardButton : Sprite;
		private var _backButton : Sprite;
		
		private var _lastX : Number = 256;
		private var _index : Number = 0;
		
		public function ThumbnailScroller()
		{
			init();
		}
		
		private function init() : void
		{
			trace( this + "initializing..." );
			
			_forwardButton = getChildByName( "forward_mc" ) as Sprite;
			_backButton = getChildByName( "back_mc" ) as Sprite;
			
			defineEventHandlers();
		}
		
		private function defineEventHandlers() : void
		{
			addEventListener( MouseEvent.ROLL_OVER, onMouseOver )
			
			_forwardButton.addEventListener( MouseEvent.ROLL_OVER, onRollOverButton );
			_forwardButton.addEventListener( MouseEvent.ROLL_OUT, onRollOutButton );
			_forwardButton.addEventListener( MouseEvent.MOUSE_UP, onForwardButtonUp );
			_forwardButton.addEventListener( MouseEvent.MOUSE_DOWN, onForwardButtonDown );
			
			_backButton.addEventListener( MouseEvent.ROLL_OVER, onRollOverButton );
			_backButton.addEventListener( MouseEvent.ROLL_OUT, onRollOutButton );
			_backButton.addEventListener( MouseEvent.MOUSE_UP, onBackButtonUp );
			_backButton.addEventListener( MouseEvent.MOUSE_DOWN, onBackButtonDown );
		}
		
		private function onMouseOver( e : MouseEvent ) : void
		{
			//trace( e.localX );
			//_container.x = e.localX;
			
		}
		
		private function onRollOverButton( e : MouseEvent ) : void
		{
			Tweener.addTween( e.currentTarget, {alpha: .9, time: .75} );
		}
		
		private function onRollOutButton( e  : MouseEvent ) : void
		{
			Tweener.addTween( e.currentTarget, {alpha: .5, time: .75} );
		}
		
		private function onForwardButtonDown( e  : MouseEvent = null ) : void
		{
			addEventListener( Event.ENTER_FRAME, scrollForward );
		}
		
		private function onForwardButtonUp( e  : MouseEvent = null ) : void
		{
			removeEventListener( Event.ENTER_FRAME, scrollForward );
		}
		
		private function onBackButtonDown( e  : MouseEvent = null ) : void
		{
			addEventListener( Event.ENTER_FRAME, scrollBackward );
		}
		
		private function onBackButtonUp( e  : MouseEvent = null ) : void
		{
			removeEventListener( Event.ENTER_FRAME, scrollBackward );
		}
		
		private function scrollForward( e : Event ) : void
		{
			Tweener.addTween( _container, {x: _container.x - 256, time: 2.75} );
		}
		
		private function scrollBackward( e  : Event ) : void
		{
			Tweener.addTween( _container, {x: _container.x + 256, time: 2.75} );
		}
		
		private function onThumbnailLoaded( e : Event ) : void
		{
			var thumbnail : VideoThumbnail = new VideoThumbnail();
    		thumbnail.thumb = e.currentTarget as MovieClip;
    		thumbnail.alpha = 1;
    		thumbnail.x = ( e.currentTarget.width + 5 ) * index;
    		thumbnail.y = 0;
    		thumbnail.source = _playlist.items[_index].url;
    		thumbnail.addEventListener( "showInformation", onShowInformation );
    		thumbnail.addEventListener( "hideInformation", onHideInformation );
    		    		
    		var shadow : DropShadowFilter = new DropShadowFilter( 3, 90, 0x363636, .5 );
    		
    		thumbnail.filters = [ shadow ];
    		
    		_container.addChild( thumbnail );
			
			var reflection : Reflection = new Reflection( {mc:e.currentTarget, alpha:25, ratio:100, distance:0, updateTime:-1, reflectionDropoff:1} );
    		
			if( _index == _playlist.length-1 )
			{
				showThumbnails();
			} else {
				_index++
			}
    		
		}
		
		private function onShowInformation( e : Event ) : void
		{
			trace( "Show Movie Information!!!" );
		}
		
		private function onHideInformation( e : Event ) : void
		{
			trace( "Hide Information" );
		}
		
		private function showThumbnails() : void
		{
			_index = 0;
			
			Tweener.addTween( _container, {alpha: 1, time: .7, transition: "easeIn"} );
			Tweener.addTween( _container, {x: stage.stageWidth/2-256/2, time: 2, transition: "easeIn"} );
		}
		
		public function set playlist( playlist : Playlist ) : void
		{
			_playlist = playlist;
			
			_container = new Sprite()
			_container.alpha = 0;
			_container.x = stage.stageWidth;
						
			addChildAt( _container, 0 );
			
			for( var i : int = 0; i < playlist.length; i++ ) {
					var asset : AssetLoader = new AssetLoader( playlist.items[i].thumbnail );
					asset.addEventListener( Event.COMPLETE, onThumbnailLoaded );	
				
			}
				
		}
		
		public function get index() : Number
		{
			return _index;
		}
		
		
		override public function toString() : String
		{
			return "[ThumbnailScroller " + VERSION + " ]: ";
		}
	}
}