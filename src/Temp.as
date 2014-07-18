import flash.geom.Matrix;
import flash.geom.Point;

var dataXML:XML


var matrixFlags:Array = [
	"type",
	"ma", "mb", "mc", "md", "tx", "ty",
	"r", "g", "b", "tint", "alpha"
]

var staticFlags:Array = [
	"type", "tx", "ty", "scaleX", "scaleY", "skewX", "skewY", "r", "g", "b", "tint", "alpha"
]

var tweenFlags:Array = [
	"type", "index", "duration",
	"ease", "easePosition", "easeScale", "easeRotation", "offsetX", "offsetY",
	"tx", "ty", "scaleX", "scaleY", "skewX", "skewY",
	"delta_tx", "delta_ty", "delta_scaleX", "delta_scaleY", "delta_skewX", "delta_skewY",
	"r", "g", "b", "tint", "alpha",
	"delta_r", "delta_g", "delta_b", "delta_tint", "delta_alpha"
]




var tweensArr:Array = new Array()
tweensArr[0] = curveParse([new Point(0, 0), new Point(0.3333, 0.3333), new Point(0.6667, 0.6667), new Point(1, 1)])



var spritesArr:Array = new Array()
var transformArr_old:Array = new Array()
var framesArr:Array = new Array()
var labelsArr:Array = new Array()

var transformArr:Array = new Array()
var transformIndexesArr:Array = new Array()

var loader:URLLoader;
loader = new URLLoader(new URLRequest("input.xml"));
loader.addEventListener(Event.COMPLETE, XMLLoaded);


function XMLLoaded(e:Event):void{
	var xmlnsPattern:RegExp = new RegExp("xmlns[^\"]*\"[^\"]*\"", "gi");
	dataXML = new XML(e.target.data.replace(xmlnsPattern, ""));

	//trace(dataXML)

	var layersList:XMLList = dataXML.timeline.DOMTimeline.layers.DOMLayer
	var layersNum:int = layersList.length()

	for(var i:uint = 0; i<layersNum; i++){
		if(layersList[i].@layerType != "folder"){
			parseFrame(layersList[i].frames.DOMFrame)
		}
	}

	traceData()
}


function parseFrame(frames:XMLList){
	var framesList:XMLList = frames
	var framesNum:int = framesList.length()

	for(var i:uint = 0; i<framesNum; i++){
		var frameIndex:int = int(framesList[i].@index)
		var frameDuration = (framesList[i].@duration != undefined)? int(framesList[i].@duration):1



		var tweenType:String = "blank"

		if(framesList[i].@name && framesList[i].@labelType == "name" ){
			labelsArr.push({name:framesList[i].@name, index:frameIndex})
		}


		var tweenAll:String = ""
		var tweenPosition:String = ""
		var tweenScale:String = ""
		var tweenRotation:String = ""

		if(framesList[i].@acceleration != undefined){
			tweenAll = getTweenFromAcceleration(framesList[i].@acceleration)
		}

		if(framesList[i].tweens != undefined){
			tweenAll = parseTweens(framesList[i].tweens, "all")
			tweenPosition = parseTweens(framesList[i].tweens, "position")
			tweenScale = parseTweens(framesList[i].tweens, "rotation")
			tweenRotation = parseTweens(framesList[i].tweens, "scale")
		}

		if(framesList[i].elements.DOMSymbolInstance.length() > 0){ //Если на ключевом кардре что-то есть
			tweenType = "matrix"
			if(framesList[i].@tweenType == "motion"){
				if(framesList[i+1] != undefined){ //Если есть ключевой кадр
					if(framesList[i+1].elements.DOMSymbolInstance.length() > 0){ //Если конечный ключевой кадр не пустой
						tweenType = "tween"
					}
				}
			}
		}

		switch(tweenType){
			case "blank":
				//trace("no symbols", frameIndex, frameDuration)
				break

			case "matrix":
				//addMatrix(frameIndex, frameDuration, framesList[i].elements.DOMSymbolInstance)
				addStatic(frameIndex, frameDuration, framesList[i].elements.DOMSymbolInstance)
				break

			case "tween":

				var tweenIndexes:Array = [pushTween(tweenAll), pushTween(tweenPosition), pushTween(tweenScale), pushTween(tweenRotation)]
				addTween(frameIndex, frameDuration, framesList[i].elements.DOMSymbolInstance, framesList[i+1].elements.DOMSymbolInstance, tweenIndexes)
				break
		}
		//trace(framesList[i].@tweenType)
	}
}



