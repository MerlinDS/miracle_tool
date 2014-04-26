/**
 * User: MerlinDS
 * Date: 26.04.2014
 * Time: 11:22
 */
package com.merlinds.miracle_tool.tools.editor.view.components {
	import com.bit101.components.List;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	import com.merlinds.miracle_tool.Config;
	import com.merlinds.miracle_tool.tools.editor.models.EditorModel;

	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.MouseEvent;

	public class SelectAnimationWindow extends Window {

		private var _model:EditorModel;
		private var _list:List;

		public function SelectAnimationWindow(parent:DisplayObjectContainer, model:EditorModel) {
			_model = model;
			var stage:Stage = parent.stage;
			var x:int = stage.stageWidth - Config.windowWindth >> 1;
			var y:int = stage.stageHeight - Config.windowHeight * 2 >> 1;
			super(parent, x, y, "Select animation");
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		override protected function init():void {
			super.init();
			this.setSize(Config.windowWindth, Config.windowHeight * 2);
//			this.hasCloseButton = true;
			var box:VBox = new VBox(this);
			_list = new List(box, 0, 0, _model.libraryListing);
			var button:PushButton = new PushButton(box, 0, 0, "Select", this.selectHandler);
			button.x = this.width - button.width >> 1;
			_list.setSize(this.width,
							this.height - _titleBar.height - button.height - box.spacing * 2);
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function selectHandler(event:MouseEvent):void {
			_model.instanceName = _list.selectedItem.toString();
			this.onClose(event);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		//} endregion GETTERS/SETTERS ==================================================
	}
}
