/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:21
 */
package com.merlinds.miracle_tool.models {
	import com.merlinds.miracle_tool.models.vo.ActionVO;

	import org.robotlegs.mvcs.Actor;

	public class AppModel extends Actor {

		private var _menuActions:Vector.<ActionVO>;

		public function AppModel() {
			super();
			_menuActions = new <ActionVO>[];
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function get menuActions():Vector.<ActionVO> {
			return _menuActions;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
