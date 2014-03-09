import cryflash.CryObjects.Text.CryLabel;
import cryflash.CryRegistry;
import cryflash.Definitions;

/**
 * ...
 * @author RuneRask
 */
class cryflash.Examples.menuLabel extends CryLabel
{
	/**
	 * MenuLabel an example extension of the CryLabel demonstrating how to use it and make your own buttons.
	 * 
	 * @param	id			STRING		id of the Object (must be unique).
	 * @param	caption		STRING		caption of the Object.
	 * @param	column		ARRAY		Column Array to place this object in.
	 * @param	guide		MOVIECLIP	MovieClip guide / helper for placement.
	 */	
	public function menuLabel(id, $caption, column, guide) 
	{
		super(id, Definitions.Label, CryRegistry.CryButtonHolder);
		defineLabel(Definitions.CaptionField, "", $caption, Definitions.ScaleBox);
		placeObject(column, guide);
	}
	
	
}