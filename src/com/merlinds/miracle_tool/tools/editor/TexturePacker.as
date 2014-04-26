/**
 * User: MerlinDS
 * Date: 25.04.2014
 * Time: 21:28
 */
package com.merlinds.miracle_tool.tools.editor {

	import com.merlinds.miracle_tool.tools.editor.models.EditorModel;
	import com.merlinds.miracle_tool.tools.editor.models.Element;

	import flash.utils.getQualifiedClassName;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class TexturePacker{
		private var _model:EditorModel;

		private var _target:MovieClip;
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
				_model.output = new BitmapData(_outputSize, _outputSize, true, 0x00000000);
				_packer = new MaxRectPacker(_outputSize, _outputSize);
				var n:int = _model.elements.length;
				_complete = true;
				for(var i:int = 0; i < n; i++){
					_complete = this.placeElementToOutput(_model.elements[i]);
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
			_model.elements = new <Element>[];
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
					if(!_model.hasElement(elementName)){
						element = new Element(elementName, elementView);
						_model.elements.push(element);
					}
				}
			}
			//get bounds of elements
			n = _model.elements.length;
			for(i = 0; i < n; i++){
				element = _model.elements[i];
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

			element.width = view.width + _model.boundsOffset * 2;
			element.height = view.height + _model.boundsOffset * 2;

			element.vertexes = new <Number>[topLeftPoint.x, topLeftPoint.y, topRightPoint.x, topRightPoint.y,
				bottomRightPoint.x, bottomRightPoint.y, bottomLeftPoint.x, bottomLeftPoint.y];


			return element;
		}

		[Inline]
		private function placeElementToOutput(element:Element):Boolean{
			var rect:Rectangle = _packer.quickInsert(element.width, element.height);

			if(rect != null){
				//draw output
				_model.output.copyPixels(element.bitmapData, element.bitmapData.rect,
						new Point(rect.x + _model.boundsOffset, rect.y + _model.boundsOffset));
				//get uv position
				element.uv = new <Number>[
					rect.left, rect.top,
					rect.right, rect.top,
					rect.right, rect.bottom,
					rect.left, rect.bottom
				];

			}

			return rect != null;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function get complete():Boolean {
			return _complete;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}