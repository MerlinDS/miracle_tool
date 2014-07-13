/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:36
 */
package com.merlinds.miracle_tool.views.project {
	import com.bit101.components.Component;
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.AppModel;

	import flash.events.MouseEvent;

	import org.robotlegs.mvcs.Mediator;

	public class ToolsMediator extends Mediator {

		[Inject]
		public var _model:AppModel;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ToolsMediator() {
			super();
		}


		override public function onRegister():void {
			this.addContextListener(EditorEvent.PROJECT_OPEN, this.editorHandler);
			this.addViewListener(MouseEvent.CLICK, this.clickHandler);
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
		private function editorHandler(event:EditorEvent):void {
			if(event.type == EditorEvent.PROJECT_OPEN){
				(this.viewComponent as Component).enabled = true;
			}else if(event.type == EditorEvent.PROJECT_CLOSED){
				(this.viewComponent as Component).enabled = false;
			}
		}

		private function clickHandler(event:MouseEvent):void {
			_model.activeTool = this.viewComponent.activeTool;
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
