import cryflash.CryObjects.Buttons.CryActionButton;
import caurina.transitions.*
import cryflash.CryRegistry;
import cryflash.Delegates;
/**
 * ...
 * @author RuneRask
 */
class cryflash.Examples.menuBackButton extends CryActionButton
{
	private var anim:MovieClip;
	private var spFormat:TextFormat;
	/**
	 * menuBackButton is a example extension of the CryActionButton demonstrating how to use it and make your own buttons.
	 * @param	id			STRING		id of the Object (must be unique).
	 * @param	caption		STRING		caption of the Object.
	 * @param	column		ARRAY		Column Array to place this object in.
	 * @param	guide		MOVIECLIP	MovieClip guide / helper for placement.
	 */
	public function menuBackButton(id:String, caption:String, tooltip:String) 
	{
		super		(id, cryflash.Definitions.BackButton, CryRegistry.CryStaticElements);
		addCaption	(cryflash.Definitions.CaptionField, caption);
		addTooltip	(cryflash.CryRegistry.CryToolTip, tooltip);
		addHitbox	(cryflash.Definitions.Hitbox);
		placeObject	(cryflash.CryRegistry.backObjects, CryRegistry.BackGuide);
		anim 		= _CHILD["anim1"];
		
		createHandlers();
		
		spFormat = new TextFormat();
		spFormat.letterSpacing = 5;

		_CHILD.onEnterFrame = Delegates.create(this, onEnter);
	}
	public function onRollOver()
	{
		super.onRollOver();
		//trace("Hover!!!");
		//trace(anim._alpha);
		captionTxt.textColor = 0x00A1DE;
		//Tweener.addTween(anim, { _alpha:100, time:1 } );
		captionTxt.setNewTextFormat(spFormat);
	}
	public function onRollOut()
	{
		super.onRollOut();
		//trace(anim._alpha);
		captionTxt.textColor = 0xFFFFFF;
		//Tweener.addTween(anim, { _alpha:0, time:1 } );
		captionTxt.setNewTextFormat(spFormat);
	}
	private function onEnter():Void
	{
		captionTxt.setNewTextFormat(spFormat);
		captionTxt.text = captionTxt.text;
		delete _CHILD.onEnterFrame;
	}
}