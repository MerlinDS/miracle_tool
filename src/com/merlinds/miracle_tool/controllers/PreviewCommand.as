/**
 * User: MerlinDS
 * Date: 18.07.2014
 * Time: 19:06
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.viewer.ViewerView;

	import org.robotlegs.mvcs.Command;

	public class PreviewCommand extends Command {

		[Inject]
		public var model:AppModel;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function PreviewCommand() {
			super();
		}

		override public function execute():void {
			var viewer:ViewerView = new ViewerView(this.model);
			this.contextView.addChild(viewer);
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
