/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 22:10
 */
package com.merlinds.miracle_tool.tools.editor {
	import com.merlinds.miracle_tool.models.AppModel;

	import flash.display.NativeWindow;

	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;

	public class EditorLauncher {

		private static var _instance:EditorLauncher;

		private var _options:NativeWindowInitOptions;
		private var _model:AppModel;
		private var _stage:Stage;
		private var _onClose:Function;

		public function EditorLauncher() {

		}
		//==============================================================================
		//{region							PUBLIC METHODS
		public static function getInstance():EditorLauncher {
			if(_instance == null){
				_instance = new EditorLauncher();
			}
			return _instance;
		}

		public function initialize(stage:Stage, model:AppModel):void{
			_stage = stage;
			_model = model;
			_options = new NativeWindowInitOptions();
			_options.type = NativeWindowType.UTILITY;
			_options.systemChrome = NativeWindowSystemChrome.STANDARD;
			_options.resizable = true;
			_options.owner = _stage.nativeWindow;
		}

		public function execute(onClose:Function):void{
			var list:Vector.<NativeWindow> = _stage.nativeWindow.listOwnedWindows();
			for(var i:int = 0; i < list.length; i++){
				list[i].close();
			}
			_onClose = onClose;
			this.createWindow();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		private function createWindow():void {
			var newWindow:NativeWindow = new NativeWindow(_options);
			newWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
			newWindow.stage.align = StageAlign.TOP_LEFT;
			newWindow.stage.stageWidth = 1024;
			newWindow.stage.stageHeight = 780;
			newWindow.bounds = new Rectangle(200, 200, 1024, 780);
			newWindow.title = "Editor: " + _model.workFLA.name;
			//
			var editor:Editor = new Editor(_model);
			newWindow.stage.addChild(editor);
			newWindow.activate();
			newWindow.addEventListener(Event.CLOSE, this.closeHandler);
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function closeHandler(event:Event):void {
			trace("Editor was closed");
			var target:EventDispatcher = event.target as EventDispatcher;
			target.removeEventListener(event.type, arguments.callee);
			_onClose.apply(this);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
