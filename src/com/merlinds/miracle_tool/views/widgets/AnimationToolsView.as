/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:01
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.bit101.components.CheckBox;
	import com.bit101.components.List;
	import com.bit101.components.PushButton;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.Event;

	public class AnimationToolsView extends WidgetWindow {

		private var _data:Object;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AnimationToolsView(parent:DisplayObjectContainer = null) {
			super(parent, 0, 0, "Animation Tools");
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void{
			new List(this, 0, 0, []);
			new PushButton(this, 0, 0, "Add animation");
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		override public function get data():Object {
			return _data;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
