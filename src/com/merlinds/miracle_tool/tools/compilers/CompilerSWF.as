/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 22:38
 */
package com.merlinds.miracle_tool.tools.compilers {
	import com.merlinds.miracle_tool.Config;
	import com.merlinds.miracle_tool.tools.AbstractTool;

	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.errors.IllegalOperationError;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;

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
				this.executeErrorCallback(  new IllegalOperationError("NativeProcess not supported.") );
			}else{
				var nativeProcessStartupInfo:NativeProcessStartupInfo = new
						NativeProcessStartupInfo()
				var args:Vector.<String> = new <String>[ Config.swfCompiler.name ];
				nativeProcessStartupInfo.executable = Config.flashIDEPath;
				nativeProcessStartupInfo.workingDirectory = Config.nativeFilesPath;
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
		}

//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
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
