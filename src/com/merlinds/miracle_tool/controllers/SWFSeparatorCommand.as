/**
 * User: MerlinDS
 * Date: 14.07.2014
 * Time: 19:06
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.services.DecodeService;

	import org.robotlegs.mvcs.Command;

	public class SWFSeparatorCommand extends Command {

		[Inject]
		public var projectModel:ProjectModel;
		[Inject]
		public var decodeService:DecodeService;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function SWFSeparatorCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			var output:Object = this.decodeService.output;
			this.decodeService.clear();
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
