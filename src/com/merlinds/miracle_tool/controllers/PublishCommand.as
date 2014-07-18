/**
 * User: MerlinDS
 * Date: 18.07.2014
 * Time: 15:14
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.services.FileSystemService;

	import org.robotlegs.mvcs.Command;

	public class PublishCommand extends Command {

		[Inject]
		public var projectModel:ProjectModel;
		[Inject]
		public var fileSystemService:FileSystemService;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function PublishCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			this.fileSystemService.writeTexture();
			this.fileSystemService.writeTimeline();
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
