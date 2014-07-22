/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 22:22
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.ActionEvent;
	import com.merlinds.miracle_tool.events.DialogEvent;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.models.vo.AnimSourcesVO;
	import com.merlinds.miracle_tool.models.vo.AnimationVO;
	import com.merlinds.miracle_tool.models.vo.TimelineVO;
	import com.merlinds.miracle_tool.services.ActionService;
	import com.merlinds.miracle_tool.utils.XMLConverters;

	import flash.geom.Matrix;
	import flash.geom.Point;

	import org.robotlegs.mvcs.Command;

	public class AnimationConverterCommand extends Command {

		private static const BLANK_TYPE:String = "blank";
		private static const TWEEN_TYPE:String = "tween";
		private static const MATRIX_TYPE:String = "matrix";
		private static const MOTION_TYPE:String = "motion";

		private static const TWEEN_ALL_FLAG:String = "all";
		private static const TWEEN_POSITION_FLAG:String = "position";
		private static const TWEEN_SCALE_FLAG:String = "scale";
		private static const TWEEN_ROTATION_FLAG:String = "rotation";

		[Inject]
		public var projectModel:ProjectModel;
		[Inject]
		public var actionService:ActionService;
		[Inject]
		public var event:ActionEvent;

		private var _animation:AnimationVO;
		private var _timeline:TimelineVO;
		private var _namespace:Namespace;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AnimationConverterCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			var data:AnimSourcesVO = this.projectModel.tempData;
			if(data == null){
				this.projectModel.tempData = this.event.body;
				this.actionService.addAcceptActions(new <String>[this.event.type]);
				this.dispatch(new DialogEvent(DialogEvent.CHOOSE_ANIMATION, this.event.body.names));
			}else{
				this.projectModel.tempData = null;
				data.chosen.push(this.event.body["list"]);
				_animation = this.projectModel.animationInProgress;
				var name:String;
				while(data.chosen.length > 0){
					name = data.chosen.pop();
					if(name == AnimSourcesVO.DEFAULT_NAME){
						name = _animation.file.name;
						name = name.substr(_animation.file.extension.length);
					}
					this.convertXML(data[name] as XML, name);
				}
			}
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function convertXML(xml:XML, name:String):void{
			log(this, "convertXML", name);
			_timeline = new TimelineVO(name);
			//add namespace
			_namespace = new Namespace(xml.inScopeNamespaces()[0],
					xml.inScopeNamespaces()[1]);
			default xml namespace = _namespace;
			xml.normalize();
			//start parse
			var layersList:XMLList = xml.timeline.DOMTimeline.layers.children();
			var n:int = layersList.length();
			//get all layers
			for(var i:int = 0; i < n; i++){
				var child:XML = layersList[i];
				if(child.@layerType != "folder"){//exclude Folders from parsing
					//parse frames on layer
					this.parseFrames( child.frames.DOMFrame );
				}
			}
			//end
			_animation.timelines.push(_timeline);
		}

		[Inline]
		private function parseFrames(frames:XMLList):void {
			log(this, "parseFrames");
			default xml namespace =  _namespace;

			var n:int = frames.length();
			for(var i:int = 0; i < n; i++) {
				var frame:XML = frames[i];
				var duration:int = frame.@duration;
				var index:int = frame.@index;
				trace("Frame duration =", duration, "; index =", index);
				if(frame.@tweenType == MOTION_TYPE){
					trace("Has classic motion");
				}
				this.parseElements(frame.elements.DOMSymbolInstance);
			}
		}

		[Inline]
		private function parseElements(elements:XMLList):void {
			default xml namespace =  _namespace;

			var n:int = elements.length();
			for(var i:int = 0; i < n; i++) {
				var element:XML = elements[i];
				var elementName:String = element.@libraryItemName;
				//get element matrix
				var matrix:Matrix = XMLConverters.convertToObject(element.matrix.Matrix, Matrix);
				var transformationPoint:Point = XMLConverters.convertToObject(
						element.transformationPoint.Point, Point);

				//TODO add colors multipliers
				trace(elementName, matrix, transformationPoint);
			}
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