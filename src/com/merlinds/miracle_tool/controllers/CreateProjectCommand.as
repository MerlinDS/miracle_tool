/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 20:54
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.services.ActionService;
	import com.merlinds.miracle_tool.services.FileSystemService;
	import com.merlinds.miracle_tool.views.AppView;
	import com.merlinds.miracle_tool.views.project.ProjectView;
	import com.merlinds.miracle_tool.views.widgets.ProjectWidgets;

	import org.robotlegs.mvcs.Command;

	public class CreateProjectCommand extends Command {

		[Inject]
		public var appView:AppView;
		[Inject]
		public var resizeController:ResizeController;
		[Inject]
		public var actionService:ActionService;
		[Inject]
		public var fileSystemService:FileSystemService;
		[Inject]
		public var event:EditorEvent;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function CreateProjectCommand() {
			super();
		}

		override public function execute():void {
			//create model for project
			var projectName:String = this.event.body.projectName;
			var referenceSize:int = this.event.body.referenceSize;

			var projectModel:ProjectModel = new ProjectModel(projectName, referenceSize);
			projectModel.boundsOffset = this.event.body.boundsOffset;
			//
			this.injector.mapValue(ProjectModel, projectModel);
			projectModel.eventDispatcher = this.eventDispatcher;
			this.resizeController.addInstance(new ProjectWidgets(this.contextView));
			//create view for project
			var view:ProjectView = new ProjectView(projectModel.name, this.appView);
			this.resizeController.addInstance(view);
			this.actionService.done();
			this.fileSystemService.readProjectSources(this.event.body.sources);
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
