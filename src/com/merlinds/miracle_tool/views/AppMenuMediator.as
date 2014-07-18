/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:35
 */
package com.merlinds.miracle_tool.views {
	import com.merlinds.miracle_tool.events.ActionEvent;
	import com.merlinds.miracle_tool.services.ActionService;
	import com.merlinds.miracle_tool.utils.dispatchAction;
	import com.merlinds.miracle_tool.views.components.controls.ActionButton;

	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	import org.robotlegs.mvcs.Mediator;

	public class AppMenuMediator extends Mediator {

		[Inject]
		public var actionService:ActionService;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AppMenuMediator() {
			super();
		}

		override public function onRegister():void {
			this.contextView.stage.addEventListener(KeyboardEvent.KEY_UP, this.keyboardHandler);
			this.addViewListener(MouseEvent.CLICK, this.mouseClickHandler);
		}

		override public function onRemove():void {
			this.removeViewListener(MouseEvent.CLICK, this.mouseClickHandler);
			this.contextView.stage.removeEventListener(KeyboardEvent.KEY_UP, this.keyboardHandler);
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

		private function keyboardHandler(event:KeyboardEvent):void {
			switch (event.keyCode){
				case 78: // N
					if(event.ctrlKey){
						//new project
						this.dispatch(new ActionEvent(ActionEvent.NEW_PROJECT));
					}
					break;
				case 83: // S
					if(event.ctrlKey){
						//save project
						this.dispatch(new ActionEvent(ActionEvent.SAVE_PROJECT));
					}
					break;
				case 81: // Q
					if(event.ctrlKey){
						//close program
					}
					break;
				case 69: // E
					if(event.ctrlKey){
						//close project
						this.dispatch(new ActionEvent(ActionEvent.CLOSE_PROJECT));
					}
					break;
				case 86: // V
					break;
				case 72: // H
					break;
				case 119: // F8
					break;
				case 120: // F9
					break;
			}
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
