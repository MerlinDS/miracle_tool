/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 22:38
 */
package com.merlinds.miracle_tool.tools.compilers {
	import com.merlinds.miracle_tool.Config;
	import com.merlinds.miracle_tool.components.ErrorWindown;
	import com.merlinds.miracle_tool.tools.AbstractTool;

	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.errors.IllegalOperationError;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class CompilerSWF extends AbstractTool{

		private var _process:NativeProcess;

		public function CompilerSWF() {
		}

		//==============================================================================
		//{region							PUBLIC METHODS

		override public function execute():void {
			super.execute();
			trace(this, "execute");
			if(!NativeProcess.isSupported){
				var error:IllegalOperationError = new IllegalOperationError("NativeProcess not supported. " +
						"Cannot execute Flash IDE for swf compiling. ");
				new ErrorWindown(error);
				this.executeErrorCallback(error);
			}else{
				this.prepareJSFL();
				this.executeCompilation();
			}
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

		private function executeCompilation():void{
			var nativeProcessStartupInfo:NativeProcessStartupInfo = new
					NativeProcessStartupInfo();
			var args:Vector.<String> = new <String>[ Config.swfCompiler.name ];
			nativeProcessStartupInfo.executable = Config.flashIDEPath;
			nativeProcessStartupInfo.workingDirectory = _model.workDir;
			nativeProcessStartupInfo.arguments = args;
			//
			_process = new NativeProcess();
			_process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
			_process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
			_process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
			_process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
			_process.addEventListener(NativeProcessExitEvent.EXIT, onExit);
			_process.start(nativeProcessStartupInfo);
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		public function onOutputData(event:ProgressEvent):void
		{
			trace("CompilerSWF Got: ", _process.standardOutput.readUTFBytes(_process.standardOutput.bytesAvailable));
		}

		public function onErrorData(event:ProgressEvent):void
		{
			this.executeErrorCallback(new Error(_process.standardError.readUTFBytes +
					_process.standardError.bytesAvailable));
		}

		public function onExit(event:NativeProcessExitEvent):void
		{
			trace("CompilerSWF Process exited with ", event.exitCode);
			this.executeCallback();
		}

		public function onIOError(event:IOErrorEvent):void
		{
			this.executeErrorCallback(new Error(event.text));
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
