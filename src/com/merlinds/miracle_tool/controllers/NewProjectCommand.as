/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:54
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.ActionEvent;
	import com.merlinds.miracle_tool.events.DialogEvent;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.models.vo.ActionVO;
	import com.merlinds.miracle_tool.view.logger.StatusBar;
	import com.merlinds.miracle_tool.views.AppView;
	import com.merlinds.miracle_tool.views.project.ProjectView;

	import flash.events.Event;

	import flash.geom.Point;

	import org.robotlegs.mvcs.Command;

	public class NewProjectCommand extends Command {

		[Inject]
		public var appModel:AppModel;
		[Inject]
		public var appView:AppView;
		[Inject]
		public var resizeController:ResizeController;
		[Inject]
		public var event:ActionEvent;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function NewProjectCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute", event);
			if(this.injector.hasMapping(ProjectModel)){
				//need to save and remove project
				//TODO:Check for existing project
				StatusBar.warning("New project is exist");
			}else{
				//parse event
				if(event.body == null){
					//open project setting dialog
					var actionVO:ActionVO = this.appModel.getActionByType(this.event.type);
					this.dispatch(new DialogEvent(DialogEvent.PROJECT_SETTINGS, actionVO));
				}else{
					//create project view and add it to stage
					StatusBar.log("Create project");
					var projectName:String = this.event.body.projectName;
					if(projectName == null || projectName.length == 0){
						projectName = "Miracle project_" + new Date().time;//create unique name for project
					}
					var sceneSize:Point = new Point(this.event.body.sceneWidth, this.event.body.sceneHeight);
					//quote size to normal
					sceneSize.x = sceneSize.x <= 0 ? 1024 : sceneSize.x;
					sceneSize.y = sceneSize.y <= 0 ? 768 : sceneSize.y;
					log(this, "execute", "Create project:", projectName, ", Scene size = ", sceneSize);
					//create model for project
					var model:ProjectModel = new ProjectModel(projectName, sceneSize);
					this.injector.mapValue(ProjectModel, model);
					//create view for project
					var view:ProjectView = new ProjectView(model.name, this.appView);
					this.resizeController.addInstance(view);
				}
			}
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
