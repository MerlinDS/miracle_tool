/**
 * User: MerlinDS
 * Date: 18.07.2014
 * Time: 15:14
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.ActionEvent;
	import com.merlinds.miracle_tool.events.DialogEvent;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.models.vo.ElementVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;
	import com.merlinds.miracle_tool.services.ActionService;
	import com.merlinds.miracle_tool.services.FileSystemService;
	import com.merlinds.miracle_tool.utils.MeshUtils;

	import flash.debugger.enterDebugger;

	import flash.display.Bitmap;

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
//				this.fileSystemService.writeTimeline();
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
			}
			_mesh = new ByteArray();
			_mesh.writeObject(mesh);
			_png = PNGEncoder.encode(buffer);
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
