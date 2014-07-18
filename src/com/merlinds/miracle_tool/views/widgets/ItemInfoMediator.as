/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 15:57
 */
package com.merlinds.miracle_tool.views.widgets {
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.vo.ElementVO;
	import com.merlinds.miracle_tool.utils.MeshUtils;

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
					vertexes:MeshUtils.flipToY(element.vertexes).join(","),
					uv:MeshUtils.covertToRelative(element.uv, this.projectModel.outputSize).join(","),
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
