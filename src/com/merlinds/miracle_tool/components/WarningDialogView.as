/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 16:33
 */
package com.merlinds.miracle_tool.components {
	import com.merlinds.miracle_tool.services.FileManager;

	import flash.events.Event;
	import flash.events.MouseEvent;

	public class WarningDialogView extends WarningDialog {

		private var _text:String;

		public function WarningDialogView(text:String) {
			super();
			_text = text;
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
			this.message.text = _text;
			this.button.addEventListener(MouseEvent.CLICK, this.clickHandler);
		}

		private function clickHandler(event:MouseEvent):void {
			trace(this.message.text);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
