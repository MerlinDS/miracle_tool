/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 20:31
 */
package com.merlinds.miracle_tool.models {
	import flash.filesystem.File;
	import flash.net.SharedObject;

	public class AppModel {

		private var _workFLA:File;
		private var _workSWF:File;

		private var _lastDirectory:File;
		private var _sharedObject:SharedObject;

		private var _instanceName:String;

		public function AppModel() {
			this.initialize();
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function initialize():void{
			_sharedObject = SharedObject.getLocal("save");
			if(_sharedObject.size == 0){
				//save initialized directory;
				this.lastDirectory = null;
			}else{
				_lastDirectory = new File(_sharedObject.data.lastDirectory);
			}
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function get workFLA():File {
			return _workFLA;
		}

		public function get workDir():File {
			return _workFLA.parent;
		}

		public function set workFLA(value:File):void {
			_workFLA = value;
			if(_workFLA != null){
				var fileName:String = _workFLA.name.substr( 0, -workFLA.extension.length ) + "swf";
				_workSWF = _workFLA.resolvePath(fileName);
			}else{
				_workSWF = null;
			}
		}

		public function get workSWF():File {
			return _workSWF;
		}

		public function get lastDirectory():File {
			return _lastDirectory;
		}

		public function set lastDirectory(value:File):void {
			_lastDirectory = value;
			if(_lastDirectory == null){
				_lastDirectory = File.documentsDirectory;
			}
			_sharedObject.data.lastDirectory = _lastDirectory.nativePath;
			_sharedObject.flush();
		}

		public function get instanceName():String {
			return _instanceName;
		}

		public function set instanceName(value:String):void {
			_instanceName = value;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
