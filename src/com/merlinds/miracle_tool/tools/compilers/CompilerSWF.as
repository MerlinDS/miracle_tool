/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 22:38
 */
package com.merlinds.miracle_tool.tools.compilers {
	import com.merlinds.miracle_tool.Config;

	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class CompilerSWF extends AbstractCompiler{

		public function CompilerSWF() {
		}

		//==============================================================================
		//{region							PUBLIC METHODS

		override public function execute():void {
			super.execute();
			this.prepareJSFL();

			var args:Vector.<String> = new <String>[ Config.swfCompiler.name ];
			this.executeCompilation(Config.flashIDEPath, _model.workDir, args);
		}

//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function prepareJSFL():void {
			var jsflFile:File = Config.swfCompiler;
			var target:File = _model.workDir.resolvePath(jsflFile.name);
			jsflFile.copyTo(target, true);
			var stream:FileStream = new FileStream();
			stream.open(target, FileMode.UPDATE);
			stream.position = 0;
			var sctipt:String = "var fileName = '" + _model.workFLA.name + "';\n";
			stream.writeUTFBytes(sctipt);
			stream.close();
			trace(target.nativePath);
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
