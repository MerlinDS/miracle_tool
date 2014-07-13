/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:36
 */
package com.merlinds.miracle_tool.views.project {
	import org.robotlegs.mvcs.Mediator;

	public class ToolsMediator extends Mediator {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ToolsMediator() {
			super();
		}


		override public function onRegister():void {
			trace("Ok");
			super.onRegister();
		}

		override public function onRemove():void {
			super.onRemove();
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
