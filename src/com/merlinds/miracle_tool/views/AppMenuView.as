/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:39
 */
package com.merlinds.miracle_tool.views {
	import com.bit101.components.HBox;
	import com.bit101.components.Label;
	import com.merlinds.miracle_tool.models.vo.ActionVO;
	import com.merlinds.miracle_tool.views.interfaces.IResizable;
	import com.merlinds.miracle_tool.views.components.controls.ActionButton;

	import flash.display.DisplayObjectContainer;

	public class AppMenuView extends HBox implements IResizable{

		private static const HEIGHT:int = 40;

		private var _buttons:Vector.<ActionButton>;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AppMenuView(parent:DisplayObjectContainer, actions:Vector.<ActionVO>) {
			super(parent, 0, 0);
			this.initialize(actions);
		}


		public function projectState(open:Boolean):void {
			for each(var button:ActionButton in _buttons){
				if(button.action.onProject){
					button.enabled = open;
				}
			}
		}

		override public function setSize(w:Number, h:Number):void {
			super.setSize(w, HEIGHT);
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		private function initialize(actions:Vector.<ActionVO>):void{
			new Label(this, 0, 0, "Miracle Editor:");
			_buttons = new <ActionButton>[];
			var n:int = actions.length;
			for(var i:int = 0; i < n; i++){
				var action:ActionVO = actions[i];
				if(action.inMenu){
					var button:ActionButton = new ActionButton(this, action.title, this.dispatchEvent);
					button.action = action;
					_buttons.push( button );
				}
			}
			this.projectState(false);
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
		public function get buttons():Vector.<ActionButton> {
			return _buttons;
		}

		public function set buttons(value:Vector.<ActionButton>):void {
			_buttons = value;
		}
	}
}
