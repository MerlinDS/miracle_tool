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

		public function clone():TimelineVO {
			var clone:TimelineVO = new TimelineVO();
			var n:int = clone._frames.length = _frames.length;
			clone._frames.fixed = true;
			for(var i:int = 0; i < n; i++){
				clone._frames[i] = _frames[i].clone();
			}
			clone._frames.fixed = false;
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

		public function get frames():Vector.<FrameVO> {
			return _frames;
		}

		public function set scale(value:Number):void{
			var n:int = _frames.length;
			for(var i:int = 0; i < n; i++){
				_frames[i].scale = value;
			}
		}
//} endregion GETTERS/SETTERS ==================================================
	}
}
