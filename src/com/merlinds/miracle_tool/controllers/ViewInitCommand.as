/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:26
 */
package com.merlinds.miracle_tool.controllers {
	import com.bit101.components.Style;
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.view.interfaces.IResizable;
	import com.merlinds.miracle_tool.views.AppMenuView;
	import com.merlinds.miracle_tool.views.alerts.AlertView;

	import org.robotlegs.mvcs.Command;

	public class ViewInitCommand extends Command {

		[Inject]
		public var model:AppModel;
		[Inject]
		public var resizeController:ResizeController;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ViewInitCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			//setup style
			Style.setStyle(Style.DARK);
			//create views of the application and add it to stage and to resize controller
			this.resizeController.addInstance( this.contextView as IResizable );
			this.resizeController.addInstance( new AlertView(this.contextView) );
			this.resizeController.addInstance( new AppMenuView(this.contextView, model.menuActions) );
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
