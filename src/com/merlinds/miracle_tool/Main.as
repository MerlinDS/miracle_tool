/**
 * User: MerlinDS
 * Date: 04.04.2014
 * Time: 15:48
 */
package com.merlinds.miracle_tool {

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	[SWF(backgroundColor="0x333333", frameRate=60)]
	public class Main extends Sprite {

		//==============================================================================
		//{region							PUBLIC METHODS
		public function Main() {
			super ();
			this.addEventListener(Event.ADDED_TO_STAGE, this.initialize);
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function initialize(event:Event):void {
			this.removeEventListener(event.type, this.initialize);
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			var rl:ApplicationContext = new ApplicationContext(this);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
