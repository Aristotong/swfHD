package com.completeperspective.display {
	import flash.display.*;
	import flash.filters.*;
	
	public class ColorTools {
		
		// Constants:
		// Public Properties:
		// Private Properties:
	
		// Initialization:
		public function ColorTools() { }
	
		// Public Methods:
		static public function desaturate( item : MovieClip ) : void
		{
				//color matrix array		
				var grayScale_array:Array = [0.3, 0.59, 0.11, 0, 0,0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
				//create new color matrix
				var myColorMatrix_filter:ColorMatrixFilter = new ColorMatrixFilter(grayScale_array);
				//apply filter
				item.filters = [myColorMatrix_filter];
		};
		
		static public function restore(item : MovieClip ) : void
		{
				//color matrix array
				var fullColor_array  :Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
				//create new color matrix
				var myColorMatrix_filter:ColorMatrixFilter = new ColorMatrixFilter(fullColor_array);
				//apply filter
				item.filters = [myColorMatrix_filter];
		};	
	
		// Protected Methods:
	}
	
}