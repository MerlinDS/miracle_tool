/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 21:57
 */
package com.merlinds.miracle_tool.tools.editor {
	import com.bit101.components.Window;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.tools.editor.models.EditorModel;
	import com.merlinds.miracle_tool.tools.editor.models.Element;
	import com.merlinds.miracle_tool.tools.editor.view.components.CompleteWindow;
	import com.merlinds.miracle_tool.tools.editor.view.components.SelectAnimationWindow;

	import flash.display.Bitmap;

	import flash.display.BitmapData;

	import flash.display.Graphics;

	import flash.display.Sprite;
	import flash.events.Event;

	public class Editor extends Sprite {

		private var _appModel:AppModel;
		private var _model:EditorModel;

		private var _tile:BitmapData;
		private var _textureScreen:Sprite;
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
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function initHandler(event:Event):void {
			this.removeEventListener(event.type, initHandler);
			this.graphics.beginFill(0x333333);
			this.graphics.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			this.graphics.endFill();
			//start
			_tile = new PSTile();
			_model = new EditorModel();
			_textureScreen = new Sprite();
			_texturePacker = new TexturePacker(_model);
			this.addChild(_textureScreen);
			var swfLoader:SWFLoader = new SWFLoader();
			swfLoader.addEventListener(Event.COMPLETE, this.competeLoaderHandler);
			swfLoader.load(_appModel.workSWF);
		}

		private function competeLoaderHandler(event:Event):void {
			var swfLoader:SWFLoader = event.target as  SWFLoader;
			swfLoader.removeEventListener(event.type, this.competeLoaderHandler);
			_model.target = swfLoader.output;
			_window = new SelectAnimationWindow(this, _model);
			_window.addEventListener(Event.CLOSE, this.closeHandler);
		}

		private function closeHandler(event:Event):void {
			_window.removeEventListener(event.type, arguments.callee);
			this.removeChild(_window);
			if(_window is CompleteWindow){
				_model.cleanElements();
				_appModel.output = _model.output.clone();
				_appModel.elements = _model.elements;
				_model.destroy();
				this.stage.nativeWindow.close();
			}else{
				_texturePacker.execute(_model.instanceName);
				this.addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
			}
		}

		private function enterFrameHandler(event:Event):void {
			if(_texturePacker.complete){
				this.removeEventListener(event.type, this.enterFrameHandler);
				trace("All done", _model.output.width);
				_window = new CompleteWindow(this);
				_window.addEventListener(Event.CLOSE, this.closeHandler);
			}else{
				_texturePacker.enterFrame();
				//clear old view
				_textureScreen.removeChildren();
				_textureScreen.graphics.clear();
				//draw tiles
				var g:Graphics = _textureScreen.graphics;
				g.lineStyle(1);
				g.beginBitmapFill(_tile);
				g.drawRect(0, 0, _model.output.width, _model.output.height);
				g.endFill();
				//draw output
				_textureScreen.addChild(new Bitmap(_model.output));
				//centring
				_textureScreen.x = this.stage.stageWidth - _textureScreen.width >> 1;
				_textureScreen.y = this.stage.stageHeight - _textureScreen.height >> 1;
			}
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
