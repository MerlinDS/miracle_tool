/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:56
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.ActionEvent;
	import com.merlinds.miracle_tool.events.DialogEvent;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.services.ActionService;

	import org.robotlegs.mvcs.Command;

	public class OpenProjectCommand extends Command {

		[Inject]
		public var appModel:AppModel;
		[Inject]
		public var actionService:ActionService;
		[Inject]
		public var event:ActionEvent;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function OpenProjectCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			if(!this.injector.hasMapping(ProjectModel)){

			}else{
				this.actionService.addAcceptActions(new <String>[ActionEvent.SAVE_PROJECT,
					ActionEvent.CLOSE_PROJECT, this.event.type]);
				this.actionService.addDenyActions(new <String>[ActionEvent.CLOSE_PROJECT, this.event.type]);
				this.dispatch(new DialogEvent(DialogEvent.SAVE_PROJECT));
			}
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
