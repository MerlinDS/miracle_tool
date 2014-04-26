/**
 * User: MerlinDS
 * Date: 26.04.2014
 * Time: 16:25
 */
package com.merlinds.miracle_tool.tools.compilers {
	import com.merlinds.miracle_tool.tools.AbstractTool;

	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.errors.IOError;
	import flash.errors.IllegalOperationError;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;

	public class AbstractCompiler extends AbstractTool {

		private var _process:NativeProcess;
		private var _nativeProcessStartupInfo:NativeProcessStartupInfo;

		public function AbstractCompiler() {
			super();
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		override public function execute():void {
			super.execute();
			trace(this, "execute");
			if(!NativeProcess.isSupported){
				var error:IllegalOperationError = new IllegalOperationError("NativeProcess not supported. " +
						"Cannot execute Flash IDE for swf compiling. ");
				this.executeErrorCallback(error);
			}
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		protected function executeCompilation(executable:File,
		                                workingDirectory:File = null, args:Vector.<String> = null):void {
			var error:ArgumentError;
			if(!executable.exists){
				error = new ArgumentError("Executable file was not found");
				this.executeErrorCallback(error);
			}else{
				_nativeProcessStartupInfo = new NativeProcessStartupInfo();
				_nativeProcessStartupInfo.executable = executable;
				if(workingDirectory != null){
					if(!workingDirectory.exists){
						error = new ArgumentError("Working directory was not found");
						this.executeErrorCallback(error);
					} else {
						_nativeProcessStartupInfo.workingDirectory = workingDirectory;
					}
				}
				if(args != null){
					_nativeProcessStartupInfo.arguments = args;
				}
				this.executeProcess();
			}
		}

		private function executeProcess():void {
			_process = new NativeProcess();
			_process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
			_process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
			_process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
			_process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
			_process.addEventListener(NativeProcessExitEvent.EXIT, onExit);
			_process.start(_nativeProcessStartupInfo);

		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		protected function onOutputData(event:ProgressEvent):void
		{
			trace("CompilerSWF Got: ", _process.standardOutput.readUTFBytes(_process.standardOutput.bytesAvailable));
		}

		protected  function onErrorData(event:ProgressEvent):void
		{
			this.executeErrorCallback(new Error(_process.standardError.readUTFBytes +
					_process.standardError.bytesAvailable));
		}

		protected  function onExit(event:NativeProcessExitEvent):void
		{
			trace("CompilerSWF Process exited with ", event.exitCode);
			this.executeCallback();
		}

		protected  function onIOError(event:IOErrorEvent):void
		{
			this.executeErrorCallback(new IOError(event.text));
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
