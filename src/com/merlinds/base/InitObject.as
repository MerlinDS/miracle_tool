/**
 * User: MerlinDS
 * Date: 12.06.2014
 * Time: 20:33
 */
package com.merlinds.base {
	import com.merlinds.debug.log;
	import com.merlinds.debug.warning;

	import flash.errors.IllegalOperationError;

	public class InitObject {

		private var _initialized:Boolean;

		private var _afterInitializedHandlers:Vector.<Function>;
		private var _afterDestroyingHandlers:Vector.<Function>;

		public function InitObject() {
			_afterInitializedHandlers = new <Function>[];
			_afterDestroyingHandlers = new <Function>[];
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function initialize():void{
			if(this.destroyed){
				throw new IllegalOperationError("Cant be initialized after already destroyed");
			}
			if(_initialized){
				warning(this, "initialize", "Try to initialized twice");
			}else{
				_initialized = true;
				log(this, "initialize");
				this.executeHandlers(_afterInitializedHandlers);
			}
		}

		public function destroy():void{
			_initialized = false;
			_afterInitializedHandlers = null;
			log(this, "destroy");
			this.executeHandlers(_afterDestroyingHandlers);
			_afterDestroyingHandlers = null;
		}

		public function afterInitialized(handler:Function):void{
			this.addHandler(handler, _afterInitializedHandlers);
		}

		public function afterDestroying(handler:Function):void{
			this.addHandler(handler, _afterDestroyingHandlers);
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		[Inline]
		private function executeHandlers(handlers:Vector.<Function>):void{
			var n:int = handlers.length;
			for(var i:int = 0; i < n; i++){
				var handler:Function = handlers[i];
				handler.apply(this, []);
			}
		}

		[Inline]
		private function addHandler(handler:Function, target:Vector.<Function>):void{
			if(!destroyed){
				if(target.indexOf(handler) < 0){
					target.push(handler);
				}else{
					warning(this, "addHandler", "Already added");
				}
			}else{
				throw new IllegalOperationError("Cant add handler to destroyed instance");
			}
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public final function get initialized():Boolean{
			return _initialized;
		}

		public final function get destroyed():Boolean{
			return _afterInitializedHandlers == null;
		}
		//} endregion GETTERS/SETTERS ==================================================
	}
}
