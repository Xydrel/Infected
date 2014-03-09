import cryflash.CryObjects.Various.CrySeparator;

/**
 * ...
 * @author RuneRask
 */
class cryflash.Examples.menuSeperator extends cryflash.CryObjects.Various.CrySeparator
{
	/**
	 * MenuSeperator an example extension of the CrySeperator demonstrating how to use it and make your own buttons.
	 * 
	 * @param	id			STRING		id of the Object (must be unique).
	 * @param	caption		STRING		caption of the Object.
	 * @param	tooltip		STRING		tooltip of the Object.
	 * @param	column		ARRAY		Column Array to place this object in.
	 * @param	guide		MOVIECLIP	MovieClip guide / helper for placement.
	 */
	public function menuSeperator(id:String, caption:String, column:Array, guide:MovieClip) 
	{
		super(id, cryflash.Definitions.Seperator, cryflash.CryRegistry.CryButtonHolder);
		addCaption(cryflash.Definitions.CaptionField, caption);
		placeObject(column, guide);
	}
	
}