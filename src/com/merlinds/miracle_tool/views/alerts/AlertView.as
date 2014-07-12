/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:38
 */
package com.merlinds.miracle_tool.views.alerts {
	import com.merlinds.miracle_tool.view.interfaces.IResizable;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class AlertView extends Sprite implements IResizable{

		//==============================================================================
		//{region							PUBLIC METHODS
		public function AlertView(parent:DisplayObjectContainer = null) {
			super();
			parent.addChild(this);
		}

		public function setSize(w:Number, h:Number):void {
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
