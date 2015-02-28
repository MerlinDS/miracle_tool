/**
 * User: MerlinDS
 * Date: 25.02.2015
 * Time: 18:00
 */
package com.merlinds.miracle_tool.services {
	import com.merlinds.miracle.animations.AnimationHelper;
	import com.merlinds.miracle.animations.FrameInfo;
	import com.merlinds.miracle.format.maf.MAF1;
	import com.merlinds.miracle.geom.Transformation;
	import com.merlinds.miracle_tool.models.vo.AnimationVO;
	import com.merlinds.miracle_tool.models.vo.FrameVO;
	import com.merlinds.miracle_tool.models.vo.SourceVO;
	import com.merlinds.miracle_tool.models.vo.TimelineVO;
	import com.merlinds.unitls.Resolutions;

	import flash.geom.Rectangle;

	public class MAFCompiler extends OutputCompiler {

		private var _maf:MAF1;
		private var _scale:Number;

		private var _transforms:Vector.<Transformation>;
		private var _frames:Vector.<FrameInfo>;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function MAFCompiler(){}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		override protected function compile():void
		{
			_maf = new MAF1();

			_scale = Resolutions.width(this.model.targetResolution) /
			Resolutions.width(this.model.referenceResolution);

			var n:int = this.model.sources.length;
			for(var i:int = 0; i < n; i++)
			{
				var source:SourceVO = this.model.sources[i];
				var m:int = source.animations.length;
				for(var j:int = 0; j < m; j++)
				{
					var animationVO:AnimationVO = source.animations[j];
					var animation:AnimationHelper = this.calculateAnimations(animationVO);
					this._maf.addAnimation(source.clearName + "." + animationVO.name, animation);
				}
			}
			_maf.finalize();
		}

		private function calculateAnimations(animationVO:AnimationVO):AnimationHelper
		{
			var totalFrames:int = animationVO.totalFrames;
			var numLayers:int = animationVO.timelines.length;
			var bounds:Rectangle = animationVO.bounds.clone();
			bounds.x = bounds.x * _scale;
			bounds.y = bounds.y * _scale;
			bounds.width = bounds.width * _scale;
			bounds.height = bounds.height * _scale;

			_transforms = new <Transformation>[];
			_frames = new <FrameInfo>[];

			for(var i:int = 0; i < numLayers; i++)
			{
				var timelineVO:TimelineVO = animationVO.timelines[i];
				var m:int = timelineVO.frames.length;
				for(var j:int = 0; j < m; j++){
					var frameVO:FrameVO = timelineVO.frames[j];
//					var frame:FrameInfo = new FrameInfo();
				}
			}

			return new AnimationHelper(animationVO.name, totalFrames, numLayers, _frames);
		}
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
