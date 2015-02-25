/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:20
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.controllers.placers.PlacerCommand;
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.services.ActionService;
	import com.merlinds.miracle_tool.services.DecodeService;
	import com.merlinds.miracle_tool.services.FileSystemService;
	import com.merlinds.miracle_tool.services.PublishingService;
	import com.merlinds.miracle_tool.views.AppMenuMediator;
	import com.merlinds.miracle_tool.views.AppMenuView;
	import com.merlinds.miracle_tool.views.alerts.AlertMediator;
	import com.merlinds.miracle_tool.views.alerts.AlertView;
	import com.merlinds.miracle_tool.views.project.ProjectMediator;
	import com.merlinds.miracle_tool.views.project.ProjectView;
	import com.merlinds.miracle_tool.views.project.ToolView;
	import com.merlinds.miracle_tool.views.project.ToolsMediator;
	import com.merlinds.miracle_tool.views.widgets.ItemInfoView;
	import com.merlinds.miracle_tool.views.widgets.ItemInfoMediator;
	import com.merlinds.miracle_tool.views.widgets.ProjectInfoView;
	import com.merlinds.miracle_tool.views.widgets.ProjectInfoMediator;
	import com.merlinds.miracle_tool.views.widgets.AnimationToolsView;
	import com.merlinds.miracle_tool.views.widgets.AnimationToolsMediator;
	import com.merlinds.miracle_tool.views.widgets.SheetToolsView;
	import com.merlinds.miracle_tool.views.widgets.SheetToolsView;
	import com.merlinds.miracle_tool.views.widgets.SheetToolsMediator;

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
			this.injector.mapSingleton(AppModel);
			this.injector.mapSingleton(FileSystemService);
			this.injector.mapSingleton(DecodeService);
			this.injector.mapSingleton(ActionService);
			this.injector.mapSingleton(PublishingService);
		}

		private function controllersMapping():void {
			log(this, "controllersMapping");
			//map controllers
			this.injector.mapSingleton(ResizeController);
			//map commands
			this.commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, AppInitCommand, ContextEvent, true);
			this.commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, ViewInitCommand, ContextEvent, true);
			//
			this.commandMap.mapEvent(EditorEvent.CREATE_PROJECT, CreateProjectCommand, EditorEvent);
			this.commandMap.mapEvent(EditorEvent.FILE_READ, FileDecodeCommand, EditorEvent);
			this.commandMap.mapEvent(EditorEvent.SOURCE_ATTACHED, SWFSeparatorCommand, EditorEvent);
			this.commandMap.mapEvent(EditorEvent.PLACE_ITEMS, PlacerCommand, EditorEvent);
			this.commandMap.mapEvent(EditorEvent.PREVIEW, PreviewCommand, EditorEvent);
		}

		private function viewsMapping():void {
			log(this, "viewsMapping");
			this.mediatorMap.mapView(AppMenuView, AppMenuMediator);
			this.mediatorMap.mapView(ProjectView, ProjectMediator);
			this.mediatorMap.mapView(ToolView, ToolsMediator);
			this.mediatorMap.mapView(AlertView, AlertMediator);
			//widgets
			this.mediatorMap.mapView(ProjectInfoView, ProjectInfoMediator);
			this.mediatorMap.mapView(ItemInfoView, ItemInfoMediator);
			this.mediatorMap.mapView(SheetToolsView, SheetToolsMediator);
			this.mediatorMap.mapView(AnimationToolsView, AnimationToolsMediator);
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
