/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:57
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.debug.warning;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.models.vo.AnimationVO;
	import com.merlinds.miracle_tool.models.vo.FrameVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;
	import com.merlinds.miracle_tool.models.vo.TimelineVO;
	import com.merlinds.miracle_tool.services.FileSystemService;
	import com.merlinds.miracle_tool.views.logger.StatusBar;

	import org.robotlegs.mvcs.Command;

	public class SaveProjectCommand extends Command {

		[Inject]
		public var fileSystemService:FileSystemService;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function SaveProjectCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			if(this.injector.hasMapping(ProjectModel)){
				var model:ProjectModel = this.injector.getInstance(ProjectModel);
				//forming save data
				var data:Object = { projectName:model.name, sceneSize:model.sceneSize };
				data.sources = [];
				var n:int = model.sources.length;
				for(var i:int = 0; i < n; i++){
					var source:SourceVO = model.sources[i];
					var sourceData:Object = {file:source.file.nativePath, animations:[]};
					var m:int = source.animations.length;
					for(var j:int = 0; j < m; j++){
						var animation:AnimationVO = source.animations[j];
						sourceData.animations.push( this.parseAnimations(animation) );
					}
					data.sources.push(sourceData);
				}
				if(n > 0){
					data.sheetSize = model.sheetSize;
					data.boundsOffset = model.boundsOffset;
				}
				//save data
				this.fileSystemService.writeProject(model.name, data);
				model.saved = true;
			}else{
				var warningText:String = "Can not save not exist project";
				warning(this, warningText);
				StatusBar.warning(warningText);
			}
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		[Inline]
		private function parseAnimations(animationVO:AnimationVO):Object {
			var data:Object = {
				name:animationVO.name,
				totalFrames:animationVO.totalFrames,
				timelites:[]
			};
			var n:int = animationVO.timelines.length;
			for(var i:int = 0; i < n; i++){
				var timeline:TimelineVO = animationVO.timelines[i];
				var m:int = timeline.frames.length;
				var timelineData:Array = new Array(m);
				for(var j:int = 0; j < m; j++){
					var frame:FrameVO = timeline.frames[j];
					timelineData[j] = {
						name:frame.name,
						type:frame.type,
						duration:frame.duration,
						indexes:frame.index,
						matrix:frame.matrix,
						transformationPoint:frame.transformationPoint
					};
				}
				data.timelites.push(timelineData);
			}
			return data;
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
