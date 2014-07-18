/**
 * User: MerlinDS
 * Date: 18.07.2014
 * Time: 16:20
 */
package com.merlinds.miracle_tool.utils {
	import flash.errors.IllegalOperationError;

	public class MeshUtils {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function MeshUtils() {
			throw new IllegalOperationError("Can not be instantiated");
		}

		public static function covertToRelative(target:Vector.<Number>, outputSize:int):Vector.<Number>{
			var n:int = target.length;
			var result:Vector.<Number> = new <Number>[];
			result.length = n;
			for(var i:uint = 0; i < n; i++){
				result[i] = target[i]/outputSize;
			}
			return result;
		}

		public static function flipToY(target:Vector.<Number>):Vector.<Number>{
			var n:int = target.length;
			var result:Vector.<Number> = new <Number>[];
			result.length = n;
			for(var i:uint = 0; i < n; i++){
				result[i] = target[i];
				if(i%2==1)result[i] = result[i] * -1;
			}
			return result;
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
