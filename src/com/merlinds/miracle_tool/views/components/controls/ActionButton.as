/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:18
 */
package com.merlinds.miracle_tool.views.components.controls {
	import com.bit101.components.PushButton;
	import com.merlinds.miracle_tool.models.vo.ActionVO;

	import flash.display.DisplayObjectContainer;

	public class ActionButton extends PushButton {

		private var _action:ActionVO;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ActionButton(parent:DisplayObjectContainer = null, label:String = "", defaultHandler:Function = null) {
			super(parent, 0, 0, label, defaultHandler);
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

		public function get action():ActionVO {
			return _action;
		}

		public function set action(value:ActionVO):void {
			_action = value;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
