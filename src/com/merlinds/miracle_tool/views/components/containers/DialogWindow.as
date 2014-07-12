/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 23:19
 */
package com.merlinds.miracle_tool.views.components.containers {
	import com.bit101.components.Window;

	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	public class DialogWindow extends Window {

		private var _closeCallback:Function;

		public function DialogWindow(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, title:String = "Window") {
			super(parent, xpos, ypos, title);
		}
		//==============================================================================
		//{region							PUBLIC METHODS

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS

		override protected function onClose(event:MouseEvent):void {
			super.onClose(event);
			if(_closeCallback is Function){
				_closeCallback.apply(this);
			}
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function set closeCallback(value:Function):void {
			_closeCallback = value;
		}

		public function get data():* {
			return null;
		}
//} endregion GETTERS/SETTERS ==================================================
	}
}
