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
		public function SaveProjectDialog(parent:DisplayObjectContainer, xpos:Number = 0, ypos:Number = 0) {
			super(parent, xpos, ypos, "Save project");
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void {
			this.addText("Current project will be closed. Do you want to save it?");
			this.addButton("Yes", DialogWindow.ACCEPT);
			this.addButton("No", DialogWindow.DENY);
			this.addButton("Cancel", DialogWindow.ACCEPT);

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
