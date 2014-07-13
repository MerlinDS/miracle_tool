/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:58
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.models.ProjectModel;

	import org.robotlegs.mvcs.Mediator;

	internal class WidgetMediator extends Mediator {

		[Inject]
		public var appModel:AppModel;
		[Inject]
		public var projectModel:ProjectModel;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function WidgetMediator() {
			super();
		}

		override public final function onRegister():void {
			this.addContextListener(EditorEvent.PROJECT_OPEN, this.editorHandler);
			this.addContextListener(EditorEvent.PROJECT_CLOSED, this.editorHandler);
		}

		override public final function onRemove():void{
			this.removeContextListener(EditorEvent.PROJECT_OPEN, this.editorHandler);
			this.removeContextListener(EditorEvent.PROJECT_CLOSED, this.editorHandler);
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		protected function editorHandler(event:EditorEvent):void {
//			this.viewComponent.enabled = event.type == EditorEvent.PROJECT_OPEN;
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		protected function set data(value:Object):void{
			this.viewComponent.data = value;
		}
		//} endregion GETTERS/SETTERS ==================================================
	}
}
