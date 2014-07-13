/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:37
 */
package com.merlinds.miracle_tool.views.project {
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.view.logger.StatusBar;

	import org.robotlegs.mvcs.Mediator;

	public class ProjectMediator extends Mediator {

		[Inject]
		public var model:ProjectModel;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectMediator() {
			super();
		}

		override public function onRegister():void {
			super.onRegister();
			StatusBar.log("Project", model.name, "was created");
		}

		override public function onRemove():void {
			super.onRemove();
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
