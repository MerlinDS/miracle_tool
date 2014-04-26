/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 21:57
 */
package com.merlinds.miracle_tool.tools.editor {
	import com.bit101.components.Window;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.tools.editor.models.EditorModel;
	import com.merlinds.miracle_tool.tools.editor.view.components.SelectAnimationWindow;

	import flash.display.Bitmap;

	import flash.display.BitmapData;

	import flash.display.Graphics;

	import flash.display.Sprite;
	import flash.events.Event;

	public class Editor extends Sprite {

		private var _appModel:AppModel;
		private var _model:EditorModel;

		private var _textureScreen:Bitmap;
		private var _texturePacker:TexturePacker;

		private var _window:Window;

		public function Editor(model:AppModel) {
			_appModel = model;
			this.addEventListener(Event.ADDED_TO_STAGE, this.initHandler);
			super();
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function drawTile():void{
			var g:Graphics = this.graphics;
			var tile:BitmapData = new PSTile();
			g.beginBitmapFill(tile);
			g.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			g.endFill();
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function initHandler(event:Event):void {
			this.removeEventListener(event.type, initHandler);
			this.drawTile();
			//start
			_model = new EditorModel();
			_textureScreen = new Bitmap();
			_texturePacker = new TexturePacker(_model);
			this.addChild(_textureScreen);
			//TODO add preloader
			var swfLoader:SWFLoader = new SWFLoader();
			swfLoader.addEventListener(Event.COMPLETE, this.competeLoaderHandler);
			swfLoader.load(_appModel.workSWF);
		}

		private function competeLoaderHandler(event:Event):void {
			var swfLoader:SWFLoader = event.target as  SWFLoader;
			swfLoader.removeEventListener(event.type, this.competeLoaderHandler);
			_model.target = swfLoader.output;
			_window = new SelectAnimationWindow(this, _model);
			_window.addEventListener(Event.CLOSE, this.selectAnimationHandler);
		}

		private function selectAnimationHandler(event:Event):void {
			_window.removeEventListener(event.type, this.selectAnimationHandler);
			this.removeChild(_window);
			_texturePacker.execute(_model.instanceName);
			this.addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
		}

		private function enterFrameHandler(event:Event):void {
			if(_texturePacker.complete){
				this.removeEventListener(event.type, this.enterFrameHandler);
				trace("All done", _model.output.width);
			}else{
				_texturePacker.enterFrame();
				_textureScreen.bitmapData = _model.output;
			}
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
