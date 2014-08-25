/**
 * User: MerlinDS
 * Date: 13.07.2014
 * Time: 17:11
 */
package com.merlinds.miracle_tool.services {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.EditorEvent;
	import com.merlinds.miracle_tool.models.AppModel;
	import com.merlinds.unitls.structures.QueueFIFO;

	import flash.events.Event;

	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	import flash.utils.ByteArray;

	import org.robotlegs.mvcs.Actor;

	public class FileSystemService extends Actor {

		public static const PROJECT_EXTENSION:String = ".mtp"; /** Miracle tools project **/
		public static const TEXTURE_EXTENSION:String = ".mtf"; /** Miracle texture format **/
		public static const ANIMATION_EXTENSION:String = ".maf"; /** Miracle animation format **/
		[Inject]
		public var appModel:AppModel;
		[Inject]
		public var actionService:ActionService;

		private var _target:File;
		private var _output:ByteArray;
		private var _sourceQueue:QueueFIFO;
		private var _publishBuilder:PublishBuilder;
		private var _queue:QueueFIFO;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function FileSystemService() {
			super();
			_queue = new QueueFIFO();
			_sourceQueue = new QueueFIFO();
			_publishBuilder = new PublishBuilder();
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
			log(this, "readAnimation");
			var filters:Array = [
				new FileFilter("FLA file", "*" + PROJECT_EXTENSION)
			];
			this.selectSource("Open project", filters);
		}

		public function readProjectSources(sources:Array):void{
			if(sources != null){
				log(this, "readProjectSources");
				while(sources.length > 0){
					_sourceQueue.push(sources.shift());
				}
				this.readProjectSource();
			}
		}

		public function writeProject(name:String, data:Object):void{
			log(this, "writeProject", name);
			_output = new ByteArray();
			//add signature
			_output.position = 0;
			_output.writeUTFBytes(PROJECT_EXTENSION.substr(1).toUpperCase());
			_output.position = 4;
			_output.writeObject(data);
			name = name + PROJECT_EXTENSION;

			_target = this.appModel.lastFileDirection.resolvePath(name);
			_target.addEventListener(Event.SELECT, this.selectProjectForSaveHandler);
			_target.browseForSave("Save project");

		}

		public function writeTexture(name:String, png:ByteArray, mesh:ByteArray):void{
			log(this, "writeTexture", name);
			name = name + TEXTURE_EXTENSION;
			//create file
			_output = new ByteArray();
			//add signature
			_output.position = 0;
			_output.writeUTFBytes(TEXTURE_EXTENSION.substr(1).toUpperCase());
			_output.position = 4;
			var meshHeaderBlocks:int = Math.ceil( mesh.length / 512 );
			_output.writeUnsignedInt( meshHeaderBlocks );
			_output.position = 8;
			_output.writeBytes(mesh);
			_output.position = 8 + meshHeaderBlocks * 512;
			//save file
			_target = this.appModel.lastFileDirection.resolvePath(name);
			_publishBuilder.createATFFile(png, 0, this.publishBuilderATFHandler);
		}

		public function writeAnimation(animation:ByteArray):void{
			var output:ByteArray = new ByteArray();
			//add signature
			output.position = 0;
			output.writeUTFBytes(ANIMATION_EXTENSION.substr(1).toUpperCase());
			output.position = 4;
			output.writeBytes(animation);
			_queue.push(output);
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

		private function readProjectSource():void {
			if(!_sourceQueue.empty)
			{
				var source:Object = _sourceQueue.pop();
				_target = new File(source.file);
				log(this, "readProjectSource", _target.name);
				//start to download
				var fileStream:FileStream = new FileStream();
				fileStream.addEventListener(Event.COMPLETE, this.completeReadHandler);
				fileStream.openAsync(_target, FileMode.READ);
			}
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function selectSourceHandler(event:Event):void {
			_target.removeEventListener(event.type, this.selectSourceHandler);
			this.appModel.lastFileDirection = _target.parent;
			log(this, "selectSourceHandler", _target.name);
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
			this.readProjectSource();
		}

		private function selectProjectForSaveHandler(event:Event):void {
			_target.removeEventListener(event.type, this.selectSourceHandler);
			this.appModel.lastFileDirection = _target.parent;
			log(this, "selectProjectForSaveHandler", _target.name);
			var fileStream:FileStream = new FileStream();
			fileStream.open(_target, FileMode.WRITE);
			fileStream.writeBytes(_output);
			fileStream.close();
			_output.clear();
			_output = null;
			if(!_queue.empty){
				_output = _queue.pop();
				var name:String = _target.name.replace(TEXTURE_EXTENSION, ANIMATION_EXTENSION);
				_target = this.appModel.lastFileDirection.resolvePath(name);
				_target.addEventListener(Event.SELECT, this.selectProjectForSaveHandler);
				_target.browseForSave("Publish animation");
			}
			log(this, "selectProjectForSaveHandler", "Project Saved");
			this.actionService.done();
		}

		private function publishBuilderATFHandler():void {
			_output.writeBytes(_publishBuilder.output);
			_target.addEventListener(Event.SELECT, this.selectProjectForSaveHandler);
			_target.browseForSave("Publish texture");
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
