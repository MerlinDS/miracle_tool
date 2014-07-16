/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 19:36
 */
package com.merlinds.miracle_tool.models.vo {
	import flash.filesystem.File;

	public class AnimetionVO {

		private var _file:File;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AnimetionVO(file:File) {
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

		public function get file():File {
			return _file.clone();
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
