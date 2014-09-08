/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 23:17
 */
package com.merlinds.miracle_tool.views.alerts.dialogs {

	import com.merlinds.miracle_tool.views.components.containers.DialogWindow;
	import com.merlinds.unitls.Resolutions;

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
			var resolutions:Array = [
				Resolutions.toString(Resolutions.RETINA),
				Resolutions.toString(Resolutions.FULL_HD),
				Resolutions.toString(Resolutions.XGA),
				Resolutions.toString(Resolutions.VGA),
				Resolutions.toString(Resolutions.QVGA)
			];
			this.addBr();
			this.addInput("projectName", "Project Name");
			this.addComboBox("Chose resolution", resolutions);
			this.addInput("boundsOffset", "Bounds offset", "0");
			//TODO MF-28 Add bound offset to project setting dialog
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
