/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:40
 */
package com.merlinds.miracle_tool.views {
	import com.bit101.components.VBox;
	import com.merlinds.miracle_tool.views.interfaces.IResizable;
	import com.merlinds.miracle_tool.views.project.ProjectView;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class AppView extends VBox implements IResizable{

		private var _project:DisplayObject;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AppView(parent:DisplayObjectContainer = null) {
			super(parent);
		}


		override public function addChild(child:DisplayObject):DisplayObject {
			if(_project != null){
				this.removeChild(_project);
			}
			if(child is ProjectView){
				_project = child;
			}
			return super.addChild(child);
		}

		public function removeProject():DisplayObject{
			var result:DisplayObject;
			if(_project != null && _project.parent == this){
				result = super .removeChild(_project);
				_project = null;
			}
			return result;
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
		//} endregion GETTERS/SETTERS ==================================================
	}
}
