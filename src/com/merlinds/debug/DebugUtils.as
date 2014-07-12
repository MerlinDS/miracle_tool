/**
 * User: MerlinDS
 * Date: 17.03.14
 * Time: 22:36
 */
package com.merlinds.debug {
	import flash.utils.getTimer;

	internal class DebugUtils {

		public static const ERROR_LOG:String = "ERROR";
		public static const WARNING_LOG:String = "WARNING";
		public static const NOTE_LOG:String = "NOTE";

		public function DebugUtils() {
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public static function writeLog(instance:Object, method:String, level:String, message:Array = null):void {
			var target:String = instance.toString();
			target = target.substr(0, target.length - 1) + "." + method + "()]";
			var timestamp:Number = getTimer() * .001;
			message.unshift(timestamp.toFixed(4), level, target);
			trace.apply(null, message);
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
