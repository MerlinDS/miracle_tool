/**
 * User: MerlinDS
 * Date: 14.07.2014
 * Time: 19:11
 */
package com.merlinds.miracle_tool.models.vo {
	import flash.display.DisplayObject;
	import flash.filesystem.File;

	public class SourceVO {

		private var _file:File;
		private var _elements:Vector.<ElementVO>;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function SourceVO(file:File) {
			_file = file;
			_elements = new <ElementVO>[];
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
			return _file;
		}

		public function get elements():Vector.<ElementVO> {
			return _elements;
		}

		public function set selected(value:Boolean):void{
			var n:int =  _elements.length;
			for(var i:int = 0; i < n; i++){
				_elements[i].selected = value;
			}
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
