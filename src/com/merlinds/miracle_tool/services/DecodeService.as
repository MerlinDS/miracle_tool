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

		//==============================================================================
		//{region							PUBLIC METHODS
		public function DecodeService() {
			super();
		}

		public function decodeSource(bytes:ByteArray):void{
			log(this, "decodeSource");
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loaderCompleteHandler);
			var loaderContext:LoaderContext = new LoaderContext(false);
			loaderContext.allowCodeImport = true;
			loader.loadBytes(bytes, loaderContext);
		}

		public function decodeAnimation(bytes:ByteArray):void{
			log(this, "decodeAnimation");
		}

		public function decodeProject(bytes:ByteArray):void{
			log(this, "decodeProject");
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
			this.dispatch(new EditorEvent(EditorEvent.SOURCE_ATTACHED, loaderInfo.content));
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
//} endregion GETTERS/SETTERS ==================================================
	}
}
