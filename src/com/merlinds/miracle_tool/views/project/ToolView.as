/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 21:39
 */
package com.merlinds.miracle_tool.views.project {
	import com.bit101.components.Component;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	import com.merlinds.miracle_tool.view.interfaces.IResizable;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class ToolView extends Window implements IResizable{
		[Embed(source="../../../../../../assets/tools_icons.png", mimeType="image/png")]
		public static const Icons:Class;

		private var _iconSource:BitmapData;
		private var _body:VBox;
		private var _activeTool:Component;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ToolView(parent:DisplayObjectContainer = null) {
			super(parent, 0, 0, "...");
			this.initialize();
		}

		override public function setSize(w:Number, h:Number):void {
			if(_body != null) {
				super.setSize(30, _body.height + this.titleBar.height + 10);
			}
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function initialize():void {
			this.y = 50;
			super .setSize(30, 100);
			_body = new VBox(this);
			_body.x = 30 - 21 >> 1;
			_body.y = 5;
			_activeTool = new ToolButton(_body, this.getIcon(0), "Pointer");
			_activeTool.addEventListener(MouseEvent.CLICK, this.buttonClick);
			new ToolButton(_body, this.getIcon(3), "Hand").addEventListener(MouseEvent.CLICK, this.buttonClick);
			new ToolButton(_body, this.getIcon(1), "Crop").addEventListener(MouseEvent.CLICK, this.buttonClick);
			new ToolButton(_body, this.getIcon(2), "Zoom").addEventListener(MouseEvent.CLICK, this.buttonClick);
			this.enabled = false;
		}

		private function getIcon(index:int):Bitmap {
			if(_iconSource == null){
				_iconSource = new Icons().bitmapData;
			}
			var icon:Bitmap = new Bitmap(new BitmapData(21, 21, false, 0xFF525252));
			icon.bitmapData.copyPixels(_iconSource, new Rectangle(21 *index, 0, 21, 21), new Point());
			return icon;
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function buttonClick(event:MouseEvent):void {
			_activeTool = event.target as Component;
			for(var i:int = 0; i < _body.numChildren; i++){
				(_body.getChildAt(i) as Component).enabled = true;
			}
			_activeTool.enabled = false;
			this.dispatchEvent(event);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get activeTool():String{
			return _activeTool.name;
		}

		override public function set enabled(value:Boolean):void {
			super.enabled = value;
			if(value){
				_activeTool.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			}
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}

import com.bit101.components.PushButton;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

class ToolButton extends PushButton{

	private var _name:String;
	private var _icon:DisplayObject;

	public function ToolButton(parent:DisplayObjectContainer, icon:DisplayObject, name:String) {
		_name = name;
		_icon = icon;
		super(parent, 0, 0, "");
		this.setSize(icon.width + 2, icon.height + 2);
		this.addChild(_icon);
		_icon.y = _icon.x = 1;
	}

	override public function set enabled(value:Boolean):void {
		super.enabled = value;
		_icon.alpha = value ? 1: 0.5;
	}

	override public function get name():String {
		return _name;
	}
}