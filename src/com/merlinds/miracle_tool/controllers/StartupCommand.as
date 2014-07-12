/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:20
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;

	import flash.utils.setTimeout;

	import org.robotlegs.base.ContextEvent;

	import org.robotlegs.mvcs.Command;

	public class StartupCommand extends Command {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function StartupCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute", "STARTUP");
			this.modelsMapping();
			this.controllersMapping();
			this.viewsMapping();
			log(this, "execute", "STARTUP_COMPLETE");
			//on next frame
			setTimeout(this.dispatch, 0, new ContextEvent(ContextEvent.STARTUP_COMPLETE));
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function modelsMapping():void {
			log(this, "modelsMapping");
		}

		private function controllersMapping():void {
			log(this, "controllersMapping");
			this.commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, ViewInitializerCommand, ContextEvent, true);
		}

		private function viewsMapping():void {
			log(this, "viewsMapping");
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
