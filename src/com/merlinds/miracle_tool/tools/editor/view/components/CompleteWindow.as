/**
 * User: MerlinDS
 * Date: 26.04.2014
 * Time: 12:56
 */
package com.merlinds.miracle_tool.tools.editor.view.components {

	import com.bit101.components.PushButton;
	import com.bit101.components.Window;
	import com.merlinds.miracle_tool.Config;

	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;

	public class CompleteWindow extends Window {
		public function CompleteWindow(parent:DisplayObjectContainer = null) {
			var stage:Stage = parent.stage;
			var x:int = stage.stageWidth - Config.windowWindth >> 1;
			var y:int = stage.stageHeight - Config.windowHeight >> 1;
			super(parent, x, y, "Complete");
		}

		//==============================================================================
		//{region							PUBLIC METHODS

		override protected function init():void {
			super.init();
			this.setSize(Config.windowWindth, Config.windowHeight);
			var button:PushButton = new PushButton(this, 0, 0, "OK", this.onClose);
			button.x = this.width - button.width >> 1;
			button.y = this.height - button.height >> 1;
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
		//} endregion GETTERS/SETTERS ==================================================
	}
}
