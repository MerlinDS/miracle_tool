/**
 * User: MerlinDS
 * Date: 18.07.2014
 * Time: 17:42
 */
package com.merlinds.miracle_tool.viewer {
	import com.merlinds.miracle_tool.models.vo.ConfigVO;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;

	[SWF(backgroundColor="0x333333", frameRate=60)]
	public class ViewerView extends Sprite {

		[Embed(source="../../../../../assets/app.cgf", mimeType="application/octet-stream")]
		private static var Config:Class;
		private var _config:ConfigVO;

		private var _input:File;
		private var _mtf:ByteArray;

		public function ViewerView(input:File = null, config:ConfigVO = null) {
			super();
			_input = input;
			if(config == null){
				config = new ConfigVO(new Config());
			}
			_config = config;

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

			//TODO: Initialize Miracle

			if(_input == null){
				var so:SharedObject = SharedObject.getLocal(_config.settingsFile);
				if(so.size > 0){
					_input = new File(so.data[_config.lastFileDirection]);
				}else{
					_input = File.documentsDirectory;
				}
				_input.addEventListener(Event.SELECT, this.selectFileHandler)
				_input.browseForOpen("Open file that you want to view");
			}
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function selectFileHandler(event:Event):void {
			_input.removeEventListener(event.type, this.selectFileHandler);
			_mtf = new ByteArray();
			var stream:FileStream = new FileStream();
			stream.open(_input, FileMode.READ);
			stream.readBytes(_mtf);
			stream.close();
			//parse
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
