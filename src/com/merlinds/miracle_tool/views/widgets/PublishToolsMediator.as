/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:56
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.ActionEvent;
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.services.ActionService;

	import flash.events.Event;

	public class PublishToolsMediator extends WidgetMediator {

		[Inject]
		public var actionService:ActionService;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function PublishToolsMediator() {
			super();
		}

		override public function onRegister():void {
			this.addViewListener(Event.SELECT, this.selectHandler);
			this.addContextListener(EditorEvent.SOURCE_ATTACHED, this.editorHandler);
			super.onRegister();
		}


		override public function onRemove():void {
			this.removeViewListener(Event.SELECT, this.selectHandler);
			this.removeContextListener(EditorEvent.SOURCE_ATTACHED, this.editorHandler);
			super.onRemove();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		override protected function editorHandler(event:EditorEvent):void {
			log(this, "editorHandler");
			super.editorHandler(event);
			this.viewComponent.enabled = true;
		}

		private function selectHandler(event:Event):void {
			log(this, "selectHandler", this.viewComponent.data);
			if(this.viewComponent.data == 0){
				this.dispatch( new ActionEvent(ActionEvent.PUBLISHING ));
			}else{
				//Open preview window
				this.dispatch( new EditorEvent(EditorEvent.PREVIEW))
			}
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
