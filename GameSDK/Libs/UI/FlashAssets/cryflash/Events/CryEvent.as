/**
 * ...
 * @author RuneRask
 */
class cryflash.Events.CryEvent
{
	// GENERAL EVENTS:
	public static var ACTIVATE:String 		= "activate";
    public static var ADDED:String 			= "added";
    public static var CANCEL:String 		= "cancel";
    public static var CHANGE:String 		= "change";
    public static var CLOSE:String 			= "close";
    public static var COMPLETE:String 		= "complete";
    public static var INIT:String 			= "init";
	public static var CALLER:String			= "caller";
	public static var DELETED:String		= "deleted";
	
	// SITUATIONAL EVENTS:
	public static var ACCEPTED:String		= "accepted";
	public static var DECLINED:String		= "declined";
	
	// INTERACTIVITY EVENTS:
	public static var ON_RELEASE:String		= "on_release";
	public static var ON_ACTION:String		= "on_action";
	public static var ON_ROLLOVER:String	= "on_rollover";
	public static var ON_ROLLOUT:String		= "on_rollout";

	// Send Static Variables/
	public var type;
	public var target;
	
	/**
	 *  Constructor for CryEvents. - Works similair to Delegates, except that these are our own callbacks (onRollOver = AS2 / .CHANGE = CryEvent).
	 * @param	$type Event type to send.
	 * @param	$target Target to delegate to (still needed because as2 scope).
	 */
    public function CryEvent( $type, $target)
    {
		
		if (!$target || $target == "" || $target == undefined)
		{
			//trace("ERROR(CryEvent):Event Target must be an Object.");
		}
		type 	= $type;
		target 	= $target;
	}
    public function toString():String
    {
    	return "[Event target= " + target + " type= " + type + "]";
    }
}