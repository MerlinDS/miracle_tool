/**
 * User: MerlinDS
 * Date: 31.03.2014
 * Time: 19:34
 */
package com.merlinds.unitls.structures {
	public class QueueFIFO {

		private var _head:Item;

		public function QueueFIFO() {
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function push(...args):void{
			if(_head == null){
				_head = new Item(args.shift());
			}
			var item:Item = _head;
			while(args.length > 0) {
				//add other items to queue
				while(item.next != null){
					item = item.next;
				}
				item.next = new Item(args.shift());
			}
		}

		public function pop():*{
			if(_head == null)return null;
			var value:* = _head.value;
			_head = _head.next;
			return value;
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get first():* {
			return _head != null ? _head.value : null;
		}

		public function get empty():Boolean{
			return _head == null;
		}
		//} endregion GETTERS/SETTERS ==================================================
	}
}
/**
 * Class helper
 */
class Item{
	/**
	 * Link to next item in queue
	 */
	public var next:Item;
	/**
	 * Value of the current item
	 */
	public var value:*;

	public function Item(value:*) {
		this.value = value;
	}
}