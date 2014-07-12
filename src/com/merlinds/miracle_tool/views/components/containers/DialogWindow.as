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

		public static const ACCEPT:String = "accept";
		public static const DENY:String = "deny";

		private var _modal:Boolean;
		private var _closeCallback:Function;
		private var _closeReason:String;
		private var _data:*;


		public function DialogWindow(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, title:String = "Window") {
			super(parent, xpos, ypos, title);
			_closeReason = DENY;
			this.setSize(400, 300);
			this.hasCloseButton = true;
			this.hasMinimizeButton = false;
			this.initialize();
		}
		//==============================================================================
		//{region							PUBLIC METHODS

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		protected function initialize():void{
			//abstract
		}

		protected final function close(closeReason:String, data:* = null):void{
			_closeReason = closeReason;
			_data = data;
			this.onClose(new MouseEvent(MouseEvent.CLICK));
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS

		override protected function onClose(event:MouseEvent):void {
			if(_closeCallback is Function){
				_closeCallback.apply(this, [_closeReason, _data]);
			}
			super.onClose(event);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function set closeCallback(value:Function):void {
			_closeCallback = value;
		}

		public function get modal():Boolean {
			return _modal;
		}

		public function set modal(value:Boolean):void {
			_modal = value;
			this.draggable = !_modal;
			this.hasMinimizeButton = !_modal;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
