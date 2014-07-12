/**
 * User: MerlinDS
 * Date: 17.03.14
 * Time: 22:44
 */
package com.merlinds.debug {
	public function warning(instance:Object, method:String, ...message):void {
		DebugUtils.writeLog(instance, method, DebugUtils.WARNING_LOG, message);
	}
}
