/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 18:06
 */
package com.merlinds.miracle_tool.tools {
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.tools.compilers.CompilerSWF;
	import com.merlinds.miracle_tool.tools.editor.EditorTool;

	import flash.events.ErrorEvent;

	import flash.events.Event;

	import flash.events.EventDispatcher;
	[Event(type="flash.events.Event", name="change")]
	[Event(type="flash.events.ErrorEvent", name="error")]

	public class ToolProcessor extends EventDispatcher {

		private var _model:AppModel;
		private var _tools:Vector.<AbstractTool>;
		private var _currentTool:int;

		public function ToolProcessor(model:AppModel) {
			_model = model;
			this.prepareTools();
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function execute():void {
			trace("Execute processing for file", _model.workFLA.name);
			if(_currentTool < 0){
				this.nextTool();
			}else{
				trace("Previous conversion not finished yet");
			}
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function prepareTools():void{
			_tools = new <AbstractTool>[ new CompilerSWF(), new EditorTool() ];
			for(var i:int = 0; i < _tools.length; i++){
				_tools[i].model = _model;
				_tools[i].callback = this.callback;
				_tools[i].errorCallback = this.errorCallback;
			}
			_currentTool = -1;
		}

		private function nextTool():void {
			if(++_currentTool >= _tools.length){
				_currentTool = -1;
			}

			if(_currentTool >= 0) {
				this.dispatchEvent(new Event(Event.CHANGE));
				_tools[_currentTool].execute();
			} else{
				this.dispatchEvent( new Event(Event.COMPLETE));
			}
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function callback():void{
			this.nextTool();
		}

		private function errorCallback(error:Error):void{
			this.dispatchEvent( new ErrorEvent(ErrorEvent.ERROR, error.message));
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
