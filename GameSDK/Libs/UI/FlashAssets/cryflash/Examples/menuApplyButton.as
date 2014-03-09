import cryflash.CryObjects.Buttons.CryActionButton;
import caurina.transitions.*
import cryflash.CryRegistry;
import cryflash.Definitions;
import cryflash.Delegates;
/**
 * ...
 * @author RuneRask
 */
class cryflash.Examples.menuApplyButton extends CryActionButton
{
	private var anim:MovieClip;
	
	
	
	private var spFormat:TextFormat;
	/**
	 * menuApplyButton is a example extension of the CryActionButton demonstrating how to use it and make your own buttons.
	 * @param	id			STRING		id of the Object (must be unique).
	 * @param	caption		STRING		caption of the Object.
	 * @param	column		ARRAY		Column Array to place this object in.
	 * @param	guide		MOVIECLIP	MovieClip guide / helper for placement.
	 */
	public function menuApplyButton(id:String, caption:String, tooltip:String) 
	{
		super		(id, cryflash.Definitions.ApplyButton, cryflash.CryRegistry.CryStaticElements);
		addCaption	(Definitions.CaptionField, caption);
		addTooltip	(CryRegistry.CryToolTip, tooltip);
		addHitbox	(Definitions.Hitbox);
		placeObject	(cryflash.CryRegistry.applyObjects, cryflash.CryRegistry.ApplyGuide);
		anim 		= _CHILD["anim1"];
		createHandlers();		
		
		spFormat = new TextFormat();
		spFormat.letterSpacing = 4;
		
		_CHILD.onEnterFrame = Delegates.create(this, onEnter);
	}
	public function onRollOver()
	{
		super.onRollOver();
		//trace("Hover!!!");
		Tweener.addTween(anim, { _alpha:100, time:1 } );
		//trace(anim._alpha);
	}
	public function onRollOut()
	{
		super.onRollOut();
		//trace(anim._alpha);
		Tweener.addTween(anim, { _alpha:0, time:1 } );
	}
	private function onEnter():Void
	{
		captionTxt.setNewTextFormat(spFormat);
		captionTxt.text = captionTxt.text;
		delete _CHILD.onEnterFrame;
		
	}
}