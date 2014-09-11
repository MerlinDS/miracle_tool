/**
 * User: MerlinDS
 * Date: 11.09.2014
 * Time: 19:22
 */
package com.merlinds.unitls {
	import flash.errors.IllegalOperationError;

	/**
	 * Utilities class that helps with color
	 */
	public class ColorUtils {

		//==============================================================================
		//{region							PUBLIC METHODS
		/**
		 * @private
		 * Constructor
		 * @throws flash.errors.IllegalOperationError This class can not be instantiated!
		 */
		public final function ColorUtils() {
			throw new IllegalOperationError("This class can not be instantiated!");
		}

		/**
		 * Extract red channel from the color
		 * @param color Channel will be extracted from specified color
		 * @return Value of the red chanel
		 */
		public static function extractRed(color:uint):uint {
			return (( color >> 16 ) & 0xFF);
		}
		/**
		 * Extract green channel from the color
		 * @param color Channel will be extracted from specified color
		 * @return Value of the green chanel
		 */
		public static function extractGreen(color:uint):uint {
			return ( (color >> 8) & 0xFF );
		}
		/**
		 * Extract blue channel from the color
		 * @param color Channel will be extracted from specified color
		 * @return Value of the blue chanel
		 */
		public static function extractBlue(color:uint):uint {
			return ( color & 0xFF );
		}
		//} endregion PUBLIC METHODS ===================================================
	}
}
