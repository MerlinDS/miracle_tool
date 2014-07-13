/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:57
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.merlinds.debug.warning;
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.vo.SheetToolsVO;
	import com.merlinds.miracle_tool.services.FileSystemService;
	import com.merlinds.miracle_tool.views.logger.StatusBar;

	import flash.events.Event;

	import flash.events.MouseEvent;

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
			this.addViewListener(Event.SELECT, this.selectHandler);
			this.addContextListener(EditorEvent.ANIMATION_ATTACHED, this.editorHandler);
			this.addContextListener(EditorEvent.SOURCE_ATTACHED, this.editorHandler);
		}


		override public function onRemove():void {
			super.onRemove();
			this.removeViewListener(Event.SELECT, this.selectHandler);
			this.removeContextListener(EditorEvent.ANIMATION_ATTACHED, this.editorHandler);
			this.removeContextListener(EditorEvent.SOURCE_ATTACHED, this.editorHandler);
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		override protected function editorHandler(event:EditorEvent):void {
			super.editorHandler(event);
			this.data = new SheetToolsVO(
					this.projectModel.sources,
					this.projectModel.elements.length,
					this.projectModel.sheetSize
			);

		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function selectHandler(event:Event):void {
			if(this.viewComponent.data > 0 && this.projectModel.elements.length == 0){
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
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
