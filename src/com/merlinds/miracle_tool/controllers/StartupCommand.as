/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:20
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.views.AppMenuMediator;
	import com.merlinds.miracle_tool.views.AppMenuView;
	import com.merlinds.miracle_tool.views.alerts.AlertMediator;
	import com.merlinds.miracle_tool.views.alerts.AlertView;
	import com.merlinds.miracle_tool.views.project.ProjectMediator;
	import com.merlinds.miracle_tool.views.project.ProjectView;
	import com.merlinds.miracle_tool.views.project.ToolView;
	import com.merlinds.miracle_tool.views.project.ToolsMediator;

	import flash.utils.setTimeout;

	import org.robotlegs.base.ContextEvent;

	import org.robotlegs.mvcs.Command;

	public class StartupCommand extends Command {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function StartupCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute", "STARTUP");
			this.modelsMapping();
			this.controllersMapping();
			this.viewsMapping();
			log(this, "execute", "STARTUP_COMPLETE");
			//on next frame
			setTimeout(this.dispatch, 0, new ContextEvent(ContextEvent.STARTUP_COMPLETE));
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function modelsMapping():void {
			log(this, "modelsMapping");
		}

		private function controllersMapping():void {
			log(this, "controllersMapping");
			//map controllers
			this.injector.mapSingleton(ResizeController);
			//map commands
			this.commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, ViewInitializerCommand, ContextEvent, true);
		}

		private function viewsMapping():void {
			log(this, "viewsMapping");
			this.mediatorMap.mapView(AppMenuView, AppMenuMediator);
			this.mediatorMap.mapView(ProjectView, ProjectMediator);
			this.mediatorMap.mapView(ToolView, ToolsMediator);
			this.mediatorMap.mapView(AlertView, AlertMediator);
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
