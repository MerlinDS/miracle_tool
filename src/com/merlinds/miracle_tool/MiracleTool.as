/**
 * User: MerlinDS
 * Date: 04.04.2014
 * Time: 15:48
 */
package com.merlinds.miracle_tool {
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.tools.editor.EditorLauncher;
	import com.merlinds.miracle_tool.view.MainScene;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	public class MiracleTool extends Sprite {

		private var _model:AppModel;

		public function MiracleTool() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, this.initializeHandler);
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function initializeHandler(event:Event):void {
			this.removeEventListener(event.type, this.initializeHandler);
			new Config("C:\\Program Files\\Adobe\\Adobe Flash CC\\Flash.exe");
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;

			_model = new AppModel();
			EditorLauncher.getInstance().initialize(this.stage, _model);

			var scene:MainScene = new MainScene(_model);
			this.addChild(scene);
		}

		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
