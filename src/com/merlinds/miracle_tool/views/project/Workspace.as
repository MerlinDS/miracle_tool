/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 2:09
 */
package com.merlinds.miracle_tool.views.project {
	import com.bit101.components.Component;
	import com.merlinds.miracle_tool.views.interfaces.IResizable;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class Workspace extends Component implements IResizable{

		[Embed(source="../../../../../../assets/backgound.png", mimeType="image/png")]
		private static var Background:Class;

		private var _bg:BitmapData;
		private var _body:DisplayObjectContainer;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function Workspace(parent:DisplayObjectContainer) {
			_bg = new Background().bitmapData;
			_body = super .addChild(new Sprite()) as DisplayObjectContainer;
			parent.addChild(this);
		}

		override public function setSize(w:Number, h:Number):void {
			this.x = w - this.width >> 1;
			this.y = h - this.height>> 1;
		}

		override public function addChild(child:DisplayObject):DisplayObject {
			return _body.addChild(child);
		}

		public function clear():void {
			_body.removeChildren();
		}

		public function scale(value:Number):void {
			_body.scaleX = value;
			_body.scaleY = value;
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function updateBg():void {
			if(_bg != null){
				this.graphics.clear();
				this.graphics.beginBitmapFill(_bg);
				this.graphics.drawRect(0, 0, this.width, this.height);
				this.graphics.endFill();
			}
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		override public function set width(w:Number):void {
			super.width = w;
			this.updateBg();
		}

		override public function set height(h:Number):void {
			super.height = h;
			this.updateBg();
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
