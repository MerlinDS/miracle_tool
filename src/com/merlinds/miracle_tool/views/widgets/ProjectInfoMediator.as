/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:54
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.merlinds.miracle_tool.events.EditorEvent;

	public class ProjectInfoMediator extends WidgetMediator {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectInfoMediator() {
			super();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		override protected function editorHandler(event:EditorEvent):void {
			this.data = this.projectModel.infoVO;
			super.editorHandler(event);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
