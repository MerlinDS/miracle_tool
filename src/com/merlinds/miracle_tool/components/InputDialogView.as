/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 16:33
 */
package com.merlinds.miracle_tool.components {
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class InputDialogView extends InputDialog {
		public function InputDialogView() {
			super();

			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStageHandler);
		}


		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function onAddToStageHandler(event:Event):void {
			this.removeEventListener(event.type, this.onAddToStageHandler);
			this.x = this.stage.stageWidth - this.width >> 1;
			this.y = this.stage.stageHeight - this.height >> 1;
			this.message.text = 'output';
			this.button.addEventListener(MouseEvent.CLICK, this.clickHandler);
		}

		private function clickHandler(event:MouseEvent):void {
			trace("SELECTED", this.message.text);
			this.dispatchEvent( new Event(Event.SELECT));
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
