/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 1:51
 */
package com.merlinds.miracle_tool.models {
	import com.merlinds.miracle_tool.models.vo.ProjectInfoVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;

	import flash.filesystem.File;

	import flash.geom.Point;

	import org.robotlegs.mvcs.Actor;

	public class ProjectModel extends Actor {

		private var _name:String;
		private var _sceneSize:Point;
		private var _sheetSize:Point;

		private var _sources:Vector.<SourceVO>;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectModel(name:String, sceneSize:Point) {
			_name = name;
			_sceneSize = sceneSize;
			_sources = new <SourceVO>[];
			_sheetSize = new Point();
			super();
		}

		public function addSource(file:File):void {
			var find:Boolean;
			var n:int = _sources.length;
			for(var i:int = 0; i < n; i++){
				var source:SourceVO = _sources[i];
				find = source.file.nativePath == file.nativePath;
				if(find)break;
			}
			if(!find){
				_sources.push(new SourceVO(file));
			}else
			{
				//TODO update exist source
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

		public function get elements():Vector.<Object> {
			return null;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
