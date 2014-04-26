/**
 * User: MerlinDS
 * Date: 26.04.2014
 * Time: 12:29
 */
package com.merlinds.miracle_tool.tools.editor.models {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;

	public class Element{
		private static const CLEAR_MATRIX:Matrix = new Matrix();

		public var name:String;
		public var view:DisplayObject;
		public var bitmapData:BitmapData;
		public var width:Number;
		public var height:Number;
		public var uv:Vector.<Number>;

		private var _vertexes:Vector.<Number>;

		public function Element(name:String, view:DisplayObject) {
			this.view = view;
			this.name = name;
			this.view.transform.matrix = CLEAR_MATRIX;
		}

		public function get vertexes():Vector.<Number> {
			return _vertexes;
		}

		public function set vertexes(value:Vector.<Number>):void {
			_vertexes = value;
			if(value != null){
				var matrix:Matrix = new Matrix(1, 0, 0, 1, -vertexes[0], -vertexes[1]);
				this.bitmapData = new BitmapData(this.width, this.height, true, 0x0);
				bitmapData.draw(this.view, matrix);
			}
		}
	}
}
