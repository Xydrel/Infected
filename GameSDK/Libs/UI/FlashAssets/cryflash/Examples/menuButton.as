import cryflash.CryObjects.Buttons.CryButton;
import caurina.transitions.*;
import cryflash.CryRegistry;
import cryflash.utils.ColorFader;
import cryflash.utils.helpers;
import cryflash.Delegates;

/**
 * ...
 * @author RuneRask
 * 
 * - Simple example button used for the CryEngine SDK menu system:
 */

 
class cryflash.Examples.menuButton extends cryflash.CryObjects.Buttons.CryButton
{
	private var AnimObj1	:MovieClip; // Object to Animate on RollOver/RollOut.
	private var AnimObj2	:MovieClip; // Object to Animate on RollOver/RollOut.
	private var AnimObj3	:MovieClip; // Object to Animate on RollOver/RollOut.
	private var txtColor;

	private var RED			:Number;
	private var GREEN		:Number;
	private var BLUE		:Number;
	
	private var m_textColor	:ColorFader;
	
	private var $id			:Number; 
	private var $interval	:Number = 33; 
	private var $colorFrom	:Object; // information about starting color
	private var $colorTo	:Object; // information about the color fading to
	private var $remains	:Number; 
	private var $total		:Number; 

	/**
	 * menuButton is a example extension of the CryButton demonstrating how to use it and make your own buttons.
	 * @param	id			STRING		id of the Object (must be unique).
	 * @param	caption		STRING		caption of the Object.
	 * @param	column		ARRAY		Column Array to place this object in.
	 * @param	guide		MOVIECLIP	MovieClip guide / helper for placement.
	 */
	public function menuButton(id:String, caption:String, tooltip:String, column:Array, guide:MovieClip ) 
	{
		super			(id, cryflash.Definitions.SimpleButton, cryflash.CryRegistry.CryButtonHolder);// Here we use the cryflash.Definitions file and CryRegistry to set up the buttn
																					// Thise reference could be any graphic/movieClip/external file.
																					// As long as you set it up as a single MovieClip reference.
																					// Using either Flash Pro or image editing software.
		
		//AnimObj1		= _CHILD["Line1"];					 // These objects are children of our reference object cryflash.Definitions.SimpleButton, and so we can specify that here.
		//AnimObj2		= _CHILD["Line2"];					 // If you design your own objects and/or use TimeLine Animation you need to specify that here, or use the start/stop
		//AnimObj3		= _CHILD["PullOut"];				 // In the RollOver / RollOut.
		//txtColor		= helpers.RGBtoHEX(204, 204, 204);
		//RED 			= 204;
		//GREEN 			= 204;
		//BLUE 			= 204;
		//m_textColor		= new ColorFader(_CHILD);
		//m_textColor.setRGB(0xCCCCCC);		
		
		addHitbox		(cryflash.Definitions.Hitbox);				 	// Add a reference to the hit=box for this object.
		addTooltip		(cryflash.CryRegistry.CryToolTip, tooltip);   	// Add a reference to our global tooltip textfield and specify what to display there on rollOver.
		addCaption		(cryflash.Definitions.CaptionField, caption); 	// Here we define the caption for the button, using a generic rerference to the textfield, and populate it
																		// With the caption argument given in the constructor.
		placeObject		(column, guide);								// Here we tell the button to be placed in the column specified in the constructor using the guide provided there aswell.
		
		
		createHandlers	();												// Finally we create the handlers for this object.
		_CHILD.onEnterFrame = Delegates.create(this, onColor);
	}
	/**
	 *  onRollOver - Called when mouse rolls over the hitbox.
	 */
	private function onRollOver():Void 
	{
		super.onRollOver();//Call the basic onRollOver.
		//Tweener.addTween(AnimObj1, 	{_y:0,_alpha:100, time:1} );0xCCCCCC
		//Tweener.addTween(AnimObj2, 	{_y:50,_alpha:100, time:1} );
		//m_textColor.fadeTo(0x0095D6, 100, 10);
		captionTxt.textColor = 0x00aef0;
		//Tweener.addTween(this, {RGB:[0, 149, 214], time:1} );
	}
	/**
	 *  onRollOut - Called when mouse rolls out of the hitbox.
	 */
	private function onRollOut():Void 
	{
		super.onRollOut();// Call the basic onRollOut.
		//Tweener.addTween(AnimObj1, 	{_y:10,_alpha:0, time:1} );
		//Tweener.addTween(AnimObj2, 	{_y:40,_alpha:0, time:1} );
		//m_textColor.fadeTo(0xCCCCCC, 100, 10);		
		//Tweener.addTween(this, {RGB:[204, 204, 204], time:1} );		
		captionTxt.textColor = 0xCCCCCC;

	}
	public function onColor():Void
	{
		//txtColor = helpers.RGBtoHEX(RED, GREEN, BLUE);
		//trace("HEX VALUE: " + txtColor);
		//trace("ACTUAL COLOR: " + "RED:" + RED + "GREEN:" + GREEN + "BLUE:" + BLUE);
		//trace("RGB array TWEEN:" + RGB);
		//captionTxt.textColor = txtColor;
	}
	
}