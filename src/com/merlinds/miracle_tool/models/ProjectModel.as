/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 1:51
 */
package com.merlinds.miracle_tool.models {
	import flash.geom.Point;

	import org.robotlegs.mvcs.Actor;

	public class ProjectModel extends Actor {

		private var _name:String;
		private var _sceneSize:Point;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectModel(name:String, sceneSize:Point) {
			_name = name;
			_sceneSize = sceneSize;
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

//} endregion GETTERS/SETTERS ==================================================
	}
}
