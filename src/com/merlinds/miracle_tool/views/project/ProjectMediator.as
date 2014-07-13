/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:37
 */
package com.merlinds.miracle_tool.views.project {
	import com.merlinds.miracle_tool.events.ActionEvent;
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.models.vo.ActionVO;
	import com.merlinds.miracle_tool.utils.dispatchAction;
	import com.merlinds.miracle_tool.views.logger.StatusBar;

	import flash.events.Event;

	import org.robotlegs.mvcs.Mediator;

	public class ProjectMediator extends Mediator {

		[Inject]
		public var model:ProjectModel;
		[Inject]
		public var appModel:AppModel;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectMediator() {
			super();
		}

		override public function onRegister():void {
			StatusBar.log("Project", model.name, "was created");
			this.dispatch(new EditorEvent(EditorEvent.PROJECT_OPEN));
			this.addViewListener(Event.CLOSE, this.closeHandler);
			this.addContextListener(EditorEvent.SOURCE_ATTACHED, this.editorHandler);

		}

		override public function onRemove():void {
			this.removeViewListener(Event.CLOSE, this.closeHandler);
			StatusBar.log("Project", model.name, "was closed");
			this.dispatch(new EditorEvent(EditorEvent.PROJECT_CLOSED));
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function closeHandler(event:Event):void {
			var vo:ActionVO = this.appModel.getActionByType(ActionEvent.CLOSE_PROJECT);
			dispatchAction(vo, this.dispatch);
		}

		private function editorHandler(event:EditorEvent):void {
			//TODO add sheet view to the project view and execute packer command
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
