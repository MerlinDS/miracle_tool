/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 23:17
 */
package com.merlinds.miracle_tool.views.alerts.dialogs {

	import com.merlinds.miracle_tool.views.components.containers.DialogWindow;

	import flash.display.DisplayObjectContainer;

	public class ProjectSettingDialog extends DialogWindow {

		public function ProjectSettingDialog(parent:DisplayObjectContainer, xpos:Number = 0, ypos:Number = 0) {
			super(parent, xpos, ypos, "Project settings");
		}
		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void {
			this.addInput("projectName", "Project Name");
			this.addInput("sceneWidth", "Screen width", "1024");
			this.addInput("sceneHeight", "Screen height", "768");
			this.addButton("Create", DialogWindow.ACCEPT);
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
