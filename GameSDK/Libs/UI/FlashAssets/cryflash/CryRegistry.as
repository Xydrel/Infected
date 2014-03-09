/**
 * ...
 * @author RuneRask
 */
class cryflash.CryRegistry
{
	//{ REGION : CONTAINERS:
	/**
	 * CryButtonHolder - MovieClip to hold all Buttons.
	 */
	public static var CryButtonHolder	:MovieClip;
	/**
	 * CryDialogHolder - MovieClip to hold all Dialogs.
	 */
	public static var CryDialogHolder	:MovieClip;	
	/**
	 * CryImageHolder - MovieClip to hold all Images.
	 */
	public static var CryImageHolder	:MovieClip;
	/**
	 *  CryStaticElements - MovieClip to hold all static elements.
	 */
	public static var CryStaticElements	:MovieClip; 
	/**
	 *  CryParticleHolder - MovieClip to hold all particles.
	 */
	public static var CryParticleHolder	:MovieClip; 
	
	public static var CryBGPlane:MovieClip;
	//}
	
	//{ REGION : CONSOLE HANDLER:
	/**
	 * CryConsoleHandler - MovieClip holding all console related stuff.
	 */
	public static var CryConsoleHandler	:MovieClip;
	//}
	
	//{ REGION : Global Array's and Lists:
	/**
	 *  CryDialogs - Array used to hold all Dialogs.
	 */
	public static var CryDialogs		:Array;		
	/**
	 *  CryButtons - Array used to hold all Buttons.
	 */
	public static var CryButtons		:Array;		
	/**
	 *  CryImages - Array used to hold all Images.
	 */
	public static var CryImages			:Array;		
	/**
	 * CrySwitches - Array used to hold all Switches.
	 */
	public static var CrySwitches		:Array;
	/**
	 * CrySliders - Array used to hold all Sliders.
	 */
	public static var CrySliders		:Array;
	/**
	 * CryListBoxes - Array used to hold all ListBoxes.
	 */
	public static var CryListboxes		:Array;
	/**
	 * CryChatBoxes - Array used to hold all ChatBoxes.
	 */
	public static var CryChatBoxes		:Array;
	/**
	 *  CryTextFields - Array used to hold all TextFields.
	 */
	public static var CryTextFields		:Array;
	/**
	 *  CryItemSelects - Array used to hold all ItemSelects.
	 */
	public static var CryItemSelects	:Array;
	/**
	 *  LeftObjects - Array used to hold all left Objects (GENERIC).
	 */
	public static var leftObjects		:Array; 
	/**
	 *  MiddleObjects - Array used to hold all middle Objects (GENERIC).
	 */
	public static var middleObjects		:Array; 
	/**
	 * RightObjects - Array used to hold all right Objects (GENERIC).
	 */
	public static var rightObjects		:Array; 
	/**
	 * BackObjects - Array used to hold all back Objects (GENERIC).
	 */
	public static var backObjects		:Array; 
	/**
	 * ApplyObjects - Array used to hold all apply Objects (GENERIC).
	 */
	public static var applyObjects		:Array;
	/**
	 *  ResetObjects - Array used to hold all reset Objects (GENERIC).
	 */
	public static var resetObjects		:Array;
	//}

	//{ REGION : Textfield
	/**
	 *  CryToolTip - TextField for button tooltips (GLOBAL).
	 */
	public static var CryToolTip		:TextField;
	/**
	 * CryPageName - TextField to display current page name
	 */
	public static var CryPageName		:TextField;
	//}
	
	//{ REGION :  Focus View Placement Helpers:
	/**
	 *  leftColumn - Helper for items that go into left column.
	 */
	public static var leftColumn		:MovieClip;
	/**
	 *  - Helper for items that go into Middle Column.
	 */
	public static var middleColumn		:MovieClip;
	/**
	 *  - Helper for items that go into Right Column
	 */
	public static var rightColumn		:MovieClip;
	/**
	 *  - Helper for items that go into Apply Area.
	 */
	public static var ApplyGuide		:MovieClip;
	/**
	 *  - Helper for items that go into Reset Area.
	 */
	public static var ResetGuide		:MovieClip;
	/**
	 *  - Helper for items that go into Back Area.
	 */
	public static var BackGuide			:MovieClip;
	/**
	 *  - Helper for items that go into Action Area.
	 */
	public static var ActionGuide		:MovieClip;
	//}
	public static var cry_system		:String;
	
}