/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:21
 */
package com.merlinds.miracle_tool.models.vo {
	public class ActionVO {

		private var _title:String;
		private var _event:Class;
		private var _type:String;
		//==============================================================================
		//{region							PUBLIC METHODS

		public function ActionVO(title:String, event:Class, type:String) {
			_title = title;
			_event = event;
			_type = type;
		}

		public function toString():String {
			return "[ActionVO(type = " + _type + ")]";
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

		public function get title():String {
			return _title;
		}

		public function get event():Class {
			return _event;
		}

		public function get type():String {
			return _type;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
