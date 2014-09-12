/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 22:22
 */
package com.merlinds.miracle_tool.controllers.converters {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.controllers.converters.XMLColorConverter;
	import com.merlinds.miracle_tool.events.ActionEvent;
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.models.vo.AnimSourcesVO;
	import com.merlinds.miracle_tool.models.vo.AnimationVO;
	import com.merlinds.miracle_tool.models.vo.FrameVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;
	import com.merlinds.miracle_tool.models.vo.TimelineVO;
	import com.merlinds.miracle_tool.services.ActionService;
	import com.merlinds.miracle_tool.utils.XMLConverters;

	import flash.debugger.enterDebugger;

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
			//search for animation in file
			var data:AnimSourcesVO = this.event.body as AnimSourcesVO;
			var source:SourceVO = this.projectModel.selected;
			if(source == null)source = this.projectModel.inProgress;
			var n:int = source.animations.length;
			for(var i:int = 0; i < n; i++){
				var animation:AnimationVO = source.animations[i];
				for(var sourceName:String in data){
					if(animation.name + '.xml' == sourceName){
						_animation = animation;
						this.convertXML( data[sourceName] as XML, animation.name );
						_animation.file = this.projectModel.tempFile;
						_animation.added = true;
					}
				}
			}
			this.dispatch(new EditorEvent(EditorEvent.ANIMATION_ATTACHED, source.name));
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
//			trace(_animation.timelines);
		}

		[Inline]
		private function parseFrames(frames:XMLList):void {
//			log(this, "parseFrames");
			default xml namespace =  _namespace;
			var n:int = frames.length();
			for(var i:int = 0; i < n; i++) {
				var frame:XML = frames[i];
				_currentFrame = new FrameVO(frame.@index, frame.@duration);
				_currentFrame.type = frame.@tweenType;
				this.parseElements(frame.elements.DOMSymbolInstance);
				_currentTimeline.frames.push(_currentFrame);
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
				_currentFrame.color = new XMLColorConverter(element.color.Color);
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