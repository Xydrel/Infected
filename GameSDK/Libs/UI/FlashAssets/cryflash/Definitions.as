/**
 * ...
 * The definition file contains a string reference for all the movieClips in the source FLA file.
 * this is for easy access in our example objects, and is generally a good practice in AS2 for large/larger
 * systems.
 * 
 * If you reskin/add new visual elements, this is a good place to edit/add references.
 *  * Edited 	on 		12-06-2013. By Rune Rask
 */
class cryflash.Definitions
{
	/**
	*  cryflash.Definitions is a reference class of sorts. Used as a crude way to set up a library of usable Object References (Useable for re-skinning / decoupled editing).
	*/
	public function Definitions() 
	{}//No Constructor.
	
	
	//{ REGION : Simple Elements:
	/**
	* SimpleButton - String Reference for SimpleButton movieclip.
	*/
	public static var SimpleButton	:String 		= "SimpleButton"; 		// Used by menuButton.
	/**
	* Seperator - String Reference for Seperator movieclip.
	*/
	public static var Seperator		:String 		= "SimpleSeperator";	// Used by menuSeperator.
	/**
	* Slider - String Reference for Slider movieclip.
	*/
	public static var Slider		:String 		= "SimpleSlider";		// Used by menuSlider.
	/**
	* Switch - String Reference for Switch movieclip.
	*/
	public static var Switch		:String 		= "SimpleSwitch";		// Used by menuSwitch.
	/**
	* Dialog - String Reference for Dialog movieclip.
	*/
	public static var Dialog		:String 		= "SimpleDialog";		// Used by menuDialog.
	/**
	* Label - String Reference for Label movieclip.
	*/
	public static var Label			:String 		= "SimpleTextField";	// Used by menuLabel.
	/**
	*  Listbox- String Reference for Listbox movieclip.
	*/
	public static var ListBox		:String 		= "SimpleList";			// Used by menuListBox.
	/**
	* ListBoxItem - String Reference for ListBoxItem movieclip.
	*/
	public static var ListBoxItem	:String 		= "SimpleItem";			// Used by menuItem.
	/**
	* ChatBox - String Reference for ChatBox movieclip.
	*/
	public static var ChatBox		:String 		= "SimpleChat";			// Used by menuChatBox.
	/**
	* InputTextField - String Reference for InputTextField movieclip.
	*/
	public static var InputTextField:String 		= "SimpleInputField";	// Used by menuInputField.
	//}
	
	//{ REGION : Navigation buttons:
	/**
	* ResetButton - String Reference for ResetButton movieclip.
	*/
	public static var ResetButton	:String 		= "SimpleResetButton";	// Used by menuResetButton.
	/**
	* ApplyButton - String Reference for ApplyButton movieclip.
	*/
	public static var ApplyButton	:String 		= "SimpleApplyButton";	// Used by menuApplyButton.
	/**
	* BackButton - String Reference for BackButton movieclip.
	*/
	public static var BackButton	:String 		= "SimpleBackButton";	// Used by menuBackButton.
	//}
	
	//{ REGION : Various Elements: ( Residing inside Simple Elements )
	/**
	*  All of these are just names that are used numerous times in different elements. 
	* 	the naming convention here is not so important, but if you dont want to define 2 hitboxes
	*  for example, it is a good idea to name the hitbox on all items the same.
	*/
	
	/**
	* Hitbox - String Reference for Hitbox movieclip(Inside a Elements MovieClip).
	*/
	public static var Hitbox						= "hitbox";
	/**
	* ScaleBox - String Reference for "ScaleBox" movieclip(Inside a Elements MovieClip).
	*/
	public static var ScaleBox						= "ScaleBox";
	//Various Fields:
	/**
	* CaptionField - String Reference for CaptionField movieclip(Inside a Elements MovieClip).
	*/
	public static var CaptionField					= "CaptionText";
	/**
	* TitleField - String Reference for a Title Textfield(Inside a Elements MovieClip).
	*/
	public static var TitleField					= "TitleText";
	/**
	* InputField - String Reference for InputField Textfield(Inside a Elements MovieClip).
	*/
	public static var InputField					= "InputField";
	/**
	* SwitchField - String Reference for SwitchField Textfield(Inside a Elements MovieClip).
	*/
	public static var SwitchField					= "switchField";
	/**
	* SliderField - String Reference for SliderValue movieclip(Inside a Elements MovieClip).
	*/
	public static var SliderField					= "SliderValue";
	//Various Buttons:
	/**
	* LeftArrow - String Reference for LeftArrow movieclip(Inside a Elements MovieClip).
	*/
	public static var LeftArrow						= "LeftArrow";
	/**
	* RightArrow - String Reference for RightArrow movieclip(Inside a Elements MovieClip).
	*/
	public static var RightArrow					= "RightArrow";
	/**
	* UpArrow - String Reference for UpArrow movieclip(Inside a Elements MovieClip).
	*/
	public static var UpArrow 						= "upArrow";
	/**
	* DownArrow - String Reference for DownArrow movieclip(Inside a Elements MovieClip).
	*/
	public static var DownArrow						= "downArrow";
	/**
	* EnterButton - String Reference for EnterButton movieclip(Inside a Elements MovieClip).
	*/
	public static var EnterButton					= "enterBtn";
	
