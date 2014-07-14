/**
 * User: MerlinDS
 * Date: 14.07.2014
 * Time: 21:49
 */
package com.merlinds.miracle_tool.controllers.placers {
	import flash.errors.IllegalOperationError;

	internal class PlacerAlgorithmClassList {

		private static var algorithms:Object;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function PlacerAlgorithmClassList() {
			throw new IllegalOperationError("Can not be instantiated!");
		}

		public static function getAlgorithm(name:String):PlacerAlgorithm{
			var algorithm:PlacerAlgorithm;
			if(algorithms.hasOwnProperty(name)){
				var algorithmClass:Class = algorithms[name];
				algorithm = new algorithmClass;
			}
			return algorithm;
		}
		//} endregion PUBLIC METHODS ===================================================
		{
			algorithms = {};
			algorithms[PlacerAlgorithmList.MAX_RECT] = MaxRectAlgorithm;
		}
	}
}
