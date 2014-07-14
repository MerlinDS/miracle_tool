/**
 * User: MerlinDS
 * Date: 14.07.2014
 * Time: 21:40
 */
package com.merlinds.miracle_tool.controllers.placers {
	import com.merlinds.miracle_tool.models.vo.ElementVO;

	internal class PlacerAlgorithm {

		protected var elements:Vector.<ElementVO>;
		protected var boundsOffset:int;

		private var _complete:Boolean;
		private var _outputSize:int;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function PlacerAlgorithm() {
		}

		public function init(elements:Vector.<ElementVO>, outputSize:int, boundsOffset:int = 0):void{
			this.elements = elements;
			this.boundsOffset = boundsOffset;
			_outputSize = outputSize;
			_complete = false;
		}

		public function calculateStep(complete:Boolean = false):void{
			_complete = complete;
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
		public function get complete():Boolean {
			return _complete;
		}

		public function set complete(value:Boolean):void {
			_complete = value;
		}

		public function get outputSize():int {
			return _outputSize;
		}

		public function set outputSize(value:int):void {
			_outputSize = value;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
