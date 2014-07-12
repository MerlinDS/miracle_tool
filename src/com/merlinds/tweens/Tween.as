/**
 * User: MerlinDS
 * Date: 16.06.2014
 * Time: 13:39
 */
package com.merlinds.tweens {
	import com.loonyquack.base.GameContext;

	public class Tween implements ITicker{

		private var _onComplete:Function;
		private var _target:Object;

		private var _properties:Vector.<String>;
		private var _startValues:Vector.<Number>;
		private var _endValues:Vector.<Number>;
		private var _propertiesCount:int;
		private var _autoRemove:Boolean;

		private var _t:Number; /* 0 - 1 */
		private var _step:Number;
		private var _passedTime:Number;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function Tween(target:Object, time:Number,  properties:Object) {
			this.reset(target, time, properties);
			_autoRemove = true;
		}

		public function reset(target:Object, time:Number,  properties:Object):void{
			_target = target;
			_step = 1 / ( time * 1000 );
			_t = _passedTime = 0;

			if(_properties == null)_properties = new <String>[]; else _properties.length = 0;
			if(_startValues == null)_startValues = new <Number>[]; else _startValues.length = 0;
			if(_endValues == null)_endValues = new <Number>[]; else _endValues.length = 0;

			//parse transition
			for(var prop:String in properties){
				if(!_target.hasOwnProperty(prop)){
					throw new ArgumentError("Can not found property " + prop + " in target");
				}
				_properties.push(prop);
				_startValues.push(target[prop]);
				_endValues.push(properties[prop]);
			}
			_propertiesCount = _properties.length;
		}

		public function tick(time:Number):void {
			_passedTime = _passedTime + time;
			_t = _passedTime * _step;
			if(_t < 1 ){
				this.linerUpdate();
			}else{
				_t = 1;
				this.linerUpdate();

				if(_autoRemove && GameContext.current.ticktock.has(this)){
					GameContext.current.ticktock.remove(this);
					_passedTime = 0;
				}
				if(_onComplete is Function){
					_onComplete.apply(this);
				}
			}
		}


		public function swap():Tween{
			var tmp:Vector.<Number> = _startValues;
			_startValues = _endValues;
			_endValues = tmp;
			_passedTime = 0;
			return this;
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		[Inline]
		private function linerUpdate():void {
			for(var i:int = 0; i < _propertiesCount; i++){
				_target[ _properties[i] ] = (1 - _t) * _startValues[i] + _t * _endValues[i];
			}
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function set onComplete(value:Function):void{
			_onComplete = value;
		}

		public function get autoRemove():Boolean {
			return _autoRemove;
		}

		public function set autoRemove(value:Boolean):void {
			_autoRemove = value;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
