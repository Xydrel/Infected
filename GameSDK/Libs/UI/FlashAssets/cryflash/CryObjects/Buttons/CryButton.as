/**
 * ...
 * @author RuneRask
 */
import cryflash.CryObjects.CryBaseObject;
import caurina.transitions.*; 
import cryflash.*;
import cryflash.Events.CryEvent;

class cryflash.CryObjects.Buttons.CryButton extends cryflash.CryObjects.CryBaseObject
{
	//{ REGION : Private Variables:
	private var _CAPTION	:String; 	// String Object defining this object's Caption (if any).
	private var _TOOLTIP	:String;	// String defining this object's tooltip (if any).
	private var _COLUMN		:Array;		// Column to place this object. (used by focus navigation).
	
	private var _GUIDE		:MovieClip; // Guide for placing this object (according to focus navigation).
	private var tooltipTxt	:TextField;	// The textfield that should update when this button shows it's tooltip.
	private var captionTxt	:TextField; // Caption textfield Object.
	//}
	
	
	//{ REGION : Constructor:
	/**
	 * Creates a Simple BareBones Button - <br>
	 * For full usage, it should be extended, and used with all define functions used.<br>
	 * 
	 * @param	$id 	- ID of the Button (Must be a Unique string).<br>
	 * @param	$libobj - Library Object Reference to use for this Object.<br>
	 * @param	$parent - Parent MovieClip of this Object.<br>
	 */
	public function CryButton($id:String, $libObj:String, $parent:MovieClip) 
	{			
		super($id, $libObj, $parent);
		setIsInstant	(true);
		setIsSelectable	(true);
		ACTIVE 			= false;
	}
	//}
	
	//{ REGION : Standard interaction and Event Dispatchers:
	/**
	 * Overwrites the actAct method, just sends a event that the button as been acted on (using focus nav).
	 */
	public function actAct():Void
	{
		dispatchEvent(new CryEvent(CryEvent.ON_RELEASE, this));
	}
	/**
	* Simply selects the button (using focus nav).
	*/
	public function select():Void
	{
		super.select();
	}
	/**
	* Overwrites onRollOver, updates tooltip if it defined.
	*/
	public function onRollOver():Void 
	{
		super.onRollOver();
		if (tooltipTxt != undefined)
		{
			tooltipTxt.text = _TOOLTIP;
			//trace(cryflash.CryErrors.TOOLTIP_MISSING);
		}
	}
	/**
	* Overwrites onRollOut, empties tooltip if it is defined.
	*/
	public function onRollOut():Void 
	{
		super.onRollOut();		
		if (tooltipTxt != undefined)
		{
			tooltipTxt.text = "";
			//trace(cryflash.CryErrors.TOOLTIP_MISSING);
		}
	}
	//}
	
	//{ REGION : Standard Define object methods:
	/**
	 * Defines a caption for the button.
	 * @param	mcID	name of the textfield to hold the caption.
	 * @param	text	text to display in the textfield.
	 */
	public function addCaption(mcID:String, text:String):Void
	{
		captionTxt = _CHILD[mcID];
		_CAPTION   = text;
		// Update the field to show the value: 
		captionTxt.text = _CAPTION;
	}
	/**
	 * Add a tooltip textfield reference to this object.
	 * @param	mcID Name of the tooltip textfield to refference.
	 * @param 	text text to display in the tooltip field on rollover for example.
	 */
	public function addTooltip(mcID:TextField, text:String):Void 
	{
		tooltipTxt 	= mcID;
		_TOOLTIP 	= text;
	}
	//}
}