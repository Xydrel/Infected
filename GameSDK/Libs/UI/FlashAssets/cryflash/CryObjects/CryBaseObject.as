
/**
 * ...
 * @author RuneRask
 * 
 **/
import cryflash.baseObjects.CrySprite;
import cryflash.Delegates;
import cryflash.Events.CryDispatcher;
import cryflash.Events.CryEvent


class cryflash.CryObjects.CryBaseObject extends cryflash.CrySprite
{
	
	//{ REGION : Private Variables		:
	private var _LIBOBJ		:String; 	//Internal Pointer for which library object to use (String Based).
	private var _GLOBALLIST	:Array;		// Global List DisplayList Simulation (Deprecated).
	private var _HITBOX		:MovieClip; // Hitbox MovieClip (Define it using addHitbox if you want interactive functionality).
	private var isColumPlace:Boolean;	// Wether or not the Object is placed in the column system (Focus Navigation).
	//}
	
	//{ REGION : Public Variables		:
	public 	var SELECTABLE	:Boolean; 	// Is this object selectable?
	public  var ACTIVE		:Boolean; 	// Is the object currently active?
	public  var INSTANT		:Boolean; 	// Is the interaction for this object instant?
	public  var SCROLLER	:Boolean; 	// Is this object part of the generic scroller list?
	public 	var ISMANIP		:Boolean; 	// Is the Object manipulatable from the beginning?
	//}
	
	//{ REGION : CONSTRUCTOR 			:
	/**
	 * Constructor for CryBaseObject.<br>
	 * @param	$id 			ID of the object to be created.<br>
	 * @param	$libobj			The Library Object (MovieClip to pass)<br>
	 * @param	$parent			ParentMovieClip (should exist);<br>
	 */
	public function CryBaseObject($id:String, $libobj:String, $parent:MovieClip) 
	{		
		
		super($id, $parent);
		//{ Set Object variables:
		INSTANT 		= false;
		_LIBOBJ			= $libobj;
		SCROLLER 		= false;
		ISMANIP			= false;
		//}
		if ($libobj != undefined) // If you dont define a library item, you are gonna have a bad time.
		{
			attachLibObject(_LIBOBJ);
			//
		}	
		else
		{
			//trace("[ITEM]: " + _ID + "[]" + cryflash.CryErrors.LIBOBJ_MISSING);
		}
	}
	//}
		
	//{ REGION : Initialization Methods	:
	
	/**
	 *  Defines the "hitbox" for this object.<br>
	 * 	Is designed to a be a MovieClip child of the MovieClip used for the BaseObject.
	 * @param	mcID String name of the movieclip.
	 */
	public function addHitbox(mcID:String)
	{
		_HITBOX = _CHILD[mcID];
		createHandlers();
	}
	/**
	*  Creates handlers to fire events:<br>
	*	- By Default it creates the following events:<br>
	* 	onRollOver (Fired when the mouse enters the hitbox).<br>
	* 	onRollOut (Fired when the mouse leaves the hitbox).<br>
	* 	onRelease (Fired after a click (down and up) - could be released outside hitbox).<br>
	*/
	public function createHandlers():Void
	{		
		if (_HITBOX != undefined)
		{
			_HITBOX.onRollOver 	= Delegates.create(this, onRollOver);
			_HITBOX.onRollOut 	= Delegates.create(this, onRollOut);
			_HITBOX.onRelease	= Delegates.create(this, onRelease);
		}

	}
	public function suspendHandlers():Void
	{
		_CHILD.enabled 		= false;
		_HITBOX.enabled 	= false;
		_ROOT.enabled		= false;
	}
	public function enactHandlers():Void
	{
		_CHILD.enabled 		= true;
		_HITBOX.enabled 	= true;
		_ROOT.enabled		= true;
	}
	/**
	 * Place according to column internally. this is used to place the object in a three column system automatically.<br>
	 * - it is crucial for the focus navigation to work.<br>
	 * 
	 * @param	$column 	- Column Array to place the item in .<br>
	 * @param	$guide 		- Guide MovieClip, used to "guide" the placement of the item on the x and y axis.<br>
	 */
	private function placeObject($column:Array, $guide:MovieClip):Void
	{
		if ($column[0] == undefined)
		{
			X = $guide._x;
			Y = $guide._y;
			$column.push(this);
		}
		else
		{
			X = $guide._x;
			Y = $column[$column.length - 1].Y + $column[$column.length - 1].HEIGHT + 12;
			$column.push(this);
		}		
	}
	//}
	
