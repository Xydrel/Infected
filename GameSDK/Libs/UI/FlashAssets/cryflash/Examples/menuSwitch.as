import cryflash.CryObjects.Buttons.CrySwitch;
import cryflash.Definitions;
import cryflash.CryRegistry;
import caurina.transitions.*
/**
 * ...
 * MenuSwitch
 * Edited 	on 		12-06-2013. By Rune Rask
 */
class cryflash.Examples.menuSwitch extends cryflash.CryObjects.Buttons.CrySwitch
{
	private var AnimObj1		:MovieClip; // Object to Animate on RollOver/RollOut.
	private var AnimObj2		:MovieClip; // Object to Animate on RollOver/RollOut.
	private var AnimObj3		:MovieClip; // Object to Animate on RollOver/RollOut.
	
	/**
	 * menuSwitch is a example extension of the CrySwitch demonstrating how to use it and make your own buttons.
	 * @param	id			STRING		id of the Object (must be unique).
	 * @param	caption		STRING		caption of the Object.
	 * @param	tooltip		STRING		tooltip of the Object.
	 * @param	column		ARRAY		Column Array to place this object in.
	 * @param	guide		MOVIECLIP	MovieClip guide / helper for placement.
	 */
	public function menuSwitch(id:String, caption:String, tooltip:String, Column:Array, Guide:MovieClip ) 
	{
		super				(id, cryflash.Definitions.Switch, cryflash.CryRegistry.CryButtonHolder);
		AnimObj1			= _CHILD["Line1"];					 // These objects are children of our reference object cryflash.Definitions.SimpleButton, and so we can specify that here.
		AnimObj2			= _CHILD["Line2"];					 // If you design your own objects and/or use TimeLine Animation you need to specify that here, or use the start/stop
		AnimObj3			= _CHILD["PullOut"];				 // In the RollOver / RollOut.
		
		addHitbox			(Definitions.Hitbox);
		addCaption			(Definitions.CaptionField, caption);
		addTooltip			(CryRegistry.CryToolTip, tooltip);
		defineSwitchElements(Definitions.LeftArrow, Definitions.RightArrow, Definitions.SwitchField);
		
		placeObject			(Column, Guide);
		createHandlers		();
		
		ISMANIP = true;
		
	}
	/**
	 *  onRollOver - Called when mouse rolls over the hitbox.
	 */
	private function onRollOver():Void 
	{
		super.onRollOver		();//Call the basic onRollOver.
		Tweener.addTween		(RightArrow, 	{ _alpha:100, 	time:0.5 } );
		Tweener.addTween		(LeftArrow, 	{ _alpha:100, 	time:0.5 } );
		SwitchValue.textColor 	= 0x00A1DE;
		captionTxt.textColor 	= 0x00A1DE;
	}
	/**
	 *  onRollOut - Called when mouse rolls out of the hitbox.
	 */
	private function onRollOut():Void 
	{
		
		super.onRollOut			();// Call the basic onRollOut.
		Tweener.addTween		(RightArrow, 	{ _alpha:0, 	time:0.5 } );
		Tweener.addTween		(LeftArrow, 	{ _alpha:0, 	time:0.5 } );
		SwitchValue.textColor 	= 0xFFFFFF;
		captionTxt.textColor 	= 0xFFFFFF;
	}
}