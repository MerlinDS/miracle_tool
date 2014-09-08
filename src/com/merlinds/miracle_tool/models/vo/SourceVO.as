/**
 * User: MerlinDS
 * Date: 14.07.2014
 * Time: 19:11
 */
package com.merlinds.miracle_tool.models.vo {
	import flash.filesystem.File;

	public class SourceVO {

		private var _file:File;
		private var _animations:Vector.<AnimationVO>;
		private var _elements:Vector.<ElementVO>;
		private var _selected:Boolean;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function SourceVO(file:File) {
			_file = file;
			_elements = new <ElementVO>[];
			_animations = new <AnimationVO>[];
		}

		public function clone(scale:Number = 1):SourceVO {
			var i:int, n:int;
			var clone:SourceVO = new SourceVO(this.file);
			clone._animations = _animations.concat();
			//clone animation
			clone._animations.length = _animations.length;
			clone._animations.fixed = true;
			n = _animations.length;
			for(i = 0; i < n; i++){
				clone._animations[i] = _animations[i].clone();
				if(scale != 1)clone._animations[i].scale = scale;
			}
			//clone elements
			clone._elements.length = _elements.length;
			clone._elements.fixed = true;
			n = _elements.length;
			for(i = 0; i < n; i++){
				clone._elements[i] = _elements[i].clone();
				if(scale != 1)clone._elements[i].scale = scale;
			}
			clone.selected = selected;
			clone._elements.fixed = false;
			clone._animations.fixed = false;
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

		public function get name():String {
			return _file != null ? _file.name : null;
		}

		public function get file():File {
			return _file.clone();
		}

		public function get elements():Vector.<ElementVO> {
			return _elements;
		}

		public function set elements(value:Vector.<ElementVO>):void {
			_elements = value;
		}

		public function get animations():Vector.<AnimationVO> {
			return _animations;
		}

		public function set animations(value:Vector.<AnimationVO>):void {
			_animations = value;
		}

		public function set selected(value:Boolean):void{
			var n:int =  _elements.length;
			for(var i:int = 0; i < n; i++){
				_elements[i].selected = value;
			}
			_selected = value;
		}

		public function get selected():Boolean{
			return _selected;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
