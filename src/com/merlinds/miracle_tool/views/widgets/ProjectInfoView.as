/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:01
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.bit101.components.FPSMeter;
	import com.bit101.components.HBox;
	import com.bit101.components.IndicatorLight;
	import com.bit101.components.Label;
	import com.merlinds.miracle_tool.models.vo.ProjectInfoVO;

	import flash.display.DisplayObjectContainer;

	public class ProjectInfoView extends WidgetWindow {

		private var _saveIndicator:IndicatorLight;
		private var _size:Label;
		private var _name:Label;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectInfoView(parent:DisplayObjectContainer = null) {
			super(parent, 0, 0, "Project Info");
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function initialize():void{
			var line:HBox = new HBox(this);
			new Label(line, 0, 0, "Project Name =");
			_name = new Label(line, 0, 0, "big project name with trulala and tralalu");
			line = new HBox(this);
			new Label(line, 0, 0, "Project size =");
			_size = new Label(line, 0, 0, "2048x2048");
			_saveIndicator = new IndicatorLight(this, 0, 0, 0xFFFF0000, " Not saved");
			_saveIndicator.isLit = true;
			new FPSMeter(this);
			this.height += 10;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		override public function set data(value:Object):void {
			this.enabled = value != null;
			if(this.enabled){
				var info:ProjectInfoVO = value as ProjectInfoVO;
				_name.text = info.name;
				_size.text = info.screenSize;
				_saveIndicator.color = info.saved ? 0xFF00FF00 : 0xFFFF0000;
				_saveIndicator.label = info.saved ? "Saved" : "Not saved";
			}
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
