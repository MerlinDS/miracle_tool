/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 20:54
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.models.vo.AnimationVO;
	import com.merlinds.miracle_tool.models.vo.FrameVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;
	import com.merlinds.miracle_tool.models.vo.TimelineVO;
	import com.merlinds.miracle_tool.services.ActionService;
	import com.merlinds.miracle_tool.services.FileSystemService;
	import com.merlinds.miracle_tool.views.AppView;
	import com.merlinds.miracle_tool.views.project.ProjectView;
	import com.merlinds.miracle_tool.views.widgets.ProjectWidgets;

	import flash.filesystem.File;
	import flash.geom.Matrix;
	import flash.geom.Point;

	import org.robotlegs.mvcs.Command;

	public class CreateProjectCommand extends Command {

		[Inject]
		public var appView:AppView;
		[Inject]
		public var resizeController:ResizeController;
		[Inject]
		public var actionService:ActionService;
		[Inject]
		public var fileSystemService:FileSystemService;
		[Inject]
		public var event:EditorEvent;

		private var _projectModel:ProjectModel;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function CreateProjectCommand() {
			super();
		}

		override public function execute():void {
			//create model for project
			var projectName:String = this.event.body.projectName;
			var sceneSize:Point = this.event.body.sceneSize;

			_projectModel = new ProjectModel(projectName, sceneSize);
			_projectModel.boundsOffset = this.event.body.boundsOffset;
			if(this.event.body.hasOwnProperty("sheetSize")){
				_projectModel.outputSize = this.event.body.sheetSize.x;
			}
			this.injector.mapValue(ProjectModel, _projectModel);
			this.resizeController.addInstance( new ProjectWidgets( this.contextView ));
			//create view for project
			var view:ProjectView = new ProjectView(_projectModel.name, this.appView);
			this.resizeController.addInstance(view);
			this.actionService.done();

			this.readSources(this.event.body.sources);
			this.fileSystemService.readProjectSources(this.event.body.sources);
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function readSources(sources:Array):void {
			if(sources != null && sources.length > 0){
				var n:int = sources.length;
				for(var i:int = 0; i < n; i++){
					var file:File = new File(sources[i].file);
					var sourceVO:SourceVO = _projectModel.addSource(file);
					sourceVO.animations = new <AnimationVO>[];
					var m:int = sources[i].animations.length;
					for(var j:int = 0; j < m; j++){
						var animationVO:AnimationVO = this.readAnimations(sources[i].animations[j]);
						sourceVO.animations.push( animationVO );
					}
				}
			}
		}

		private function readAnimations(data:Object):AnimationVO{
			var animationVO:AnimationVO;
			animationVO = new AnimationVO(new File(data.file));
			animationVO.name = data.name;
			var n:int = data.timelites.length;
			for(var i:int = 0; i < n; i++){
				var timelineVO:TimelineVO = new TimelineVO();
				var layer:Object = data.timelites[i];
				var m:int = layer.length;
				for(var j:int = 0; j < m; j++){
					var frameData:Object = layer[j];
					var frameVO:FrameVO = new FrameVO(frameData.index, frameData.duration);
					frameVO.name = frameData.name;
					frameVO.type = frameData.type;
					//get matrix and point
					frameVO.matrix = this.object2Matrix(frameData.matrix);
					frameVO.transformationPoint = this.object2Point(frameData.transformationPoint);
					timelineVO.frames.push(frameVO);
				}
				animationVO.timelines.push(timelineVO);
			}
			return animationVO;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function object2Matrix(data:Object):Matrix{
			return data == null ? null : new Matrix(
					data.a, data.b, data.c, data.d, data.tx, data.ty
			);
		}

		private function object2Point(data:Object):Point{
			return data == null ? null : new Point(data.x, data.y);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
