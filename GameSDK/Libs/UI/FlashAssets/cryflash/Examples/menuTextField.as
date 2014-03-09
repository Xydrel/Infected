import cryflash.CryObjects.Text.CryTextField;
import cryflash.CryRegistry;
import cryflash.Definitions;

/**
 * ...
 * @author RuneRask
 */
class cryflash.Examples.menuTextField extends CryTextField
{
	/**
	 * MenuTextField is a example extension of the CryTextField demonstrating how to use it and make your own buttons.
	 * @param	id			STRING		id of the Object (must be unique).
	 * @param	caption		STRING		caption of the Object.
	 * @param	tooltip		STRING		tooltip of the Object.
	 * @param	column		ARRAY		Column Array to place this object in.
	 * @param	guide		MOVIECLIP	MovieClip guide / helper for placement.
	 */
	public function menuTextField(id:String , column:Array, guide:MovieClip, isSending:Boolean) 
	{
		super				(id, Definitions.InputTextField, CryRegistry.CryButtonHolder);
		addInputTextfield	(Definitions.InputField, null);
		addHitbox			(Definitions.Hitbox);
		setIsSending		(isSending);
		createHandlers		();
		placeObject			(column, guide);
	}
	
}