/**
 * User: MerlinDS
 * Date: 25.02.2015
 * Time: 18:00
 */
package com.merlinds.miracle_tool.services {
	import com.merlinds.miracle.format.mtf.MTF1;
	import com.merlinds.miracle_tool.models.vo.ElementVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;
	import com.merlinds.miracle_tool.utils.MeshUtils;

	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.ByteArray;

	public class MTFCompiler extends OutputCompiler{

		private var _buffer:BitmapData;
		private var _atfBuilder:PublishBuilder;
		private var _mtf:MTF1;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function MTFCompiler()
		{
			_atfBuilder = new PublishBuilder();
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		override protected function compile():void {
			_mtf = new MTF1();
			this.createBitmapBuffer();
			var png:ByteArray = PNGEncoder.encode(_buffer);
			_atfBuilder.createATFFile(png, 0, this.atfCallback);
		}

		private function createBitmapBuffer():void {
			_buffer = new BitmapData(this.model.outputSize, this.model.outputSize, true, 0x0);
			var n:int = this.model.sources.length;
			for(var i:int = 0; i < n; i++){
				var source:SourceVO = this.model.sources[i];
				var m:int = source.elements.length;
				for(var j:int = 0; j < m; j++){
					//push element view to _buffer
					var element:ElementVO = source.elements[j];
					var depth:Point = new Point(element.x + this.model.boundsOffset,
							element.y + this.model.boundsOffset);
					_buffer.copyPixels(element.bitmapData, element.bitmapData.rect, depth);
				}
			}
		}

		private function compileMeshes():void {
			var n:int = this.model.sources.length;
			for(var i:int = 0; i < n; i++){
				var source:SourceVO = this.model.sources[i];
				var m:int = source.elements.length;
				var mesh:Object = {};
				for(var j:int = 0; j < m; j++){
					//push element view to _buffer
					var element:ElementVO = source.elements[j];
					mesh[element.name] = {
						vertices:MeshUtils.flipToY(element.vertexes),
						uv:MeshUtils.covertToRelative(element.uv, this.model.outputSize),
						indexes:element.indexes
					};
				}
				_mtf.addMesh(source.clearName, mesh);
			}
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function atfCallback():void {
			_mtf.addTexture(_atfBuilder.output);
			this.compileMeshes();
			_mtf.finalize();
			this.finalyzeCompilation(_mtf);
		}
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
