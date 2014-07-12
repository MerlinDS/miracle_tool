/**
 * User: MerlinDS
 * Date: 19.06.2014
 * Time: 17:44
 */
package com.merlinds.unitls.tar {
	public class TarEntry {

		private var _name:String;
		private var _size:int;
		private var _complete:Boolean;

		public function TarEntry(name:String, size:int) {
			_name = name;
			_size = size;
		}
		//==============================================================================
		//{region							PUBLIC METHODS
		public function toString():String {
			return "[object TarEntry( name = " + _name + ", size = " + _size + ")]";
		}

		internal function setComplete():void{
			_complete = true;
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

		public function get size():int {
			return _size;
		}

		public function get compete():Boolean {
			return _complete;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
