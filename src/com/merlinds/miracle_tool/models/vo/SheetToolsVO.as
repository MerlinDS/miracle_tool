/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 16:42
 */
package com.merlinds.miracle_tool.models.vo {
	import flash.filesystem.File;
	import flash.geom.Point;

	public class SheetToolsVO {

		public var sources:Array;
		public var numElements:int;
		public var size:Point;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function SheetToolsVO(sources:Vector.<File>, numElements:int, size:Point) {
			this.sources = [];
			for each(var file:File in sources){
				this.sources.push(file.name);
			}
			this.numElements = numElements;
			this.size = size.clone();
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
