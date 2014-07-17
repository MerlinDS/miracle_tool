/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 20:09
 */
package com.merlinds.miracle_tool.services {
	import com.merlinds.miracle_tool.models.vo.ActionVO;
	import com.merlinds.miracle_tool.utils.dispatchAction;
	import com.merlinds.miracle_tool.views.components.containers.DialogWindow;
	import com.merlinds.unitls.structures.QueueFIFO;
	import com.merlinds.unitls.structures.SearchUtils;

	import org.robotlegs.mvcs.Actor;

	public class ActionService extends Actor {

		private var _acceptQueue:QueueFIFO;
		private var _denyQueue:QueueFIFO;
		private var _cancelQueue:QueueFIFO;

		private var _currentQueue:QueueFIFO;
		private var _currentData:*;

		private var _actions:Vector.<ActionVO>;

		public function ActionService() {
			super();
			_acceptQueue = new QueueFIFO();
			_denyQueue = new QueueFIFO();
			_cancelQueue = new QueueFIFO();

			_actions = new <ActionVO>[];
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function addAcceptActions(actions:Vector.<String>):ActionService{
			actions = actions.concat();
			this.addActions(_acceptQueue, actions);
			return this;
		}

		public function addDenyActions(actions:Vector.<String>):ActionService {
			actions = actions.concat();
			this.addActions(_denyQueue, actions);
			return this;
		}

		public function addCancelActions(actions:Vector.<String>):ActionService {
			actions = actions.concat();
			this.addActions(_cancelQueue, actions);
			return this;
		}

		public function startActions(type:String = DialogWindow.ACCEPT, data:* = null):void {
			switch (type){
				case DialogWindow.ACCEPT:
					_currentQueue = _acceptQueue;
					_denyQueue = new QueueFIFO();
					_cancelQueue = new QueueFIFO();
					break;
				case DialogWindow.DENY:
					_currentQueue = _denyQueue;
					_acceptQueue = new QueueFIFO();
					_cancelQueue = new QueueFIFO();
					break;
				default :
					_currentQueue = _cancelQueue;
					_acceptQueue = new QueueFIFO();
					_denyQueue = new QueueFIFO();
					break;
			}
			_currentData = data;
			this.applyAction();
		}

		public function done():void {
			this.applyAction();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		[Inline]
		public function addActions(queue:QueueFIFO, actions:Vector.<String>):void{
			while(actions.length > 0){
				queue.push(actions.shift());
			}
		}

		private function applyAction():void {
			if(_currentQueue != null && !_currentQueue.empty){
				var actionVO:ActionVO = SearchUtils.findInVector(_actions, "type", _currentQueue.pop());
				dispatchAction(actionVO, this.dispatch, _currentData);
			}else{
				_currentData = null;
			}
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get actions():Vector.<ActionVO> {
			return _actions;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
