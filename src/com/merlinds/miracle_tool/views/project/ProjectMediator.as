/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:37
 */
package com.merlinds.miracle_tool.views.project {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.controllers.ResizeController;
	import com.merlinds.miracle_tool.controllers.placers.PlacerAlgorithmList;
	import com.merlinds.miracle_tool.events.ActionEvent;
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.models.vo.ActionVO;
	import com.merlinds.miracle_tool.models.vo.ElementVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;
	import com.merlinds.miracle_tool.utils.dispatchAction;
	import com.merlinds.miracle_tool.views.logger.StatusBar;

	import flash.display.DisplayObject;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import org.robotlegs.mvcs.Mediator;

	public class ProjectMediator extends Mediator {

		[Inject]
		public var appModel:AppModel;
		[Inject]
		public var projectModel:ProjectModel;
		[Inject]
		public var resizeController:ResizeController;

		private var _workspace:Workspace;
		private var _clickPoint:Point;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectMediator() {
			super();
		}

		override public function onRegister():void {
			StatusBar.log("Project", projectModel.name, "was created");
			this.addViewListener(Event.CLOSE, this.closeHandler);
			this.addViewListener(MouseEvent.MOUSE_DOWN, this.mouseHandler);
			this.addViewListener(MouseEvent.MOUSE_UP, this.mouseHandler);
			this.addContextListener(EditorEvent.SOURCE_ATTACHED, this.editorHandler);
			this.addContextListener(EditorEvent.PLACE_ITEMS, this.editorHandler);
			this.dispatch(new EditorEvent(EditorEvent.PROJECT_OPEN));

		}

		override public function onRemove():void {
			this.removeViewListener(Event.CLOSE, this.closeHandler);
			this.removeViewListener(MouseEvent.MOUSE_DOWN, this.mouseHandler);
			this.removeViewListener(MouseEvent.MOUSE_UP, this.mouseHandler);
			StatusBar.log("Project", projectModel.name, "was closed");
			this.dispatch(new EditorEvent(EditorEvent.PROJECT_CLOSED));
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function updateWorkplace():void{
			if(_workspace == null){
				_workspace = new Workspace(this.viewComponent as DisplayObjectContainer);
				this.resizeController.addInstance(_workspace);
			}
			_workspace.clear();

			var element:ElementVO;
			var source:SourceVO;
			var n:int = this.projectModel.sources.length;
			for(var i:int = 0; i < n; i++){
				source = this.projectModel.sources[i];
				var m:int = source.elements.length;
				for(var j:int = 0; j < m; j++){
					element = source.elements[j];
					_workspace.addChild(element.view);
				}
			}
		}

		private function resizeWorkplace():void {
			var sheetSize:Point = this.projectModel.sheetSize;
			if(this.resizeController.height - 20 < sheetSize.y){
				this.projectModel.zoom = (this.resizeController.height - 20) / sheetSize.y;
			}
			_workspace.width = sheetSize.x * this.projectModel.zoom;
			_workspace.height = sheetSize.y * this.projectModel.zoom;
			_workspace.scale(this.projectModel.zoom);
			_workspace.x = this.resizeController.width - _workspace.width >> 1;
			_workspace.y = this.resizeController.height - _workspace.height >> 1;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function closeHandler(event:Event):void {
			var vo:ActionVO = this.appModel.getActionByType(ActionEvent.CLOSE_PROJECT);
			dispatchAction(vo, this.dispatch);
		}

		private function editorHandler(event:EditorEvent):void {
			log(this, "editorHandler");
			switch (event.type){
				case EditorEvent.SOURCE_ATTACHED:
						this.updateWorkplace();
						this.dispatch(new EditorEvent(EditorEvent.PLACE_ITEMS, PlacerAlgorithmList.MAX_RECT));
						break;
				case EditorEvent.PLACE_ITEMS:
					this.resizeWorkplace();
					break;
			}
		}

		private function mouseHandler(event:MouseEvent):void {
			if(this.appModel.activeTool == "Pointer"){
				var target:DisplayObject = event.target as DisplayObject;
				var n:int = this.projectModel.sources.length;
				for(var i:int = 0; i < n; i++){
					var source:SourceVO = this.projectModel.sources[i];
					var m:int = source.elements.length;
					for(var j:int = 0; j < m; j++){
						var element:ElementVO = source.elements[j];
						element.selected = element.view == target;
					}
				}
			}else if(this.appModel.activeTool == "Hand"){
				if(event.type == MouseEvent.MOUSE_DOWN)
				{
					_workspace.startDrag();
				}else{
					_workspace.stopDrag();
				}
			}else if(this.appModel.activeTool == "Zoom"){
				trace("Zoom");
			}
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
