﻿package com.completeperspective.media.net {		import com.completeperspective.media.events.*;	import flash.events.*;	import flash.media.*;	/**	 * @author adam	 */	public class FlashClient extends EventDispatcher	{		private var _videoDisplay : Video;				public function FlashClient( p_video : Video, target: IEventDispatcher = null) {			super(target);			_videoDisplay = p_video;		}				public function onMetaData( o : Object ) : void		{			//dispatchEvent( new PlayerEvent( PlayerEvent.METADATA_RECEIVED, o ) );		}	}}