	//{ REGION : Instruction Methods	:
	/**
	 * Set wether or not the item is selectable (Used by the Focus Navigation system).<br>
	 * @param	value set to true if it is selectable.
	 */
	public function setIsSelectable(value:Boolean):Void
	{
		SELECTABLE = value;
	}	
	/**
	 * Sets wether or not the item is instant (used by the Focus Navigation system).<br>
	 * @param	value set to true if it is instant.
	 */
	public function setIsInstant(value:Boolean):Void
	{
		INSTANT = value;
	}	
	/**
	 *  Internal method for selecting the item. (used by Focus Navigation system).<br>
	 */
	public function select():Void
	{
		onRollOver();
	}
	/**
	 *  Internal method for deselecting the item (used by Focus Navigation system).<br>
	 */
	public function deselect():Void
	{
		onRollOut();	
		ACTIVE = false;
	}
	//{ REGION : Fake Virtual functions, overwrite for functionality:
	/**
	 * Usually called by Focus Navigation - overwrite to add your own functionality.<br>
	 * @param	sender instance of the navigation system.
	 */
	public function actAct(sender:Object):Void
	{
		//
	}
	/**
	 * Usually called by Focus Navigation - overwrite to add your own functionality.<br>
	 * @param	sender instance of the navigation system.
	 */
	public function actLeft(sender:Object):Void
	{
		//
	}
	/**
	* Usually called by Focus Navigation - overwrite to add your own functionality.<br>
	* @param	sender instance of the navigation system.
	*/
	public function actRight(sender:Object):Void
	{
		//
	}
	/**
	* Usually called by Focus Navigation - overwrite to add your own functionality.<br>
	 * @param	sender instance of the navigation system.
	*/
	public function actDown(sender:Object):Void
	{
		//
	}
	/**
	* Usually called by Focus Navigation - overwrite to add your own functionality.<br>
	* @param	sender instance of the navigation system.
	*/
	public function actUp(sender:Object):Void
	{
		//
	}
	/**
	* Usually called by Focus Navigation - overwrite to add your own functionality.<br>
	* @param	sender instance of the navigation system.
	*/
	public function actActivate(sender:Object):Void
	{
		ACTIVE = true;
	}
	/**
	* Usually called by Focus Navigation - overwrite to add your own functionality.<br>
	* @param	sender instance of the navigation system.
	*/
	public function backAct(sender:Object):Void
	{
		dispatchEvent(new CryEvent(CryEvent.CLOSE, this));
	}
	//}
	//}

	//{ REGION : Event Dispatchers		:
	/**
	 *  Delegate for the onRollOver (overwrite to add your own internal functionality).<br>
	 */
	private function onRollOver():Void
	{
		dispatchEvent(new CryEvent(CryEvent.ON_ROLLOVER, this));
	}
	/**
	*  Delegate for the onRollOut (overwrite to add your own internal functionality).<br>
	*/
	private function onRollOut():Void
	{
		dispatchEvent(new CryEvent(CryEvent.ON_ROLLOUT, this));
	}
	/**
	*  Delegate for the onRelease (overwrite to add your own internal functionality).<br>
	*/
	private function onRelease():Void
	{
		dispatchEvent(new CryEvent(CryEvent.ON_RELEASE, this));
	}
	/**
	*  Delegate for the onAction (overwrite to add your own internal functionality).<br>
	*/
	private function onAction():Void
	{
		dispatchEvent(new CryEvent(CryEvent.ON_ACTION, this));
	}
	//}
	//{ REGION : Deprecated				:
	private function setGlobalList($globalList):Void
	{
		//Deprecated.
	}
	//}
}