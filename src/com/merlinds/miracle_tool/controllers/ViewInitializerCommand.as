/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:26
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;

	import org.robotlegs.mvcs.Command;

	public class ViewInitializerCommand extends Command {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ViewInitializerCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			//create views of the application and add it to stage
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
