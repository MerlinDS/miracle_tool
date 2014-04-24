/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 21:57
 */
package com.merlinds.miracle_tool.tools.editor {
	import com.merlinds.miracle_tool.models.AppModel;

	import flash.display.Sprite;
	import flash.events.Event;

	public class Editor extends Sprite {

		private var _model:AppModel;

		public function Editor(model:AppModel) {
			_model = model;
			this.addEventListener(Event.ADDED_TO_STAGE, this.initHandler);
			super();
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function initHandler(event:Event):void {
			this.removeEventListener(event.type, initHandler);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