	//Various for Sliders
	/**
	* SliderBar - String Reference for SiderBar movieclip(Inside a Elements MovieClip).
	*/
	public static var SliderBar						= "BarDisplay";
	/**
	* SliderHitBox - String Reference for SliderHitBox movieclip(Inside a Elements MovieClip).
	*/
	public static var SliderHitBox					= "BarHit";
	//Various Dialog elements:
	/**
	* DiagButton1 - String Reference for Dialog Button 1 movieclip(Inside a Elements MovieClip).
	*/
	public static var diagButton1					= "btn1";
	/**
	* DiagButton2 - String Reference for Dialog Button 2 movieclip(Inside a Elements MovieClip).
	*/
	public static var diagButton2					= "btn2";
	/**
	* dBtn1Txt - String Reference for Dialog Button 1 - TextField(Inside a Elements MovieClip).
	*/
	public static var dBtn1Txt 						= "btn1Text";
	/**
	* dBtn2Txt - String Reference for Dialog Button 2 - TextField(Inside a Elements MovieClip).
	*/
	public static var dBtn2Txt 						= "btn2Text";
	/**
	* DiagMessage - String Reference for Dialog Message Textfield(Inside a Elements MovieClip).
	*/
	public static var diagMessage					= "msgText";
	//}
	
	//{ REGION : CryRegistry setup cryflash.Definitions:
	/**
	*	@see CryRegistry 
	* 	These Definitions are used only by the example SDK system. 
	* 	You should build your own system in flash or edit these values to match your own.
	* 	If some of these registry entries are undefined / null - some functions might not
	*   work in the example system.
	*/
	
	/**
	*  DefineCryReg - Simply adds references to all objects needed by the Project.
	*/
	public function defineCryReg()
	{
		cryflash.CryRegistry.leftColumn 		= _root.menu_root.LeftColumn;
		cryflash.CryRegistry.middleColumn 		= _root.menu_root.MiddleColumn;
		cryflash.CryRegistry.rightColumn 		= _root.menu_root.RightColumn;
		
		cryflash.CryRegistry.BackGuide			= _root.elements.BackGuide;
		cryflash.CryRegistry.ApplyGuide			= _root.elements.ApplyGuide;
		cryflash.CryRegistry.ResetGuide			= _root.elements.ResetGuide;
		
		cryflash.CryRegistry.CryPageName		= _root.elements.menuTitleText;
		cryflash.CryRegistry.CryToolTip			= _root.elements.tooltipText;
		cryflash.CryRegistry.CryConsoleHandler 	= _root.elements.CONSOLEHANDLER;
		
		cryflash.CryRegistry.CryDialogHolder 	= _root.dialogs;
		cryflash.CryRegistry.CryImageHolder		= _root.elements;
		cryflash.CryRegistry.CryButtonHolder	= _root.menu_root;
		cryflash.CryRegistry.CryStaticElements 	= _root.elements;
		cryflash.CryRegistry.CryParticleHolder	= _root.ParticleHolder;	
	}
	/**
	*  Clears all arrays used in the CryRegistry File.
	*  - Used when switching screens.
	*/
	public function cleanArrays():Void
	{
		//{ REGION : Initialize CryRegistry Array's:
		
		cryflash.CryRegistry.CryConsoleHandler 	= _root.elements.CONSOLEHANDLER;

		cryflash.CryRegistry.CryButtons 		= new Array();
		cryflash.CryRegistry.CryDialogs 		= new Array();
		cryflash.CryRegistry.CryListboxes		= new Array();
		cryflash.CryRegistry.CrySwitches		= new Array();
		cryflash.CryRegistry.CrySliders			= new Array();
		cryflash.CryRegistry.CryImages			= new Array();
		
		cryflash.CryRegistry.leftObjects		= new Array();
		cryflash.CryRegistry.middleObjects		= new Array();
		cryflash.CryRegistry.rightObjects		= new Array();
		
		cryflash.CryRegistry.backObjects		= new Array();
		cryflash.CryRegistry.resetObjects		= new Array();
		cryflash.CryRegistry.applyObjects		= new Array();
		cryflash.CryRegistry.CryChatBoxes		= new Array();
		cryflash.CryRegistry.CryTextFields      = new Array();
		cryflash.CryRegistry.CryItemSelects		= new Array();
		
		//}
	}
	//}
	
	
}