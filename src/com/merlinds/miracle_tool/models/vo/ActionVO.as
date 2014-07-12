/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:21
 */
package com.merlinds.miracle_tool.models.vo {
	public class ActionVO {

		private var _name:String;
		private var _action:Class;
		private var _type:String;
		//==============================================================================
		//{region							PUBLIC METHODS

		public function ActionVO(name:String, action:Class, type:String) {
			_name = name;
			_action = action;
			_type = type;
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

		public function get name():String {
			return _name;
		}

		public function get action():Class {
			return _action;
		}

		public function get type():String {
			return _type;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
