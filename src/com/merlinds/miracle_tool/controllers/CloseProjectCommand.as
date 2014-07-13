/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:56
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.debug.warning;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.views.interfaces.IResizable;
	import com.merlinds.miracle_tool.views.logger.StatusBar;
	import com.merlinds.miracle_tool.views.AppView;
	import com.merlinds.miracle_tool.views.widgets.ProjectWidgets;

	import flash.display.DisplayObject;

	import org.robotlegs.mvcs.Command;

	public class CloseProjectCommand extends Command {

		[Inject]
		public var appView:AppView;
		[Inject]
		public var resizeController:ResizeController;
		//==============================================================================
		//{region							PUBLIC METHODS

		public function CloseProjectCommand() {
			super();
		}

		override public function execute():void {
			if(this.injector.hasMapping(ProjectModel))
			{
				log(this, "execute");
				//find widgets and delete them
				var n:int = this.contextView.numChildren;
				for(var i:int = 0; i < n; i++){
					var child:DisplayObject = this.contextView.getChildAt(i);
					if(child is ProjectWidgets){
						this.resizeController.removeInstance( child as IResizable );
						this.contextView.removeChild(child);
						break;
					}
				}
				//delete project
				this.injector.unmap(ProjectModel);
				var instance:IResizable = this.appView.removeProject() as IResizable;
				this.resizeController.removeInstance(instance);

			}else{
				warning(this, "execute", "Trying to close empty project");
				StatusBar.warning("Trying to close empty project");
			}
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
