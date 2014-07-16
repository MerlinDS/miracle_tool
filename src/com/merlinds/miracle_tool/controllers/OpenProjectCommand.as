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
	import com.merlinds.miracle_tool.models.vo.ActionVO;

	import org.robotlegs.mvcs.Command;

	public class OpenProjectCommand extends Command {

		[Inject]
		public var appModel:AppModel;
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
				//display message that previous project will be closed;
				if(event.body == null){
					//open project setting dialog
					var actionVO:ActionVO = this.appModel.getActionByType(this.event.type);
					this.dispatch(new DialogEvent(DialogEvent.SAVE_PROJECT, actionVO));
				}else{
					//TODO: open project
				}
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
