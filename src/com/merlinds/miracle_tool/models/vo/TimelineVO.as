/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 22:40
 */
package com.merlinds.miracle_tool.models.vo {
	public class TimelineVO {
		private var _frames:Vector.<FrameVO>;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function TimelineVO() {
			_frames = new <FrameVO>[];
		}

		public function toString():String {
			var string:String =  "[TimelineVO(frames = \n";
			for each(var frame:FrameVO in _frames){
				string += "\t" + frame.toString() + "\n";
			}
			string += ")]\n";
			return string;
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

		public function get frames():Vector.<FrameVO> {
			return _frames;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
