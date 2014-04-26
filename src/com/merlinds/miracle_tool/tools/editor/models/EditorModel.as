/**
 * User: MerlinDS
 * Date: 25.04.2014
 * Time: 21:16
 */
package com.merlinds.miracle_tool.tools.editor.models {
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.data.SWFSymbol;
	import com.codeazur.as3swf.tags.TagSymbolClass;

	import flash.display.BitmapData;

	import flash.display.DisplayObject;

	import flash.display.MovieClip;

	public class EditorModel {

		private var _target:MovieClip;
		private var _symbols:Array;

		private var _boundsOffset:Number;
		private var _instanceName:String;

		private var _output:BitmapData;
		private var _elements:Vector.<Element>;

		public function EditorModel() {
			_boundsOffset = 0;
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function getInstanceFromTarget(name:String):DisplayObject{
			var result:DisplayObject;
			try{
				var clazz:Class = _target.loaderInfo.applicationDomain.getDefinition(name) as Class;
				result = new clazz() as DisplayObject;
			}catch(error:Error){
				trace("Cannot define instance with name", name);
			}finally{
				return result;
			}
		}

		public function hasElement(name:String):Boolean {
			var result:Boolean;
			var i:int, n:int = _elements.length;
			for(i = 0; i < n; i++){
				result = _elements[i].name == name;
				if(result)break;
			}
			return result;
		}

		public function destroy():void {
			_output.dispose();
			this.target = null;
			_elements = null;
			_symbols = null;
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function clear():void {
			_target = null;
			_symbols = null;
		}

		public function cleanElements():void{
			var n:int = _elements.length;
			for(var i:int = 0; i < n; i++){
				_elements[i].bitmapData.dispose();
				_elements[i].bitmapData = null;
				_elements[i].view = null;
			}
		}

		private function parse():void {
			//get library info
			_symbols = [];
			var swf:SWF = new SWF(_target.loaderInfo.bytes);
			var i:int, j:int, n:int, m:int;
			n = swf.tags.length;
			for (i = 0; i < n; i++) {
				if(swf.tags[i].name == "SymbolClass"){
					var symbolClass:TagSymbolClass = swf.tags[i] as TagSymbolClass;
					m = symbolClass.symbols.length;
					for(j = 0; j < m; j++){
						var swfSymbol:SWFSymbol = symbolClass.symbols[j];
						_symbols.push(swfSymbol.name);
					}
				}
			}
			trace(">>" +  _symbols);
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function get target():MovieClip {
			return _target;
		}

		public function set target(value:MovieClip):void {
			_target = value;
			var method:Function = value == null ? this.clear : this.parse;
			method.apply(this);
		}

		public function get libraryListing():Array{
			return _symbols;
		}

		public function get boundsOffset():Number {
			return _boundsOffset;
		}

		public function get instanceName():String {
			return _instanceName;
		}

		public function set instanceName(value:String):void {
			_instanceName = value;
		}


		public function get output():BitmapData {
			return _output;
		}

		public function set output(value:BitmapData):void {
			_output = value;
		}

		public function get elements():Vector.<Element> {
			return _elements;
		}

		public function set elements(value:Vector.<Element>):void {
			_elements = value;
		}


//} endregion GETTERS/SETTERS ==================================================
	}
}
