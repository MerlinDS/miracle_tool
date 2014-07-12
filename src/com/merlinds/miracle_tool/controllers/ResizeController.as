/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:55
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.warning;
	import com.merlinds.miracle_tool.view.interfaces.IResizable;

	import flash.display.Stage;
	import flash.events.Event;

	import org.robotlegs.mvcs.Actor;

	/**
	 * Resize view instances by actual stage sizes
	 */
	public class ResizeController extends Actor {

		private var _stage:Stage;
		private var _instances:Vector.<IResizable>;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ResizeController() {
			_instances = new <IResizable>[];
			super();
		}

		public function addInstance(instace:IResizable):void {
			if(!this.hasInstance(instace)){
				_instances.push(instace);
			}else{
				warning(this, "addInstance", "instance already added");
			}
		}

		public function removeInstance(instace:IResizable):void {
			var indexOf:int = _instances.indexOf(instace);
			if(indexOf >= 0){
				_instances.splice(indexOf, 1);
			}else{
				warning(this, "removeInstance", "can not find instance");
			}
		}

		public function hasInstance(instace:IResizable):Boolean {
			var indexOf:int = _instances.indexOf(instace);
			return indexOf >= 0;
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function resizeHandler(event:Event):void {
			var n:int = _instances.length;
			for(var i:int = 0; i < n; i++){
				var instance:IResizable = _instances[i];
				instance.setSize(_stage.stageWidth, _stage.stageHeight);
			}
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function set stage(value:Stage):void {
			if(_stage != null){
				_stage.removeEventListener(Event.RESIZE, this.resizeHandler);
			}
			_stage = value;
			if(_stage != null){
				_stage.addEventListener(Event.RESIZE, this.resizeHandler);
			}
		}

		//} endregion GETTERS/SETTERS ==================================================
	}
}
