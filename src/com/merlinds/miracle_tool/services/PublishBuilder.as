/**
 * User: MerlinDS
 * Date: 18.07.2014
 * Time: 15:54
 */
package com.merlinds.miracle_tool.services {
	import com.merlinds.debug.error;
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.views.logger.StatusBar;

	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	public class PublishBuilder {

		private var _workDir:File;
		private var _file:File;
		private var _atf:File;
		private var _output:ByteArray;
		private var _callback:Function;
		private var _minMap:int;

		private var _png2atf:File;
		private var _process:NativeProcess;

		public function PublishBuilder() {
			_png2atf = File.applicationDirectory;
			_png2atf = _png2atf.resolvePath("png2atf.exe");
		}
		//==============================================================================
		//{region							PUBLIC METHODS
		public function createATFFile(png:ByteArray, minMap:int, callback:Function):void{
			_callback = callback;
			_minMap = minMap;
			//create temp dir and place resources there
			_workDir = File.createTempDirectory();

			_file = _workDir.resolvePath("png4atf.png");
			_atf = _workDir.resolvePath("output.atf");
			var stream:FileStream = new FileStream();
			stream.openAsync(_file, FileMode.WRITE);
			stream.writeBytes(png);
			stream.close();
			//execute atf packer
			if(NativeProcess.isSupported)
			{
				this.executePngToAtf();
			}
			else
			{
				var errorText:String = "NativeProcess not supported.";
				error(this, errorText);
				StatusBar.error(errorText);
			}

		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function executePngToAtf():void {
			var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			nativeProcessStartupInfo.executable = _png2atf;
			nativeProcessStartupInfo.workingDirectory =_workDir;
			nativeProcessStartupInfo.arguments =  new <String>[
				"-n", "0," + _minMap, "-i", _file.name, "-o", _atf.name
			];

			trace(nativeProcessStartupInfo.arguments);
			_process = new NativeProcess();
			_process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, this.outputDataHandler);
			_process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, this.errorDataHandler);
			_process.addEventListener(NativeProcessExitEvent.EXIT, this.exitHandler);
			_process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, this.ioErrorHandler);
			_process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, this.ioErrorHandler);
			_process.start(nativeProcessStartupInfo);
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function outputDataHandler(event:ProgressEvent):void {
			log(this, "outputDataHandler", "Got: ", _process.standardOutput.readUTFBytes(_process.standardOutput.bytesAvailable));
		}

		private function errorDataHandler(event:ProgressEvent):void {
			error(this, "errorDataHandler", "ERROR -", _process.standardError.readUTFBytes(_process.standardError.bytesAvailable));
		}

		private function ioErrorHandler(event:IOErrorEvent):void {
			error(this, "errorDataHandler",event.toString());
		}

		private function exitHandler(event:NativeProcessExitEvent):void {
			log(this, "outputDataHandler", "Process exited with ", event.exitCode);
			if(event.exitCode == 0){
				//read parsed atf
				_output = new ByteArray();
				var stream:FileStream = new FileStream();
				stream.open(_atf, FileMode.READ);
				stream.readBytes(_output);
				stream.close();
				trace(_atf.nativePath);
				_atf.deleteFile();
				_file.deleteFile();
				_workDir.deleteDirectory(true);
				if(_callback is Function){
					_callback.apply(this);
				}
			}
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function get output():ByteArray {
			return _output;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
