/**
 * User: MerlinDS
 * Date: 02.02.14
 * Time: 19:22
 */
package com.merlinds.debug {
	public function log(instance:Object, method:String, ...message):void {
		DebugUtils.writeLog(instance, method, DebugUtils.NOTE_LOG, message);
	}
}
