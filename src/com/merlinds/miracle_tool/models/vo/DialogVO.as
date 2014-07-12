/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 23:21
 */
package com.merlinds.miracle_tool.models.vo {
	public class DialogVO {

		private var _clazz:Class;
		private var _type:String;
		//==============================================================================
		//{region							PUBLIC METHODS
		/**
		 * Value Object for dialog windows
		 * @param clazz
		 * @param type Event type that must create dialog
		 */
		public function DialogVO(clazz:Class, type:String) {
			_clazz = clazz;
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

		public function get clazz():Class {
			return _clazz;
		}

		public function get type():String {
			return _type;
		}
		//} endregion GETTERS/SETTERS ==================================================
	}
}
