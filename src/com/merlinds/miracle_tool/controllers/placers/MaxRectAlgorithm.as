/**
 * User: MerlinDS
 * Date: 14.07.2014
 * Time: 21:39
 */
package com.merlinds.miracle_tool.controllers.placers {
	import com.merlinds.miracle_tool.models.vo.ElementVO;

	import flash.geom.Rectangle;

	internal class MaxRectAlgorithm extends PlacerAlgorithm{

		private var _packer:MaxRectPacker;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function MaxRectAlgorithm() {
		}


		override public function calculateStep(complete:Boolean = false):void {
			if(!this.complete){
				//nearest power of 2
				this.outputSize = Math.pow(2, Math.ceil(
								Math.log(this.outputSize) * Math.LOG2E));
				_packer = new MaxRectPacker(this.outputSize, this.outputSize);
				var n:int = this.elements.length;
				complete = true;
				for(var i:int = 0; i < n; i++){
					complete = this.placeElement( this.elements[i]);
					if(!complete){
						this.outputSize++;
						break;
					}
				}
			}
			super.calculateStep(complete);
		}

//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		[Inline]
		private function placeElement(element:ElementVO):Boolean{
			var rect:Rectangle = _packer.quickInsert(element.width, element.height);

			if(rect != null){
				element.view.x = rect.x + this.boundsOffset;
				element.view.y = rect.y + this.boundsOffset;
				//get uv position
				element.uv = new <Number>[
					rect.left, rect.top,
					rect.right, rect.top,
					rect.right, rect.bottom,
					rect.left, rect.bottom
				];
				element.x = rect.left;
				element.y = rect.top;
			}

			return rect != null;
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
