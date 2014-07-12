/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:56
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;

	import org.robotlegs.mvcs.Command;

	public class OpenProjectCommand extends Command {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function OpenProjectCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
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
