/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:57
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.merlinds.debug.log;
	import com.merlinds.debug.warning;
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.vo.SheetToolsVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;
	import com.merlinds.miracle_tool.services.FileSystemService;
	import com.merlinds.miracle_tool.views.logger.StatusBar;

	import flash.events.Event;

	import flash.events.Event;

	public class SheetToolsMediator extends WidgetMediator {

		[Inject]
		public var fileSystemService:FileSystemService;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function SheetToolsMediator() {
			super();
		}


		override public function onRegister():void {
			super.onRegister();
			this.addViewListener(Event.OPEN, this.openHandler);
			this.addViewListener(Event.SELECT_ALL, this.selectHandler);
			this.addContextListener(EditorEvent.SELECT_ITEM, this.editorHandler);
			this.addContextListener(EditorEvent.ANIMATION_ATTACHED, this.editorHandler);
			this.addContextListener(EditorEvent.SOURCE_ATTACHED, this.editorHandler);
		}


		override public function onRemove():void {
			super.onRemove();
			this.removeViewListener(Event.OPEN, this.openHandler);
			this.removeViewListener(Event.SELECT_ALL, this.selectHandler);
			this.removeContextListener(EditorEvent.SELECT_ITEM, this.editorHandler);
			this.removeContextListener(EditorEvent.ANIMATION_ATTACHED, this.editorHandler);
			this.removeContextListener(EditorEvent.SOURCE_ATTACHED, this.editorHandler);
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		override protected function editorHandler(event:EditorEvent):void {
			log(this, "editorHandler");
			super.editorHandler(event);
			if(event.type == EditorEvent.SELECT_ITEM){
//				this.viewComponent.cancel();
			}else{
				var sources:Array = [];
				var numElements:Vector.<int> = new <int>[];
				var n:int = this.projectModel.sources.length;
				for(var i:int = 0; i < n; i++){
					var source:SourceVO = this.projectModel.sources[i];
					sources.push(source.name);
					numElements.push(source.elements.length);
				}
				this.data = new SheetToolsVO(sources, numElements, this.projectModel.sheetSize);
			}
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function openHandler(event:Event):void {
			if(this.viewComponent.data > 0 && this.projectModel.sources.length == 0){
				var text:String = "Can not attach animation till no sources was attached";
				warning(this, "selectHandler", text);
				StatusBar.warning(text);
			}else{
				var method:Function = this.viewComponent.data == 0
					? this.fileSystemService.readSource
					: this.fileSystemService.readAnimation;
				method.apply(this);
			}
		}

		private function selectHandler(event:Event):void {
			var n:int = this.projectModel.sources.length;
			for(var i:int = 0; i < n; i++){
				var source:SourceVO = this.projectModel.sources[i];
				source.selected = source.name == this.viewComponent.data;
			}
			this.dispatch(new EditorEvent(EditorEvent.SELECT_ITEM));
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
