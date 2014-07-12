/**
 * User: MerlinDS
 * Date: 19.06.2014
 * Time: 17:41
 */
package com.merlinds.unitls.tar {
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;

	public class TarFile {

		private static const MAX_CHUNKS:int = 128;
		private static const CHUNK:int = 512;
		private static const SIZE:int = 124;
		private static const NAME:int = 100;

		private var _source:ByteArray;
		private var _onComplete:Function;

		private var _entries:Vector.<TarEntry>;
		private var _entriesBytes:Vector.<ByteArray>;

		private var _currentEntry:TarEntry;
		private var _currentBytes:ByteArray;

		private var _chunksCount:int;
		private var _position:int;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function TarFile(source:ByteArray) {
			_source = source;
			_entries = new <TarEntry>[];
			_entriesBytes = new <ByteArray>[];
		}

		public function getInput(entry:TarEntry):ByteArray {
			var index:int = _entries.indexOf(entry);
			return entry.compete ? _entriesBytes[ index ] : null;
		}

		public function unpack(onComplete:Function):void {
			if(_source == null || _source.length == 0){
				throw new IllegalOperationError("Can not unpack empty file");
			}
			_onComplete = onComplete;
			//start unpack
			_position = 0;
			this.getHeader();
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function getHeader():void {
			if(_source.length > _position){
				_source.position = _position;
				var name:String = _source.readMultiByte(NAME, "us-ascii");
				_source.position = _position + SIZE;
				var size:String = _source.readMultiByte(12, "us-ascii");
				_currentEntry = new TarEntry(name, parseInt(size, 8));
				_source.position = _position + CHUNK;
				_chunksCount = Math.ceil(_currentEntry.size / CHUNK);
				_currentBytes = new ByteArray();
				_position += CHUNK * (_chunksCount + 1);
				if(_currentEntry.size == 0){
					this.getHeader();
				}else{
					setTimeout(this.readBytes, 0);
				}
			}else{
				_onComplete.apply(this);
			}
		}

		private function readBytes():void {
			var readLength:int;
			var timer:Number = getTimer();
			while(_chunksCount > 0 && getTimer() - timer < 16){
				if(_chunksCount > MAX_CHUNKS){
					_chunksCount -= MAX_CHUNKS;
					readLength = MAX_CHUNKS * CHUNK;
				}else{
					readLength = _chunksCount * CHUNK;
					_chunksCount = 0;
				}
				_source.readBytes(_currentBytes, _currentBytes.length, readLength);
			}

			if(_chunksCount == 0){
				_currentEntry.setComplete();
				_entriesBytes.push(_currentBytes);
				_entries.push(_currentEntry);
				setTimeout(this.getHeader, 0);
			}else{
				setTimeout(this.readBytes, 0);
			}
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get entryCount():int {
			return _entries.length;
		}

		public function get entries():Vector.<TarEntry> {
			return _entries;
		}
		//} endregion GETTERS/SETTERS ==================================================
	}
}
