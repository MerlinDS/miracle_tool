/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 14:56
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.bit101.components.VBox;
	import com.merlinds.miracle_tool.views.interfaces.IResizable;

	import flash.display.DisplayObjectContainer;

	public class ProjectWidgets extends VBox implements IResizable {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectWidgets(parent:DisplayObjectContainer) {
			super();
			parent.addChild(this);
			this.initialize();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function initialize():void{
			new ProjectInfoView(this).draggable = false;
			new ItemInfo(this).draggable = false;
			new SheetToolsView(this).draggable = false;
			new PublishTools(this).draggable = false;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS

		override public function setSize(w:Number, h:Number):void {
			this.y = 50;
			this.x = w - this.width;
		}

//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function set data(value:Array):void{

		}
		//} endregion GETTERS/SETTERS ==================================================
	}
}
