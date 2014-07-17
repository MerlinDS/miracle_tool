/**
 * User: MerlinDS
 * Date: 17.07.2014
 * Time: 13:08
 */
package com.merlinds.miracle_tool.views.alerts.dialogs {
	import com.merlinds.miracle_tool.views.components.containers.DialogWindow;

	import flash.display.DisplayObjectContainer;

	public class ChooseAnimationDialog extends DialogWindow {


		//==============================================================================
		//{region							PUBLIC METHODS
		public function ChooseAnimationDialog(parent:DisplayObjectContainer, data:Object = null) {
			super(parent, data, "Choose animation");
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void {
			this.addList();
			this.addButton("Choose", DialogWindow.ACCEPT);
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
