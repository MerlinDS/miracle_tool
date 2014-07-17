/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 23:17
 */
package com.merlinds.miracle_tool.views.alerts.dialogs {

	import com.merlinds.miracle_tool.views.components.containers.DialogWindow;

	import flash.display.DisplayObjectContainer;

	public class ProjectSettingDialog extends DialogWindow {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectSettingDialog(parent:DisplayObjectContainer, data:Object = null) {
			super(parent, data, "Project settings");
		}
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
