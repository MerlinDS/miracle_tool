/**
 * User: MerlinDS
 * Date: 18.07.2014
 * Time: 17:59
 */
package com.merlinds.miracle_tool.models.vo {
	public class ConfigVO {

		private var _vestion:String;
		private var _settingsFile:String;
		private var _lastFileDirection:String;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ConfigVO(dataString:String) {
			var dataObject:Object = JSON.parse(dataString);
			_vestion = dataObject.version;
			_settingsFile = dataObject.settings.fileName;
			_lastFileDirection = dataObject.settings.lastFileDirection;
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function get vestion():String {
			return _vestion;
		}

		public function get settingsFile():String {
			return _settingsFile;
		}

		public function get lastFileDirection():String {
			return _lastFileDirection;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
