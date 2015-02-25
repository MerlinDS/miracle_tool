/**
 * User: MerlinDS
 * Date: 25.02.2015
 * Time: 17:45
 */
package com.merlinds.miracle_tool.services {
	import com.merlinds.miracle_tool.models.ProjectModel;

	import org.robotlegs.mvcs.Actor;

	public class PublishingService extends Actor {

		private var _model:ProjectModel;
		private var _compilers:Vector.<OutputCompiler>;
		private var _compiledCount:int;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function PublishingService()
		{
			super();
			_compilers = new <OutputCompiler>[
				new MAFCompiler(),
				new MTFCompiler()
			];
		}

		/**
		 * Publish project
		 * @param model Model of the project
		 */
		public function execute(model:ProjectModel):void
		{
			_model = model;
			for each(var compiler:OutputCompiler in _compilers)
			{
				_compiledCount++;
				compiler.execute(_model, this.completeCallback);
			}

		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function completeCallback():void {
			if(--_compiledCount == 0)
				this.writeOutput();
		}

		private function writeOutput():void {
			trace("writeOutput");

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
