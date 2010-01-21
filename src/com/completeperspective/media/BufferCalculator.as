package com.completeperspective.media
{

	public class BufferCalculator
	{

		public static var BUFFER_PADDING:Number = 10;

		public function BufferCalculator() 
		{
		}

		public static function calculate( duration : Number, bitrate : Number, bandwidth : Number ) : Number
		{
			var bufferTime:Number;
			
			if ( bitrate > bandwidth) {
				bufferTime = Math.ceil( duration - duration / ( bitrate / bandwidth ) ) / 2;
			} else {
				bufferTime = 5;
			}

			bufferTime += BUFFER_PADDING;
	
			return bufferTime;
			
			
		}
	}
}