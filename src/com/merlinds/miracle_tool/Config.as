/**
 * User: MerlinDS
 * Date: 24.04.2014
 * Time: 20:10
 */
package com.merlinds.miracle_tool {
	import flash.errors.IllegalOperationError;
	import flash.filesystem.File;

	public class Config {

		private static var _flashIDEPath:File;
		private static var _nativeFilesPath:File;
		private static var _swfCompiler:File;
		private static var _png2atf:File;

		{
			_nativeFilesPath = File.applicationDirectory;
			_nativeFilesPath = _nativeFilesPath.resolvePath("com/merlinds/miracle_tool/nativeapp/");
			if(!_nativeFilesPath.exists){
				throw Error("Cannot found path to native applications");
			}
			//
			_swfCompiler = File.applicationDirectory;
			_swfCompiler = _nativeFilesPath.resolvePath("swfCompiler.jsfl");
			if(!_swfCompiler.exists){
				throw Error("Cannot found path to swf compiler");
			}
			//
			_png2atf = File.applicationDirectory;
			_png2atf = _nativeFilesPath.resolvePath("png2atf.exe");
			if(!_png2atf.exists){
				throw Error("Cannot found path to png2atf");
			}
		}

		public function Config(flashIDEPath:String) {
			_flashIDEPath = new File(flashIDEPath);
			_flashIDEPath.canonicalize();
			if(!_flashIDEPath.exists){
				throw new ArgumentError("Cannot found path to Flash.exe");
			}
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public static function get flashIDEPath():File{
			if(_flashIDEPath == null){
				throw IllegalOperationError("Config must be initialized first");
			}
			return _flashIDEPath;
		}

		public static function get nativeFilesPath():File {
			return _nativeFilesPath;
		}


		public static function get swfCompiler():File {
			return _swfCompiler;
		}

		public static function get png2atf():File {
			return _png2atf;
		}

//} endregion GETTERS/SETTERS ==================================================
	}
}
