/**
 * User: MerlinDS
 * Date: 18.07.2014
 * Time: 15:06
 */
package com.merlinds.miracle_tool.views.alerts.dialogs {
	import com.merlinds.miracle_tool.views.components.containers.DialogWindow;

	import flash.display.DisplayObjectContainer;

	public class PublishSettingsDialog  extends DialogWindow {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function PublishSettingsDialog(parent:DisplayObjectContainer, data:Object = null) {
			super(parent, data, "Publish settings");
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void {
			this.addInput("projectName", "Project Name");
			this.addInput("size", "Screen size", "1024");
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
