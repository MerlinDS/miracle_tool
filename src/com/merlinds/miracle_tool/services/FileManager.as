/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 16:41
 */
package com.merlinds.miracle_tool.services {
	import com.merlinds.miracle_tool.models.AppModel;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;

	[Event(type="flash.events.Event", name="complete")]

	public class FileManager extends EventDispatcher{

		private var _file:File;
		private var _stream:FileStream;
		private var _model:AppModel;

		public function FileManager(model:AppModel) {
			_file = model.lastDirectory;
			_model = model;
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function browseForFLA():void {
			var filter:FileFilter = new FileFilter("Only FLA file", "*.fla");
			_file.browseForOpen("Select FLA source file", [filter]);
			_file.addEventListener(Event.SELECT, selectHandler);
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function selectHandler(event:Event):void {
			_file.removeEventListener(event.type, this.selectHandler);
			_file.addEventListener(Event.COMPLETE, this.completeHandler);
			_model.lastDirectory = _file.parent;
			//copy to work dir
			const workDirectory:File = File.createTempDirectory();
			var target:File = workDirectory.resolvePath( _file.name );
			_file.copyToAsync(target, true);
		}

		private function completeHandler(event:Event):void {
			_file.removeEventListener(event.type, this.completeHandler);
			_model.workFLA = _file;
			this.dispatchEvent(event);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
