﻿package com.completeperspective.media.players{	import com.completeperspective.media.events.*;	import com.completeperspective.media.model.*;	import com.completeperspective.media.utils.*;		import caurina.transitions.*;		import flash.display.*;	import flash.text.*;	import flash.events.*;		/**	 * Serves as both the View and the Controller in the MVC	 */	public class MediaPlayer extends Sprite	{		public static const VERSION : String = "1.0.0";				public var model : MediaPlayerModel = MediaPlayerModel.getInstance();		public var autoPlay : Boolean = true;		public var bandwidth : Number;		public var player : ProgressiveVideo;		public var showingPlaylist : Boolean = false;				private var _autoPlay : Boolean = false;		private var _controls : PlayerControls;		private var _backdrop : MovieClip;		private var _path : String = "http://seatoskyhometours.com/examples/new/video/2257.mp4";				public function MediaPlayer()		{			stage.scaleMode = StageScaleMode.NO_SCALE;            stage.align = StageAlign.TOP_LEFT;						addEventListener( Event.ADDED_TO_STAGE, handleInit );		}				public function handleInit( e : Event ) : void		{			// Get FlashVars			try {		    	var keyStr:String;		    	var valueStr:String;		    	var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;			   			    for (keyStr in paramObj) {			        valueStr = String(paramObj[keyStr]);			        trace("\t" + keyStr + ":\t" + valueStr + "\n");			    }			    			   	if( paramObj["file"] ) {			   		_path = paramObj["path"];				}								if( paramObj["autoPlay"] ) {			   		_autoPlay = paramObj["autoPlay"];				}								if ( paramObj["size"] ) {					// set width and height for embeded player "512x288"					var test:String = String(paramObj["size"]);					var w : String = test.substr( 0, 3);					var h : String = test.substr( 4, 3 );										model.playerWidth = Number( w );					model.playerHeight = Number( h );				}			    			} catch (error:Error) {			    trace(error.toString());			}															_controls = getChildByName( "playerControls_mc" ) as PlayerControls;			_controls.addEventListener( MediaPlayerEvent.SHOW_PLAYLIST_VIEW, handleShowPlaylistView );			_controls.setWidth ( model.playerWidth );			_controls.y = model.playerHeight - _controls.height + 14;						_backdrop = getChildByName( "backdrop_mc" ) as MovieClip;			_backdrop.width = model.playerWidth;			_backdrop.height = model.playerHeight;						loading_mc.x = model.playerWidth / 2 - loading_mc.width / 2;			loading_mc.y = model.playerHeight / 2 - loading_mc.height / 2;						loading_mc.message_txt.text = "Detecting Bandwidth...";						var bandwidthTester : BandwidthTest = new BandwidthTest( "http://seatoskyhometours.com/examples/new/misc_thumbs/videoinsetplay.jpg" );			bandwidthTester.addEventListener( BandwidthEvent.THUMBNAIL_RECEIVED, handleThumbnailReceived );			bandwidthTester.addEventListener( BandwidthEvent.BANDWIDTH_RECEIVED, handleBandwidthReceived );						bandwidthTester.test();		}				private function handleThumbnailReceived( e : BandwidthEvent ) : void		{			var thumb : MovieClip = e.data as MovieClip;			thumb.name = "thumb";			thumb.width = model.playerWidth;			thumb.height = model.playerHeight;						addChildAt( thumb, 2 );						trace( "Thumb: " + getChildByName( "thumb" ) );		}				private function handleBandwidthReceived( e : Event ) : void		{			loading_mc.message_txt.text = "Bandwidth Received. " + e.target.detectedBandwidth ;			bandwidth = e.target.detectedBandwidth;						//connSpeed.text = String( Math.round(bandwidth) ) + " kbps.";						preloadVideo();		}				private function loadPlaylist() : void		{			model.addEventListener( PlaylistEvent.PLAYLIST_READY, handlePlaylistReady );						try {				loading_mc.message_txt.text = "Loading Playlist..."; 				model.loadPlaylist( "feeds/swfHD_Channel.xml" );			} catch ( e : Error ) {				loading_mc.message_txt.text = "ERROR: " + e.message;			}					}				private function preloadVideo() : void		{			loading_mc.message_txt.text = "Buffering Video";						var videoPlayer : ProgressiveVideo = new ProgressiveVideo( bandwidth, _path );			videoPlayer.name = "player";			videoPlayer.alpha = 0;			videoPlayer.addEventListener( MediaPlayerEvent.BUFFERING, handleBuffering );			videoPlayer.addEventListener( MediaPlayerEvent.BUFFERED, handleBuffered );			videoPlayer.addEventListener( MediaPlayerEvent.FINISHED, handleEndOfVideo );						addChildAt( videoPlayer, 3 );						player = videoPlayer;			_controls.player = player;						addEventListener( Event.ENTER_FRAME, handleEnterFrame );		}				private function handleBuffered( e : MediaPlayerEvent ) : void		{			loading_mc.gotoAndStop( 2 );						trace( "Thumb: " + getChildByName( "thumb" ) );			if( _autoPlay ) {				startVideo();			}else{				addEventListener( MouseEvent.CLICK, startVideo );			}		}				private function handleBuffering( e : MediaPlayerEvent ) : void		{					}				private function handleEndOfVideo( e : MediaPlayerEvent ) : void		{			trace( "VIDEO IS OVER" );			var videoPlayer : ProgressiveVideo = e.data as ProgressiveVideo;									loading_mc.gotoAndStop( 2 );			Tweener.addTween( loading_mc, { alpha: 1, time:1.5 } );			Tweener.addTween( videoPlayer, { alpha: 0, time: 2 } );						addEventListener( MouseEvent.CLICK, startVideo );					}				private function handlePlaylistReady( e : PlaylistEvent ) : void		{			trace( this + ": Playlist has loaded" );						var videoPlayer : ProgressiveVideo = new ProgressiveVideo( bandwidth, model.playlist.items[0].url );			videoPlayer.name = "player";			addChildAt( videoPlayer, 2 );						_controls.player = videoPlayer;						addEventListener( Event.ENTER_FRAME, handleEnterFrame );			addEventListener( MouseEvent.MOUSE_OVER, handleMouseOver );			addEventListener( MouseEvent.MOUSE_OUT, handleMouseOut );						addEventListener( MediaPlayerEvent.SHOW_PLAYLIST_VIEW, handleShowPlaylistView );		}				private function startVideo( e : MouseEvent = null ) : void		{			removeEventListener( MouseEvent.CLICK, startVideo );						addEventListener( MouseEvent.MOUSE_OVER, handleMouseOver );			addEventListener( MouseEvent.MOUSE_OUT, handleMouseOut );						var player : ProgressiveVideo = getChildByName( "player" ) as ProgressiveVideo;			player.startVideo();						Tweener.addTween( loading_mc, { alpha: 0, time:1.5 } );			Tweener.addTween( player, { alpha: 1, time: 2 } );		}				private function handleShowPlaylistView( e : MediaPlayerEvent ) : void		{						showingPlaylist = true;			var mediaPlayer : ProgressiveVideo = getChildByName( "player" ) as ProgressiveVideo;			mediaPlayer.addEventListener( MouseEvent.CLICK, handleHidePlaylist );			var newX : Number = model.playerWidth / 2;			newX *= .5;			Tweener.addTween( mediaPlayer, { scaleX: 0.5, time:1.5 } );			Tweener.addTween( mediaPlayer, { scaleY: 0.5, time:1.5 } );			Tweener.addTween( mediaPlayer, { x: newX, time:1.5 } );			Tweener.addTween( mediaPlayer, { y:10, time:1.5 } );			Tweener.addTween( playlist_mc, { alpha:1, time:2 } );					}				private function handleHidePlaylist( e : Object = null ) : void		{			showingPlaylist = false;			var mediaPlayer : ProgressiveVideo = getChildByName( "player" ) as ProgressiveVideo;						Tweener.addTween( mediaPlayer, { width:model.playerWidth, time:2 } );			Tweener.addTween( mediaPlayer, { height:model.playerHeight, time:2 } );			Tweener.addTween( mediaPlayer, { x:0, time:2 } );			Tweener.addTween( mediaPlayer, { y:0, time:2 } );			Tweener.addTween( playlist_mc, { alpha:0, time:2 } );		}				private function handleEnterFrame(e:Event):void		{			var player : ProgressiveVideo = getChildByName( "player" ) as ProgressiveVideo;			var nowSecs:Number = Math.floor( player.ns.time );				var totalSecs:Number = Math.round( player.media.duration );						if(nowSecs > 0)			{				_controls.timeCode_txt.text = getTimeCode(nowSecs) + "/" + getTimeCode(totalSecs);				var amountPlayed:Number = nowSecs / totalSecs;				var amountLoaded:Number = player.ns.bytesLoaded / player.ns.bytesTotal;								_controls.playStatus_mc.width = _controls.track_mc.width * amountPlayed;				_controls.dlStatus_mc.width = _controls.track_mc.width * amountLoaded;												//bfTime.text = String(player.ns.bufferTime);				//bfLength.text = String( Math.floor(player.ns.bufferLength) );											}								}				private function handleMouseOver(e:MouseEvent=null):void		{			Tweener.addTween( _controls, {alpha:1, time:3});		}				private function handleMouseOut(e:MouseEvent=null):void		{			Tweener.addTween( _controls, { alpha:0, time:3 } );		}								public function getTimeCode( myTime : Number ) : String 		{			var mediaPlayer : ProgressiveVideo = getChildByName( "player" ) as ProgressiveVideo;			return mediaPlayer.getTimeCode( myTime );		}				override public function toString():String		{			return "[MediaPlayer v" + VERSION + "]"; 		}						}}