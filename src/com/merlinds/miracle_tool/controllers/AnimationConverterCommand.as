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
	import com.merlinds.miracle_tool.models.vo.FrameVO;
	import com.merlinds.miracle_tool.models.vo.TimelineVO;
	import com.merlinds.miracle_tool.services.ActionService;
	import com.merlinds.miracle_tool.utils.XMLConverters;

	import flash.geom.Matrix;
	import flash.geom.Point;

	import org.robotlegs.mvcs.Command;

	public class AnimationConverterCommand extends Command {

		[Inject]
		public var projectModel:ProjectModel;
		[Inject]
		public var actionService:ActionService;
		[Inject]
		public var event:ActionEvent;

		private var _animation:AnimationVO;

		private var _currentFrame:FrameVO;
		private var _currentTimeline:TimelineVO;

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
			_animation.name = name;
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
					_currentTimeline = new TimelineVO();
					this.parseFrames( child.frames.DOMFrame );
					_animation.timelines.push(_currentTimeline);
				}
			}
			//end
		}

		[Inline]
		private function parseFrames(frames:XMLList):void {
			log(this, "parseFrames");
			default xml namespace =  _namespace;
			var n:int = frames.length();
			for(var i:int = 0; i < n; i++) {
				var frame:XML = frames[i];
				_currentFrame = new FrameVO(frame.@index, frame.@duration);
				_currentFrame.type = frame.@tweenType;
				this.parseElements(frame.elements.DOMSymbolInstance);
				_currentTimeline.frames.push(_currentFrame);
				trace(_currentFrame.toString());
			}
		}

		[Inline]
		private function parseElements(elements:XMLList):void {
			default xml namespace =  _namespace;

			var n:int = elements.length();
			for(var i:int = 0; i < n; i++) {
				var element:XML = elements[i];
				_currentFrame.name = element.@libraryItemName;
				//get element matrix
				_currentFrame.matrix = XMLConverters.convertToObject(element.matrix.Matrix, Matrix);
				_currentFrame.transformationPoint = XMLConverters.convertToObject(
						element.transformationPoint.Point, Point);

				//TODO add colors multipliers, create vo for colors
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