import cryflash.Delegates;
import cryflash.Events.CryEvent;
/**
 * ...
 * Edited 	on 		12-06-2013. By Rune Rask
 */
class cryflash.CryObjects.Buttons.CrySlider extends cryflash.CryObjects.Buttons.CryButton
{
	
	//{ REGION : Standard Library Objects:
	/**
	* 
	*/
	private var LeftArrow	:MovieClip;
	private var RightArrow	:MovieClip;
	
	
	public var PercentBar	:MovieClip;
	public var PercentHit	:MovieClip;	
	public var SliderValue	:TextField;
	//}
	
	//{ REGION : Slider Interaction Variables:
	/**
	* 
	*/
	private var sliderPerc	:Number;
	private var min			:Number;
	private var max			:Number;
	private var isDefined	:Boolean;

	public 	var actualValue	:Number;
	//}
	
	/**
	 * CrySlider - Creates a Simple BareBones Slider.
	 * 
	 * @param	$id 	- ID of the Slider (Must be a Unique string).<br>
	 * @param	$min	- Minimum value of the slider.<br>
	 * @param	$max	- Maximum value of the Slider.<br>
	 * @param	$libobj - Library Object Reference to use for this Object.<br>
	 * @param	$parent - Parent MovieClip of this Object.<br>
	 */
	public function CrySlider($id:String, $min:Number, $max:Number, $libobj:String, $parent:MovieClip) 
	{
		super		($id, $libobj, $parent);
		setIsInstant(false);
		min 		= $min;
		max			= $max;
	}
	
	//{ REGION : Slider Interaction:
	
	//{ REGION : Public interaction:
	/**
	 * 	Select - used by Focus Navigation system.
	 */
	public function select():Void 
	{
		onRollOver();
	}
	/**
	 * ActLeft - triggers onLeft() - used by Focus Navigation system.
	 * @param	sender (Focus Nav system Reference).
	 */
	public function actLeft(sender:Object):Void 
	{
		super.actLeft(sender);
		
		onLeft();		
	}
	/**
	 * ActRight - triggers onRight() - used by Focus Navigation system.
	 * @param	sender
	 */
	public function actRight(sender:Object):Void
	{
		super.actRight(sender);
		onRight();
	}
	/**
	 * ActDown - triggers a onDown event on Focus Navigation system.
	 * @param	sender
	 */
	public function actDown(sender:Object):Void
	{
		super.actDown(sender);
		ACTIVE = false;
		sender.Navigate("down");
	}
	/**
	 * ActUp - triggers a onUp even on Focus Navigation system.
	 * @param	sender
	 */
	public function actUp(sender:Object):Void
	{
		super.actUp(sender);
		ACTIVE = false;
		sender.Navigate("up");
	}
	public function actAct(sender:Object):Void
	{
		onRight();
	}
	/**
	 * Sets the value of the slider from external data:
	 * @param	$value
	 */
	public function setValue($value):Void
	{
		updateSlider(Number($value));
	}
	/**
	 * Get the current value of the slider:
	 * @return
	 */
	public function getValue():String
	{
		return String(actualValue);
	}
	//}
	
	//{ REGION : Slider overwrites for moving left/ right 
	/**
	* Does a onLeft action.
	*/
	private function onLeft():Void
	{
		updateSlider(actualValue -= (max / 20));
	}
	/**
	* Does a onRight action.
	*/
	private function onRight():Void
	{
		updateSlider(actualValue += (max / 20));
	}
	//}
	/**
	* is triggered when the user clicks anywhere on the slider hitbox (if it's defined).
	* and updates the slider.
	*/
	private function onBarRelease():Void 
	{
		if (isDefined)
		{
			var mouseHit			:Number;
			var hitPercent			:Number;
			mouseHit 				= PercentHit._width - PercentHit._xmouse;
			hitPercent 				= 100 - (Math.round((mouseHit / PercentHit._width) * 100));
			var dealtNumber:Number 	= max * (hitPercent / 100);
			updateSlider(dealtNumber);
		}
	}
	/**
	*  Updates the slider with the given value (internal) use set value to update externally
	* @param	$value Value to send to the slider.
	*/
	private function updateSlider($value:Number):Void
	{
		var tempVal = $value;
		if (tempVal <= 0)
		{
			tempVal = min;
		}
		if (tempVal > max)
		{
			tempVal = max;
		}
		actualValue 				= tempVal;
		sliderPerc 					= (tempVal / max) * 100;
		
		if (isDefined)
		{
			PercentBar._xscale 		= (Math.round(sliderPerc)); 
			var roundedValue		= int(actualValue * 100) / 100;
			
			//trace("Actual Value: " + actualValue + "Rounded Value: " + roundedValue);
			
			SliderValue.text 		= String(roundedValue);
		}		
		dispatchEvent(new CryEvent(CryEvent.CHANGE, this));
	}	
	//}
	
	//{ REGION : Define Sliders (Public functions #2):
	/**
	 * Used to define the slider object. Per default this system uses a set of "standard" objects. feel free to add/remove in your own class.
	 * All these items are designed to be a children of the main object (_CHILD or as defined by the libObj in the contructor.)
	 * @param	leftArrow 		- Name of a "leftArrow" movieclip to be used to update slider to the left.
	 * @param	rightArrow 		- Name of a "RightArrow" movieclip to be used to update slider to the right.
	 * @param	sliderValue 	- Name of a "SliderValue" textfield to represent the sliders current value in numbers.
	 * @param	sliderBar 		- Name of a "SliderBar" slider movieclip to represent it's current value.
	 * @param	sliderHitbox 	- Name of a "SliderHitbox" movieclip to be used to handle general clicks on the slider.
	 */
	public function addSliderObjectReferences(leftArrow:String, rightArrow:String, sliderValue:String, sliderBar:String, sliderHitbox:String):Void 
	{
		LeftArrow 	= _CHILD[leftArrow];
		RightArrow 	= _CHILD[rightArrow];
		PercentBar 	= _CHILD[sliderBar];
		PercentHit	= _CHILD[sliderHitbox];
		SliderValue = _CHILD[sliderValue];
		
		isDefined 	= true;
	}
	/**
	 * Creates handlers for the object.
	 */
	private function createHandlers():Void 
	{
		super.createHandlers();
		if (isDefined)
		{
			PercentHit.onRelease 	= cryflash.Delegates.create(this, onBarRelease);
			LeftArrow.onRelease 	= cryflash.Delegates.create(this, onLeft);
			RightArrow.onRelease 	= cryflash.Delegates.create(this, onRight);
			
			PercentHit.onRollOver 	= cryflash.Delegates.create(this, onRollOver);
			LeftArrow.onRollOver 	= cryflash.Delegates.create(this, onRollOver);
			RightArrow.onRollOver 	= cryflash.Delegates.create(this, onRollOver);
			PercentHit.onRollOut 	= cryflash.Delegates.create(this, onRollOut);
			LeftArrow.onRollOut 	= cryflash.Delegates.create(this, onRollOut);
			RightArrow.onRollOut 	= cryflash.Delegates.create(this, onRollOut);
		}
		
	}
	public function suspendHandlers():Void
	{
		super.suspendHandlers();
		RightArrow.enabled 	= false;
		LeftArrow.enabled 	= false;
		PercentHit.enabled 	= false;
	}
	public function enactHandlers():Void
	{
		super.enactHandlers();
		RightArrow.enabled 	= true;
		LeftArrow.enabled 	= true;
		PercentHit.enabled 	= true;
	}	
	//}
}