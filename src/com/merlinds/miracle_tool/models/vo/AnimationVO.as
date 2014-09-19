/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 19:36
 */
package com.merlinds.miracle_tool.models.vo {
	import flash.filesystem.File;
	import flash.geom.Rectangle;

	public class AnimationVO {

		private var _file:File;
		private var _name:String;
		private var _totalFrames:int;
		private var _timelines:Vector.<TimelineVO>;
		private var _bounds:Rectangle;
		private var _added:Boolean;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AnimationVO(file:File = null, bounds:Rectangle = null) {
			_file = file;
			_timelines = new <TimelineVO>[];
			this._bounds = bounds;
		}

		public function clone():AnimationVO{
			var clone:AnimationVO = new AnimationVO(_file, _bounds.clone());
			clone._name = _name;
			clone._added = _added;
			clone._totalFrames = _totalFrames;
			var n:int = clone._timelines.length = _timelines.length;
			clone._timelines.fixed = true;
			for(var i:int = 0; i < n; i++){
				clone._timelines[i] = _timelines[i].clone();
			}
			clone._timelines.fixed = false;
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

		public function get file():File {
			return _file != null ? _file.clone() : null;
		}

		public function set file(file:File):void {
			_file = file;
		}

		public function get timelines():Vector.<TimelineVO> {
			return _timelines;
		}

		public function get name():String {
			return _name;
		}

		public function set name(value:String):void {
			_name = value;
		}


		public function get totalFrames():int {
			return _totalFrames;
		}

		public function set totalFrames(value:int):void {
			_totalFrames = value;
		}

		public function get bounds():Rectangle {
			return _bounds;
		}

		public function get added():Boolean {
			return _added;
		}

		public function set added(value:Boolean):void {
			_added = value;
		}


		public function set scale(value:Number):void{
			var n:int = _timelines.length;
			for(var i:int = 0; i < n; i++){
				_timelines[i].scale = value;
			}
		}
//} endregion GETTERS/SETTERS ==================================================
	}
}
