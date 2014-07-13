/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 3:22
 */
package com.merlinds.miracle_tool.views.logger {
	import com.bit101.components.HBox;
	import com.bit101.components.IndicatorLight;
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.merlinds.miracle_tool.views.interfaces.IResizable;

	import flash.display.DisplayObjectContainer;

	public class StatusBar extends Panel implements IResizable {

		private static const _label:Label = new Label();
		private static const _indicator:IndicatorLight = new IndicatorLight(null, 0, 4, 0xFF00FF00);
		private static var _errorWasOcure:Boolean;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function StatusBar(parent:DisplayObjectContainer) {
			super(parent, 0, 0);
			var body:HBox = new HBox(this);
			body.x = 10;
			body.addChild(_indicator);
			body.addChild(_label);
			_indicator.isLit = true;
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		override public function setSize(w:Number, h:Number):void {
			this.y = h;
			super.setSize(w, _label.height);
		}

		public static function log(...message):void {
			if(!_errorWasOcure){
				_label.text = "Log: " + message.join(" ");
				_indicator.color = 0xFF00FF00;
				_indicator.isLit = true;
			}
		}

		public static function warning(...message):void {
			if(!_errorWasOcure){
				_indicator.color = 0xFFFF9900;
				_indicator.flash(500);
				_label.text = "Warning: " + message.join(" ") + "!";
			}
		}

		public static function error(...message):void {
			_indicator.color = 0xFFFF0000;
			_indicator.flash(200);
			_label.text = "Error: " + message.join(" ") + "!";
			_errorWasOcure = true;
		}

		public static function fixed():void {
			_errorWasOcure = false;
			log("Ok!");
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public static function get height():int {
			return _label.height;
		}
		//} endregion GETTERS/SETTERS ==================================================
	}
}
