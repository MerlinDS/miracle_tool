/**
 * User: MerlinDS
 * Date: 04.04.2014
 * Time: 15:48
 */
package com.merlinds.miracle_tool {
	import com.merlinds.miracle_tool.components.BaseButton;
	import com.merlinds.miracle_tool.tools.ITool;
	import com.merlinds.miracle_tool.tools.structures.StructureConverter;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class MiracleTool extends Sprite {

		private var _tools:Object;/**ITool**/

		public function MiracleTool() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, this.initializeHandler);
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function drawGui():void{
			var button:BaseButton = new BaseButton("Select structure");
			button.addEventListener(MouseEvent.CLICK, this.buttonHandler);
			this.addChild(button);
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function initializeHandler(event:Event):void {
			this.removeEventListener(event.type, arguments.callee);
			_tools = {
				"Select structure":StructureConverter
			};
			this.drawGui();
		}

		private function buttonHandler(event:MouseEvent):void {
			var button:BaseButton = event.target as BaseButton;
			var toolClass:Class = _tools[button.name];
			var tool:ITool = new toolClass();
			tool.execute(this.toolCallback);
		}

		private function toolCallback():void {

		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
