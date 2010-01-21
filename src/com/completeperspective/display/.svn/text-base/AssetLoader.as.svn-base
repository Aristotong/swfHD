package com.completeperspective.display
{
 import flash.display.*;
 import flash.events.*;
 import flash.net.URLRequest;

    public class AssetLoader extends MovieClip {
        
        public static const VERSION : String = "1.0.0";
        
        private var _url:String;
        

        public function AssetLoader( url : String )
        {
           
           	_url = url;
           	
            var loader:Loader = new Loader();
            configureListeners( loader.contentLoaderInfo );
            loader.addEventListener(MouseEvent.CLICK, clickHandler);

            var request:URLRequest = new URLRequest( _url );
            loader.load(request);

            addChild(loader);
        }

        private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(Event.INIT, initHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
        }

        private function completeHandler(event:Event):void {
        //    trace(this + "completeHandler: " + event);
            dispatchEvent( event );
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
           // trace(this +"httpStatusHandler: " + event);
        }

        private function initHandler(event:Event):void {
          //  trace(this +"initHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
          //  trace(this +"ioErrorHandler: " + event);
        }

        private function openHandler(event:Event):void {
         //   trace(this + "openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
         //   trace(this +"progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }

        private function unLoadHandler(event:Event):void {
         //   trace(this +"unLoadHandler: " + event);
        }

        private function clickHandler(event:MouseEvent):void {
        //    trace(this +"clickHandler: " + event);
            //var loader:Loader = Loader(event.target);
            //loader.unload();
        }
        
        override public function toString() : String
        {
        	return "[AssetLoader " + VERSION + " ]: ";
        }
    }
}