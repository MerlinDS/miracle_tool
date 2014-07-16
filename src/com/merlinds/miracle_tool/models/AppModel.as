/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:21
 */
package com.merlinds.miracle_tool.models {
	import com.merlinds.miracle_tool.models.vo.ActionVO;
	import com.merlinds.miracle_tool.models.vo.DialogVO;
	import com.merlinds.unitls.structures.SearchUtils;

	import flash.filesystem.File;

	import flash.net.SharedObject;

	import org.robotlegs.mvcs.Actor;

	public class AppModel extends Actor {

		private var _so:SharedObject;
		private var _lastFileDirection:File;
		///
		private var _menuActions:Vector.<ActionVO>;
		private var _dialogs:Vector.<DialogVO>;
		private var _activeTool:String;

		public function AppModel() {
			_dialogs = new <DialogVO>[];
			_menuActions = new <ActionVO>[];
			_so = SharedObject.getLocal("settings");
			if(_so.size == 0){
				this.lastFileDirection = File.documentsDirectory;
			}else{
				this.lastFileDirection = new File(_so.data.lastFileDirection);
			}
			super();
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function getActionByType(type:String):ActionVO {
			return SearchUtils.findInVector(_menuActions, "type", type);
		}

		public function getDialogByType(type:String):DialogVO {
			return SearchUtils.findInVector(_dialogs, "type", type);
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

		public function get menuActions():Vector.<ActionVO> {
			return _menuActions;
		}

		public function get dialogs():Vector.<DialogVO> {
			return _dialogs;
		}

		public function get activeTool():String {
			return _activeTool;
		}

		public function set activeTool(value:String):void {
			_activeTool = value;
		}

		public function get lastFileDirection():File {
			return _lastFileDirection.clone();
		}

		public function set lastFileDirection(value:File):void {
			_lastFileDirection = value;
			_so.data.lastFileDirection = _lastFileDirection.nativePath;
			_so.flush();
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
