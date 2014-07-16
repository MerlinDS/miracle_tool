/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 14:20
 */
package com.merlinds.miracle_tool.events {
	import flash.events.Event;

	import org.robotlegs.base.ContextEvent;

	public class EditorEvent extends ContextEvent {

		public static const CREATE_PROJECT:String = "EditorEvent::CREATE_PROJECT";
		public static const PROJECT_OPEN:String = "EditorEvent::PROJECT_OPEN";
		public static const PROJECT_CLOSED:String = "EditorEvent::PROJECT_CLOSED";
		//Attaches
		public static const SOURCE_ATTACHED:String = "EditorEvent::SOURCE_ATTACHED";
		public static const ANIMATION_ATTACHED:String = "EditorEvent::ANIMATION_ATTACHED";
		public static const FILE_READ:String = "EditorEvent::FILE_READ";
		//Tools
		public static const PLACE_ITEMS:String = "EditorEvent::PLACE_ITEMS";
		public static const SELECT_ITEM:String = "EditorEvent::SELECT_ITEM";
		//==============================================================================
		//{region							PUBLIC METHODS
		public function EditorEvent(type:String, body:* = null) {
			super(type, body);
		}

		override public function clone():Event {
			return new DialogEvent(type, body);
		}

		override public function toString():String {
			return this.formatToString("EditorEvent", "type", "body");
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
