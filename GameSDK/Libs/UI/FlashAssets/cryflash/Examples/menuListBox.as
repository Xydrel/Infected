import cryflash.CryObjects.Lists.CryListbox;
import cryflash.CryRegistry;
import cryflash.Definitions;

/**
 * ...
 * @author RuneRask
 */
class cryflash.Examples.menuListBox extends CryListbox
{
	
	public function menuListBox(id, caption, column, guide) 
	{
		super				(id, Definitions.ListBox, CryRegistry.CryButtonHolder);		
		defineListItem		(Definitions.ListBoxItem, Definitions.CaptionField, Definitions.Hitbox);
		setMaxHeight		(6);
		defineListbox		(Definitions.UpArrow, Definitions.DownArrow);
		addTitle			(Definitions.CaptionField, caption);
		addScroller			("scroller", "scrollBar");
		
		setTooltipRef		(CryRegistry.CryToolTip);
		placeObject			(column, guide);
		
		createHandlers		();
		
	}
}