function pushTween(str:String):int{
	var index:int = -1

	if(str != ""){
		for(var i:uint = 0; i<tweensArr.length; i++){
			if(tweensArr[i] == str){
				index = i
			}
		}
		if(index == -1){
			index = tweensArr.length
			tweensArr.push(str)
		}
	}

	return index
}
function getTweenFromAcceleration(v:Number):String{
	var accel:Number = v / 100
	var dif:Number = 0.3333

	var p0:Point = new Point(0, 0)
	var p1:Point = new Point(0.3333, 0.3333 + dif * accel)
	var p2:Point = new Point(0.6667, 0.6667 + dif * accel)
	var p3:Point = new Point(1, 1)

	return curveParse([p0, p1, p2, p3])
}


function parseTweens(data:XMLList, flag:String):String{
	var tweensList:XMLList = data.CustomEase

	var pointsArr:Array = new Array()

	for(var i:uint = 0; i<tweensList.length(); i++){
		var target:String = tweensList[i].@target

		if(flag == target){
			var pointsList:XMLList = tweensList[i].Point
			pointsArr = new Array
			for(var j:uint = 0; j<pointsList.length(); j++){
				var point:Point = new Point(0, 0)
				if(pointsList[j].@x != undefined )point.x = pointsList[j].@x
				if(pointsList[j].@y != undefined )point.y = pointsList[j].@y
				pointsArr.push(point)
			}
//			trace(target, curveParse(pointsArr))
		}
	}
	return curveParse(pointsArr)
}


function curveParse(tweenCurve:Array):String{
	var curveArr:Array = new Array()
	var curveStep:Number = 0.1
	var i:uint

	for(i = 0; i<tweenCurve.length-1; i+= 3){
		var p0:Point = tweenCurve[i+0]
		var p1:Point = tweenCurve[i+1]
		var p2:Point = tweenCurve[i+2]
		var p3:Point = tweenCurve[i+3]


		var cx:Number = 3*(p1.x-p0.x);
		var bx:Number = 3*(p2.x-p1.x)-cx;
		var ax:Number = p3.x-p0.x-cx-bx;
		var cy:Number = 3*(p1.y-p0.y);
		var by:Number = 3*(p2.y-p1.y)-cy;
		var ay:Number = p3.y-p0.y-cy-by;

		for(var t:Number = 0; t < 1; t += 0.01){
			var xPos:Number = ax*Math.pow(t,3)+bx*Math.pow(t,2)+cx*t+p0.x;
			var yPos:Number = ay*Math.pow(t,3)+by*Math.pow(t,2)+cy*t+p0.y;
			var dotIndex:int = Math.ceil(xPos  / curveStep)
			curveArr[dotIndex] = yPos

			for(var g:uint = 0; g<10; g++){

			}
		}
	}

	var str:String = ""
	for(i = 0; i<curveArr.length; i++){

		var num:Number = curveArr[i]// * 100
		if(i == 0)num = 0
		if(i == curveArr.length-1)num = 1
		str += num.toFixed(2)
		if(i < curveArr.length-1) str += ","
	}
	return str
}

