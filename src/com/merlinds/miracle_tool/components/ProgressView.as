/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 16:03
 */
package com.merlinds.miracle_tool.components {
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class ProgressView extends ProgressMC {

		private static const STATES:Vector.<String> = new <String>["start", "swf", "png", "atf", "finish"];

		private var _currentState:int;

		public function ProgressView(parent:DisplayObjectContainer = null) {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addHandler);
			if(parent != null){
				parent.addChild(this);
			}
		}


		//==============================================================================
		//{region							PUBLIC METHODS

		public function nextState():void {
			if(++_currentState >= STATES.length ){
				_currentState = 0;
			}

			var state:String = STATES[_currentState];
			this.p.gotoAndStop(state);
			this.x = this.stage.stageWidth - this.width >> 1;
			if(_currentState == 0)
				this.y = this.stage.stageHeight - this.height >> 1;
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================
		private function addHandler(event:Event):void {
			this.removeEventListener(event.type, this.addHandler);
			_currentState = -1;
		}

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
