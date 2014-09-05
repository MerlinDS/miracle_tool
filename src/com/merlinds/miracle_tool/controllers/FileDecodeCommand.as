/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 17:40
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.error;
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.services.DecodeService;
	import com.merlinds.miracle_tool.services.FileSystemService;
	import com.merlinds.miracle_tool.views.logger.StatusBar;

	import flash.filesystem.File;
	import flash.utils.ByteArray;

	import org.robotlegs.mvcs.Command;

	public class FileDecodeCommand extends Command {

		[Inject]
		public var fileSystemService:FileSystemService;
		[Inject]
		public var decodeService:DecodeService;

		private var _target:File;
		private var _byteArray:ByteArray;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function FileDecodeCommand() {
			super();
		}

		override public function execute():void {
			log(this, 'execute', fileSystemService.target.name);
			_target = fileSystemService.target;
			_byteArray = fileSystemService.output;
			this.decode();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function decode():void{
			var projectModel:ProjectModel;
			if(this.injector.hasMapping(ProjectModel)){
				projectModel = this.injector.getInstance(ProjectModel);
			}
			//decide how to decode file by it's extension
			var method:Function;
			switch (_target.extension){
				case 'swf': case 'png': case 'jpg':
					projectModel.addSource(_target);
					method = this.decodeService.decodeSource;
					break;
				case 'fla': case 'xml':
					method = this.decodeService.decodeAnimation;
					break;
				case FileSystemService.PROJECT_EXTENSION.substr(1):
					method = this.decodeService.decodeProject;
					_target = null;
					break;
				default :
					var errorText:String = "Can not decode unknown file type";
					error(this, "execute", errorText);
					StatusBar.error(errorText);
					_target = null;
					_byteArray = null;
					this.fileSystemService.clear();
					break;
			}
			if(method is Function){
				method.apply(this, [_byteArray]);
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
