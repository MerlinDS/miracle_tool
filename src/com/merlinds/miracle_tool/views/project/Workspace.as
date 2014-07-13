/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 2:09
 */
package com.merlinds.miracle_tool.views.project {
	import com.bit101.components.FPSMeter;
	import com.bit101.components.Window;
	import com.bit101.components.Window;
	import com.merlinds.miracle_tool.views.interfaces.IResizable;

	import flash.display.BitmapData;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class Workspace extends Sprite implements IResizable{

		[Embed(source="../../../../../../assets/backgound.png", mimeType="image/png")]
		private static var Background:Class;

		private var _bg:BitmapData;
		private var _fps:FPSMeter;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function Workspace(parent:DisplayObjectContainer) {
			super();
			_bg = new Background().bitmapData;
			parent.addChild(this);
			_fps = new FPSMeter(this);
		}

		public function setSize(w:Number, h:Number):void {
			this.graphics.clear();
			this.graphics.beginBitmapFill(_bg);
			this.graphics.drawRect(0, 0, w, h);
			this.graphics.endFill();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
