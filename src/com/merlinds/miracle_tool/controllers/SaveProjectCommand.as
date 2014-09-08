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
	import com.merlinds.miracle_tool.models.vo.SourceVO;
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
				var data:Object = { projectName:model.name,
					referenceSize:model.referenceResolution,
					boundsOffset:model.boundsOffset
				};
				data.sources = [];
				var n:int = model.sources.length;
				for(var i:int = 0; i < n; i++){
					var source:SourceVO = model.sources[i];
					var sourceData:Array = [source.file.nativePath];
					var m:int = source.animations.length;
					for(var j:int = 0; j < m; j++){
						var animation:AnimationVO = source.animations[j];
						if(animation.added && animation.file != null){
							var nativePath:String = animation.file.nativePath;
							if(sourceData.indexOf(nativePath) < 0){
								sourceData.push( animation.file.nativePath );
							}
						}
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
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
