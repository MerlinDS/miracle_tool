/**
 * User: MerlinDS
 * Date: 14.07.2014
 * Time: 21:37
 */
package com.merlinds.miracle_tool.controllers.placers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.models.vo.ElementVO;

	import flash.display.DisplayObject;

	import org.robotlegs.mvcs.Command;

	public class PlacerCommand extends Command {

		[Inject]
		public var projectModel:ProjectModel;

		[Inject]
		public var event:EditorEvent;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function PlacerCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			var algorithmName:String = event.body.toString();
			var algorithm:PlacerAlgorithm = PlacerAlgorithmClassList.getAlgorithm(algorithmName);
			var elements:Vector.<ElementVO> = new <ElementVO>[];
			var n:int = this.projectModel.sources.length;
			for(var i:int = 0; i < n; i++){
				elements = elements.concat(this.projectModel.sources[i].elements);
			}
			algorithm.init(elements, this.projectModel.outputSize, this.projectModel.boundsOffset);
			//immediately calculation
			while(!algorithm.complete){
				algorithm.calculateStep();
			}
			this.projectModel.outputSize = algorithm.outputSize;
			log(this, "execute", "End. OutputSize =", algorithm.outputSize);
		}

//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
