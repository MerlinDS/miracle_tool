/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 17:44
 */
package com.merlinds.miracle_tool.services {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.EditorEvent;

	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.geom.Point;
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
			bytes.position = 0;
			var signature:String = String.fromCharCode(bytes[0], bytes[1], bytes[2]);
			if(signature != "MTP"){
				//display error
			}else{
				bytes.position = 4;
				var data:Object = bytes.readObject();
				var sceneSize:Point = new Point(data.sceneSize.x, data.sceneSize.y);
				var boundsOffset:Number = data.boundsOffset;
				var sheetSize:Point = new Point(data.sheetSize.x, data.sheetSize.y);
				this.dispatch(new EditorEvent(EditorEvent.CREATE_PROJECT,
						{projectName:data.projectName, sceneSize:sceneSize,
							boundsOffset:boundsOffset, sheetSize:sheetSize,
							sources:data.sources
						}));
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
			this.dispatch(new EditorEvent(EditorEvent.SOURCE_ATTACHED, loaderInfo.content));
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
//} endregion GETTERS/SETTERS ==================================================
	}
}
