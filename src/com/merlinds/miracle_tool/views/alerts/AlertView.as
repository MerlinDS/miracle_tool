/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:38
 */
package com.merlinds.miracle_tool.views.alerts {
	import com.merlinds.miracle_tool.view.interfaces.IResizable;
	import com.merlinds.miracle_tool.views.components.containers.DialogWindow;

	import flash.display.DisplayObject;

	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;

	public class AlertView extends Sprite implements IResizable{

		private var _dialogs:Sprite;
		private var _modalBlocker:Shape;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AlertView(parent:DisplayObjectContainer = null) {
			super();
			_modalBlocker = super.addChild(new Shape()) as Shape;
			_dialogs = super.addChild(new Sprite()) as Sprite;
			parent.addChild(this);
		}

		public function setSize(w:Number, h:Number):void {
			this.visible = false;
			_modalBlocker.graphics.clear();
			_modalBlocker.graphics.beginFill(0x000000, 0.3);
			_modalBlocker.graphics.drawRect(0, 0, w, h);
			_modalBlocker.graphics.endFill();
			_modalBlocker.visible = false;
			if(_dialogs.numChildren > 0){
				for(var i:int = 0; i < _dialogs.numChildren; i++){
					var child:DisplayObject = _dialogs.getChildAt(i);
					child.x = this.width - child.width >> 1;
					child.y = this.height - child.height >> 1;
				}
				_dialogs.visible =  true;
			}
		}

		override public function addChild(child:DisplayObject):DisplayObject {
			child.addEventListener(Event.ADDED_TO_STAGE, this.childAddedHandler);
			return _dialogs.addChild(child);
		}


		override public function removeChild(child:DisplayObject):DisplayObject {
			// when super.removeChild will be executed numChildren will be equals 0
			if(_dialogs.numChildren == 1){
				this.visible =  false;
			}
			return _dialogs.removeChild(child);
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function childAddedHandler(event:Event):void {
			var child:DisplayObject = event.target as DisplayObject;
			child.removeEventListener(Event.ADDED_TO_STAGE, this.childAddedHandler);
			//only on next frame//Hack for minimal comps
			setTimeout(function():void{
				child.x = width - child.width >> 1;
				child.y = height - child.height >> 1;
				visible = true;
				_modalBlocker.visible = (child as DialogWindow).modal;
			}, 0);
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
