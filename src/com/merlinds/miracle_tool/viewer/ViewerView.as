/**
 * User: MerlinDS
 * Date: 18.07.2014
 * Time: 17:42
 */
package com.merlinds.miracle_tool.viewer {
	import com.bit101.components.List;
	import com.bit101.components.List;
	import com.bit101.components.Window;
	import com.merlinds.debug.log;
	import com.merlinds.miracle.Miracle;
	import com.merlinds.miracle.display.MiracleImage;
	import com.merlinds.miracle.utils.Asset;
	import com.merlinds.miracle.utils.MtfReader;
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
		private var _assets:Vector.<Asset>;
		private var _window:Window;
		private var _name:String;

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

		private function choseAnimation():void {
			//find animation asset and add all of animations to chose list
			var n:int = _assets.length;
			for(var i:int = 0; i < n; i++){
				var asset:Asset = _assets[i];
				if(asset.type == Asset.TIMELINE_TYPE){
					//parse output
					_window = new Window(this, 0, 0, "Chose mesh");
					var list:List = new List(_window, 0, 0, this.getAnimations(asset.output));
					_window.x = this.stage.stageWidth - _window.width;
					list.addEventListener(Event.SELECT, this.selectAnimationHandler);
				}
			}
		}

		private function getAnimations(bytes:ByteArray):Array {
			var result:Array = [];

			return result;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function createHandler(animation:Boolean = false):void {
			//TODO: Show view if it exit
			if(animation || _model.viewerInput == null){
				_model.viewerInput = _model.lastFileDirection;
				_model.viewerInput.addEventListener(Event.SELECT, this.selectFileHandler);
				_model.viewerInput.browseForOpen("Open " + animation ? "Animation" : "Sprite"
						+ "file that you want to view");
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
			if(_assets == null)_assets = new <Asset>[];
			var asset:Asset = new Asset(_model.viewerInput.name, byteArray);
			if(asset.type == Asset.TIMELINE_TYPE){
				_name = asset.name;
			}
			_assets.push(asset);
//			var name:String = asset.name;
			if(_assets.length > 1){
				this.choseAnimation();
				Miracle.createScene(_assets, 1);
				Miracle.currentScene.createImage(_name)
						.addEventListener(Event.ADDED_TO_STAGE, this.imageAddedToStage);
				Miracle.resume();
			}else{
				this.createHandler(true);
			}
		}

		private function selectAnimationHandler(event:Event):void {
			var list:List = event.target as List;
			log(this, "selectAnimationHandler", list.selectedItem);
			//add animation to miracle
			var name:String = list.selectedItem.toString();

		}

		private function imageAddedToStage(event:Event):void {
			var target:MiracleImage = event.target as MiracleImage;
			target.moveTO(
					this.stage.stageWidth - target.width >> 1,
					this.stage.stageHeight - target.height >> 1
			);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
