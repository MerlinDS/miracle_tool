/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 22:45
 */
package com.merlinds.miracle_tool.models.vo {
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class FrameVO {

		public static const STATIC_TYPE:String = "static";
		public static const MOTION_TYPE:String = "motion";

		private var _name:String;
		private var _type:String;

		private var _index:int;
		private var _duration:int;

		private var _matrix:Matrix;
		private var _transformationPoint:Point;
		//==============================================================================
		//{region							PUBLIC METHODS

		public function FrameVO(index:int, duration:int) {
			_index = index;
			_duration = duration;
			_type = STATIC_TYPE;
		}

		public function toString():String {
			return "[FrameVO(name = " + _name+ ", index = " + _index + ", duration = " + _duration +
					", type = " + _type + ", transformationPoint = " + _transformationPoint
					+ ", matrix = " + _matrix + ")]";
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

		public function get index():int {
			return _index;
		}

		public function get duration():int {
			return _duration;
		}

		public function get type():String {
			return _type;
		}

		public function set type(value:String):void {
			if(value != null && value.length != 0){
				_type = value;
			}
		}


		public function get name():String {
			return _name;
		}

		public function set name(value:String):void {
			_name = value;
		}

		public function get matrix():Matrix {
			return _matrix;
		}

		public function set matrix(value:Matrix):void {
			_matrix = value;
		}

		public function get transformationPoint():Point {
			return _transformationPoint;
		}

		public function set transformationPoint(value:Point):void {
			_transformationPoint = value;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
