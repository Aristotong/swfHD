package com.completeperspective.media
{
	import com.completeperspective.display.*;
	
	import caurina.transitions.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	import flash.ui.*;
	
	public class VideoThumbnail extends Thumbnail
	{
		public static const VERSION : String = "1.0.0";
		
		private var _source : String;
		
		private var _nc : NetConnection;
		private var _ns : NetStream;
		
		private var _thumbBuffer = 10;
		
		private var _movie : Sprite;
		private var _video : Video;
		private var _thumb : MovieClip;
		
		private var _videoReflection : Reflection;
		
		public function VideoThumbnail()
		{
			draw();
		}
		
		private function draw() : void
		{
			_movie = new MovieClip();
			_movie.name = "movie_mc";
			_movie.graphics.beginFill( 0x000000, 1 );
			_movie.graphics.drawRect(0,0,256,144);
			_movie.graphics.endFill();
			
			_movie.alpha = 0;
			
			addChild( _movie );
			
			
		}
		
		private function defineEventHandlers() : void
		{
			trace( this + "defining event handlers..." );
			addEventListener( "playPreview", onPlayPreview );
			addEventListener( "stopPreview", onStopPreview );
		}
				
		private function onPlayPreview( e : Event ) : void
		{
			trace( this + "play preview..." );
			createPreview();
		}
		
		private function onStopPreview( e : Event ) : void
		{
			trace( this + "stop preview!" );
			Mouse.show();
			
			try
			{
				Tweener.addTween( _movie, {alpha:0, time:3} );
				Tweener.addTween( _thumb, {alpha:1, time:3, transition: "easeOut", onComplete: clearPreview} );
			} catch (e : Error)
			{
				trace( this + e.message );
			}
			
		}
		
		public function set source( url : String ) : void
		{
			
			var type : String = url.substr( url.lastIndexOf(".")+1, 3 );
			
			switch( type )
			{
				case "mp4":
					//url = type + ":" + url;
					break;
			}
			
			trace( "VideoThumbnail.source = " + url );
			
			_source = url;
			
			defineEventHandlers();
		}
		
		private function createPreview() : void
		{
			trace( this + "creating preview..." );
			_nc = new NetConnection();
			_nc.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			_nc.connect( null );
			
			_ns = new NetStream( _nc );
			_ns.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			_ns.client = this;
			_ns.bufferTime = _thumbBuffer;
			
			_ns.play( _source );
						
			_video = new Video();
			_video.width = 256;
			_video.height = 144;
			_video.smoothing = true;
			_video.attachNetStream( _ns );
						
			_movie.addChild( _video );
			
			_videoReflection  = new Reflection( {mc:_movie, alpha:25, ratio:100, distance:0, updateTime:1, reflectionDropoff:1} );
			
			showPreview();
		}
		
		private function onNetStatus( e : NetStatusEvent ) : void
		{
			trace( e.info.code );
		}
		
		private function showPreview() : void
		{
			Tweener.addTween( _thumb, {alpha:0, time:3} );
			Tweener.addTween( _movie, {alpha:1, time:3} );
			Mouse.hide();
		}
		
		private function clearPreview() : void
		{
			try {
				_ns.close();
				_ns.removeEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
				
				_nc.close();
				_nc.removeEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
	
				_video.clear();
				_movie.removeChild( _video );
				
				_videoReflection.destroy();
			} catch( e : Error ) {
				trace( this + "runtime error: " + e.message );
			}
		}
		
		public function onMetaData( meta : Object ) : void
		{
		
		}
		
		public function set thumb( mc : MovieClip ) : void
		{
			_thumb = mc;
			addChild( _thumb );
		}
		
		override public function toString() : String
		{
			return "[VideoThumbnail " + VERSION + " ]: ";
		}
		
		
	}
}