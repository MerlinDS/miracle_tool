/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:56
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.models.vo.AnimationVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;
	import com.merlinds.miracle_tool.services.ActionService;
	import com.merlinds.miracle_tool.services.FileSystemService;

	import flash.events.Event;

	public class AnimationToolsMediator extends WidgetMediator {

		[Inject]
		public var actionService:ActionService;
		[Inject]
		public var fileSystemService:FileSystemService;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AnimationToolsMediator() {
			super();
		}

		override public function onRegister():void {
			this.addViewListener(Event.SELECT, this.selectHandler);
			this.addContextListener(EditorEvent.SELECT_ITEM, this.editorHandler);
			this.addContextListener(EditorEvent.SELECT_SHEETS, this.editorHandler, EditorEvent);
			this.addContextListener(EditorEvent.ANIMATION_ATTACHED, this.editorHandler, EditorEvent);
			super.onRegister();
		}


		override public function onRemove():void {
			this.removeContextListener(EditorEvent.SELECT_SHEETS, this.editorHandler, EditorEvent);
			this.removeContextListener(EditorEvent.ANIMATION_ATTACHED, this.editorHandler, EditorEvent);
			super.onRemove();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function editorHandler(event:EditorEvent):void {
			var name:String = event.body;
			if(event.type == EditorEvent.SELECT_SHEETS || event.type == EditorEvent.ANIMATION_ATTACHED){
				this.viewComponent.enabled = true;
				var animations:Array = [];
				var n:int = this.projectModel.sources.length;
				for(var i:int = 0; i < n; i++){
					var sourceVO:SourceVO = this.projectModel.sources[i];
					if(sourceVO.name == event.body){
						var m:int = sourceVO.animations.length;
						for(var j:int = 0; j < m; j++){
							animations.push(sourceVO.animations[j].name);
						}
					}
				}
				this.viewComponent.data = animations;
			}else{
				this.viewComponent.enabled = false;
			}
		}

		private function selectHandler(event:Event):void {
			if(this.viewComponent.data == null){
				this.fileSystemService.readAnimation();
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
