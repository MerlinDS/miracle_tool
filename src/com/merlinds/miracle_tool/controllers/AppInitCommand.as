/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:23
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.ActionEvent;
	import com.merlinds.miracle_tool.events.DialogEvent;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.models.vo.ActionVO;
	import com.merlinds.miracle_tool.models.vo.DialogVO;
	import com.merlinds.miracle_tool.views.alerts.dialogs.ProjectSettingDialog;
	import com.merlinds.miracle_tool.views.alerts.dialogs.SaveProjectDialog;

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
			this.initializeDialogs();
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function initializeMenuActions():void {
			this.mapAction(NewProjectCommand, ActionEvent, ActionEvent.NEW_PROJECT, "New...");
			this.mapAction(OpenProjectCommand, ActionEvent, ActionEvent.OPEN_PROJECT, "Open...");
			this.mapAction(CloseProjectCommand, ActionEvent, ActionEvent.CLOSE_PROJECT, "Close...");
			this.mapAction(SaveProjectCommand, ActionEvent, ActionEvent.SAVE_PROJECT, "Save As...");
			this.mapAction(OpenSettingCommand, ActionEvent, ActionEvent.OPEN_SETTINGS, "Settings...");
			this.mapAction(OpenHelpCommand, ActionEvent, ActionEvent.OPEN_HELP, "Help...");
		}

		private function initializeDialogs():void {
			this.mapDialog(ProjectSettingDialog, DialogEvent.PROJECT_SETTINGS);
			this.mapDialog(SaveProjectDialog, DialogEvent.SAVE_PROJECT);
		}
		//utilities
		[Inline]
		private function mapAction(command:Class, event:Class, type:String, title:String):void {
			this.commandMap.mapEvent(type, command, event);
			_model.menuActions.push(new ActionVO(title, event, type));
		}

		[Inline]
		private function mapDialog(clazz:Class, type:String):void {
			_model.dialogs.push( new DialogVO(clazz, type ));
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
