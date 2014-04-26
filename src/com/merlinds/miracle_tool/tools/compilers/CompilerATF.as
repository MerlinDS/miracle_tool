/**
 * User: MerlinDS
 * Date: 26.04.2014
 * Time: 16:45
 */
package com.merlinds.miracle_tool.tools.compilers {
	import com.merlinds.miracle_tool.Config;

	import flash.events.Event;

	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	public class CompilerATF extends AbstractCompiler {

		public function CompilerATF() {
			super();
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		override public function execute():void {
			super.execute();
			this.saveOutputAsPNG();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function saveOutputAsPNG():void {
			var pngBytes:ByteArray = PNGEncoder.encode(_model.output);
			var fileName:String = _model.workFLA.name;
			fileName = fileName.substr(0, -_model.workFLA.extension.length) + "png";
			var file:File = _model.workDir.resolvePath( fileName );
			var fileStream:FileStream = new FileStream();
			fileStream.addEventListener(Event.CLOSE, this.closeHandler);
			fileStream.openAsync(file, FileMode.WRITE);
			fileStream.writeBytes(pngBytes);
			fileStream.close();
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function closeHandler(event:Event):void {
			var fileStream:FileStream = event.target as FileStream;
			fileStream.removeEventListener(event.type, arguments.callee);
			trace("Ok");
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
