/**
 * User: MerlinDS
 * Date: 11.07.2014
 * Time: 21:14
 */
package com.merlinds.miracle_tool.models.vo {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class ElementVO {

		private static const CLEAR_MATRIX:Matrix = new Matrix();
		public var name:String;
		public var view:DisplayObject;
		public var bitmapData:BitmapData;
		public var width:Number;
		public var height:Number;
		public var uv:Vector.<Number>;

		private var _vertexes:Vector.<Number>;

		public function ElementVO(name:String, view:DisplayObject) {
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
				var selector:Bitmap = new Bitmap(new BitmapData(this.width, this.height, true, 0x3300FF00));
				selector.visible = false;
				var view:Sprite = new Sprite();
				view.addChild(selector);
				view.addChild(new Bitmap(bitmapData));
				view.name = "element";
				this.view = view;
			}
		}

		public function toString():String {
			return "[Element(name = " + name + ", vertex = [" + _vertexes + "], uv =[" + uv +"] )]";
		}

		public function set selected(value:Boolean):void{
			if(this.view && (this.view as DisplayObjectContainer).numChildren > 1){
				var selector:DisplayObject = (this.view as DisplayObjectContainer).getChildAt(0);
				selector.visible = value;
			}
		}

		public function get selected():Boolean {
			if(this.view && (this.view as DisplayObjectContainer).numChildren > 1){
				var selector:DisplayObject = (this.view as DisplayObjectContainer).getChildAt(0);
				return selector.visible;
			}
			return false;
		}
	}
}
