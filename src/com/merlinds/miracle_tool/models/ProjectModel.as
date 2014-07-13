/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 1:51
 */
package com.merlinds.miracle_tool.models {
	import com.merlinds.miracle_tool.models.vo.ProjectInfoVO;

	import flash.filesystem.File;

	import flash.geom.Point;

	import org.robotlegs.mvcs.Actor;

	public class ProjectModel extends Actor {

		public static const EMPTY:String = 'Empty';

		private var _name:String;
		private var _sceneSize:Point;
		private var _sources:Vector.<File>;
		private var _sheetSize:Point;
		private var _elements:Vector.<Object>;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectModel(name:String, sceneSize:Point) {
			_name = name;
			_sceneSize = sceneSize;
			_sources = new <File>[];
			_elements = new <Object>[];
			_sheetSize = new Point();
			super();
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

		public function get sources():Vector.<File> {
			return _sources;
		}

		public function get sheetSize():Point {
			return _sheetSize;
		}

		public function get elements():Vector.<Object> {
			return _elements;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
