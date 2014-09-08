/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 23:19
 */
package com.merlinds.miracle_tool.views.components.containers {
	import com.bit101.components.ComboBox;
	import com.bit101.components.Component;
	import com.bit101.components.Component;
	import com.bit101.components.HBox;
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.List;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	import com.bit101.components.Text;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	import com.merlinds.miracle_tool.views.components.containers.DialogWindow;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	public class DialogWindow extends Window {

		public static const ACCEPT:String = "accept";
		public static const DENY:String = "deny";
		public static const CANCEL:String = "cancel";

		private var _modal:Boolean;
		private var _closeCallback:Function;
		private var _closeReason:String;
		private var _data:*;

		private var _body:VBox;
		private var _controls:Object;

		public function DialogWindow(parent:DisplayObjectContainer = null,
		                             data:Object = null, title:String = "Window") {
			this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
			super(parent, 0, 0, title);
			_controls = {};
			_body = new VBox(this);
			_closeReason = DENY;
			_data = data;
			this.initialize();
			this.postInitialize();
		}
		//==============================================================================
		//{region							PUBLIC METHODS

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		protected function initialize():void{
			//abstract
		}

		private function postInitialize():void{
			this.setSize(_body.width, _body.height + this.titleBar.height + 10);
			this.hasMinimizeButton = false;
			this.hasCloseButton = true;
		}

		protected final function addBr():void{
			var br:Component = new Component();
			br.width = 1;
			br.height = 20;
			_body.addChild(br);
		}

		protected final function addInput(name:String, label:String, text:String = ""):void{
			var field:HBox = new HBox();
			var input:InputText = new InputText(field, 0, 0, text);
			input.width = 150;
			new Label(field, 0, 0, label);
			_body.addChild(field);
			_controls[name] = input;
			if(_data != null && _data.hasOwnProperty(name)){
				input.text = _data[name];
			}
		}

		protected final function addText(text:String = ""):void{
			var field:Text = new Text(_body, 0, 0, text);
			field.editable = false;
		}

		protected final function addList(value:Array = null):void{
			if(value == null){
				value = _data;
			}
			_controls["list"] = new List(_body, 0, 0, value);
		}

		protected final function addComboBox(label:String, value:Array = null):void{
			if(value == null){
				value = _data;
			}
			var field:HBox = new HBox(_body);
			_controls["comboBox"] = new ComboBox(field, 0, 0, value[0], value);
			new Label(field, 0, 0, label);
		}

		protected final function addButton(label:String, closeReason:String = ACCEPT):void{
			var callback:Function = function(event:MouseEvent):void{
				event.target.removeEventListener(event.type, arguments.callee);
				close(closeReason);
			};
			var button:PushButton = new PushButton(_body, 0, 0, label, callback);
			button.x = _body.width - button.width >> 1;
		}

		protected final function close(closeReason:String, data:* = null):void{
			_closeReason = closeReason;
			if(data == null){
				//collect data from created fields
				data = {};
				for(var name:String in _controls){
					var control:Object = _controls[name];
					if(control is InputText){
						data[name] = control.text;
					}else if(control is List){
						data[name] = control.selectedItem;
					}
					//TODO add else controls that will be created automatically
				}
			}
			_data = data;
			this.stage.removeEventListener(KeyboardEvent.KEY_UP, this.keyBoardHandler);
			this.onClose(new MouseEvent(MouseEvent.CLICK));
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS

		override protected final function onClose(event:MouseEvent):void {
			if(_closeCallback is Function){
				_closeCallback.apply(this, [_closeReason, _data]);
			}
			super.onClose(event);
		}

		private function keyBoardHandler(event:KeyboardEvent):void {
			if(event.keyCode == 13)//Enter
			{
				this.close(DialogWindow.ACCEPT);
			}
		}

		private function addedToStageHandler(event:Event):void {
			this.removeEventListener(event.type, this.addedToStageHandler);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, this.keyBoardHandler);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function set closeCallback(value:Function):void {
			_closeCallback = value;
		}

		public function get modal():Boolean {
			return _modal;
		}

		public function set modal(value:Boolean):void {
			_modal = value;
			this.draggable = !_modal;
			this.hasMinimizeButton = !_modal;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
