/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:01
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.bit101.components.HBox;
	import com.bit101.components.Label;
	import com.bit101.components.List;
	import com.bit101.components.PushButton;

	import flash.display.DisplayObjectContainer;

	public class SheetTools extends WidgetWindow {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function SheetTools(parent:DisplayObjectContainer = null) {
			super(parent, 0, 0, "Sheet Tools");
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void{
			new PushButton(this, 0, 0, "Attach new texture");
			new PushButton(this, 0, 0, "Attach new animation");
			new List(this, 0, 0, ["item.png", "item.swf"]);
			var line:HBox = new HBox(this);
			new Label(line, 0, 0, "Sheet size =");
			new Label(line, 0, 0, "2048x2048");
			line = new HBox(this);
			new Label(line, 0, 0, "Parts =");
			new Label(line, 0, 0, "35");
			this.height += 130;
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
