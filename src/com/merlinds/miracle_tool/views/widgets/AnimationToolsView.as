/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:01
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.bit101.components.List;
	import com.bit101.components.PushButton;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class AnimationToolsView extends WidgetWindow {

		private var _data:Object;

		private var _removeButton:PushButton;
		private var _addButton:PushButton;
		private var _list:List;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AnimationToolsView(parent:DisplayObjectContainer = null) {
			super(parent, 0, 0, "Animation Tools");
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void{
			_list = new List(this, 0, 0, null);
			_addButton = new PushButton(this, 0, 0, "Add animation", this.buttonHandler);
			_removeButton = new PushButton(this, 0, 0, "Remove animation", this.buttonHandler);
			this.height += 80;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function buttonHandler(event:MouseEvent):void {
			if(event.target == _removeButton){
				_data = _list.selectedItem;
			}else{
				_data = null;
			}
			this.dispatchEvent(new Event(Event.SELECT));
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		override public function get data():Object {
			return _data;
		}

		override public function set data(value:Object):void {
			super.data = value;
			if(value != null){
				_removeButton.enabled = true;
				_list.removeAll();
				while(value.length){
					_list.addItem(value.shift());
				}
				if(value.length == 0){
					_list.addItem(null);
				}
			}
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
