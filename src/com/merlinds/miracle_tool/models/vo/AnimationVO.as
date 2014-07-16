/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 19:36
 */
package com.merlinds.miracle_tool.models.vo {
	import flash.filesystem.File;

	public class AnimationVO {

		private var _file:File;
		private var _timelines:Array;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AnimationVO(file:File) {
			_file = file;
			_timelines = [];
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

		public function get timelines():Array {
			return _timelines;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
