/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:39
 */
package com.merlinds.miracle_tool.views.project {
	import com.bit101.components.HBox;
	import com.bit101.components.Window;
	import com.merlinds.miracle_tool.view.interfaces.IResizable;

	import flash.display.DisplayObjectContainer;

	public class ProjectView extends Window implements IResizable{

		private var _body:HBox;
		private var _workspace:IResizable;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectView(name:String, parent:DisplayObjectContainer = null) {
			//
			super(parent, 0, 0, "Project: " + name);
			this.hasCloseButton = true;
			this.hasMinimizeButton = false;
			this.draggable = false;
			_body = new HBox(this);
			_workspace = new Workspace(_body);
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		override public function setSize(w:Number, h:Number):void {
			if(_body != null && _workspace != null){
				_body.setSize(w , h);
			}
			super.setSize(w, h);
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
