/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:39
 */
package com.merlinds.miracle_tool.views.project {
	import com.bit101.components.Window;
	import com.merlinds.miracle_tool.view.interfaces.IResizable;

	import flash.display.DisplayObjectContainer;

	public class ProjectView extends Window implements IResizable{

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectView(name:String, parent:DisplayObjectContainer = null) {
			super(parent, 0, 0, name);
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
