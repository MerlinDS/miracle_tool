/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:38
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.bit101.components.HBox;
	import com.bit101.components.Label;
	import com.bit101.components.Text;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	public class ItemInfo extends WidgetWindow {
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ItemInfo(parent:DisplayObjectContainer = null) {
			super(parent, 0, 0, "Item Info");
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void{
			var line:HBox = new HBox(this);
			new Label(line, 0, 0, "Name =");
			new Label(line, 0, 0, "some name");
			new Label(this, 0, 0, "Rect");
			var text:Text = new Text(this, 0, 0, new Rectangle(0, 0, 100, 100).toString());
			text.editable = false;
			text.setSize(this.width - 10, 20);
			new Label(this, 0, 0, "Vertexes");
			text = new Text(this, 0, 0, [0.4535345 ,0.4535345, 0.4535345, 0.4535345, 0.4535345, 0.4535345].toString());
			text.editable = false;
			text.setSize(this.width - 10, 50);
			new Label(this, 0, 0, "UV");
			text = new Text(this, 0, 0, [0.4535345 ,0.4535345, 0.4535345, 0.4535345, 0.4535345, 0.4535345].toString());
			text.editable = false;
			text.setSize(this.width - 10, 50);
			new Label(this, 0, 0, "Indexes");
			text = new Text(this, 0, 0, [1, 2, 3, 4, 5, 6].toString());
			text.editable = false;
			text.setSize(this.width - 10, 20);
			this.height += 200;
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
