/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 1:51
 */
package com.merlinds.miracle_tool.models {
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.vo.AnimationVO;
	import com.merlinds.miracle_tool.models.vo.ElementVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;
	import com.merlinds.unitls.Resolutions;

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
		//storage for handling previous resolution sources
		private var _memorize:Object;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectModel(name:String, referenceResolution:int) {
			_name = name;
			_memorize = {};
			_referenceResolution = referenceResolution;
			_targetResolution = referenceResolution;
			_sources = new <SourceVO>[];
			_boundsOffset = 0;
			_sheetSize = new Point();
			super();
		}

		public function addSource(file:File):SourceVO {
			//revert to default sources and delete old backups
			this.revertBackupTo(_referenceResolution);
			_memorize = {};
			//add new source
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
				//TODO MF-30 Update swf source if it already added
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
		/**
		 * Backup sources for current resolution
		 */
		private function prepareBackup():void {
			if(!_memorize.hasOwnProperty(_targetResolution.toString())){
				_memorize[_targetResolution] = _sources.concat();
			}
		}

		/**
		 * get sources for resolution
		 * @param resolution
		 * @return True if backup was reverted. In other case returns false
		 */
		private function revertBackupTo(resolution:int):Boolean {
			var result:Boolean = _memorize.hasOwnProperty(resolution.toString());
			if(result){
				_sources = _memorize[resolution];
			}
			return result;
		}

		/**
		 * Scale sources for resolution
		 */
		private function scaleSources():void {
			//calculate scale
			var scale:Number = Resolutions.width(_targetResolution) / Resolutions.width(_referenceResolution);
			//clone default sources, that was first for the project and scale elements in it
			var defaultSources:Vector.<SourceVO> = _memorize[_referenceResolution.toString()];
			var sources:Vector.<SourceVO> = new <SourceVO>[];
			var n:int = sources.length = defaultSources.length;
			sources.fixed = true;
			for(var i:int = 0; i < n; i++){
				//cloning
				sources[i] = defaultSources[i].clone();
				//scaling
				var elements:Vector.<ElementVO> = sources[i].elements;
				var m:int = elements.length;
				for(var j:int = 0; j < m; j++){
					var element:ElementVO = elements[j];
					element.scale = scale;
				}
			}
			//end
			sources.fixed = false;
			_sources = sources;
		}
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
				if(_sources.length > 0){
					this.dispatch(new EditorEvent(EditorEvent.UPDATE_PROJECT));
				}
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
			//TODO: MF-31 Disable resizing in a big way
			if(value != _targetResolution){
				this.prepareBackup();
				_targetResolution = value;
				if(_sources.length > 0){
					var reverted:Boolean = this.revertBackupTo(_targetResolution);
					if( !reverted ){
						this.scaleSources();
					}
					this.dispatch(new EditorEvent(EditorEvent.UPDATE_PROJECT));
				}
			}
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
