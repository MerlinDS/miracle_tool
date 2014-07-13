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
	import com.merlinds.miracle_tool.models.vo.SheetToolsVO;

	import flash.display.DisplayObjectContainer;

	public class SheetToolsView extends WidgetWindow {

		private var _sources:List;
		private var _size:Label;
		private var _numElements:Label;
		private var _sourceAttach:PushButton;
		private var _animationAttach:PushButton;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function SheetToolsView(parent:DisplayObjectContainer = null) {
			super(parent, 0, 0, "Sheet Tools");
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void{
			_sourceAttach = new PushButton(this, 0, 0, "Attach new texture");
			_animationAttach = new PushButton(this, 0, 0, "Attach new animation");
			_sources = new List(this, 0, 0);
			var line:HBox = new HBox(this);
			new Label(line, 0, 0, "Sheet size =");
			_size = new Label(line, 0, 0, "2048x2048");
			line = new HBox(this);
			new Label(line, 0, 0, "Elements =");
			_numElements = new Label(line);
			this.height += 130;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		override public function set data(value:Object):void {
			this.enabled = value != null;
			if(this.enabled){
				var vo:SheetToolsVO = value as SheetToolsVO;
				_numElements.text = vo.numElements.toString();
				_size.text = vo.size.toString();
				while(vo.sources.length){
					_sources.addItem(vo.sources.pop());
				}
				if(_sources.items.length == 0){
					_sources.enabled = false;
					_animationAttach.enabled = false;
				}else{
					_sources.enabled = true;
					_animationAttach.enabled = true;
				}
			}
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
