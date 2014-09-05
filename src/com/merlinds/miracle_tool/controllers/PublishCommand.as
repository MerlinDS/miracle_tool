/**
 * User: MerlinDS
 * Date: 18.07.2014
 * Time: 15:14
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle.meshes.MeshMatrix;
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

	import flash.display.BitmapData;
	import flash.geom.Point;

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
			var mesh:Array = [];
			var n:int = this.projectModel.sources.length;
			for(var i:int = 0; i < n; i++){
				var source:SourceVO = this.projectModel.sources[i];
				var m:int = source.elements.length;
				for(var j:int = 0; j < m; j++){
					//push element view to buffer
					var element:ElementVO = source.elements[j];
					var depth:Point = new Point(element.x + this.projectModel.boundsOffset,
									element.y + this.projectModel.boundsOffset);
					buffer.copyPixels(element.bitmapData, element.bitmapData.rect, depth);
					//get mesh
					mesh.push({
						name:element.name,
						vertexes:MeshUtils.flipToY(element.vertexes),
						uv:MeshUtils.covertToRelative(element.uv, this.projectModel.outputSize),
						indexes:element.indexes
					});
				}
				//get animation
				m = source.animations.length;
				var animations:Array = [];
				for(j = 0; j < m; j++){
					var animation:Object = this.createAnimationOutput(source.animations[j]);
					animations.push(animation);
				}
			}
			_mesh = new ByteArray();
			_mesh.writeObject(mesh);
			_png = PNGEncoder.encode(buffer);
			_animations = new ByteArray();
			_animations.writeObject(animations);
		}

		private function createAnimationOutput(animationVO:AnimationVO):Object {
			var data:Object = { name:animationVO.name,// name of the matrix
				totalFrames:animationVO.totalFrames,// Total animation frames
				layers:[]};
			var n:int = animationVO.timelines.length;
			//find matrix sequence for current animation
			for(var i:int = 0; i < n; i++){
				var timelineVO:TimelineVO = animationVO.timelines[i];
				var m:int = timelineVO.frames.length;
				var layer:Layer = new Layer();
				for(var j:int = 0; j < m; j++){
					var frameVO:FrameVO = timelineVO.frames[j];
					//create matrix
					var prevMatrix:MeshMatrix = layer.matrixList.length > 0
							? layer.matrixList[ layer.matrixList.length - 1] : null;
					var matrix:MeshMatrix = MeshMatrix.fromMatrix(frameVO.matrix,
							frameVO.transformationPoint.x, frameVO.transformationPoint.y);
					if(prevMatrix != null && matrix != null){
						//calculate shortest angle between previous matrix skew and current matrix skew
						matrix.skewX = this.getShortest(matrix.skewX, prevMatrix.skewX);
						matrix.skewY = this.getShortest(matrix.skewY, prevMatrix.skewY);
						//
					}
					var index:int = matrix == null ? -1 : layer.matrixList.push(matrix) - 1;
					var framesArray:Array = this.createFramesInfo(index, frameVO.name,
							frameVO.duration, frameVO.type == "motion");
					layer.framesList = layer.framesList.concat(framesArray);
					prevMatrix = matrix;
				}
				data.layers.unshift(layer);
			}
			trace(JSON.stringify(data));
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

		[Inline]
		private function getShortest(a:Number, b:Number):Number {
			if(Math.abs(a - b) > Math.PI){
				if(a > 0){
					return a - Math.PI * 2;
				}else if(a < 0){
					return Math.PI * 2 + a;
				}
			}
			return a;
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