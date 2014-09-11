/**
 * User: MerlinDS
 * Date: 11.09.2014
 * Time: 18:41
 */
package com.merlinds.miracle_tool.controllers.converters {
	import com.merlinds.miracle.meshes.Color;
	import com.merlinds.unitls.ColorUtils;

	/**
	 * The XMLColorConverter class present color transformations from the XML to Miracle format.
	 * In miracle engine this object will be downloaded as Color object and gives to shader color transformations data.
	 *
	 * @see com.merlinds.miracle.meshes.Color
	 **/
	public class XMLColorConverter extends Color{
		//constants Color node attributes that need convert to Color parameters
		private static const BRIGHTNESS_TAG:String = "brightness";
		private static const TINT_MULTIPLIER:String = "tintMultiplier";
		private static const TINT_COLOR:String = "tintColor";
		//auxiliary constants
		private static const ALPHA_PREFIX:String = "alpha";
		private static const MULTIPLIER_POSTFIX:String = "Multiplier";
		//==============================================================================
		//{region							PUBLIC METHODS
		public function XMLColorConverter(xml:XMLList) {
			super();
			/* Get attributes from Color node
			 * Node example:
			 * Additional =
			 * <Color alphaMultiplier="0.5"
			 *      redMultiplier="0.69921875"
			 *      blueMultiplier="0.69921875"
			 *      greenMultiplier="0.69921875"
			 *      redOffset="2"
			 *      blueOffset="200"
			 *      greenOffset="2"
			 *      alphaOffset="255"
			 * />
			 *  Tint = <Color tintMultiplier="0.43" tintColor="#289AB6"/>
			 *  Brightness = <Color brightness="0.44"/>
			 *  Alpha = <Color alphaMultiplier="0.37109375"/>
			 */
			var attributes:XMLList = xml.attributes();
			if(attributes.length() > 0){
				this.parseXML(attributes);
			}else{
				//no color transformations
				this.type = NONE;
			}
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function parseXML(xml:XMLList):void {
			var n:int = xml.length();
			for(var i:int = 0; i < n; i++){
				var name:String = xml[i].name();
				var attribute:* = xml[i];
				if(this.hasOwnProperty(name)) {
					//write attribute value to parameter without deep conversions
					if(name.lastIndexOf(MULTIPLIER_POSTFIX) < 0){//this is offset attribute
						/*
						 * In xml Color node color in offsets has form (-255, 255).
						 * Need to covert it to (-1, 1) form
						 */
						attribute = attribute / 255;
					}else{
						if(name.lastIndexOf(ALPHA_PREFIX) > -1){
							//Need to revert alpha
							attribute = 1 - attribute;
						}
					}
					this[name] = attribute;
				}else{
					/* Color node has unique attributes that need to be converted to Color parameters */
					if(name == TINT_COLOR){
						this.covertTintColor(attribute);
					}else if(name == TINT_MULTIPLIER){
						//tint multiplier spreads for all channels except alpha chanel
						this.redMultiplier = this.greenMultiplier = this.blueMultiplier = attribute;
					}else if(name == BRIGHTNESS_TAG){
						//brightness multiplier spreads for all channels except alpha chanel
						this.redMultiplier = this.greenMultiplier = this.blueMultiplier = attribute;
						//all channels offset equals 255 channels except alpha chanel
						this.redOffset = this.greenOffset = this.blueOffset = 1;
					}
				}
			}
			//define color transformation type
			if(this.alphaMultiplier + this.alphaOffset > 0){
				this.type += ALPHA;
			}
			if(this.redMultiplier + this.greenMultiplier + this.blueMultiplier +
					this.redOffset + this.greenOffset + this.blueOffset > 0){
				this.type += COLOR;
			}
			//in other case Color type is none
		}

		private function covertTintColor(hex:String):void{
			//convert string color to hex. Example: from #FF000000 to 0xFF000000.
			hex = hex.replace("#", "0x");
			trace(uint(hex).toString(16));
			this.redOffset = ColorUtils.extractRed( uint(hex) ) / 255;
			this.greenOffset = ColorUtils.extractGreen( uint(hex) ) / 255;
			this.blueOffset = ColorUtils.extractBlue( uint(hex) ) / 255;
			//in this case alpha channel do not transform
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
