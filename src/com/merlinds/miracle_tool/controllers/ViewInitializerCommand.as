/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:26
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.views.AppMenuView;
	import com.merlinds.miracle_tool.views.alerts.AlertView;

	import org.robotlegs.mvcs.Command;

	public class ViewInitializerCommand extends Command {

		[Inject]
		public var resizeController:ResizeController;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ViewInitializerCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			//create views of the application and add it to stage and to resize controller
			this.resizeController.addInstance( new AlertView(this.contextView) );
			this.resizeController.addInstance( new AppMenuView(this.contextView) );
			//add stage to resize controller for it's initialization
			this.resizeController.stage = this.contextView.stage;
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
