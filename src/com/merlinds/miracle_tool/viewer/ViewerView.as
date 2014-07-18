/**
 * User: MerlinDS
 * Date: 18.07.2014
 * Time: 17:42
 */
package com.merlinds.miracle_tool.viewer {
	import com.merlinds.miracle.Miracle;
	import com.merlinds.miracle.utils.Asset;
	import com.merlinds.miracle_tool.models.AppModel;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	[SWF(backgroundColor="0x333333", frameRate=60)]
	public class ViewerView extends Sprite {

		private var _model:AppModel;

		public function ViewerView(model:AppModel = null) {
			super();
			_model = model;
			if(_model == null){
				_model = new AppModel();
			}

			this.addEventListener(Event.ADDED_TO_STAGE, this.initialize);
		}
		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function initialize(event:Event):void {
			this.removeEventListener(event.type, this.initialize);
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			Miracle.start(this.stage, this.createHandler, true);
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function createHandler():void {
			if(_model.viewerInput == null){
				_model.viewerInput = _model.lastFileDirection;
				_model.viewerInput.addEventListener(Event.SELECT, this.selectFileHandler)
				_model.viewerInput.browseForOpen("Open file that you want to view");
			}
		}

		private function selectFileHandler(event:Event):void {
			_model.viewerInput.removeEventListener(event.type, this.selectFileHandler);
			_model.lastFileDirection = _model.viewerInput.parent;
			var byteArray:ByteArray = new ByteArray();
			var stream:FileStream = new FileStream();
			stream.open(_model.viewerInput, FileMode.READ);
			stream.readBytes(byteArray);
			stream.close();
			//parse
			var asset:Asset = new Asset(_model.viewerInput.name, byteArray);
			Miracle.createScene(new <Asset>[asset], 1);
			Miracle.currentScene.createImage(asset.name);
			Miracle.resume();
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
