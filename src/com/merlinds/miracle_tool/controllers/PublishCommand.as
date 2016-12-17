/**
 * User: MerlinDS
 * Date: 18.07.2014
 * Time: 15:14
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle.geom.Transformation;
	import com.merlinds.miracle.utils.serializers.MTFSerializer;
	import com.merlinds.miracle_tool.events.ActionEvent;
	import com.merlinds.miracle_tool.events.DialogEvent;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.models.vo.AnimationVO;
	import com.merlinds.miracle_tool.models.vo.ElementVO;
	import com.merlinds.miracle_tool.models.vo.FrameVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;
	import com.merlinds.miracle_tool.models.vo.TimelineVO;
	import com.merlinds.miracle_tool.services.ActionService;
	import com.merlinds.miracle_tool.services.FileSystemService;
	import com.merlinds.miracle_tool.utils.MeshUtils;
	import com.merlinds.unitls.Resolutions;

	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	import org.robotlegs.mvcs.Command;

	public class PublishCommand extends Command {

		[Inject]
		public var projectModel:ProjectModel;
		[Inject]
		public var fileSystemService:FileSystemService;
		[Inject]
		public var actionService:ActionService;
		[Inject]
		public var event:ActionEvent;

		private var _mesh:ByteArray;
		private var _png:ByteArray;
		private var _animations:ByteArray;

		private var _scale:Number;
		private var _elements:Object;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function PublishCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			if(event.body == null){
				var data:Object = {
					projectName:this.projectModel.name
				};
				this.actionService.addAcceptActions(new <String>[ActionEvent.PUBLISHING]);
				this.dispatch(new DialogEvent(DialogEvent.PUBLISH_SETTINGS, data));
			}else{
				var  projectName:String = event.body.projectName;
				_scale = Resolutions.width(this.projectModel.targetResolution) /
						Resolutions.width(this.projectModel.referenceResolution);
				this.createOutput();
				this.fileSystemService.writeTexture(projectName, _png, _mesh);
				this.fileSystemService.writeAnimation(_animations);
			}
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function createOutput():void{
			var buffer:BitmapData = new BitmapData(this.projectModel.outputSize, this.projectModel.outputSize, true, 0x0);
			_elements = {};
			var meshes:Array = [];
			var animations:Array = [];
			var n:int = this.projectModel.sources.length;
			for(var i:int = 0; i < n; i++){
				var mesh:Array = [];
				var source:SourceVO = this.projectModel.sources[i];
				var m:int = source.elements.length;
				for(var j:int = 0; j < m; j++){
					//push element view to buffer
					var element:ElementVO = source.elements[j];
					var depth:Point = new Point(element.x, element.y);
					//assert
					/*var kl:int = element.x;
					if(element.x - kl != 0)
						throw new Error("This");
					kl = element.y;
					if(element.y - kl != 0)
						throw new Error("Tis");*/

					buffer.copyPixels(element.bitmapData, element.bitmapData.rect, depth);
					//get mesh
					mesh.push({
						name:element.name,
						vertices:MeshUtils.flipToY(element.vertexes),
						uv:MeshUtils.covertToRelative(element.uv, this.projectModel.outputSize),
						indexes:element.indexes
					});
					//save mesh bounds to buffer for animation bounds calculation
					_elements[element.name] = element.vertexes;
				}
				meshes.push({name:source.clearName, mesh:mesh});
				//get animation
				m = source.animations.length;
				for(j = 0; j < m; j++){
					var animation:Object = this.createAnimationOutput(source.animations[j], source.clearName);
					animations.push(animation);
				}
			}
			trace("mesh");
			var json:String = JSON.stringify(meshes);
			trace(json);
			var serializer:MTFSerializer =  MTFSerializer.createSerializer(MTFSerializer.V2);
			_mesh = serializer.serialize(meshes);
//			_mesh.writeObject(meshes);
			_animations = new ByteArray();
			_animations.writeObject(animations);
			_animations.position = 0;
			var test:Object = _animations.readObject();
			_png = PNGEncoder.encode(buffer);
		}

		private function createAnimationOutput(animationVO:AnimationVO, meshPrefix:String):Object {
			var data:Object = { name:meshPrefix + "." + animationVO.name,// name of the matrix
				totalFrames:animationVO.totalFrames,// Total animation frames
				layers:[]};
			//scale bounds
			var bounds:Rectangle = animationVO.bounds.clone();
			bounds.x = bounds.x * _scale;
			bounds.y = bounds.y * _scale;
			bounds.width = bounds.width * _scale;
			bounds.height = bounds.height * _scale;
			data.bounds = bounds;
			//calculate frames
			var n:int = animationVO.timelines.length;
			//find matrix sequence for current animation
			for(var i:int = 0; i < n; i++){
				var timelineVO:TimelineVO = animationVO.timelines[i];
				var m:int = timelineVO.frames.length;
				var layer:Layer = new Layer();
				for(var j:int = 0; j < m; j++){
					var frameVO:FrameVO = timelineVO.frames[j];
					//create matrix
					var transform:Transformation = frameVO.generateTransform(_scale,
							//get previous frame transformation object
							layer.matrixList.length > 0 ? layer.matrixList[ layer.matrixList.length - 1] : null
					);
					var index:int = transform == null ? -1 : layer.matrixList.push(transform) - 1;
					var framesArray:Array = this.createFramesInfo(index, frameVO.name,
							frameVO.duration, frameVO.type == "motion");
					layer.framesList = layer.framesList.concat(framesArray);
				}
				data.layers.unshift(layer);
			}
			return data;
		}

		[Inline]
		private function createFramesInfo(index:int, polygonName:String,
		                                  duration:int, motion:Boolean):Array {
			var result:Array = new Array(duration);
			if(duration < 2){
				motion = false;
			}
			if(index > -1){
				var t:Number = 1 / duration;
				for(var i:int = 0; i < duration; i++){
					var frameInfoData:FrameInfoData = new FrameInfoData();
					frameInfoData.index = index;
					frameInfoData.polygonName = polygonName;
					frameInfoData.motion = motion;
					frameInfoData.t = motion ? t * i : 0;
					result[i] = frameInfoData;
				}
			}
			return result;
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
class Layer{
	public var matrixList:Array;
	public var framesList:Array;

	public function Layer() {
		this.framesList = [];
		this.matrixList = [];
	}
}

class FrameInfoData{
	public var polygonName:String;
	public var motion:Boolean;
	public var index:int;
	public var t:Number;
}