/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:01
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.bit101.components.ComboBox;
	import com.bit101.components.FPSMeter;
	import com.bit101.components.HBox;
	import com.bit101.components.IndicatorLight;
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.unitls.Resolutions;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class ProjectInfoView extends WidgetWindow {

		private var _projectModel:ProjectModel;

		private var _saveIndicator:IndicatorLight;
		private var _projectResolution:Label;
		private var _targetResoultion:ComboBox;
		private var _boundOffset:InputText;
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
			var resolutions:Array = [
				Resolutions.toString(Resolutions.RETINA),
				Resolutions.toString(Resolutions.FULL_HD),
				Resolutions.toString(Resolutions.XGA),
				Resolutions.toString(Resolutions.VGA),
				Resolutions.toString(Resolutions.QVGA)
			];
			var line:HBox = new HBox(this);
			new Label(line, 0, 0, "Project Name =");
			_name = new Label(line, 0, 0, "big project name with trulala and tralalu");
			line = new HBox(this);
			new Label(line, 0, 0, "Project resolution =");
			_projectResolution = new Label(line, 0, 0, "2048x2048");
			//
			line = new HBox(this);
			new Label(line, 0, 0, "Target");
			_targetResoultion = new ComboBox(line, 0, 0, resolutions[0], resolutions);
			//
			line = new HBox(this);
			new Label(line, 0, 0, "Bounds");
			_boundOffset = new InputText(line, 0, 0, "0");
			//
			_saveIndicator = new IndicatorLight(this, 0, 0, 0xFFFF0000, " Not saved");
			_saveIndicator.isLit = true;
			this.height += 50;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function comboBoxHandler(event:Event):void {
			_projectModel.targetResolution = Resolutions.fromString(_targetResoultion.selectedItem.toString());
		}

		private function inputHandler(event:Event):void {
			if(_boundOffset.text.length > 0){
				_projectModel.boundsOffset = int(_boundOffset.text);
			}
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		override public function set data(value:Object):void {
			this.enabled = value != null;
			if(this.enabled){
				_projectModel = value as ProjectModel;
				_name.text = _projectModel.name;
				_projectResolution.text = Resolutions.toString(_projectModel.referenceResolution);
				_boundOffset.text = _projectModel.boundsOffset.toString();
				_saveIndicator.color = _projectModel.saved ? 0xFF00FF00 : 0xFFFF0000;
				_saveIndicator.label = _projectModel.saved ? "Saved" : "Not saved";
				//choose target resolution
				var targetString:String = Resolutions.toString(_projectModel.targetResolution);
				var list:Array = _targetResoultion.items;
				for(var i:int = 0; i < list.length; i++){
					if(list[i] == targetString){
						_targetResoultion.selectedIndex = i;
						break;
					}
				}
				//add listeners
				_targetResoultion.addEventListener(Event.SELECT, this.comboBoxHandler);
				_boundOffset.addEventListener(Event.CHANGE, this.inputHandler);
			}
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
