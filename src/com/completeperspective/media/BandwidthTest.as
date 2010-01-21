package com.completeperspective.media
{
	import com.completeperspective.events.BandwidthEvent;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;

	public class BandwidthTest extends EventDispatcher
	{
		private var _downloadCount : uint;
		private var _bandwidthTests : Array;
		private var _detectedBandwidth : Number;
		private var _startTime : uint;
		private var _source : String
		
		public function get detectedBandwidth() : Number
		{
			return _detectedBandwidth;
		}
		
		public function BandwidthTest( image : String )
		{
			_source = image;
			_downloadCount = 0;
			_bandwidthTests = new Array();
		}
		
		public function test() : void
		{
			// Use a URLLoader to load the data
			var loader : Loader = new Loader();
			
			// Use a unique query string to ensure the browser isn't caching the asset
			//trace( "loading: " + _source + "?uid=" + (new Date()).getTime() );
			var request : URLRequest = new URLRequest( _source + "?uid=" + (new Date()).getTime());
			loader.contentLoaderInfo.addEventListener( Event.OPEN, handleStart );
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, handleLoad );
			loader.load( request );
		}
		
		// When the test starts, record the time
		private function handleStart( e : Event ) : void
		{
			//trace( "badwidth timer starting" );
			_startTime = getTimer();
		}
		
		private function handleLoad( e : Event ) : void
		{
			// The download time is the timer value when the file has downloaded
			// minus the timer value when the value started downloading.  Then
			// divid by 1000 to convert from milliseconds to seconds.
			var downloadTime : Number = (getTimer() - _startTime ) / 1000;
			_downloadCount++;
			
			// Convert from bytes to kilobits
			var kilobits : Number = e.target.bytesTotal / 1000 * 8;
			
			// Divide the kilobits by the download time.
			var kbps : Number = kilobits / downloadTime;
			
			// Add the test value to the array
			_bandwidthTests.push( kbps );
			
			if ( _downloadCount == 1) {
				
				//Save the loaded bitmap to a local variable
				//var image:Bitmap = Bitmap(e.target.content);
				var image : Bitmap = e.target.content;
				var thumb : MovieClip = new MovieClip()
				
				thumb.addChild( image );
				
				trace( thumb );
				dispatchEvent( new BandwidthEvent( BandwidthEvent.INIT, thumb ) );
				
				// If it's only run one test, run a second one
				test();
			} else if( _downloadCount == 2 ) {
				
				// If it's run two tests then determine the margin between the
				// first two tests.
				// If the margin is small (in this case 50kbps) then dispatch
				// a complete event. If not, run another test
				if( Math.abs( _bandwidthTests[0] - _bandwidthTests[1] ) < 50 ) {
					dispatchCompleteEvent();
				} else {
					test();
				}
			} else {
				// Following the third test, dispatch a complete event
				dispatchCompleteEvent();
			}
				
		}
		
		private function dispatchCompleteEvent() : void
		{
			// Determine the avarage bandwidth detection value.
			_detectedBandwidth = 0;
			var i : uint;
			for( i = 0; i < _bandwidthTests.length; i++ ) {
				_detectedBandwidth += _bandwidthTests[i];		
			}
			_detectedBandwidth /= _downloadCount;
			
			//trace( "bandwidth: " + detectedBandwidth );
			//Dispatch a complete event.
			dispatchEvent( new BandwidthEvent( BandwidthEvent.COMPLETE, _detectedBandwidth ) );
		}
		
	}
}