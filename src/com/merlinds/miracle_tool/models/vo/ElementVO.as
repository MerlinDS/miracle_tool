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
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class ElementVO {

		private static const CLEAR_MATRIX:Matrix = new Matrix();
		public var name:String;
		public var view:DisplayObject;

		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;

		//this will be published
		public var bitmapData:BitmapData;
		public var uv:Vector.<Number>;
		public var indexes:Vector.<int>;

		private var _vertexes:Vector.<Number>;

		public function ElementVO(name:String, view:DisplayObject) {
			this.view = view;
			this.name = name;
			this.indexes = new <int>[0, 3, 1, 2, 1, 3];
			this.view.transform.matrix = CLEAR_MATRIX;
		}

		public function clone():ElementVO {
			var clone:ElementVO = new ElementVO(name, this.view);
			clone.x = this.x;
			clone.y = this.y;
			clone.width = this.width;
			clone.height = this.height;
			clone.bitmapData = this.bitmapData;
			clone.uv = this.uv;
			clone.indexes = indexes;
			clone._vertexes = _vertexes;
			clone.selected = this.selected;
			return clone;
		}

		private function updateView(fromBitmap:Boolean, scale:Number = 1):void {
			var matrix:Matrix = new Matrix(scale, 0, 0, scale);
			var source:IBitmapDrawable;
			if(!fromBitmap){
				this.normalizeSize(matrix);
				matrix.tx = -_vertexes[0];
				matrix.ty = -_vertexes[1];
				source = this.view;
			}else{
				this.normalizeSize(matrix);
				source = this.bitmapData.clone();
			}
			if(this.width < 1)this.width = 1;
			this.bitmapData = new BitmapData(this.width, this.height, true, 0x0);
			bitmapData.draw(source, matrix, null, null, null, true);
			var selector:Bitmap = new Bitmap(new BitmapData(this.width, this.height, true, 0x3300FF00));
			selector.visible = false;
			var view:Sprite = new Sprite();
			view.addChild(selector);
			view.addChild(new Bitmap(bitmapData));
			view.name = "element";
			this.view = view;
		}

		private function normalizeSize(matrix:Matrix):void
		{
			var n:int = Math.floor(this.height);
			if(this.height - n > 0)
			{
				matrix.a += (++n / this.height) - 1;
				this.height = n;
			}
			//
			n = Math.floor(this.width);
			if(this.width - n > 0)
			{
				matrix.d += (++n / this.width) - 1;
				this.width = n;
			}
		}

		public function get vertexes():Vector.<Number> {
			return _vertexes;
		}

		public function set vertexes(value:Vector.<Number>):void {
			_vertexes = value;
			if(value != null){
				this.updateView(false);
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

		public function set scale(value:Number):void {
			this.width = this.width * value;
			this.height = this.height * value;
			//calculate new vertexes
			for(var i:int = 0; i < _vertexes.length; i++){
				_vertexes[i] = _vertexes[i] * value;
			}
			this.view = new Bitmap(bitmapData);
			this.updateView(true, value);
		}
	}
}
