/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:39
 */
package com.merlinds.miracle_tool.views.project {
	import com.bit101.components.Window;
	import com.merlinds.miracle_tool.views.interfaces.IResizable;

	import flash.display.DisplayObject;

	import flash.display.DisplayObjectContainer;

	public class ProjectView extends Window implements IResizable{

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectView(name:String, parent:DisplayObjectContainer = null) {
			//
			super(parent, 0, 0, "Project: " + name);
			this.hasCloseButton = true;
			this.hasMinimizeButton = false;
			this.draggable = false;
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		override public function setSize(w:Number, h:Number):void {
			super.setSize(w, h);
		}

		override public function addChild(child:DisplayObject):DisplayObject {
			this.content.removeChildren();
			return this.content.addChild(child);
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
