/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:10
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.bit101.components.VBox;
	import com.bit101.components.Window;

	import flash.display.DisplayObject;

	import flash.display.DisplayObjectContainer;

	public class WidgetWindow extends Window {

		private var _body:VBox;

		public function WidgetWindow(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, title:String = "Window") {
			super(parent, xpos, ypos, title);
			this.width = 150;
			_body = new VBox();
			_body.y = _body.x = 5;
			super .addChild(_body);
			this.initialize();
			this.hasMinimizeButton = true;
			this.enabled = false;
		}
		//==============================================================================
		//{region							PUBLIC METHODS

		override public function addChild(child:DisplayObject):DisplayObject {
			return _body.addChild(child);
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		protected function initialize():void{

		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		override public function set enabled(value:Boolean):void {
			super.enabled = value;
			this.minimized = !value;
		}

		public function set data(value:Object):void{

		}
//} endregion GETTERS/SETTERS ==================================================
	}
}
