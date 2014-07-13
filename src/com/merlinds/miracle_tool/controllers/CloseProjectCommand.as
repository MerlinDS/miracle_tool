/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:56
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.debug.warning;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.views.logger.StatusBar;
	import com.merlinds.miracle_tool.views.AppView;

	import org.robotlegs.mvcs.Command;

	public class CloseProjectCommand extends Command {

		[Inject]
		public var appView:AppView;
		[Inject]
		public var projectModel:ProjectModel;
		//==============================================================================
		//{region							PUBLIC METHODS

		public function CloseProjectCommand() {
			super();
		}

		override public function execute():void {
			if(this.projectModel.name != ProjectModel.EMPTY)
			{
				log(this, "execute");
				this.injector.unmap(ProjectModel);
				this.appView.removeProject();
				this.injector.mapValue(ProjectModel, new ProjectModel(ProjectModel.EMPTY, null));
			}else{
				warning(this, "execute", "Trying to close empty project");
				StatusBar.warning("Trying to close empty project");
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
