/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 17:11
 */
package com.merlinds.miracle_tool.services {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.AppModel;

	import flash.events.Event;

	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;

	import org.robotlegs.mvcs.Actor;

	public class FileSystemService extends Actor {

		[Inject]
		public var appModel:AppModel;

		private var _target:File;
		private var _output:ByteArray;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function FileSystemService() {
			super();
		}

		public function readSource():void{
			log(this, "readSource");
			var filters:Array = [
				new FileFilter("SWF file", "*.swf"),
				new FileFilter("PNG Image file", "*.png"),
				new FileFilter("JPG Image file", "*.jpg")
			];
			this.selectSource("Attach source file to project", filters);
		}

		public function readAnimation():void{
			log(this, "readAnimation");
			var filters:Array = [
				new FileFilter("FLA file", "*.fla"),
				new FileFilter("XML file with animation description", "*.xml")
			];
			this.selectSource("Attach animation file to project", filters);
		}

		public function readProject():void{

		}

		public function writeProject():void{

		}

		public function writeTexture():void{

		}

		public function writeTimelien():void{

		}

		public function writeMesh():void{

		}

		public function clear():void {
			_target = null;
			_output.clear();
			_output = null;
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function selectSource(title:String, filters:Array = null):void {
			_target = this.appModel.lastFileDirection;
			_target.addEventListener(Event.SELECT, this.selectSourceHandler);
			_target.browseForOpen(title, filters);
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function selectSourceHandler(event:Event):void {
			_target.removeEventListener(event.type, this.selectSourceHandler);
			log(this, "selectSourceHandler", _target.name);
			this.appModel.lastFileDirection = _target.parent;
			//start to download
			var fileStream:FileStream = new FileStream();
			fileStream.addEventListener(Event.COMPLETE, this.completeReadHandler);
			fileStream.openAsync(_target, FileMode.READ);
		}

		private function completeReadHandler(event:Event):void {
			var fileStream:FileStream = event.target as FileStream;
			fileStream.removeEventListener(event.type, this.completeReadHandler);
			log(this, "completeReadHandler");
			_output = new ByteArray();
			fileStream.readBytes(_output);
			fileStream.close();
			this.dispatch(new EditorEvent(EditorEvent.FILE_READ));
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		public function get target():File {
			return _target;
		}

		public function get output():ByteArray {
			return _output;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
