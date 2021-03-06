/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:26
 */
package com.merlinds.miracle_tool.controllers {
	import com.bit101.components.Style;
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.services.ActionService;
	import com.merlinds.miracle_tool.views.AppMenuView;
	import com.merlinds.miracle_tool.views.AppView;
	import com.merlinds.miracle_tool.views.alerts.AlertView;
	import com.merlinds.miracle_tool.views.logger.StatusBar;
	import com.merlinds.miracle_tool.views.project.ToolView;

	import org.robotlegs.mvcs.Command;

	public class ViewInitCommand extends Command {

		[Inject]
		public var actionService:ActionService;
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
			var appView:AppView = new AppView(this.contextView);
			this.resizeController.addInstance( appView );
			this.resizeController.addInstance( new AlertView( this.contextView ) );//upper than all other views
			this.resizeController.addInstance( new AppMenuView( appView , this.actionService.actions) );
			this.resizeController.addInstance( new ToolView( this.contextView ) );
			this.resizeController.addInstance( new StatusBar( this.contextView ) );
			//add stage to resize controller for it's initialization
			this.resizeController.stage = this.contextView.stage;
			this.injector.mapValue(AppView, appView);
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