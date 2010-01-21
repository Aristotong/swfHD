package com.completeperspective.media
{
	import caurina.transitions.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class Thumbnail extends Sprite
	{
		public static const VERSION : String = "1.0.0";
		
		private var _previewDelay : Number = 1;
		private var _playing : Boolean = false;
		private var _enabled : Boolean = true;
		
		private var _time : Number = 0;
		
		public function Thumbnail()
		{
			init();
		}
		
		private function init() : void
		{
			trace( this + "initializing..." );
			defineEvenHandlers();		
		}
		
		private function defineEvenHandlers() : void
		{
			addEventListener( MouseEvent.ROLL_OVER, onMouseOver );
			addEventListener( MouseEvent.ROLL_OUT, onMouseOut );
		}
		
		private function disable() : void
		{
			removeEventListener( MouseEvent.ROLL_OVER, onMouseOver );
			removeEventListener( MouseEvent.ROLL_OUT, onMouseOut );
		}
		
		private function onMouseHover( e : Event ) : void
		{
			_time++
			
			if( _time >= _previewDelay * 31 && !_playing )
			{
				dispatchEvent( new Event( "playPreview" ) );
				_playing = true;
				showInformation();
				removeEventListener( Event.ENTER_FRAME, onMouseHover );
			}
		}
		
		private function onMouseOver( e : MouseEvent ) : void
		{
			addEventListener( Event.ENTER_FRAME, onMouseHover );
		}
		
		private function onMouseOut( e : MouseEvent ) : void
		{
			removeEventListener( Event.ENTER_FRAME, onMouseHover );
			_time = 0;
			
			hideInformation();
			
			dispatchEvent( new Event( "stopPreview" ) );
			_playing = false;
		}
		
		private function showInformation() : void
		{
			dispatchEvent( new Event( "showInformation" ) );
		}
		
		private function hideInformation() : void
		{
			dispatchEvent( new Event( "hideInformation" ) );
		}
		
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		
		public function set enabled( b : Boolean ) : void
		{
			_enabled = b;
			
			enabled ? defineEvenHandlers() : disable();
		}
			
		
		override public function toString() : String
		{
			return "[Thumbnail " + VERSION + " ]: ";
		}
	}
}