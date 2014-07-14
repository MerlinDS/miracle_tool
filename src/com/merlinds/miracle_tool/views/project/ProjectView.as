/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:39
 */
package com.merlinds.miracle_tool.views.project {
	import com.bit101.components.HSlider;
	import com.bit101.components.Slider;
	import com.bit101.components.Window;
	import com.merlinds.miracle_tool.views.interfaces.IResizable;

	import flash.display.DisplayObject;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class ProjectView extends Window implements IResizable{

		private var _zoom:HSlider;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ProjectView(name:String, parent:DisplayObjectContainer = null) {
			//
			super(parent, 0, 0, "Project: " + name);
			this.hasCloseButton = true;
			this.hasMinimizeButton = false;
			this.draggable = false;
			_zoom = new HSlider(this, 0, 0);
			_zoom.setSliderParams(0.2, 2, 1);
			_zoom.addEventListener(Event.CHANGE, this.dispatchEvent);
			_zoom.enabled = false;
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		override public function setSize(w:Number, h:Number):void {
			super.setSize(w, h);
			if(_zoom != null){
				_zoom.width = w;
				_zoom.y = this.height - (_zoom.height + this.titleBar.height + 25);
			}
		}

		override public function addChild(child:DisplayObject):DisplayObject {
			for(var i:int = 0; i < this.content.numChildren; i++){
				var oldChild:DisplayObject = this.content.getChildAt(i);
				if(oldChild != _zoom){
					this.content.removeChild(oldChild);
				}
			}
			if(_zoom != null)_zoom.enabled = true;
			this.content.addChildAt(child, 0);
			return child;
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get zoom():Number{
			return _zoom != null ? _zoom.value : 0;
		}

		public function set zoom(value:Number):void{
			if(_zoom != null)_zoom.value = value;
		}
		//} endregion GETTERS/SETTERS ==================================================
	}
}
