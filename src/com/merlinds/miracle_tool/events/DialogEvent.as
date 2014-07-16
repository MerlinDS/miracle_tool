/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 23:05
 */
package com.merlinds.miracle_tool.events {
	import com.merlinds.miracle_tool.models.vo.ActionVO;

	import flash.events.Event;

	import org.robotlegs.base.ContextEvent;

	public class DialogEvent extends ContextEvent {

		public static const SAVE_PROJECT:String = "AlertEvent::SAVE_PROJECT";
		public static const PROJECT_SETTINGS:String = "AlertEvent::PROJECT_SETTINGS";

		private var _action:ActionVO;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function DialogEvent(type:String, action:ActionVO, body:* = null) {
			super(type, body);
			_action = action;
		}

		override public function clone():Event {
			return new DialogEvent(type, action, body);
		}

		override public function toString():String {
			return this.formatToString("DialogEvent", "type", "action", "body");
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

		public function get action():ActionVO {
			return _action;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
