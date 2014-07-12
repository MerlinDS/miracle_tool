/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 23:40
 */
package com.merlinds.unitls.structures {
	import flash.errors.IllegalOperationError;

	public class SearchUtils {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function SearchUtils() {
			throw new IllegalOperationError("Can not be instantiate")
		}

		/**
		 * Method find instance in Vector or Array by it's parameter.
		 * @param target Vector or Array where need to search
		 * @param parameter Parameter on instances in target
		 * @param value Parameter must value to...
		 * @return Instance from the target where parameter will equals to value
		 *
		 * @throws ArgumentError If can not find parameter in instances of target
		 */
		public static function findInVector(target:Object, parameter:String, value:String):* {
			var result:Object;
			var n:int = target.length;
			for(var i:int = 0; i < n; i++){
				result = target[i];
				if(result[parameter] == value){
					break;
				}
				result = null;
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
