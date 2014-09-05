/**
 * User: MerlinDS
 * Date: 14.07.2014
 * Time: 19:06
 */
package com.merlinds.miracle_tool.controllers {
	import avmplus.getQualifiedClassName;

	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.models.vo.AnimationVO;
	import com.merlinds.miracle_tool.models.vo.ElementVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;

	import org.robotlegs.mvcs.Command;

	public class SWFSeparatorCommand extends Command {

		[Inject]
		public var projectModel:ProjectModel;

		[Inject]
		public var event:EditorEvent;

		private var _target:MovieClip;
		private var _elements:Vector.<ElementVO>;
		private var _outputSize:int;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function SWFSeparatorCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			var source:SourceVO = this.projectModel.inProgress;
			var container:DisplayObjectContainer = this.event.body;
			if(container != null){
				_elements = source.elements;
				var n:int = container.numChildren;
				for(var i:int = 0; i < n; i++){
					_target = container.getChildAt(i) as MovieClip;
					trace(getQualifiedClassName(_target));
					//create animations value object
					var animation:AnimationVO = new AnimationVO(null, _target.width, _target.height);
					animation.name = getQualifiedClassName(_target);
					source.animations.push(animation);
					this.getElements();
				}
				this.projectModel.outputSize = _outputSize;
				log(this, "execute", "End separation");
			}
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function getElements():void{
			var element:ElementVO;
			var elementName:String;
			var elementView:DisplayObject;
			var i:int, j:int, n:int, m:int;
			n = _target.totalFrames + 1;
			for(i = 1; i < n; i++){
				_target.gotoAndStop(i);
				m = _target.numChildren;
				for(j = 0; j < m; j++){
					elementView = _target.getChildAt(j);
					elementName = getQualifiedClassName(elementView);
					if(!this.hasElement(elementName)){
						element = new ElementVO(elementName, elementView);
						_elements.push(element);
					}
				}
			}
			//get bounds of elements
			n = _elements.length;
			for(i = 0; i < n; i++){
				element = _elements[i];
				this.getElementBounds(element);
				if(_outputSize < element.width){
					_outputSize = element.width;
				}
			}
		}

		[Inline]
		private function getElementBounds(element:ElementVO):ElementVO {
			var view:DisplayObject = element.view;
			var ratio:Number = view.width / view.transform.pixelBounds.width;
			var topLeftPoint:Point = new Point(view.transform.pixelBounds.x - view.x - this.projectModel.boundsOffset,
							view.transform.pixelBounds.y - view.y - this.projectModel.boundsOffset);
			topLeftPoint.x *= ratio;
			topLeftPoint.y *= ratio;

			var topRightPoint:Point = new Point(topLeftPoint.x + view.width + this.projectModel.boundsOffset * 2,
					topLeftPoint.y);

			var bottomRightPoint:Point = new Point(topRightPoint.x,
							topRightPoint.y + view.height + this.projectModel.boundsOffset * 2);

			var bottomLeftPoint:Point = new Point(topLeftPoint.x, bottomRightPoint.y);

			element.width = view.width + this.projectModel.boundsOffset * 2;
			element.height = view.height + this.projectModel.boundsOffset * 2;

			element.vertexes = new <Number>[topLeftPoint.x, topLeftPoint.y, topRightPoint.x, topRightPoint.y,
				bottomRightPoint.x, bottomRightPoint.y, bottomLeftPoint.x, bottomLeftPoint.y];


			return element;
		}

		[Inline]
		private function hasElement(name:String):Boolean {
			var result:Boolean;
			var i:int, n:int = _elements.length;
			for(i = 0; i < n; i++){
				result = _elements[i].name == name;
				if(result)break;
			}
			return result;
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