function traceData(){
	var i:uint
	var str:String = "{\n"





	//add labels data
	str += "\"labels\":["


	for(i = 0; i<labelsArr.length; i++){
		str += "\t{\"name\":\""+labelsArr[i].name+"\", \"index\":"+labelsArr[i].index+"}"
		if(i < labelsArr.length-1)str += ",\n"
	}
	str += "],"


	//add sprites data
	str += "\n\"sprites\":[\n"


	for(i = 0; i<spritesArr.length; i++){
		str += "\t\"" + spritesArr[i] + "\""
		if(i < spritesArr.length-1)str += ",\n"
	}
	str += "\n],"


	//add ease data
	str += "\n\"ease\":[\n"


	for(i = 0; i<tweensArr.length; i++){
		//if(i > 0){
		str += "\t["+tweensArr[i]+"]"
		if(i < tweensArr.length-1)str += ",\n"
		//}

	}
	str += "\n],"



	//add transform data
	str += "\n\"transform\":[\n"
	var objTagsArr:Array = ["type","index", "duration", "ease", "easePosition", "easeScale", "easeRotation", "offsetX", "offsetY", "ma","mb","mc","md","tx","ty","scaleX","scaleY","skewX","skewY","delta_tx","delta_ty","delta_scaleX","delta_scaleY","delta_skewX","delta_skewY","r","g","b","tint","alpha","delta_r","delta_g","delta_b","delta_tint","delta_alpha"]

	for(i = 0; i<transformArr_old.length; i++){
		str += "\t{\n"

		var obj:Object = transformArr_old[i]
		var add:Boolean = false

		str += "\t\t\"" + "id" + "\":" + i + ",\n"
		for(var j:uint = 0; j<objTagsArr.length; j++){
			if(obj[objTagsArr[j]] != undefined){
				if(add)str += ",\n"
				str += "\t\t\"" + objTagsArr[j] + "\":"
				if(objTagsArr[j] == "type"){
					str += "\"" + obj[objTagsArr[j]] + "\""
				}else{
					if(objTagsArr[j] == "easeRotation" || objTagsArr[j] == "easeScale" || objTagsArr[j] == "easePosition" || objTagsArr[j] == "ease" || objTagsArr[j] == "index" || objTagsArr[j] == "duration" || objTagsArr[j] == "r" || objTagsArr[j] == "g" || objTagsArr[j] == "b" || objTagsArr[j] == "delta_r" || objTagsArr[j] == "delta_g" || objTagsArr[j] == "delta_b"){
						str += int(obj[objTagsArr[j]]) //int для некоторых значений
					}else if(objTagsArr[j] == "curve"){
						str += JSON.stringify(obj[objTagsArr[j]])
					}else{
						str += Number(obj[objTagsArr[j]]).toFixed(6) // для остальных fixed 6
					}
				}
				add = true
			}
		}
		str += "\n\t}"
		if(i < transformArr_old.length-1)str += ",\n"
	}
	str += "\n],"


	//add frames data
	str += "\n\"frames\":[\n"
	for(i = 0; i<framesArr.length; i++){
		if(framesArr[i] == undefined)framesArr[i] = []
		str += "\t" + JSON.stringify(framesArr[i])
		if(i < framesArr.length-1)str += ",\n"
	}
	str += "\n]\n}"

	var animObj:Object = new Object()
	animObj.sprites = spritesArr
	animObj.transform = transformArr_old
	animObj.frames = framesArr
	trace(str)
	saveFile(str)
}



function saveFile(str:String){
	var file:FileReference = new FileReference;
	file.save(str, "output.txt");
}

