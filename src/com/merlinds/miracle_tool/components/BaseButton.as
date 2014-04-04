/**
 * User: MerlinDS
 * Date: 04.04.2014
 * Time: 16:20
 */
package com.merlinds.miracle_tool.components {
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class BaseButton extends SelectButton {

		public function BaseButton(name:String) {
			super();
			this.name = name;
			this.addEventListener(Event.ADDED_TO_STAGE, this.updateHandler);
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function updateHandler(event:Event):void {
			this.removeEventListener(event.type, arguments.callee);
			if(this.label != null){
				this.label.text = this.name;
			}
		}

		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
