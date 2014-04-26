/**
 * User: MerlinDS
 * Date: 26.04.2014
 * Time: 14:13
 */
package com.merlinds.miracle_tool.components {
	import com.bit101.components.Text;
	import com.bit101.components.Window;

	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;

	public class ErrorWindown extends Window {

		private var _error:Error;

		public function ErrorWindown(parent:DisplayObjectContainer, error:Error) {
			_error = error;
			var stage:Stage = parent.stage;
			var x:int = stage.stageWidth - 200 >> 1;
			var y:int = stage.stageHeight - 150 >> 1;
			super(parent, x, y, "Error!!!");
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function init():void {
			super.init();
			this.shadow = false;
			this.setSize(200, 150);
			var text:Text = new Text(this, 0, 0, _error.errorID + " : " + _error.message);
			text.selectable = false;
			text.editable = false;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
