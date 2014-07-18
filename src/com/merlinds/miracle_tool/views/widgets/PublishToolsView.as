/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:01
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.bit101.components.CheckBox;
	import com.bit101.components.PushButton;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.Event;

	public class PublishToolsView extends WidgetWindow {

		private var _data:Object;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function PublishToolsView(parent:DisplayObjectContainer = null) {
			super(parent, 0, 0, "Publish Tools");
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void{
			new PushButton(this, 0, 0, "Publish", this.publishHandler);
			new PushButton(this, 0, 0, "Preview", this.previewHandler);

		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function publishHandler(event:Event):void {
			_data = 0;
			this.dispatchEvent(new Event(Event.SELECT));
		}

		private function previewHandler(event:Event):void {
			_data = 1;
			this.dispatchEvent(new Event(Event.SELECT));
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		override public function get data():Object {
			return _data;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
