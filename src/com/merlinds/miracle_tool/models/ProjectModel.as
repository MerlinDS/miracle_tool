/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 1:51
 */
package com.merlinds.miracle_tool.models {
	import com.merlinds.miracle_tool.models.vo.AnimationVO;
	import com.merlinds.miracle_tool.models.vo.ProjectInfoVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;

	import flash.filesystem.File;

	import flash.geom.Point;

	import org.robotlegs.mvcs.Actor;

	public class ProjectModel extends Actor {

		private var _name:String;
		private var _sceneSize:Point;

		private var _sources:Vector.<SourceVO>;
		private var _inProgress:int;

		private var _boundsOffset:int;
		private var _outputSize:int;
		private var _zoom:Number = 1;
		private var _sheetSize:Point;

		private var _saved:Boolean;

		private var _animationInProgress:AnimationVO;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectModel(name:String, sceneSize:Point) {
			_name = name;
			_sceneSize = sceneSize;
			_sources = new <SourceVO>[];
			_boundsOffset = 0;
			_sheetSize = new Point();
			super();
		}

		public function addSource(file:File):void {
			var n:int = _sources.length;
			for(var i:int = 0; i < n; i++){
				var source:SourceVO = _sources[i];
				if(source.file.nativePath == file.nativePath)break;
			}
			if(i >= n){
				_sources.push(new SourceVO(file));
			}else
			{
				//TODO update exist source
			}
			_inProgress = i;
		}

		public function addAnimation(file:File):void {
			var source:SourceVO = this.selected;
			var n:int = source.animations.length;
			for(var i:int = 0; i < n; i++){
				var animation:AnimationVO = source.animations[i];
				if(animation.file.nativePath == file.nativePath)break;
			}
			_animationInProgress = source.animations[i] =new AnimationVO(file);
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

		public function get sceneSize():Point {
			return _sceneSize;
		}

		public function get infoVO():ProjectInfoVO {
			return new ProjectInfoVO(_name, _sceneSize.toString());
		}

		public function get sources():Vector.<SourceVO> {
			return _sources;
		}

		public function get sheetSize():Point {
			return _sheetSize;
		}

		public function get saved():Boolean {
			return _saved;
		}

		public function set saved(value:Boolean):void {
			_saved = value;
		}

		public function get selected():SourceVO {
			var source:SourceVO;
			var n:int = _sources.length;
			for(var i:int = 0; i < n; i++){
				source = _sources[i];
				if(source.selected)break;
				source = null;
			}
			return source;
		}

		public function get inProgress():SourceVO{
			return _inProgress < 0 ? null : _sources[ _inProgress ];
		}

		public function get animationInProgress():AnimationVO {
			return _animationInProgress;
		}

		public function get boundsOffset():int {
			return _boundsOffset;
		}

		public function set boundsOffset(value:int):void {
			_boundsOffset = value;
		}

		public function get outputSize():int {
			return _outputSize;
		}

		public function set outputSize(value:int):void {
			_outputSize = value;
			_sheetSize.x = value;
			_sheetSize.y = value;
		}

		public function get zoom():Number {
			return _zoom;
		}

		public function set zoom(value:Number):void {
			_zoom = value;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
