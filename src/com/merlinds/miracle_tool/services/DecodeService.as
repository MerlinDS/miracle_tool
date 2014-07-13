/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 17:44
 */
package com.merlinds.miracle_tool.services {
	import com.merlinds.debug.log;
	import com.merlinds.debug.warning;
	import com.merlinds.miracle_tool.events.EditorEvent;

	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.system.LoaderContext;

	import flash.utils.ByteArray;

	import org.robotlegs.mvcs.Actor;

	public class DecodeService extends Actor {

		private var _output:Object;
		private var _currentName:String;
		private var _inProgress:Boolean;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function DecodeService() {
			_output = {};
			super();
		}

		public function decodeSource(bytes:ByteArray, name:String):void{
			log(this, "decodeSource");
			_output[name] = null;
			_inProgress = true;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loaderCompleteHandler);
			var loaderContext:LoaderContext = new LoaderContext(false);
			loaderContext.allowCodeImport = true;
			loader.loadBytes(bytes, loaderContext);
		}

		public function decodeAnimation(bytes:ByteArray, name:String):void{
			log(this, "decodeAnimation");
			_output[name] = null;
			_inProgress = true;
		}

		public function decodeProject(bytes:ByteArray, name:String):void{
			log(this, "decodeProject");
			_output[name] = null;
			_inProgress = true;
		}

		public function clear():void {
			if(_inProgress == false){
				_output = null;
			}else{
				warning(this, "clear", "Can not clear when service in active stage.");
			}
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function loaderCompleteHandler(event:Event):void {
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			loaderInfo.removeEventListener(event.type, this.loaderCompleteHandler);
			_output[_currentName] = loaderInfo.content;
			this.dispatch(new EditorEvent(EditorEvent.SOURCE_ATTACHED));
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function get output():Object {
			return _output;
		}

		public function inProgress():Boolean {
			return _inProgress;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
