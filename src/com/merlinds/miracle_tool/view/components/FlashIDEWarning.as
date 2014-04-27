/**
 * User: MerlinDS
 * Date: 26.04.2014
 * Time: 10:36
 */
package com.merlinds.miracle_tool.view.components {
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	import com.merlinds.miracle_tool.Config;
	import com.merlinds.miracle_tool.models.AppModel;

	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;

	public class FlashIDEWarning extends Window {

		private var _model:AppModel;

		public function FlashIDEWarning(parent:DisplayObjectContainer, model:AppModel) {
			_model = model;
			var stage:Stage = parent.stage;
			var x:int = stage.stageWidth - Config.windowWindth >> 1;
			var y:int = stage.stageHeight - Config.windowHeight >> 1;
			super(parent, x, y, "Warning");
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		override protected function init():void {
			super.init();
			this.shadow = false;
			this.hasCloseButton = true;
			this.setSize(Config.windowWindth, Config.windowHeight);
			var box:VBox = new VBox(this);
			var text:Text = new Text(box, 0, 0, "Cannot find Flash IDE.\n " +
					"Please point to Flash.exe file.");
			text.selectable = false;
			text.editable = false;
			var button:PushButton = new PushButton(box, 0, 0, "Select file", this.selectButtonHandler);
			button.x = this.width - button.width >> 1;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function selectButtonHandler(event:MouseEvent):void {
			var file:File = File.desktopDirectory;
			file.addEventListener(Event.SELECT, this.selectHandler);
			file.browseForOpen("Point to Flash.exe", [new FileFilter("choose Flash.exe", "*.exe")]);
		}

		private function selectHandler(event:Event):void{
			var file:File = event.target as File;
			//TODO LQ-37 need Flash.exe validation by it's signature
			_model.flashIDEPath = file.nativePath;
			this.onClose(new MouseEvent(MouseEvent.CLICK));
		}

//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
