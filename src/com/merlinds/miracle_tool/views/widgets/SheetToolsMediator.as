/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:57
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.vo.SheetToolsVO;

	import flash.filesystem.File;

	public class SheetToolsMediator extends WidgetMediator {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function SheetToolsMediator() {
			super();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		override protected function editorHandler(event:EditorEvent):void {
			super.editorHandler(event);
			this.data = new SheetToolsVO(
					this.projectModel.sources,
					this.projectModel.elements.length,
					this.projectModel.sheetSize
			);
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
