/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:17
 */
package com.merlinds.miracle_tool {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.controllers.StartupCommand;

	import flash.display.DisplayObjectContainer;

	import org.robotlegs.base.ContextEvent;

	import org.robotlegs.mvcs.Context;

	public class ApplicationContext extends Context {


		public function ApplicationContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true) {
			super(contextView, autoStartup);
		}
		//==============================================================================
		//{region							PUBLIC METHODS
		override public function startup():void {
			log(this, "startup");
			this.commandMap.mapEvent(ContextEvent.STARTUP, StartupCommand, ContextEvent, true);
			this.dispatchEvent( new ContextEvent(ContextEvent.STARTUP));
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
