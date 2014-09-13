/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 22:45
 */
package com.merlinds.miracle_tool.models.vo {
	import com.merlinds.miracle.geom.Color;
	import com.merlinds.miracle.geom.TransformMatrix;
	import com.merlinds.miracle.geom.Transformation;

	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

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


		/**
		 * Generate transformation object for add it to maf.
		 * @param scale Global stage scale.
		 * @param vertexes Pixel vertexes of element in texture.
		 * @param previousTransform Previous frame transformation object.
		 * (need to calculation of shortest angle between two matrix)
		 * @return Generated transform object with transformation matrix,
		 * color transformation object, and polygon bounds with transformation.
		 */
		public function generateTransform(scale:Number, vertexes:Vector.<Number>, previousTransform:Transformation):Transformation {
			if(this.matrix != null){
				var matrix:TransformMatrix = this.getMatrix();
				//multiply scale to matrix
				matrix.tx = matrix.tx * scale;
				matrix.ty = matrix.ty * scale;
				matrix.offsetX = matrix.offsetX * scale;
				matrix.offsetY = matrix.offsetY * scale;
				//calculate shortest angle between previous matrix skew and current matrix skew
				if(previousTransform != null){
					 matrix.skewX = this.getShortest(matrix.skewX, previousTransform.matrix.skewX);
					 matrix.skewY = this.getShortest(matrix.skewY, previousTransform.matrix.skewY);
				}
				var transformation:Transformation = new Transformation();
				transformation.matrix = matrix;
				//add color to transformation
				transformation.color = this.color;
				transformation.bounds = new Rectangle();
				//calculate new bounds for this frame
				var topLeft:Point = new Point(), bottomRight:Point = new Point();
				var n:int = vertexes.length >> 1;
				for(var i:int = 0; i < n; i++){
					var x:Number = vertexes[ 2 * i ] + this.transformationPoint.x;
					var y:Number = vertexes[ 2 * i + 1] + this.transformationPoint.y;
					var point:Point = this.matrix.transformPoint(new Point(x, y));
					//find smallest and largest x and y positions
					//for x
					if(point.x < topLeft.x){
						topLeft.x = point.x;
					}else if(point.x > bottomRight.x){
						bottomRight.x = point.x;
					}
					//for y
					if(point.y < topLeft.y){
						topLeft.y = point.y;
					}else if(point.y > bottomRight.y){
						bottomRight.y = point.y;
					}
				}
				transformation.bounds.topLeft = topLeft;
				transformation.bounds.bottomRight = bottomRight;
				//round rectangle
				transformation.bounds.x = Math.round(transformation.bounds.x);
				transformation.bounds.y = Math.round(transformation.bounds.y);
				transformation.bounds.width = Math.round(transformation.bounds.width);
				transformation.bounds.height = Math.round(transformation.bounds.height);
			}
			//if matrix doesn't exist then frame is empty
			return transformation;
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		[Inline]
		private function getMatrix():TransformMatrix{
			var transformMatrix:TransformMatrix;
			if(this.matrix != null){
				var position:Point = this.matrix.transformPoint(this.transformationPoint);
				transformMatrix = new TransformMatrix(
						this.transformationPoint.x * -1,
						this.transformationPoint.y,
						position.x, position.y,
						Math.sqrt(matrix.a * matrix.a + matrix.b * matrix.b),
						Math.sqrt(matrix.c * matrix.c + matrix.d * matrix.d),
						Math.atan2(-matrix.c, matrix.d),
						Math.atan2(matrix.b, matrix.a)
				)
			}
			return transformMatrix;
		}

		[Inline]
		private function getShortest(a:Number, b:Number):Number {
			if(Math.abs(a - b) > Math.PI){
				if(a > 0){
					return a - Math.PI * 2;
				}else if(a < 0){
					return Math.PI * 2 + a;
				}
			}
			return a;
		}
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
