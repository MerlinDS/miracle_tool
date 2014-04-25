/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 21:57
 */
package com.merlinds.miracle_tool.tools.editor {
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.tools.editor.models.EditorModel;

	import flash.display.BitmapData;

	import flash.display.Graphics;

	import flash.display.Sprite;
	import flash.events.Event;

	public class Editor extends Sprite {

		private var _appModel:AppModel;
		private var _model:EditorModel;

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
			//TODO add preloader
			var swfLoader:SWFLoader = new SWFLoader();
			swfLoader.addEventListener(Event.COMPLETE, this.competeLoaderHandler);
			swfLoader.load(_appModel.workSWF);
		}

		private function competeLoaderHandler(event:Event):void {
			var swfLoader:SWFLoader = event.target as  SWFLoader;
			swfLoader.removeEventListener(event.type, this.competeLoaderHandler);
			_model.target = swfLoader.output;
			//for test
			this.addChild(_model.target);
			var test:* = _model.libraryListing;
			trace(test);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
