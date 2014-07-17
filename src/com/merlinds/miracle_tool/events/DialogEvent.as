/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 23:05
 */
package com.merlinds.miracle_tool.events {
	import flash.events.Event;

	import org.robotlegs.base.ContextEvent;

	public class DialogEvent extends ContextEvent {

		public static const SAVE_PROJECT:String = "AlertEvent::SAVE_PROJECT";
		public static const PROJECT_SETTINGS:String = "AlertEvent::PROJECT_SETTINGS";
		public static const CHOOSE_ANIMATION:String = "AlertEvent::CHOOSE_ANIMATION";
		//==============================================================================
		//{region							PUBLIC METHODS
		public function DialogEvent(type:String, body:* = null) {
			super(type, body);
		}

		override public function clone():Event {
			return new DialogEvent(type, body);
		}

		override public function toString():String {
			return this.formatToString("DialogEvent", "type", "body");
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
