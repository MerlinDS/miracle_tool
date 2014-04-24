/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 18:06
 */
package com.merlinds.miracle_tool.tools {
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.tools.editor.EditorLauncher;

	import flash.desktop.NativeApplication;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.utils.setTimeout;

	[Event(type="flash.events.Event", name="change")]
	[Event(type="flash.events.ErrorEvent", name="error")]
	public class ToolProcessor extends EventDispatcher {

		private var _process:NativeProcess;
		private var _model:AppModel;

		public function ToolProcessor(model:AppModel) {
			_model = model;
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function execute(path:String, target:String):void {
			trace("Execute processing for file", path, "and target", target);
			if(NativeProcess.isSupported){
				this.executeCompiling();
			}else{
				this.dispatchEvent( new ErrorEvent(ErrorEvent.ERROR, false, false, "NativeProcess not supported."))
			}
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function executeCompiling():void {
			var file:File = File.applicationDirectory;
			file = file.resolvePath("C:\\Program Files\\Adobe\\Adobe Flash CC\\Flash.exe");

			var dir:File = File.applicationDirectory;
			dir = dir.resolvePath("com/merlinds/miracle_tool/nativeapp/");

			var nativeProcessStartupInfo:NativeProcessStartupInfo = new
					NativeProcessStartupInfo();
			var args:Vector.<String> = new <String>[];
			args.push("swfCompiler.jsfl");
			nativeProcessStartupInfo.executable = file;
			nativeProcessStartupInfo.workingDirectory = dir;
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

		public function cmd(string:String):void{
			if(_process && _process.running){
				_process.standardInput.writeUTFBytes(string + "\n");
			}
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private var _init:Boolean;
		public function onOutputData(event:ProgressEvent):void
		{
			if(!_init){
				_init = true;

//				this.cmd("START swfCompiler.jsfl");//
			}
			trace("Got: ", _process.standardOutput.readUTFBytes(_process.standardOutput.bytesAvailable));
		}

		public function onErrorData(event:ProgressEvent):void
		{
			trace("ERROR -", _process.standardError.readUTFBytes(_process.standardError.bytesAvailable));
		}

		public function onExit(event:NativeProcessExitEvent):void
		{
			trace("Process exited with ", event.exitCode);
			this.dispatchEvent( new Event(Event.CHANGE));
			setTimeout(EditorLauncher.getInstance().execute, 0);
		}

		public function onIOError(event:IOErrorEvent):void
		{
			trace(event.toString());
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