function addTween(index:int, duration:int, data1:XMLList, data2:XMLList, easeData:Array){
	var symbolName:String = data1.@libraryItemName



	var mat1:Matrix = getMatrixData(data1)
	var mat2:Matrix = getMatrixData(data2)


	var transformPoint1:Point = new Point(0, 0)
	if(data1.transformationPoint.Point.@x)transformPoint1.x = data1.transformationPoint.Point.@x
	if(data1.transformationPoint.Point.@y)transformPoint1.y = data1.transformationPoint.Point.@y

	var transformPoint2:Point = new Point(0, 0)
	if(data2.transformationPoint.Point.@x)transformPoint2.x = data2.transformationPoint.Point.@x
	if(data2.transformationPoint.Point.@y)transformPoint2.y = data2.transformationPoint.Point.@y


	var offsetPoint:Point = new Point(transformPoint1.x, transformPoint1.y)

	transformPoint1 = mat1.transformPoint(transformPoint1)
	transformPoint2 = mat2.transformPoint(transformPoint2)



	var color1:Object = getColorData(data1)
	var color2:Object = getColorData(data2)

	var tweenObj:Object = new Object()
	tweenObj.type = "tween"
	tweenObj.index = index
	tweenObj.duration = duration

	tweenObj.ease = (easeData[0] != -1)?easeData[0]-1:undefined
	tweenObj.easePosition = (easeData[1] != -1 && easeData[1] != 0)?easeData[1]-1:undefined
	tweenObj.easeScale = (easeData[2] != -1 && easeData[2] != 0)?easeData[2]-1:undefined
	tweenObj.easeRotation = (easeData[3] != -1 && easeData[3] != 0)?easeData[3]-1:undefined


	tweenObj.offsetX = offsetPoint.x * -1
	tweenObj.offsetY = offsetPoint.y

	tweenObj.tx = transformPoint1.x
	tweenObj.ty = transformPoint1.y
	tweenObj.scaleX = Math.sqrt(mat1.a * mat1.a + mat1.b * mat1.b)
	tweenObj.scaleY = Math.sqrt(mat1.c * mat1.c + mat1.d * mat1.d)
	tweenObj.skewX = Math.atan2(-mat1.c, mat1.d)
	tweenObj.skewY = Math.atan2(mat1.b, mat1.a)

	tweenObj.delta_tx = transformPoint2.x - transformPoint1.x
	tweenObj.delta_ty = transformPoint2.y - transformPoint1.y

	tweenObj.delta_scaleX = Math.sqrt(mat2.a * mat2.a + mat2.b * mat2.b) - tweenObj.scaleX
	tweenObj.delta_scaleY = Math.sqrt(mat2.c * mat2.c + mat2.d * mat2.d) - tweenObj.scaleY
	tweenObj.delta_skewX = shortestAngle(tweenObj.skewX, Math.atan2(-mat2.c, mat2.d))
	tweenObj.delta_skewY = shortestAngle(tweenObj.skewY, Math.atan2(mat2.b, mat2.a))
	tweenObj.r = color1.r
	tweenObj.g = color1.g
	tweenObj.b = color1.b
	tweenObj.tint = color1.tint
	tweenObj.alpha = color1.alpha
	tweenObj.delta_r = color2.r - tweenObj.r
	tweenObj.delta_g = color2.g - tweenObj.g
	tweenObj.delta_b = color2.b - tweenObj.b
	tweenObj.delta_tint = color2.tint - tweenObj.tint
	tweenObj.delta_alpha = color2.alpha - tweenObj.alpha



	if(tweenObj.offsetX == 0) tweenObj.offsetX = undefined
	if(tweenObj.offsetY == 0) tweenObj.offsetY = undefined
	if(tweenObj.tx == 0) tweenObj.tx = undefined
	if(tweenObj.ty == 0) tweenObj.ty = undefined
	if(tweenObj.scaleX == 1) tweenObj.scaleX = undefined
	if(tweenObj.scaleY == 1) tweenObj.scaleY = undefined
	if(tweenObj.skewX == 0) tweenObj.skewX = undefined
	if(tweenObj.skewY == 0) tweenObj.skewY = undefined

	if(tweenObj.delta_tx == 0) tweenObj.delta_tx = undefined
	if(tweenObj.delta_ty == 0) tweenObj.delta_ty = undefined
	if(tweenObj.delta_scaleX == 0) tweenObj.delta_scaleX = undefined
	if(tweenObj.delta_scaleY == 0) tweenObj.delta_scaleY = undefined

	if(tweenObj.delta_skewX == 0) tweenObj.delta_skewX = undefined
	if(tweenObj.delta_skewY == 0) tweenObj.delta_skewY = undefined

	if(tweenObj.r == 255) tweenObj.r = undefined
	if(tweenObj.g == 255) tweenObj.g = undefined
	if(tweenObj.b == 255) tweenObj.b = undefined

	if(tweenObj.tint == 1) tweenObj.tint = undefined
	if(tweenObj.alpha == 1) tweenObj.alpha = undefined
	if(tweenObj.delta_r == 0) tweenObj.delta_r = undefined
	if(tweenObj.delta_g == 0) tweenObj.delta_g = undefined
	if(tweenObj.delta_b == 0) tweenObj.delta_b = undefined
	if(tweenObj.delta_tint == 0) tweenObj.delta_tint = undefined
	if(tweenObj.delta_alpha == 0) tweenObj.delta_alpha = undefined

	var spriteId:int = pushSprite(symbolName)
	var transformId:int = pushTransform(tweenObj, tweenFlags)

	pushFrames(index, duration, spriteId, transformId)
	//trace("spriteId:", spriteId, "transformId:", transformId, symbolName, index, duration, JSON.stringify(tweenObj))
}

