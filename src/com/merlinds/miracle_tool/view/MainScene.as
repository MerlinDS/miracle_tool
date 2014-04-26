/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 14:50
 */
package com.merlinds.miracle_tool.view {
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import com.bit101.components.VBox;
	import com.merlinds.miracle_tool.components.ProgressView;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.services.FileManager;
	import com.merlinds.miracle_tool.tools.ToolProcessor;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;

	public class MainScene extends Sprite {
		private var _buttonBox:VBox;

		private var _progressView:ProgressView;
		private var _processor:ToolProcessor;
		private var _model:AppModel;

		//==============================================================================
		//{region							PUBLIC METHODS

		public function MainScene(model:AppModel) {
			super();
			_model = model;
			_processor = new ToolProcessor(model);
			this.addEventListener(Event.ADDED_TO_STAGE, addHandler);
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS

		private function addHandler(event:Event):void {
			this.removeEventListener(event.type, this.addHandler);
			//draw menu
			Style.setStyle(Style.DARK);
			_buttonBox = new VBox(this);
			_buttonBox.addChild( new PushButton(this, 0, 0, "Animation Viewer") );
			_buttonBox.addChild( new PushButton(this, 0, 0, "Create animation", this.buttonHandler) );
			_buttonBox.x = this.stage.stageWidth - _buttonBox.width >> 1;
			_buttonBox.y = this.stage.stageHeight - _buttonBox.height >> 1;
		}

		private function buttonHandler(event:MouseEvent):void {
			var fileManager:FileManager = new FileManager(_model);
			fileManager.browseForFLA();
			fileManager.addEventListener(Event.COMPLETE, this.fileCompleteHandler);
		}

		private function fileCompleteHandler(event:Event):void {
			var fileManager:FileManager = event.target as FileManager;
			fileManager.removeEventListener(event.type, arguments.callee);
			_buttonBox.visible = false;
			//TODO: add this after swf parsing
//			var inputDialog:InputDialogView = new InputDialogView();
//			inputDialog.addEventListener(Event.SELECT, this.selectAnimationHandler);
//			this.addChild(inputDialog);
			this.selectAnimationHandler(new Event(Event.SELECT));
		}

		private function selectAnimationHandler(event:Event):void {
//			var inputDialog:InputDialogView = event.target as InputDialogView;
			_progressView = new ProgressView();
			this.addChild(_progressView);
//			this.removeChild(inputDialog);
			_model.instanceName = "test";//inputDialog.message.text;
//
			_processor.addEventListener(Event.CHANGE, changeHandler);
			setTimeout(_processor.execute, 0);
		}

		private function changeHandler(event:Event):void {
			_progressView.nextState();
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
