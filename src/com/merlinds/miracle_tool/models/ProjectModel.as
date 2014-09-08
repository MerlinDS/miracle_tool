/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 1:51
 */
package com.merlinds.miracle_tool.models {
	import com.merlinds.miracle_tool.models.vo.AnimationVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;

	import flash.filesystem.File;
	import flash.geom.Point;

	import org.robotlegs.mvcs.Actor;

	public class ProjectModel extends Actor {

		private var _name:String;
		/**
		 * TODO: MF-29 Make normal comment for referenceSize
		 * This size will be used for scaling of output texture.
		 * It based of target screen resolution and resource screen resolution.
		 * For example: IF reference size (width of screen of the fla. resource ) equals 2048
		 * and will be needed to publish project for 1024 screen width, than scale will be 0.5;
		 **/
		private var _referenceResolution:int;
		/**
		 * Width of the target screen resolution
		 */
		private var _targetResolution:int;
		//TODO MF-28 Bound calculation for every polygon in texture
		private var _boundsOffset:int;

		private var _sources:Vector.<SourceVO>;
		private var _inProgress:int;

		private var _outputSize:int;
		private var _zoom:Number = 1;
		private var _sheetSize:Point;

		private var _saved:Boolean;

		//quick hack for animation saving
		public var tempFile:File;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectModel(name:String, referenceResolution:int) {
			_name = name;
			_referenceResolution = referenceResolution;
			_targetResolution = referenceResolution;
			_sources = new <SourceVO>[];
			_boundsOffset = 0;
			_sheetSize = new Point();
			super();
		}

		public function addSource(file:File):SourceVO {
			var source:SourceVO;
			var n:int = _sources.length;
			for(var i:int = 0; i < n; i++){
				 source = _sources[i];
				if(source.file.nativePath == file.nativePath)break;
			}
			if(i >= n){
				source = new SourceVO(file);
				_sources.push(source);
			}else
			{
				//TODO update exist source
			}
			_inProgress = i;
			return source;
		}

		public function deleteAnimation(name:String):void {
			var source:SourceVO = this.selected;
			var animation:AnimationVO;
			var n:int = source.animations.length;
			for(var i:int = 0; i < n; i++){
				animation = source.animations[i];
				if(animation.name == name){
					//delete founded animation
					source.animations.splice(i, 1);
					break;
				}
				animation = null;
			}
			//nulled object and add it back for future
			if(animation != null){
				animation.added = false;
				source.animations.push(animation);
			}
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

		public function get boundsOffset():int {
			return _boundsOffset;
		}

		public function set boundsOffset(value:int):void {
			if(value != _boundsOffset){
				_boundsOffset = value;
				//TODO MF-20 recalculate output
			}
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
		//TODO MF-29 Make normal comment for referenceSize
		public function get referenceResolution():int {
			return _referenceResolution;
		}

		public function get targetResolution():int {
			return _targetResolution;
		}

		public function set targetResolution(value:int):void {
			if(value != _targetResolution){
				_targetResolution = value;
				//TODO MF-20 recalculate output
			}
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
