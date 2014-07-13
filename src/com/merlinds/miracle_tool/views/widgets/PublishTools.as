/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:01
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.bit101.components.CheckBox;
	import com.bit101.components.PushButton;

	import flash.display.DisplayObjectContainer;

	public class PublishTools extends WidgetWindow {
		//==============================================================================
		//{region							PUBLIC METHODS
		public function PublishTools(parent:DisplayObjectContainer = null) {
			super(parent, 0, 0, "Publish Tools");
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void{
			new PushButton(this, 0, 0, "Publish");
			new CheckBox(this, 0, 0, "Change publish settings").selected = true;
			new PushButton(this, 0, 0, "Preview");

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
