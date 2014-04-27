/**
 * User: MerlinDS
 * Date: 26.04.2014
 * Time: 17:29
 */
package com.merlinds.miracle_tool.tools.parsers {
	import com.merlinds.miracle_tool.tools.AbstractTool;

	public class ParserFLA extends AbstractTool {
		public function ParserFLA() {
			super();
		}

		//==============================================================================
		//{region							PUBLIC METHODS

		override public function execute():void {
			super.execute();
			trace("OK. Lets do it!");
			//TODO: LQ-25 Ask the user for necessity of FLA parsing
			//TODO: LQ-25 Parse FLA file in need
			//TODO: LQ-25 At first FLA file need to be downloaded, that unzip it and parse
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
