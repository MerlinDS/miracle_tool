/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 22:22
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.models.vo.AnimationVO;

	import org.robotlegs.mvcs.Command;

	public class AnimationConverterCommand extends Command {

		[Inject]
		public var projectModel:ProjectModel;
		[Inject]
		public var event:EditorEvent;

		private var _animation:AnimationVO;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AnimationConverterCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			_animation = this.projectModel.animationInProgress;
			var name:String = _animation.file.name;
			name = name.substr(_animation.file.extension.length);
			var data:Object = this.event.body;
			if(data is XML){
				this.convertXML(data as XML, name);
			}else{
				for(name in data){
					this.convertXML(data[name] as XML, name);
				}
			}
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function convertXML(xml:XML, name:String):void{
			log(this, "convertXML", name);
			_animation.timelines.push(xml);
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
