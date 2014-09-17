/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 22:22
 */
package com.merlinds.miracle_tool.controllers.converters {
	import com.merlinds.debug.log;
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


		private var _inputLayers:Array;
		private var _animation:AnimationVO;

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
						_animation.name = animation.name;
						_animation.file = this.projectModel.tempFile;
						_animation.added = true;
						this.prepareData4Animation(data[sourceName] as XML);
						this.convert2Animation();
					}
				}
			}
			this.dispatch(new EditorEvent(EditorEvent.ANIMATION_ATTACHED, source.name));
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function prepareData4Animation(xml:XML):void {
			_namespace = new Namespace(xml.inScopeNamespaces()[0],
					xml.inScopeNamespaces()[1]);
			default xml namespace = _namespace;
			xml.normalize();
			var layers:XMLList = xml.timeline.DOMTimeline.layers.children();
			var n:int = layers.length();
			//get all layers and prepare for converting
			_inputLayers = [];
			for(var i:int = 0; i < n; i++){
				var layer:XML = layers[i];
				if(layer.@layerType != "folder"){
					//exclude Folders from list
					_inputLayers = _inputLayers.concat( this.readSourceLayer(layer) );
				}
			}
		}

		private function convert2Animation():void {
			var n:int = _inputLayers.length;
			_animation.timelines.length = n;
			for(var i:int = 0; i < n; i++){
				var layer:Array = _inputLayers[i];
				var timeline:TimelineVO = new TimelineVO();
				var m:int = layer.length;
				timeline.frames.length = m;
				for(var j:int = 0; j < m; j++){
					timeline.frames[j] = layer[j];
				}
				_animation.timelines[i] = timeline;
			}
		}

		private function readSourceLayer(layer:XML):Array {
			default xml namespace =  _namespace;
			/*
			 * This array will contains layer that was separated from current source layer
			 * Will contains minimum one layer.
			 * In case when source layer contains more than one symbol,
			 * this layer will be separated to N output layers, where N - count of symbols on source layer
			 */
			//get all frames of the source layer
			var frames:XMLList = layer.frames.DOMFrame;
			var separatedLayer:Array = this.createEmptyLayers(frames);
			var m:int = separatedLayer.length;
			var n:int = frames.length();
			for(var i:int = 0; i < n; i++){
				var frame:XML = frames[i];
				//read all symbols on the frame
				var symbols:XMLList = frame.elements.DOMSymbolInstance;
				var o:int = symbols.length();//number of symbols
				for(var j:int = 0; j < m; j++){
					var frameVO:FrameVO = new FrameVO(frame.@index, frame.@duration);
					if(j < o){
						var symbol:XML = symbols[j];
						//convert symbol to frame object and save it to sublayer
						frameVO.type = frame.@tweenType;
						this.parseSymbols(symbol, frameVO);
					}
					separatedLayer[j][i] = frameVO;
				}
			}
			return separatedLayer;
		}

		private function createEmptyLayers(frames:XMLList):Array {
			default xml namespace =  _namespace;
			var separatedLayer:Array = [];
			var n:int = frames.length();
			for(var i:int = 0; i < n; i++){
				var frame:XML = frames[i];
				//read all symbols on the frame
				var symbols:XMLList = frame.elements.DOMSymbolInstance;
				var m:int = symbols.length();
				for(var j:int = 0; j < m; j++){
					if(j + 1 > separatedLayer.length){//Sublayer does not exit in separatedLayer
						separatedLayer[j] = [];
						separatedLayer[j].length = n;
					}
				}
			}
			return separatedLayer;
		}

		private function parseSymbols(elements:XML, frameVO:FrameVO):void {
			default xml namespace =  _namespace;

			var n:int = elements.length();
			for(var i:int = 0; i < n; i++) {
				var element:XML = elements[i];
				frameVO.name = element.@libraryItemName;
				//get element matrix
				frameVO.matrix = XMLConverters.convertToObject(element.matrix.Matrix, Matrix);
				frameVO.transformationPoint = XMLConverters.convertToObject(
						element.transformationPoint.Point, Point);
				frameVO.color = new XMLColorConverter(element.color.Color);
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