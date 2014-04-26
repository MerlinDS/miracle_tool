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

		private static const ATF:String = "atf";
		private static const PNG:String = "png";
		private static const FLA:String = "fla";

		private var _file:File;

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
			var fileName:String = _model.workFLA.name.replace(FLA, PNG);
			_file = _model.workDir.resolvePath( fileName );
			_file.canonicalize();
			var fileStream:FileStream = new FileStream();
			fileStream.addEventListener(Event.CLOSE, this.closeHandler);
			fileStream.openAsync(_file, FileMode.WRITE);
			fileStream.writeBytes(pngBytes);
			fileStream.close();
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function closeHandler(event:Event):void {
			var fileStream:FileStream = event.target as FileStream;
			fileStream.removeEventListener(event.type, arguments.callee);
			//
			var input:String = _file.nativePath;
			var output:String = input.replace(PNG, ATF);
			var args:Vector.<String> = new <String>[
				"-n", "0,"+_model.atfMitmap, "-i", input, "-o", output
			];
			this.executeCompilation(Config.png2atf, null, args);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
