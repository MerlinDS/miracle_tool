/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:39
 */
package com.merlinds.miracle_tool.views.project {
	import com.bit101.components.HBox;
	import com.bit101.components.HUISlider;
	import com.bit101.components.Label;
	import com.bit101.components.List;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;

	import flash.display.DisplayObjectContainer;

	public class ToolView extends VBox {
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ToolView(parent:DisplayObjectContainer = null) {
			super(parent, 0, 0);
			this.y = 10;
			//
			var input:HBox = new HBox(this);
			new Label(input, 0, 0, "Scene size:");
			new Label(input, 0, 0, "1024x708");
			new Label(this, 0, 0, "=================");
			new PushButton(this, 0, 0, "Attach source");
			new PushButton(this, 0, 0, "Attach animation").enabled = false;
			new Label(this, 0, 0, "Attached sources:");
			 new List(this, 0, 0).enabled = false;
			input = new HBox(this);
			new Label(input, 0, 0, "Texture size:");
			new Label(input, 0, 0, "0");
			input = new HBox(this);
			new Label(input, 0, 0, "Meshes =");
			new Label(input, 0, 0, "0");
			new Label(this, 0, 0, "=================");
			new PushButton(this, 0, 0, "Preview").enabled = false;
			new PushButton(this, 0, 0, "Publish").enabled = false;
			new Label(this, 0, 0, "=================");
			new Label(this, 0, 0, "Zoom:").enabled = false;
			new HUISlider(this, 0, 0);
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
