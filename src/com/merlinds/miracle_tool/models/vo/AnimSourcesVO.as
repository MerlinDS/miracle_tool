/**
 * User: MerlinDS
 * Date: 17.07.2014
 * Time: 12:54
 */
package com.merlinds.miracle_tool.models.vo {
	public dynamic class AnimSourcesVO {

		public static const DEFAULT_NAME:String = "animation::default";
		private var _chosen:Array;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AnimSourcesVO(data:Object) {
			_chosen = [];
			if(data is XML){
				_chosen.push(DEFAULT_NAME);
				this[DEFAULT_NAME] = data;
			}else{
				for(var name:String in data){
					this[name] = data[name];
				}
			}
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

		public function get chosen():Array {
			return _chosen;
		}

		public function get names():Array{
			var result:Array = [];
			for(var name:String in this){
				if(name == "names" || name == "chosen")continue;
				result.push(name);
			}
			return result;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
