/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 22:39
 */
package com.merlinds.miracle_tool.tools {
	import com.merlinds.miracle_tool.components.ErrorWindown;
	import com.merlinds.miracle_tool.models.AppModel;

	import flash.errors.IllegalOperationError;

	public class AbstractTool implements ITool {

		private var _callback:Function;
		private var _errorCallback:Function;

		protected var _model:AppModel;

		public function AbstractTool() {
		}

		//==============================================================================
		//{region							PUBLIC METHODS

		public function execute():void {
			if(_model == null){
				throw new IllegalOperationError("Tool was not initialized yet!");
			}
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		protected final function executeCallback():void{
			if(_callback is Function){
				_callback.apply(this);
			}
			this.destroy();
		}

		protected final function executeErrorCallback(error:Error):void{
			new ErrorWindown(error);
			_errorCallback.apply(this, [error]);
			this.destroy();
		}

		protected function destroy():void{
			_callback = null;
			_errorCallback = null;
			_model = null;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		internal final function set model(value:AppModel):void{
			_model = value;
		}

		internal final function set callback(value:Function):void {
			_callback = value;
		}

		internal final function set errorCallback(value:Function):void {
			_errorCallback = value;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
