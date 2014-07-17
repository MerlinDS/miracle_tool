/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 20:00
 */
package com.merlinds.miracle_tool.views.alerts.dialogs {
	import com.merlinds.miracle_tool.views.components.containers.DialogWindow;

	import flash.display.DisplayObjectContainer;

	public class SaveProjectDialog extends DialogWindow {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function SaveProjectDialog(parent:DisplayObjectContainer, data:Object = null) {
			super(parent, data, "Save project");
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void {
			this.addText("Current project will be closed. Do you want to save it?");
			this.addButton("Yes", DialogWindow.ACCEPT);
			this.addButton("No", DialogWindow.DENY);
			this.addButton("Cancel", DialogWindow.CANCEL);

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
