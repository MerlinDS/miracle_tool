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
		/** HD720p - 1280×720 / 6:9 / 786,432 kpix**/
		public static const HD720p:int = 3;
		/** XGA - 1024×768 / 4:3 / 786,432 kpix**/
		public static const XGA:int = 4;
		/** Full HD - 1920×1080 / 16:9 / 2,07 mpix**/
		public static const FULL_HD:int = 6;
		/** Retina - 2048×1536 / 4:3 / **/
		public static const RETINA:int = 7;
		//==============================================================================
		//{region							PUBLIC METHODS
		/**
		 * throws flash.errors.IllegalOperationError Can not be instantiated !!!
		 */
		public function Resolutions() {
			throw new IllegalOperationError("Can not be instantiated");
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
				case HD720p: return "HD720p";
				default :return value > FULL_HD ? "Retina" : "Full HD";
			}
		}

		/**
		 * Return resolution value by it's name
		 * @param value Resolution name
		 * **/
		public static function fromString(value:String):int{
			switch (value){
				case "VGA": return VGA;
				case "XGA": return XGA;
				case "HD720p": return HD720p;
				case "Full HD": return FULL_HD;
				case "Retina": return RETINA;
				default: return QVGA;
			}
		}

		public static function width(resolution:int):int {
			switch (resolution){
				case 0: case QVGA: return 320;
				case VGA: return 640;
				case XGA: return 1024;
				case HD720p: return 1280;
				case RETINA: return 2048;
				default : return 1920;
			}
		}

		public static function height(resolution:int):int {
			switch (resolution){
				case 0: case QVGA: return 240;
				case VGA: return 480;
				case HD720p: return 720;
				case XGA: return 768;
				case RETINA: return 1536;
				default : return 1080;
			}
		}
		//} endregion PUBLIC METHODS ===================================================

	}
}
