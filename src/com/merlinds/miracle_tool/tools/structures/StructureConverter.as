/**
 * User: MerlinDS
 * Date: 04.04.2014
 * Time: 16:32
 */
package com.merlinds.miracle_tool.tools.structures {
	import com.merlinds.miracle_tool.tools.ITool;

	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;

	import nochump.util.zip.ZipEntry;
	import nochump.util.zip.ZipFile;

	public class StructureConverter implements ITool{

		private var _parser:FlaSymbolParser;
		private var _callback:Function;
		private var _symbols:Object;
		private var _file:File;

		public function StructureConverter() {
			_parser = new FlaSymbolParser();
			_symbols = {};
		}

		//==============================================================================
		//{region							PUBLIC METHODS

		public function execute():void {
			trace(this, "execute");
			this.selectFile();
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function selectFile():void {
			this._file = File.documentsDirectory;
			var docFilter:FileFilter = new FileFilter("Documents", "*.fla");
			_file.browseForOpen("Select structure file", [docFilter]);
			_file.addEventListener(Event.SELECT, this.selectHandler)
		}

		private function decodeBytes(bytes:ByteArray):void {
			if(_file.extension == "fla"){
				var data:ByteArray;
				var zip:ZipFile = new ZipFile(bytes);
				var entry:ZipEntry = zip.getEntry("DOMDocument.xml");
				if(entry == null){
				}else{
					var symbols:Vector.<ZipEntry> = new <ZipEntry>[];
					//parse domDocument
					data = zip.getInput(entry);
					var xml:XML = new XML(data.readUTFBytes(data.length));
					var children:XMLList = xml.children()[0].children();
					var n:int = children.length();
					for(var i:int = 0; i < n; i++){
						var link:String = children[i].@href;
						entry = zip.getEntry("LIBRARY/" + link);
						if(entry == null){
							trace("Wrong symbol in fla", link);
						}else{
							data = zip.getInput(entry);
							_symbols[link] = new XML(data.readUTFBytes(data.length));
							_symbols[link] = _parser.execute(_symbols[link]);
						}

					}
					bytes.clear();
					data.clear();
					zip = null;
					trace("Get all symbols from document");
				}
			}
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function selectHandler(event:Event):void {
			_file.removeEventListener(event.type, arguments.callee);
			var stream:FileStream = new FileStream();
			stream.addEventListener(Event.COMPLETE, this.streamCompleteHandler);
			stream.openAsync(_file, FileMode.READ);
		}

		private function streamCompleteHandler(event:Event):void {
			var stream:FileStream = event.target as FileStream;
			stream.removeEventListener(event.type, arguments.callee);
			//copy bytes
			var bytes:ByteArray = new ByteArray();
			stream.readBytes(bytes);
			stream.close();
			setTimeout(this.decodeBytes, 0, bytes);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
