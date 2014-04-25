/**
 * User: MerlinDS
 * Date: 25.04.2014
 * Time: 21:28
 */
package com.merlinds.miracle_tool.tools.editor {
	import avmplus.getQualifiedClassName;

	import com.merlinds.miracle_tool.tools.editor.models.EditorModel;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class TexturePacker{
		private var _model:EditorModel;
		private var _output:BitmapData;

		private var _target:MovieClip;
		private var _elements:Vector.<Element>;
		private var _complete:Boolean;

		private var _outputSize:int;
		private var _packer:MaxRectPacker;

		public function TexturePacker(model:EditorModel) {
			_model = model;
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function execute(target:String):void{
			trace("Start pack", target);
			//
			_target = _model.getInstanceFromTarget(target) as MovieClip;
			if(_target == null){
				throw ArgumentError("Cannot found target with name" + target);
			}
			this.getElements();
		}

		public function enterFrame():void{
			if(!_complete){
				//nearest power of 2
				_outputSize = Math.pow(2, Math.ceil(
								Math.log(_outputSize) * Math.LOG2E));
				//prepare buffer of output
				_output = new BitmapData(_outputSize, _outputSize, true, 0x00000000);
				_packer = new MaxRectPacker(_outputSize, _outputSize);
				var n:int = _elements.length;
				_complete = true;
				for(var i:int = 0; i < n; i++){
					_complete = this.placeElementToOutput(_elements[i]);
					if(!_complete){
						_outputSize++;
						break;
					}
				}
			}
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function getElements():void{
			_elements = new <Element>[];
			var element:Element;
			var elementName:String;
			var elementView:DisplayObject;
			var i:int, j:int, n:int, m:int;
			n = _target.totalFrames + 1;
			for(i = 1; i < n; i++){
				_target.gotoAndStop(i);
				m = _target.numChildren;
				for(j = 0; j < m; j++){
					elementView = _target.getChildAt(j);
					elementName = getQualifiedClassName(elementView);
					if(!this.hasElement(elementName)){
						element = new Element(elementName, elementView);
						_elements.push(element);
					}
				}
			}
			//get bounds of elements
			n = _elements.length;
			for(i = 0; i < n; i++){
				element = _elements[i];
				this.getElementBounds(element);
				if(_outputSize < element.width){
					_outputSize = element.width;
				}
			}
		}

		[Inline]
		private function getElementBounds(element:Element):Element {
			var view:DisplayObject = element.view;
			var ratio:Number = view.width / view.transform.pixelBounds.width;
			var topLeftPoint:Point = new Point(view.transform.pixelBounds.x - view.x - _model.boundsOffset,
							view.transform.pixelBounds.y - view.y - _model.boundsOffset);
			topLeftPoint.x *= ratio;
			topLeftPoint.y *= ratio;

			var topRightPoint:Point = new Point(topLeftPoint.x + view.width + _model.boundsOffset * 2,
					topLeftPoint.y);

			var bottomRightPoint:Point = new Point(topRightPoint.x,
							topRightPoint.y + view.height + _model.boundsOffset * 2);

			var bottomLeftPoint:Point = new Point(topLeftPoint.x, bottomRightPoint.y);

			element.vertexes = new <Number>[topLeftPoint.x, topLeftPoint.y, topRightPoint.x, topRightPoint.y,
				bottomRightPoint.x, bottomRightPoint.y, bottomLeftPoint.x, bottomLeftPoint.y];

			element.width = view.width + _model.boundsOffset * 2;
			element.height = view.height + _model.boundsOffset * 2;

			return element;
		}

		[Inline]
		private function hasElement(name:String):Boolean {
			var result:Boolean;
			var i:int, n:int = _elements.length;
			for(i = 0; i < n; i++){
				result = _elements[i].name == name;
				if(result)break;
			}
			return result;
		}

		private function clear():void{
			_output.dispose();
			_output = null;
		}

		[Inline]
		private function placeElementToOutput(element:Element):Boolean{
			var rect:Rectangle = _packer.quickInsert(element.width, element.height);

			if(rect != null){
				var matrix:Matrix = new Matrix(1, 0, 0, 1, -element.vertexes[0], -element.vertexes[1]);
				var bitmapData:BitmapData = new BitmapData(element.width, element.height, true, 0x0);
				bitmapData.draw(element.view, matrix);
				//draw output
				_output.copyPixels(bitmapData, bitmapData.rect, new Point(rect.x + _model.boundsOffset,
								rect.y + _model.boundsOffset));
				//TODO get uv position
			}

			return rect != null;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function get output():BitmapData {
			return _output;
		}


		public function get complete():Boolean {
			return _complete;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}

import flash.display.DisplayObject;
import flash.geom.Matrix;

class Element{
	private static const CLEAR_MATRIX:Matrix = new Matrix();

	public var name:String;
	public var view:DisplayObject;
	public var vertexes:Vector.<Number>;
	public var width:Number;
	public var height:Number;

	public function Element(name:String, view:DisplayObject) {
		this.view = view;
		this.name = name;
		this.view.transform.matrix = CLEAR_MATRIX;
	}
}