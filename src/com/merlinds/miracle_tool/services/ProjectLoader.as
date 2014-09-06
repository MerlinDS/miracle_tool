/**
 * User: MerlinDS
 * Date: 06.09.2014
 * Time: 20:59
 */
package com.merlinds.miracle_tool.services {

	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	public class ProjectLoader {

		private var _sources:Array;
		private var _fileHelpers:Vector.<FileHelper>;
		private var _currentFile:File;
		private var _callback:Function;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectLoader(callback:Function) {
			_callback = callback;
		}

		public function read(sources:Array):void {
			_sources = sources.concat();
			_fileHelpers = new <FileHelper>[];
			_currentFile = null;
			this.loadSource();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function loadSource():void{
			if(_sources.length > 0){
				var source:Array = _sources.shift();
				while(source.length > 0){
					var fileHelper:FileHelper = new FileHelper(
							new File(source.shift()));
					_fileHelpers.push(fileHelper);
				}
				_currentFile = _fileHelpers[0].file;
				this.readSourceFile();
			}else{
				_callback.apply(this);
			}
		}

		private function readSourceFile():void {
			var fileStream:FileStream = new FileStream();
			fileStream.addEventListener(Event.COMPLETE, this.completeHandler);
			fileStream.openAsync(_currentFile, FileMode.READ);
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function completeHandler(event:Event):void {
			var fileStream:FileStream = event.target as FileStream;
			fileStream.removeEventListener(event.type, this.completeHandler);
			var fileHelper:FileHelper;
			var n:int = _fileHelpers.length;
			for(var i:int = 0; i < n; i++){
				fileHelper = _fileHelpers[i];
				if(fileHelper.file == _currentFile){
					break;
				}
				fileHelper = null;
			}
			if(fileHelper == null){
				throw new ArgumentError("Can not found fileHelper for downloaded one");
			}
			fileHelper.bytes = new ByteArray();
			fileStream.readBytes(fileHelper.bytes);
			fileStream.close();
			//download next file
			if(++i < n){
				_currentFile = _fileHelpers[i].file;
				this.readSourceFile();
			}else{
				_currentFile = null;
				this.loadSource();
			}
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function get fileHelpers():Vector.<FileHelper> {
			return _fileHelpers;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}

import flash.filesystem.File;
import flash.utils.ByteArray;

class FileHelper{

	public var file:File;
	public var bytes:ByteArray;

	public function FileHelper(file:File) {
		this.file = file;
	}
}