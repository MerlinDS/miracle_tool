/**
 * User: MerlinDS
 * Date: 22.07.2014
 * Time: 21:18
 */
package com.merlinds.miracle_tool.utils {
	import flash.errors.IllegalOperationError;

	public class XMLConverters {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function XMLConverters() {
			throw new IllegalOperationError("Can not be instantiated!");
		}

		public static function convertToObject(value:XMLList, serializer:Class = null):* {
			var result:Object = serializer == null ? {} : new serializer();
			var attributes:XMLList = value.attributes();
			var n:int = attributes.length();
			for(var i:int = 0; i < n; i++){
				var attribute:XML = attributes[i];
				var propertyName:String = attribute.name();
				if(result.hasOwnProperty(propertyName)
						|| serializer == null){//If value is mutable object, than set new parameters to it
					result[propertyName] = attribute;
				}
			}
			return  result;
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
