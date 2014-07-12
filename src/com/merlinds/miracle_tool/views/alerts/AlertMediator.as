/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:37
 */
package com.merlinds.miracle_tool.views.alerts {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.DialogEvent;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.miracle_tool.models.vo.DialogVO;
	import com.merlinds.miracle_tool.utils.dispatchAction;
	import com.merlinds.miracle_tool.views.components.containers.DialogWindow;
	import com.merlinds.unitls.structures.QueueFIFO;

	import org.robotlegs.mvcs.Mediator;

	public class AlertMediator extends Mediator {

		[Inject]
		public var appModel:AppModel;

		private var _queue:QueueFIFO;
		private var _currentDialog:DialogWindow;
		private var _currentEvent:DialogEvent;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AlertMediator() {
			super();
		}

		override public function onRegister():void {
			_queue = new QueueFIFO();
			this.addContextListener(DialogEvent.PROJECT_SETTINGS, this.dialogEventHandler);
		}

		override public function onRemove():void {
			this.removeContextListener(DialogEvent.PROJECT_SETTINGS, this.dialogEventHandler);
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function showDialog():void {
			if(_currentDialog == null && !_queue.empty){
				_currentEvent = _queue.pop();
				var dialogVO:DialogVO = this.appModel.getDialogByType(_currentEvent.type);
				_currentDialog = new dialogVO.clazz(this.viewComponent);
				_currentDialog.closeCallback = this.closeHandler;
			}
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function dialogEventHandler(event:DialogEvent):void {
			log(this, "dialogEventHandler", event);
			_queue.push( event );
			this.showDialog();
		}

		private function closeHandler():void {
			this.viewComponent.removeChild(_currentDialog);
			dispatchAction(_currentEvent.action, this.dispatch, _currentDialog.data);
			_currentDialog = null;
			_currentEvent = null;
			this.showDialog();//Show nex dialog
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
