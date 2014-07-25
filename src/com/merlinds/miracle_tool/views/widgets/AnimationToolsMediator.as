/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:56
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.services.ActionService;

	public class AnimationToolsMediator extends WidgetMediator {

		[Inject]
		public var actionService:ActionService;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AnimationToolsMediator() {
			super();
		}

		override public function onRegister():void {
			this.addContextListener(EditorEvent.SELECT_SHEETS, this.selectHandler, EditorEvent);
			super.onRegister();
		}


		override public function onRemove():void {
			this.removeContextListener(EditorEvent.SELECT_SHEETS, this.selectHandler, EditorEvent);
			super.onRemove();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function selectHandler(event:EditorEvent):void {
			var name:String = event.body;
			this.viewComponent.enabled = name != null;
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
