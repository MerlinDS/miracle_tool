/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:28
 */
package com.merlinds.miracle_tool.events {
	import flash.events.Event;

	import org.robotlegs.base.ContextEvent;

	public class ActionEvent extends ContextEvent {

		/** Open new project **/
		public static const NEW_PROJECT:String = "ActionEvent::NEW_PROJECT";
		/** Open saved project **/
		public static const OPEN_PROJECT:String = "ActionEvent::OPEN_PROJECT";
		/** Close project **/
		public static const CLOSE_PROJECT:String = "ActionEvent::CLOSE_PROJECT";
		/** Save project **/
		public static const SAVE_PROJECT:String = "ActionEvent::SAVE_PROJECT";
		/** Open application help **/
		public static const OPEN_HELP:String = "ActionEvent::OPEN_HELP";
		/** Open application settings **/
		public static const OPEN_SETTINGS:String = "ActionEvent::OPNE_SETTINGS";

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ActionEvent(type:String, body:* = null) {
			super(type, body);
		}

		override public function clone():Event {
			return new ActionEvent(type, body);
		}

		override public function toString():String {
			return this.formatToString("ActionEvent", "type", "body");
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
