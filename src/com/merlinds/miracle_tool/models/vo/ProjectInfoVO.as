/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 16:16
 */
package com.merlinds.miracle_tool.models.vo {
	public class ProjectInfoVO {

		public var name:String;
		public var screenSize:String;
		public var saved:Boolean;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectInfoVO(name:String, screenSize:String) {
			this.name = name;
			this.screenSize = screenSize;
		}

		public function setSaved(value:Boolean = true):ProjectInfoVO {
			this.saved = value;
			return this;
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
