/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 14:50
 */
package com.merlinds.miracle_tool.view {
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import com.bit101.components.VBox;
	import com.merlinds.miracle_tool.Config;
	import com.merlinds.miracle_tool.components.ProgressView;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.services.FileManager;
	import com.merlinds.miracle_tool.tools.ToolProcessor;
	import com.merlinds.miracle_tool.view.components.FlashIDEWarning;

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
			new PushButton(_buttonBox, 0, 0, "Animation Viewer").enabled = false;
			new PushButton(_buttonBox, 0, 0, "Create animation", this.createButtonHandler);
			_buttonBox.x = this.stage.stageWidth - _buttonBox.width >> 1;
			_buttonBox.y = this.stage.stageHeight - _buttonBox.height >> 1;
		}

		private function createButtonHandler(event:MouseEvent = null):void {
			if(Config.flashIDEPath == null){
				new FlashIDEWarning(this, _model, this.createButtonHandler);
			}else{
				_buttonBox.visible = false;
				var fileManager:FileManager = new FileManager(_model);
				fileManager.addEventListener(Event.COMPLETE, this.fileCompleteHandler);
				fileManager.browseForFLA();
			}
		}

		private function fileCompleteHandler(event:Event):void {
			var fileManager:FileManager = event.target as FileManager;
			fileManager.removeEventListener(event.type, arguments.callee);
			this.selectAnimationHandler(new Event(Event.SELECT));
		}

		private function selectAnimationHandler(event:Event):void {
			_progressView = new ProgressView(this);
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
