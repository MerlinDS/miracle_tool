/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:38
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.bit101.components.HBox;
	import com.bit101.components.Label;
	import com.bit101.components.Text;
	import com.merlinds.miracle_tool.models.vo.ElementVO;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	public class ItemInfoView extends WidgetWindow {

		private var _indexes:Text;
		private var _uv:Text;
		private var _vertex:Text;
		private var _name:Label;
		private var _x:Label;
		private var _y:Label;
		private var _w:Label;
		private var _h:Label;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ItemInfoView(parent:DisplayObjectContainer = null) {
			super(parent, 0, 0, "Item Info");
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void{
			var line:HBox = new HBox(this);
			new Label(line, 0, 0, "Name =");
			_name = new Label(line);
			//
			line = new HBox(this);
			new Label(line, 0, 0, "x =");
			_x = new Label(line);
			line = new HBox(this);
			new Label(line, 0, 0, "y =");
			_y = new Label(line);
			line = new HBox(this);
			new Label(line, 0, 0, "width =");
			_w = new Label(line);
			line = new HBox(this);
			new Label(line, 0, 0, "height =");
			_h = new Label(line);
			//
			new Label(this, 0, 0, "Vertexes");
			_vertex = new Text(this);
			_vertex.editable = false;
			_vertex.setSize(this.width - 10, 50);
			new Label(this, 0, 0, "UV");
			_uv = new Text(this);
			_uv.editable = false;
			_uv.setSize(this.width - 10, 50);
			new Label(this, 0, 0, "Indexes");
			_indexes = new Text(this);
			_indexes.editable = false;
			_indexes.setSize(this.width - 10, 20);
			this.height += 250;
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		override public function set data(value:Object):void {
			if(value != null){
				_name.text = value.name;
				_vertex.text = value.vertexes;
				_uv.text = value.uv;
				_indexes.text = value.indexes;
				_x.text = value.rect.x;
				_y.text = value.rect.y;
				_w.text = value.rect.width;
				_h.text = value.rect.height;

			}
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
