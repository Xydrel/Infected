import cryflash.CryObjects.Buttons.CryButton;
import cryflash.Events.CryEvent;
/**
 * ...
 * Edited 	on 		12-06-2013. By Rune Rask
 */
class cryflash.CryObjects.Buttons.CrySwitch extends cryflash.CryObjects.Buttons.CryButton
{
	
	//{ REGION : MovieClips and textfield holders:
	private var LeftArrow	:MovieClip;
	private var RightArrow	:MovieClip;
	public var SwitchValue	:TextField;
	//}
	
	//{ REGION : Switch Values:
	private var counter		:Number;
	private var entries		:Array;
	private var isDefined	:Boolean;
	//}
	
	public var CurrentValue;
	
	//{ REGION : Constructor:
	/**
	 * - CrySwitch - Creates a Simple BareBones Switch.<br>
	 * @param	$id 	- ID of the Switch (Must be a Unique string).<br>
	 * @param	$libobj - Library Object Reference to use for this Object.<br>
	 * @param	$parent - Parent MovieClip of this Object.<br>
	 */
	public function CrySwitch($id:String, $libobj:String, $parent:MovieClip) 
	{
		super($id, $libobj, $parent);
		INSTANT 	= false;
		isDefined 	= false;
		counter 	= 0;
		entries 	= new Array();
	}
	//}
	
	//{ REGION : Interaction methods:
	/**
	 * Does a a Select Action.
	 * @param	sender The action requester.
	 */
	public function select():Void 
	{
		onRollOver();
	}
	/**
	 * Does a a ActLeft.
	 * @param	sender The action requester.
	 */
	public function actLeft(sender:Object):Void 
	{
		//trace("Go left!");
		//super.actLeft(sender);
		onLeft();		
	}
	/**
	 * Does a a ActRight.
	 * @param	sender The action requester.
	 */
	public function actRight(sender:Object):Void
	{
		//trace("Go left!");
		//super.actRight(sender);
		onRight();		
	}
	public function actAct(sender:Object):Void
	{
		onRight();
	}
	/**
	 * Does a a ActDown.
	 * @param	sender The action requester.
	 */
	public function actDown(sender:Object):Void
	{
		super.actDown(sender);
		ACTIVE = false;
		sender.Navigate("down");
	}
	/**
	 * Does a a ActUp.
	 * @param	sender The action requester.
	 */
	public function actUp(sender:Object):Void
	{
		super.actUp(sender);
		ACTIVE = false;
		sender.Navigate("up");
	}
	/**
	 * Add's a switch option to the current switch.
	 * @param	$Caption	- Caption of the option.
	 * @param	$Value		- Value of the option ( I/O - String / or any).
	 */
	public function addSwitchOption($Caption:String, $Value):Void
	{
		//trace("- Adding Switch Option with Value :" + $Value);
		var entry:Object	= new Object();
		entry._caption	 	= $Caption;
		entry._value 		= $Value;
		entries.push(entry);
		updateSwitch();
	}
	/**
	 *  Clears the switch and all it's values.
	 */
	public function clearSwitch():Void
	{
		if (entries.length > 0)
		{
			while (entries.length > 0)
			{
				entries.splice(0, 1);
				if (SwitchValue)
				{
					SwitchValue.text = "";
				}
				
			}
		}
		else
		{
			//trace("[CrySwitch]Was trying to clear, but it was already empty");
		}
		
	}
	/**
	* Sets the value of the switch.
	*/
	public function setValue($value):Void
	{
		//trace("Called a Switch!");
		var exists:Boolean = false;
		for (var i:Number = 0; i < entries.length; i++)
		{
			if (entries[i]._value == $value)
			{
				counter = i;
				updateSwitch();
				exists = true;
				return;
				
			}
		}
		if (!exists)
		{
			//trace("[CrySwitch]Value does not exist.");
		}
	}
	/**
	* Gets the value of the switch.
	*/
	public function getValue():String
	{
		//trace("Called a Switch!");
		if (entries[counter] != undefined)
		{
			return entries[counter]._value;
		}
		else
		{
			//trace("[CrySwitch]Value does not exist.");
		}
	}
	//}
	
	//{ RETION : Internal Handlers and updaters:
	/**
	 *  Internal : Updates the switch
	 */
	private function updateSwitch():Void
	{
		if (entries[counter] != undefined)
		{
			if (isDefined)
			{
				SwitchValue.text = entries[counter]._caption;
				dispatchEvent(new CryEvent(CryEvent.CHANGE, this));
			}			
		}
		else
		{
			if (isDefined)
			{
				SwitchValue.text = "";
			}			
			//trace("[CrySwitch]Value Does not exist.");
		}
		
	}
	/**
	 *  Creates handlers for the switch.
	 */
	private function createHandlers():Void
	{
		super.createHandlers();
		_HITBOX.onRelease		= cryflash.Delegates.create(this, onRight);
		
		LeftArrow.onRelease 	= cryflash.Delegates.create(this, onLeft);
		RightArrow.onRelease 	= cryflash.Delegates.create(this, onRight);
		
		LeftArrow.onRollOver	= cryflash.Delegates.create(this, onRollOver);
		RightArrow.onRollOver	= cryflash.Delegates.create(this, onRollOver);
		
		LeftArrow.onRollOut		= cryflash.Delegates.create(this, onRollOut);
		RightArrow.onRollOut	= cryflash.Delegates.create(this, onRollOut);
	}
	public function suspendHandlers():Void
	{
		super.suspendHandlers();
		RightArrow.enabled 	= false;
		LeftArrow.enabled 	= false;
	}
	public function enactHandlers():Void
	{
		super.enactHandlers();
		RightArrow.enabled 	= true;
		LeftArrow.enabled 	= true;
	}
	/**
	 *  Handler of onLeft action.
	 */
	private function onLeft():Void
	{
		counter--;
		if (counter < 0)
		{
			counter = entries.length-1;
		}
		updateSwitch();
		CurrentValue = entries[counter]._value;
		dispatchEvent(new CryEvent(CryEvent.CHANGE, this));
	}
	/**
	 *  Handler of onRight action.
	 */ 
	private function onRight():Void
	{
		//trace("heya");
		counter++;
		if (counter > entries.length-1)
		{
			counter = 0;
		}
		updateSwitch();
		CurrentValue = entries[counter]._value;
		dispatchEvent(new CryEvent(CryEvent.CHANGE, this));
	}
	//}
	
	//{ REGION : Object definition methods:
	/**
	 * Defines the switch. - Based on a simple set/ideas of what a switch needs. Feel free to add/remove in a extension.
	 * @param	leftArrow	- The Movieclip representing a left arrow.
	 * @param	rightArrow	- The Movieclip representing a right arrow.
	 * @param	switchValue	- The Textfield representing the value of the switch.
	 */
	public function defineSwitchElements(leftArrow:String, rightArrow:String, switchValue:String):Void
	{
		LeftArrow 		= _CHILD[leftArrow];
		RightArrow 		= _CHILD[rightArrow];
		SwitchValue 	= _CHILD[switchValue];
		isDefined 		= true;
	}
	//}
}