/**
 * User: MerlinDS
 * Date: 18.07.2014
 * Time: 17:42
 */
package com.merlinds.miracle_tool.viewer {
	import com.bit101.components.List;
	import com.bit101.components.PushButton;
	import com.merlinds.miracle.Miracle;
	import com.merlinds.miracle.animations.AnimationHelper;
	import com.merlinds.miracle.display.MiracleDisplayObject;
	import com.merlinds.miracle.utils.Asset;
	import com.merlinds.miracle.utils.MafReader;
	import com.merlinds.miracle_tool.models.AppModel;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;

	[SWF(backgroundColor="0x333333", frameRate=60)]
	public class ViewerView extends Sprite {

		private var _model:AppModel;
		private var _startBtn:PushButton;
		private var _texture:ByteArray;
		private var _animation:ByteArray;
		private var _fileName:String;
		private var _list:List;
		private var _instance:MiracleDisplayObject;

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
			_startBtn = new PushButton(this, this.stage.stageWidth >> 1, this.stage.stageHeight >> 1,
					"Start", this.startBtnHandler );
		}

		public function clear():void
		{
			if(_animation != null) _animation.clear();
			if(_texture != null) _texture.clear();
			_texture = null;
			_animation = null;
			_fileName = null;
		}

		private function startHandler():void {
			trace("Miracle was started");
			var maf:Asset = new Asset(_fileName + ".maf", _animation);
			var mtf:Asset = new Asset(_fileName + ".mtf", _texture);
			Miracle.createScene(new <Asset>[maf, mtf], this.createdHandler, 1);
		}

		private function createdHandler():void {
			trace("Scene created");
			this.getAnimationList();
		}

		private function getAnimationList():void {
			var mafReader:MafReader = new MafReader();
			mafReader.execute(_animation, 1, function():void{});
			var animationsName:Array = [];
			for each(var animation:AnimationHelper in mafReader.animations)
			{
//				animationsName.push(animation.name);
			}
			trace("Was get animations", animationsName);
			_list = new List(this, this.stage.stageWidth - 200, 0, animationsName);
			_list.width = 200;
			_list.addEventListener(Event.SELECT, this.selectAnimationHandler);
		}

		private function getAnimation():void {
			var file:File = _model.lastFileDirection;
			file.browseForOpen("Get animation file", [new FileFilter("Miracle animation format", "*.maf")] );
			file.addEventListener(Event.SELECT, this.animationSelected);
			file.addEventListener(Event.CANCEL, this.animationSelected);
		}

		private function readAnimation(file:File):void {
			_animation = new ByteArray();
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			fileStream.readBytes(_animation);
			fileStream.close();
		}

		private function getTexture(file:File):void {
			_fileName = file.name.substr(0, -file.extension.length - 1);
			file.browseForOpen("Get texture file", [new FileFilter("Miracle texture format", _fileName + ".mtf")] );
			file.addEventListener(Event.SELECT, this.animationSelected);
			file.addEventListener(Event.CANCEL, this.animationSelected);
		}

		private function readTexture(file:File):void {
			_texture = new ByteArray();
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			fileStream.readBytes(_texture);
			fileStream.close();
		}

		public function startBtnHandler(event:Event):void{
			_startBtn.visible = false;
			getAnimation();
		}

		private function animationSelected(event:Event):void {
			if(event.type == Event.CANCEL)
			{
				this.clear();
				_startBtn.visible = true;
			}else
			{
				if(_animation == null)
				{
					this.readAnimation(event.target as File);
					this.getTexture(event.target as File);
				}else
				{
					this.readTexture(event.target as File);
					trace("All loaded");
					Miracle.start(this.stage, this.startHandler, true);
				}
			}
		}

		private function selectAnimationHandler(event:Event):void {
			if(_instance != null)
			{
				Miracle.scene.removeInstance(_instance);
			}
			var selected:String = _list.selectedItem as String;
			var dot:int = selected.lastIndexOf(".");
			var animation:String = selected.substr(dot+1);
			var mesh:String = selected.substr(0, dot);
			_instance = Miracle.scene.createImage(mesh, animation);
			_instance.x = this.stage.stageWidth >> 1;
			_instance.y = this.stage.stageHeight >> 1;
			_instance.visible = true;
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
