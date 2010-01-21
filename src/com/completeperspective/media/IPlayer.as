///////////////////////////////////////////////////////////
//  IPlayer.as
//  ActionScript 3 Implementation of the Interface IMediaPlayer
//  Created on:      24-Feb-2009 16:38:11
//  Original author: Adam Colpitts
///////////////////////////////////////////////////////////

package com.completeperspective.media
{
	/**
	 * @author Adam Colpitts
	 * @version 1.0
	 * @created 24-Feb-2009 16:38:11
	 */
	public interface IPlayer
	{
		/**
		 * 
		 * @param source    source
		*/
		function load(source:String): void;

		function pause(): void;

		function play(): void;

		function stop(): void;
		
		function clear() : void;

	}//end IPlayer

}

