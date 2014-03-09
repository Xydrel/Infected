/**
 * ...
 * @author RuneRask
 * 
 *  CryDispatcher. Main Base Object for all CryObjects. It Simply enables our objects to send/recieve objects as events.
 *  
 * Makes use of the GFX event dispatcher over the native AS2 one. (this simply means we pass 3 params with a listener instead of 2)
 *  So the event, the scope and the callback. 
 * 			fx: myEvent = new CryEvent(CryEvent.ONCHANGE, this, onChangeMethod);
 * 				myObject.addEventListener(new CryEvent(CryEvent.ONADDED, this, onAddedEvent);
 *				
 * 				
 * 				inside myObject example:
 * 				onSomeFunction():void
 * 				{
 * 					dispatchEvent(new CryEvent(CryEvent.OnAdded, this)); Where the event is the event dispatched, and "this" is a refference to itself (the object dispatching the event).
 * 				}
 */

import gfx.events.EventDispatcher
import cryflash.Events.CryEvent
//{ REGION : Main BASE CLASS - CRYFLASH BASE:
class cryflash.Events.CryDispatcher
{
	
	public function CryDispatcher() 
	{
		EventDispatcher.initialize(this);
	}
	// Private method dispatch - throws the event type to the listener.
	private function dispatchEvent			(event:Object):Void { };
	// Public methods dealing with adding and removing a listener object:
	public function addEventListener		(event:String,scope:Object,callBack:String):Void { };
	public function removeEventListener		(event:String, scope:Object, callBack:String):Void { };
	public function removeAllEventListeners	(event:String):Void { };
	
}
//}