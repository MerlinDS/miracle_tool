/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:54
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.ActionEvent;
	import com.merlinds.miracle_tool.events.DialogEvent;
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.services.ActionService;
	import com.merlinds.miracle_tool.views.logger.StatusBar;
	import com.merlinds.unitls.Resolutions;

	import org.robotlegs.mvcs.Command;

	public class NewProjectCommand extends Command {

		[Inject]
		public var actionService:ActionService;
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
				this.actionService.addAcceptActions(new <String>[ActionEvent.SAVE_PROJECT,
					ActionEvent.CLOSE_PROJECT, this.event.type]);
				this.actionService.addDenyActions(new <String>[ActionEvent.CLOSE_PROJECT, this.event.type]);
				this.dispatch(new DialogEvent(DialogEvent.SAVE_PROJECT));
			}else{
				//parse event
				if(event.body == null){
					//open project setting dialog
					this.actionService.addAcceptActions(new <String>[this.event.type]);
					this.dispatch(new DialogEvent(DialogEvent.PROJECT_SETTINGS));
				}else{
					//create project view and add it to stage
					StatusBar.log("Create project");
					var projectName:String = this.event.body.projectName;
					if(projectName == null || projectName.length == 0){
						projectName = "Miracle project_" + new Date().time;//create unique name for project
					}
					var boundsOffset:int = int(this.event.body.boundsOffset);
					var resolution:int = Resolutions.fromString(this.event.body.choice);
					log(this, "execute", "Create project:", projectName,
							", Resolution = ", Resolutions.toString(resolution), "Bounds offset = ", boundsOffset);
					//see ProjectModel referenceSize
					this.dispatch(new EditorEvent(EditorEvent.CREATE_PROJECT,
							{projectName:projectName, referenceSize:resolution,
								boundsOffset:boundsOffset}));
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