function addStatic(index:int, duration:int, data:XMLList){
	var symbolName:String = data.@libraryItemName

	var color:Object = getColorData(data)
	var mat:Matrix = getMatrixData(data)

	var staticObj:Object = new Object()
	transformIndexesArr.push(transformArr.length)
	transformArr.push({key:"type", vel:"static"})
	transformArr.push({key:"tx", vel:mat.tx})
	transformArr.push({key:"ty", vel:mat.ty})
	transformArr.push({key:"scaleX", vel:Math.sqrt(mat.a * mat.a + mat.b * mat.b)})
	transformArr.push({key:"scaleY", vel:Math.sqrt(mat.c * mat.c + mat.d * mat.d)})
	transformArr.push({key:"skewX", vel:Math.atan2(-mat.c, mat.d)})
	transformArr.push({key:"skewY", vel:Math.atan2(mat.b, mat.a)})
	transformArr.push({key:"r", vel:color.r})
	transformArr.push({key:"g", vel:color.g})
	transformArr.push({key:"b", vel:color.b})
	transformArr.push({key:"tint", vel:color.tint})
	transformArr.push({key:"alpha", vel:color.alpha})


	var offsetPoint:Point = new Point(0, 0)
	if(data.transformationPoint.Point.@x)offsetPoint.x = data.transformationPoint.Point.@x
	if(data.transformationPoint.Point.@y)offsetPoint.y = data.transformationPoint.Point.@y

	staticObj.type = "static"
	staticObj.tx = mat.tx
	staticObj.ty = mat.ty
	staticObj.scaleX = Math.sqrt(mat.a * mat.a + mat.b * mat.b)
	staticObj.scaleY = Math.sqrt(mat.c * mat.c + mat.d * mat.d)
	staticObj.skewX = Math.atan2(-mat.c, mat.d)
	staticObj.skewY = Math.atan2(mat.b, mat.a)
	staticObj.r = color.r
	staticObj.g = color.g
	staticObj.b = color.b
	staticObj.tint = color.tint
	staticObj.alpha = color.alpha

	var spriteId:int = pushSprite(symbolName)
	var transformId:int = pushTransform(staticObj, staticFlags)

	pushFrames(index, duration, spriteId, transformId)
	//trace("spriteId:", spriteId, "transformId:", transformId, symbolName, index, duration, JSON.stringify(matObj))
}




function pushFrames(index:int, duration:int, spriteId:int, transformId:int){
	for(var i:uint = index; i<index+duration; i++){
		if(framesArr[i] == undefined)framesArr[i] = new Array()
		framesArr[i].unshift([spriteId, transformId])
	}
}

function pushTransform(obj:Object, flags:Array):int{
	var index:int = -1
	for(var i:uint = 0; i<transformArr_old.length; i++){
		if(checkSameObj(transformArr_old[i], obj, flags)){index = i}
	}
	if(index == -1){
		transformArr_old.push(obj)
		index = transformArr_old.length - 1
	}
	return index
}


function checkSameObj(obj1, obj2, flags:Array):Boolean{
	var same:Boolean = true
	for(var i:uint = 0; i<flags.length; i++){
		if(obj1[flags[i]] != obj2[flags[i]])same = false
	}
	return same
}

function pushSprite(str:String):int{
	var index:int = -1
	for(var i:uint = 0; i<spritesArr.length; i++){
		if(spritesArr[i] == str){index = i}
	}

	if(index == -1){
		spritesArr.push(str)
		index = spritesArr.length - 1
	}
	return index
}




function getColorData(data:XMLList):Object{
	var symbolInstance:XMLList = data

	var obj:Object = new Object()
	obj.r = 255
	obj.g = 255
	obj.b = 255
	obj.tint = 1
	obj.alpha = 1

	if(symbolInstance.color != undefined){
		if(symbolInstance.color.Color.@tintColor != undefined){
			var c:int = uint("0x" + symbolInstance.color.Color.@tintColor.substr(1));
			obj.r = ( c >> 16 ) & 0xFF
			obj.g = (c >> 8) & 0xFF
			obj.b = c & 0xFF
		}

		if(symbolInstance.color.Color.@tintMultiplier != undefined)obj.tint = Number(symbolInstance.color.Color.@tintMultiplier)
		if(symbolInstance.color.Color.@alphaMultiplier != undefined)obj.alpha = Number(symbolInstance.color.Color.@alphaMultiplier)
	}
	return obj
}






function getMatrixData(data:XMLList):Matrix{
	var symbolInstance:XMLList = data
	var mat:Matrix = new Matrix()
	if(symbolInstance.matrix != undefined){
		if(symbolInstance.matrix.Matrix.@a != undefined)mat.a = symbolInstance.matrix.Matrix.@a
		if(symbolInstance.matrix.Matrix.@b != undefined)mat.b = symbolInstance.matrix.Matrix.@b
		if(symbolInstance.matrix.Matrix.@c != undefined)mat.c = symbolInstance.matrix.Matrix.@c
		if(symbolInstance.matrix.Matrix.@d != undefined)mat.d = symbolInstance.matrix.Matrix.@d
		if(symbolInstance.matrix.Matrix.@tx != undefined)mat.tx = symbolInstance.matrix.Matrix.@tx
		if(symbolInstance.matrix.Matrix.@ty != undefined)mat.ty = symbolInstance.matrix.Matrix.@ty
	}
	return mat
}


function shortestAngle(start:Number, end:Number):Number{
	var dif:Number = end - start
	return Math.atan2(Math.sin(dif), Math.cos(dif))
}