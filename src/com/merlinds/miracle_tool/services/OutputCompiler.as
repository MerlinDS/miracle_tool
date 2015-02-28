/**
 * User: MerlinDS
 * Date: 25.02.2015
 * Time: 18:09
 */
package com.merlinds.miracle_tool.services {
	import com.merlinds.miracle_tool.models.ProjectModel;

	import flash.utils.ByteArray;

	public class OutputCompiler {

		private var _model:ProjectModel;
		private var _callback:Function;
		private var _output:ByteArray;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function OutputCompiler() {
		}

		public final function execute(model:ProjectModel, callback:Function):void
		{
			_model = model;
			_callback = callback;
			this.compile();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		protected function compile():void
		{
			throw new Error("Must be override");
		}

		protected final function finalyzeCompilation(output:ByteArray):void {
			output.position = 0;
			_output = output;
			if(_callback is Function)
				_callback.apply(this);
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public final function get output():ByteArray {
			return _output;
		}

		protected final function get model():ProjectModel {
			return _model;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
