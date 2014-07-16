/**
 * User: MerlinDS
 * Date: 28.04.2014
 * Time: 14:45
 */
package com.merlinds.miracle_tool.models.vo{

	public dynamic class CurveVO extends Array{

		public function CurveVO(...coordinates) {
			var n:int = coordinates.length;
			for(var i:int = 0; i < n; i ++){
				this[ this.length ] = coordinates[i];
			}
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function addPoint(x:Number, y:Number):void{
			this[this.length] = x;
			this[this.length] = y;
		}

		public function parse(step:Number = 0.1):Vector.<Number>{
			var x0:Number, y0:Number, x1:Number, y1:Number;
			var x2:Number, y2:Number, x3:Number, y3:Number;
			var result:Vector.<Number> = new <Number>[];
			var n:int = this.length;
			for(var i:int = 0; i < n; i += 8){
				x0 = this[i + 0]; y0 = this[i + 1];
				x1 = this[i + 2]; y1 = this[i + 3];
				x2 = this[i + 4]; y2 = this[i + 5];
				x3 = this[i + 6]; y3 = this[i + 7];

				var cx:Number = 3 * ( x1 - x0 );
				var bx:Number = 3 * ( x2 - x1 ) - cx;
				var ax:Number = x3 - x0 - cx - bx;
				var cy:Number = 3 * ( y1 - y0 );
				var by:Number = 3 * ( y2 - y1 ) - cy;
				var ay:Number = y3 - y0 - cy - by;

				for(var t:Number = 0; t < 1; t += 0.01){
					var xPos:Number = ax * Math.pow(t,3) + bx * Math.pow(t,2) + cx * t + x0;
					var yPos:Number = ay * Math.pow(t,3) + by * Math.pow(t,2) + cy * t + y0;
					var index:int = Math.ceil( xPos  / step );//Dot index
					result[ index ] = yPos;
				}
			}
			return result;
		}

		public function toString(step:Number = 0.1):String {
			var dots:Vector.<Number> = this.parse(step);
			var n:int = dots.length;
			var string:String = "";
			if(n > 0){
				string += "0,";
				for(var i:int = 1; i < n - 1; i++){
					var num:Number = dots[i];// * 100
					string += num.toFixed(2) + ",";
				}
				string += "1";
			}
			return string;
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
