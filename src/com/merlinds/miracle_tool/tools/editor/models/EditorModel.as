/**
 * User: MerlinDS
 * Date: 25.04.2014
 * Time: 21:16
 */
package com.merlinds.miracle_tool.tools.editor.models {
	import flash.display.MovieClip;

	public class EditorModel {

		private var _swf:MovieClip;

		public function EditorModel() {
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function get swf():flash.display.MovieClip {
			return _swf;
		}

		public function set swf(value:MovieClip):void {
			_swf = value;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
