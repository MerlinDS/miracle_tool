/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:57
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.vo.ElementVO;

	import flash.geom.Rectangle;

	public class ItemInfoMediator extends WidgetMediator{

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ItemInfoMediator() {
			super ();
		}


		override public function onRegister():void {
			super.onRegister();
			this.addContextListener(EditorEvent.SELECT_ITEM, this.selectHandler);
		}


		override public function onRemove():void {
			super.onRemove();
			this.removeContextListener(EditorEvent.SELECT_ITEM, this.selectHandler);
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		[Inline]
		private function covertToRelative(target:Vector.<Number>):Vector.<Number>{
			var n:int = target.length;
			var result:Vector.<Number> = new <Number>[];
			result.length = n;
			for(var i:uint = 0; i < n; i++){
				result[i] = target[i]/this.projectModel.outputSize;
			}
			return result;
		}

		[Inline]
		private function flipToY(target:Vector.<Number>):Vector.<Number>{
			var n:int = target.length;
			var result:Vector.<Number> = new <Number>[];
			result.length = n;
			for(var i:uint = 0; i < n; i++){
				result[i] = target[i];
				if(i%2==1)result[i] = result[i] * -1;
			}
			return result;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function selectHandler(event:EditorEvent):void {
			if(event.body == null){
				this.viewComponent.enabled = false;
			}else{
				this.viewComponent.enabled = true;
				var element:ElementVO = event.body;
				this.viewComponent.data = {
					name:element.name,
					vertexes:flipToY(element.vertexes).join(","),
					uv:covertToRelative(element.uv).join(","),
					indexes:element.indexes.join(","),
					rect:new Rectangle(element.x, element.y, element.width, element.height)
				};
			}
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
