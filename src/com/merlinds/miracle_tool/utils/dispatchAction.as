/**
 * User: MerlinDS
 * Date: 12.07.2014
 * Time: 22:41
 */
package com.merlinds.miracle_tool.utils {
	import com.merlinds.debug.error;
	import com.merlinds.debug.warning;
	import com.merlinds.miracle_tool.models.vo.ActionVO;

	import org.robotlegs.base.ContextEvent;

	public function dispatchAction(vo:ActionVO, dispatchMethod:Function, body:Object = null):void {
		if(vo == null || !(dispatchMethod is Function)){
			warning(dispatchAction, "dispatchAction", "For action dispatching " +
					"need action value object and dispatch method");
		}else{
			try{
				var eventClass:Class = vo.event;
				var event:ContextEvent = new eventClass(vo.type, body);
				dispatchMethod.apply(null, [event]);
			}catch (err:Error){
				error(dispatchAction, "dispatchAction", err);
			}
		}
	}
}
