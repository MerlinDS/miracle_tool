/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 22:45
 */
package com.merlinds.miracle_tool.models.vo {
	import com.merlinds.miracle.meshes.Color;

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

		private var _color:Color;
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

		public function clone():FrameVO{
			var clone:FrameVO = new FrameVO(_index, _duration);
			clone._name = _name;
			clone._type = _type;
			clone._matrix = _matrix != null ? _matrix.clone() : null;
			clone._transformationPoint = _transformationPoint != null ? _transformationPoint.clone() : null;
			return clone;
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
			return _duration == 0 ? 1 : _duration;
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
			var delim:int = value.lastIndexOf("/");
			if(delim > -1){
				value = value.substr(delim + 1);
			}
			_name = value;
		}

		public function get matrix():Matrix {
			return _matrix;
		}

		public function set matrix(value:Matrix):void {
			_matrix = value;
		}

		public function get transformationPoint():Point {
			if(_transformationPoint == null)
				this.transformationPoint = null;
			return _transformationPoint;
		}

		public function set transformationPoint(value:Point):void {
			_transformationPoint = value == null ? new Point() : value;
		}

		public function set scale(value:Number):void{
			if(_matrix != null){
				_matrix.tx = _matrix.tx * value;
				_matrix.ty = _matrix.ty * value;
			}
			if(_transformationPoint != null){
				_transformationPoint.x = _transformationPoint.x * value;
				_transformationPoint.y = _transformationPoint.y * value;
			}
		}

		public function get color():Color {
			return _color;
		}

		public function set color(value:Color):void {
			_color = value;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
