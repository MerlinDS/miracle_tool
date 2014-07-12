/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:35
 */
package com.merlinds.miracle_tool.views {
	import com.merlinds.miracle_tool.utils.dispatchAction;
	import com.merlinds.miracle_tool.views.components.controls.ActionButton;

	import flash.events.MouseEvent;

	import org.robotlegs.mvcs.Mediator;

	public class AppMenuMediator extends Mediator {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function AppMenuMediator() {
			super();
		}

		override public function onRegister():void {
			this.addViewListener(MouseEvent.CLICK, this.mouseClickHandler);
		}

		override public function onRemove():void {
			this.removeViewListener(MouseEvent.CLICK, this.mouseClickHandler);
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function mouseClickHandler(event:MouseEvent):void {
			var target:Object = event.target;
			if(target is ActionButton){
				dispatchAction((target as ActionButton).action, this.dispatch);
			}
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
