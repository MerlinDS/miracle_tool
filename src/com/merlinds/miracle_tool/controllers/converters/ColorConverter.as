/**
 * User: MerlinDS
 * Date: 10.09.2014
 * Time: 14:08
 */
package com.merlinds.miracle_tool.controllers.converters {
	import com.merlinds.debug.log;

	public class ColorConverter {

		/** Index of red color **/
		private static const R:int = 0;
		/** Index of green color **/
		private static const G:int = 1;
		/** Index of blue color **/
		private static const B:int = 2;
		/** Index of alpha chanel **/
		private static const A:int = 3;

		private var _color:Array;//RGBA
		private var _colorEffect:ColorEffect;
		private var _methods:Vector.<Function>;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ColorConverter() {
			_methods = new <Function>[this.brightness, this.alpha, this.tint, this.additional];
		}

		public function convertToArray(xml:XMLList):Array {
			_color = [0, 0, 0, 1];
			/* get attributes from Color node
			 * Node example:
			 * Additional =
			 * <Color alphaMultiplier="0.5"
			 *      redMultiplier="0.69921875"
			 *      blueMultiplier="0.69921875"
			 *      greenMultiplier="0.69921875"
			 *      redOffset="2"
			 *      blueOffset="2"
			 *      greenOffset="2"
			 * />
			 *  Tint = <Color tintMultiplier="0.43" tintColor="#289AB6"/>
			 *  Brightness = <Color brightness="0.44"/>
			 *  Alpha = <Color alphaMultiplier="0.37109375"/>
			 */
			var attributes:XMLList = xml.attributes();
			_colorEffect = new ColorEffect(attributes);
			if(_colorEffect.type != ColorEffect.NONE){
				var method:Function = _methods[_colorEffect.type];
				method.apply(this);
			}
			trace(_color);
			return _color;
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function alpha():void {
			log(this, "alpha");
			if(!isNaN(_colorEffect.alphaMultiplier)){
				_color[A] = _colorEffect.alphaMultiplier;
			}
		}

		private function brightness():void {
			log(this, "brightness");
			_color[R] = _color[G] = _color[B] = _colorEffect.brightness;
		}

		private function tint():void {
			log(this, "tint");
		}

		private function additional():void {
			log(this, "additional");
			this.alpha();//In colorEffect can be alpha multiplier
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
class ColorEffect{

	public static const NONE:int = -1;
	public static const BRIGHTNESS:int = 0;
	public static const ALPHA:int = 1;
	public static const TINT:int = 2;
	public static const ADDITIONAL:int = 3;

	private var _type:int;

	public var alphaMultiplier:Number;
	public var brightness:Number;
	public var tintMultiplier:Number;
	public var tintColor:uint;
	public var redMultiplier:Number;
	public var redOffset:Number;
	public var blueMultiplier:Number;
	public var blueOffset:Number;
	public var greenMultiplier:Number;
	public var greenOffset:Number;

	public function ColorEffect(data:XMLList) {
		for(var i:int = 0; i < data.length(); i++){
			var name:String = data[i].name();
			if(this.hasOwnProperty(name)){
				this[name] = data[i];
			}
		}
		//define type of the color effect
		_type = NONE;
		if(!isNaN(this.brightness)){
			_type = BRIGHTNESS;
		}
		if(!isNaN(this.alphaMultiplier)){
			_type = ALPHA;
		}
		if(tintColor > 0 || !isNaN(this.tintMultiplier)){
			_type = TINT;
		}
		if(!isNaN(this.redMultiplier) ||
				!isNaN(this.redOffset) ||
				!isNaN(this.blueMultiplier) ||
				!isNaN(this.blueOffset) ||
				!isNaN(this.greenMultiplier) ||
				!isNaN(this.greenOffset)){
			_type = ADDITIONAL;
		}
	}

	public function toString():String {
		return "[object ColorEffect(type = "+ _type + ")]";
	}

	public function get type():int {
		return _type;
	}
}
