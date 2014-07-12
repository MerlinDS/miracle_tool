/**
 * User: MerlinDS
 * Date: 10.06.2014
 * Time: 21:49
 */
package com.merlinds.unitls {
	import flash.errors.IllegalOperationError;

	/** Screen resolutions type **/
	public class Resolutions {
		private static const SMALLEST_WIDTH:int = 320;
		/** QVGA - 320×240 / 4:3 / 76,8 kpix**/
		public static const QVGA:int = 1;
		/** VGA - 640×480 / 4:3 / 307,2 kpix**/
		public static const VGA:int = 2;
		/** XGA - 1024×768 / 4:3 / 786,432 kpix**/
		public static const XGA:int = 4;
		/** Full HD - 1920×1080 / 16:9 / 2,07 mpix**/
		public static const FULL_HD:int = 6;
		//TODO: Add retina display
		//==============================================================================
		//{region							PUBLIC METHODS
		/**
		 * throws flash.errors.IllegalOperationError Can not be instantiated !!!
		 */
		public function Resolutions() {
			throw new IllegalOperationError("Can not be instantiated");
		}

		/**
		 * Closest resolution in value by Width
		 * @param value Width of the resolution
		 */
		public static function closestInValue(value:Number):int {
			value = Math.ceil(value / SMALLEST_WIDTH);
			if(value < QVGA)value = 1;
			else if(value > VGA && value < FULL_HD)value = XGA;
			else if(value >= FULL_HD)value = FULL_HD;
			return value;
		}

		/**
		 * Return resolution name by it's value
		 * @param value Resolution value
		 * **/
		public static function toString(value:int):String{
			switch (value){
				case 0: case QVGA: return "QVGA";
				case VGA: return "VGA";
				case XGA: return "XGA";
				default : return "Full_HD";
			}
		}

		public static function width(resolution:int):int {
			switch (resolution){
				case 0: case QVGA: return 320;
				case VGA: return 640;
				case XGA: return 1024;
				default : return 1920;
			}
		}

		public static function height(resolution:int):int {
			switch (resolution){
				case 0: case QVGA: return 240;
				case VGA: return 480;
				case XGA: return 768;
				default : return 1080;
			}
		}
		//} endregion PUBLIC METHODS ===================================================

	}
}
