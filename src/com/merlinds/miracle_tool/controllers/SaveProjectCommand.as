/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:57
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.view.logger.StatusBar;

	import org.robotlegs.mvcs.Command;

	public class SaveProjectCommand extends Command {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function SaveProjectCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			StatusBar.warning("SaveProjectCommand not yet implemented");
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
