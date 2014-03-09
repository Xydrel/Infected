import cryflash.CryObjects.Buttons.CrySlider;
import cryflash.CryRegistry;
import cryflash.Definitions;
import caurina.transitions.*
/**
 * ...
 * - A Simple example slider. Used for the CryEngine SDK menu system:
 *    Edited 	on 		12-06-2013. By Rune Rask
 */
class cryflash.Examples.menuSlider extends cryflash.CryObjects.Buttons.CrySlider
{
	// Custom objects for animation onRollOver and onRollOut.
	private var AnimObj1	:MovieClip; 
	private var AnimObj2	:MovieClip; 
	private var AnimObj3	:MovieClip;
	
	
	private var myColor1	:Color;
	private var myColor2	:Color;
	
	public var ISMANIP:Boolean = true;
	/**
	 * menuSlider is a example extension of the CrySlider demonstrating how to use it and make your own buttons.
	 * @param	id			STRING		id of the Object (must be unique).
	 * @param	caption		STRING		caption of the Object.
	 * @param	tooltip		STRING		tooltip of the Object.
	 * @param	column		ARRAY		Column Array to place this object in.
	 * @param	guide		MOVIECLIP	MovieClip guide / helper for placement.
	 */
	public function menuSlider(id:String, $min, $max, caption:String, tooltip:String, column:Array, guide:MovieClip) 
	{
		super(id, $min, $max, cryflash.Definitions.Slider, cryflash.CryRegistry.CryButtonHolder);
		//Define the Slider:
		AnimObj1		= _CHILD["Line1"];
		AnimObj2		= _CHILD["Line2"];
		AnimObj3		= _CHILD["PullOut"];
		
		myColor1		= new Color(_CHILD["BarDisplay"]);
		myColor2		= new Color(_CHILD["BarHit"]);
		
		addSliderObjectReferences(Definitions.LeftArrow, Definitions.RightArrow, Definitions.SliderField, Definitions.SliderBar, Definitions.SliderHitBox);
		addHitbox	(Definitions.Hitbox);
		addCaption	(Definitions.CaptionField, caption);
		addTooltip	(CryRegistry.CryToolTip, tooltip);
		isDefined 	= true;
		placeObject	(column, guide);
		createHandlers();
		
		ISMANIP = true;
	}
	/**
	 *  onRollOver - Called when mouse rolls over the hitbox.
	 */
	private function onRollOver():Void 
	{
		super.onRollOver();
		Tweener.addTween(RightArrow, 	{ _alpha:100, time:0.5  } );
		Tweener.addTween(LeftArrow, 	{ _alpha:100, time:0.5 } );
		SliderValue.textColor 			= 0x00A1DE;
		captionTxt.textColor			= 0x00A1DE;
		myColor1.setRGB					(0x00A1DE);
		myColor2.setRGB					(0x00A1DE);
	}
	/**
	 *  onRollOut - Called when mouse rolls out of the hitbox.
	 */
	private function onRollOut():Void 
	{
		super.onRollOut();		
		Tweener.addTween(RightArrow,	{ _alpha:0, time:0.5  } );
		Tweener.addTween(LeftArrow, 	{ _alpha:0, time:0.5 } );
		SliderValue.textColor 			= 0xFFFFFF;
		captionTxt.textColor 			= 0xFFFFFF;
		myColor1.setRGB					(0xFFFFFF);
		myColor2.setRGB					(0xFFFFFF);
	}
	
}