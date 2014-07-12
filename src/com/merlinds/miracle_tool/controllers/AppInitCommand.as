/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:23
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.ActionEvent;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.models.vo.ActionVO;

	import org.robotlegs.mvcs.Command;

	public class AppInitCommand extends Command {

		[Inject]
		public var _model:AppModel;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AppInitCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			this.initializeMenuActions();
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function initializeMenuActions():void {
			this.addAction(NewProjectCommand, ActionEvent, ActionEvent.NEW_PROJECT, "New...");
			this.addAction(OpenProjectCommand, ActionEvent, ActionEvent.OPEN_PROJECT, "Open...");
			this.addAction(CloseProjectCommand, ActionEvent, ActionEvent.CLOSE_PROJECT, "Close...");
			this.addAction(SaveProjectCommand, ActionEvent, ActionEvent.SAVE_PROJECT, "Save As...");
			this.addAction(OpenSettingCommand, ActionEvent, ActionEvent.OPEN_SETTINGS, "Settings...");
			this.addAction(OpenHelpCommand, ActionEvent, ActionEvent.OPEN_HELP, "Help...");
		}

		private function addAction(command:Class, event:Class, type:String, title:String):void {
			this.commandMap.mapEvent(type, command, event);
			_model.menuActions.push(new ActionVO(title, event, type));
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
