/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:01
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.bit101.components.FPSMeter;
	import com.bit101.components.HBox;
	import com.bit101.components.IndicatorLight;
	import com.bit101.components.Label;

	import flash.display.DisplayObjectContainer;

	public class ProjectInfo extends WidgetWindow {
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectInfo(parent:DisplayObjectContainer = null) {
			super(parent, 0, 0, "Project Info");
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void{
			var line:HBox = new HBox(this);
			new Label(line, 0, 0, "Project Name =");
			new Label(line, 0, 0, "big project name with trulala and tralalu");
			line = new HBox(this);
			new Label(line, 0, 0, "Project size =");
			new Label(line, 0, 0, "2048x2048");
			new IndicatorLight(this, 0, 0, 0xFFFF0000, " Not saved").isLit = true;
			new FPSMeter(this);
			this.height += 10;
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
