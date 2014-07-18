/**
 * User: MerlinDS
 * Date: 16.07.2014
 * Time: 22:22
 */
package com.merlinds.miracle_tool.controllers {
	import com.merlinds.debug.log;
	import com.merlinds.miracle_tool.events.ActionEvent;
	import com.merlinds.miracle_tool.events.DialogEvent;
	import com.merlinds.miracle_tool.models.ProjectModel;
	import com.merlinds.miracle_tool.models.vo.AnimSourcesVO;
	import com.merlinds.miracle_tool.models.vo.AnimationVO;
	import com.merlinds.miracle_tool.models.vo.CurveVO;
	import com.merlinds.miracle_tool.models.vo.TimelineVO;
	import com.merlinds.miracle_tool.services.ActionService;

	import flash.geom.Matrix;

	import org.robotlegs.mvcs.Command;

	public class AnimationConverterCommand extends Command {

		private static const BLANK_TYPE:String = "blank";
		private static const TWEEN_TYPE:String = "tween";
		private static const MATRIX_TYPE:String = "matrix";
		private static const MOTION_TYPE:String = "motion";

		private static const TWEEN_ALL_FLAG:String = "all";
		private static const TWEEN_POSITION_FLAG:String = "position";
		private static const TWEEN_SCALE_FLAG:String = "scale";
		private static const TWEEN_ROTATION_FLAG:String = "rotation";

		[Inject]
		public var projectModel:ProjectModel;
		[Inject]
		public var actionService:ActionService;
		[Inject]
		public var event:ActionEvent;

		private var _animation:AnimationVO;
		private var _timeline:TimelineVO;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AnimationConverterCommand() {
			super();
		}

		override public function execute():void {
			log(this, "execute");
			var data:AnimSourcesVO = this.projectModel.tempData;
			if(data == null){
				this.projectModel.tempData = this.event.body;
				this.actionService.addAcceptActions(new <String>[this.event.type]);
				this.dispatch(new DialogEvent(DialogEvent.CHOOSE_ANIMATION, this.event.body.names));
			}else{
				this.projectModel.tempData = null;
				data.chosen.push(this.event.body["list"]);
				_animation = this.projectModel.animationInProgress;
				var name:String;
				while(data.chosen.length > 0){
					name = data.chosen.pop();
					if(name == AnimSourcesVO.DEFAULT_NAME){
						name = _animation.file.name;
						name = name.substr(_animation.file.extension.length);
					}
					this.convertXML(data[name] as XML, name);
				}
			}
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function convertXML(xml:XML, name:String):void{
			log(this, "convertXML", name);
			_timeline = new TimelineVO(name);
			//add namespace
			default xml namespace = new Namespace(xml.inScopeNamespaces()[0],
					xml.inScopeNamespaces()[1]);
			xml.normalize();
			//start parse
			var layersList:XMLList = xml.timeline.DOMTimeline.layers.children();
			var n:int = layersList.length();
			for(var i:int = 0; i < n; i++){
				var child:XML = layersList[i];
				if(child.@layerType != "folder"){//exclude Folders from parsing
					this.parseFrames( child.frames.DOMFrame );
				}
			}
			//end
			_animation.timelines.push(_timeline);
		}

		private function parseFrames(frames:XMLList):void {
			log(this, "parseFrames");
			var n:int = frames.length();

			for(var i:int = 0; i < n; i++) {
				var frame:XML = frames[i];
				var frameInfo:FrameInfo = new FrameInfo(BLANK_TYPE, int(frame.@index));
				frameInfo.duration = frame.@duration != undefined ? int(frame.@duration) : 1;

				//TODO: Ask from salazkin for what this code used
				if(frame.@name && frame.@labelType == "name"){
					var obj:Object = {
						name:frame.@name,
						index:frameInfo.index
					};
				}

				if(frame.@acceleration != undefined){
					//get tween from acceleration
					var acceleration:Number = int(frame.@acceleration) / 100;
					var diff:Number = 0.3333;
					frameInfo.tweenAll = new CurveVO(0, 0,//Point 0
							0.3333, 0.3333 + diff * acceleration,//Point 1
							0.6667, 0.6667 + diff * acceleration,//Point 2
							1, 1);//Point 3
				}

				if(frame.tweens != undefined){
					frameInfo.tweenAll = this.parseTweens(frame[i].tweens, TWEEN_ALL_FLAG);
					frameInfo.tweenPosition = this.parseTweens(frame[i].tweens, TWEEN_POSITION_FLAG);
					frameInfo.tweenScale = this.parseTweens(frame[i].tweens, TWEEN_SCALE_FLAG);
					frameInfo.tweenRotation = this.parseTweens(frame[i].tweens, TWEEN_ROTATION_FLAG);
				}

				if(frame.elements.DOMSymbolInstance.length() > 0){
					frameInfo.type = MATRIX_TYPE;
					if(frame.@tweenType == MOTION_TYPE){
						if(frames[i+1] != undefined){
							if(frames[i+1].elements.DOMSymbolInstance.length() > 0){
								frameInfo.type = TWEEN_TYPE;
							}
						}
					}
				}

				trace(frameInfo);

				switch(frameInfo.type){
					case TWEEN_TYPE:{
						break;
					}
					case MATRIX_TYPE:{
						break;
					}
					default/*BLANK_TYPE and other*/:
					{
//						nothing to do. Maybe will be needed for log information
						break;
					}
				}

			}
		}

		private function parseTweens(data:XMLList, flag:String):CurveVO
		{
			var ease:XMLList = data.CustomEase;
			var curve:CurveVO = new CurveVO();
			var n:int = ease.length();
			for(var i:int = 0; i < n; i++){
				if(flag == String(ease[i].@target)){
					var pointsList:XMLList = ease[i].Point;
					var m:int = pointsList.length();
					for(var j:int = 0; j < m; j++){
						curve.addPoint(
							pointsList[j].@x != undefined ? pointsList[j].@x : 0,
							pointsList[j].@y != undefined ? pointsList[j].@y : 0
						);
					}
				}
			}
			return curve;
		}

		private function addStatic(frame:XML, frameInfo:FrameInfo):void {
			var symbolName:String = frame.@libraryItemName;
			var color:Object = {};//getColorData(frame);
			var matrix:Matrix = new Matrix();
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

import com.merlinds.miracle_tool.models.vo.CurveVO;

class FrameInfo{
	public var index:int;
	public var duration:int;
	public var type:String = "blank";
	public var tweenAll:CurveVO;
	public var tweenPosition:CurveVO;
	public var tweenScale:CurveVO;
	public var tweenRotation:CurveVO;

	public function FrameInfo(type:String, index:int) {
		this.index = index;
		this.type = type;
	}

	public function toString():String {
		var string:String = "FrameInfo type " + type + " Tweens:" +
				"\n\ttweenAll: " + String(tweenAll != null ? tweenAll : "") +
				"\n\ttweenPosition: " + String(tweenPosition != null ? tweenPosition : "") +
				"\n\ttweenScale: " + String(tweenScale != null ? tweenScale : "") +
				"\n\ttweenRotation: " + String(tweenRotation != null ? tweenRotation : "");
		return string;
	}
}