///////////////////////////////////////////////////////////
//  VideoPlayer.as
//  ActionScript 3 Implementation of the Class VideoPlayer
//  Created on:      24-Feb-2009 16:38:12
//  Original author: Adam Colpitts
///////////////////////////////////////////////////////////

package com.completeperspective.media
{
	import com.completeperspective.display.*;
	import com.completeperspective.events.*;
	
	import flash.display.*;
	import flash.media.Video;
	import flash.net.*;
	import flash.events.*;
	
	/**
	 * Plays Flash Video (.flv) and H.264 (.mp4) Video formats
	 * @author Adam Colpitts
	 * @version 1.0
	 * @created 24-Feb-2009 16:38:12
	 */
	public class VideoPlayer extends Sprite implements IPlayer
	{	    
	    static public const VERSION: String = "1.0.0";
		
		public var buffer : Number
		
		private var _nc: NetConnection;
		private var _ns : NetStream;
		private var _video : Video;
		private var _source : String;
		private var _bandwidth : Number;
		
		private var _isStream : Boolean = false;
		private var _minWidth : Number;
		private var _minHeight : Number;

		public function VideoPlayer( p_width : Number, p_height : Number )
		{
			_minWidth = p_width;
			_minHeight = p_height;
			
			init();
		}
		
	    private function init(): void
	    {
			// Setup our NetConnection
			_nc = new NetConnection();
			_nc.client = this;
			_nc.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			
			_video = new Video( _minWidth, _minHeight );
			addChild( _video );
			
	    }
		
		private function onNetStatus( e : NetStatusEvent ) : void
		{
			switch (e.info.code) {
				case "NetConnection.Connect.Success":
					trace("The connection was successful");
					if( _isStream ) {
						// Use automatic bandwidth checking through FMS
						_nc.call("checkBandwidth", null);
					} else {
						// manually check bandwidth
						var bandwidthTester : BandwidthTest = new BandwidthTest( "http://media.completeperspective.com/precip/4478586.png" );
						bandwidthTester.addEventListener( BandwidthEvent.INIT, onBandwidthInit );
						bandwidthTester.addEventListener(BandwidthEvent.COMPLETE, onBandwidthReceived );
			
						bandwidthTester.test();
					}
					
					break;
				case "NetConnection.Connect.Failed":
					trace("The connection failed");
					break;
				case "NetConnection.Connect.Rejected":
					trace("The connection was rejected");
					break;
				case "NetStream.Buffer.Full":
					_ns.bufferTime = 10;
					trace("Expanded buffer to 10");
					break;
				case "NetStream.Buffer.Empty":
					_ns.bufferTime = 2;
					trace("Reduced buffer to 2");
					break;
			}
		}		
		
		private function onBandwidthInit( e : BandwidthEvent ) : void
		{
			var thumb : MovieClip = e.data as MovieClip;
			thumb.name = "thumb";
			thumb.width = _minWidth;
			thumb.height = _minHeight;
			ColorTools.desaturate( thumb );
			thumb.alpha = .25
			addChild( thumb );
			
			var overlay : Sprite = new Sprite();
			overlay.graphics.beginFill( 0x000000, .5 );
			overlay.graphics.drawRect(0, 0, 768, 432 );
			overlay.graphics.endFill();
			
			addChild( overlay );
		}
			
		private function onBandwidthReceived( e : BandwidthEvent ) : void
		{
			_bandwidth = e.data as Number;
			
			buffer = BufferCalculator.calculate( 300, 1500, _bandwidth );

			openStream( _nc );
		}
		
		private function openStream( connection : NetConnection ) : void
		{
			_ns = new NetStream( connection );
			_ns.bufferTime = buffer;
			_ns.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			_ns.client = this;
			_ns.play( _source + "?uid=" + new Date().getTime() );
			_ns.pause();
			
			_video.attachNetStream( _ns );
		}
			
		public function onMetaData( meta : Object ) : void
		{
		}

		/**
	     * Loads the video file from the source path provided
	     * 
	     * @param source    source
	     */
	    public function load(source:String): void
	    {
			_source = source;
			_nc.connect( null );
	    }
		
		
	    public function pause(): void
	    {
	    }

	    public function play(): void
	    {
	    }

	    public function stop(): void
	    {
	    }
		
		public function clear() : void
		{
		}

	    public override function toString(): String
	    {
			return "[VideoPlayer v" + VERSION + " ]";
	    }

	}//end VideoPlayer

}
