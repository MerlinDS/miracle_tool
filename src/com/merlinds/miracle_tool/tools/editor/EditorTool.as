/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 23:16
 */
package com.merlinds.miracle_tool.tools.editor {
	import com.merlinds.miracle_tool.tools.AbstractTool;

	public class EditorTool extends AbstractTool {
		public function EditorTool() {
			super();
		}

		//==============================================================================
		//{region							PUBLIC METHODS

		override public function execute():void {
			EditorLauncher.getInstance().execute(this.executeCallback);
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
