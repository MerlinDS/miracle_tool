/**
 * User: MerlinDS
 * Date: 25.04.2014
 * Time: 21:01
 */
package com.merlinds.miracle_tool.tools.editor {
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;

	internal class SWFLoader extends EventDispatcher {

		private var _stream:FileStream;
		private var _decoder:Loader;
		private var _output:MovieClip;

		public function SWFLoader() {
			super();
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function load(file:File):void{
			_stream = new FileStream();
			_stream.addEventListener(Event.COMPLETE, this.streamCompleteHandler);
			_stream.openAsync(file, FileMode.READ);
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function clear():void{
			_stream = null;
			_decoder = null;
			_output = null;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function streamCompleteHandler(event:Event):void {
			_stream.removeEventListener(event.type, this.streamCompleteHandler);
			var bytes:ByteArray = new ByteArray();
			_stream.readBytes(bytes);
			_stream.close();
			//decode
			var context:LoaderContext = new LoaderContext();
			context.allowLoadBytesCodeExecution = true;
			context.allowCodeImport = true;
			_decoder = new Loader();
			_decoder.contentLoaderInfo.addEventListener(Event.COMPLETE, this.decodeCompleteHandler);
			_decoder.loadBytes(bytes, context);
		}

		private function decodeCompleteHandler(event:Event):void {
			_decoder.removeEventListener(event.type, this.decodeCompleteHandler);
			_output = _decoder.content as MovieClip;
			this.dispatchEvent(new Event(Event.COMPLETE));
			//delete sources on next frame
			setTimeout(this.clear, 0);
		}

		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get output():MovieClip {
			return _output;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
