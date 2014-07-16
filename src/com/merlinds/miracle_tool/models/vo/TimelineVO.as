/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 22:40
 */
package com.merlinds.miracle_tool.models.vo {
	public class TimelineVO {

		private var _name:String;
		private var _labels:Vector.<String>;
		private var _sprites:Vector.<String>;
		private var _ease:Vector.<EaseVO>;
		private var _transform:Vector.<TransformVO>;
		private var _frames:Vector.<FramesVO>;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function TimelineVO(name:String) {
			_name = name;
			_labels = new <String>[];
			_sprites = new <String>[];
			_ease = new <EaseVO>[];
			_transform = new <TransformVO>[];
			_frames = new <FramesVO>[];
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
			return _name;
		}

		public function get labels():Vector.<String> {
			return _labels;
		}

		public function get sprites():Vector.<String> {
			return _sprites;
		}

		public function get ease():Vector.<EaseVO> {
			return _ease;
		}

		public function get transform():Vector.<TransformVO> {
			return _transform;
		}

		public function get frames():Vector.<FramesVO> {
			return _frames;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
