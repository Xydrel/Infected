/**
 * 	<class> 	Main Class Document </class>
 * 	@class 		Main Class Document.
 *  			MAIN ActionScript Document File
 *  
 * 	Version 1.2.8
 *  Added 	on 		14-02-2013. By Rune Rask
 *  Edited 	on 		23-05-2013. By Rune Rask
 * 
 * Document file is used as a means of communication with FlowGraph.
 * All intented functions should be part of the UIElements/MainMenu.xml
 * 
 * - target only functions in theis Document. Dont Add references to stuff
 *   inside the FLA or MovieClips, as it's very easy to create a very strongly coupled system without meaning to in AS2.
 * 	
 * 
 * 	 	This "project" should highlight how to use flash and scaleform using mostly code.
 * 	 	However, graphic symbols are still needed to create anything with this version of scaleform.
 * 	 	It can be a image from HD or a symbol in the FLA that runs the flash. Ultimatly it's better
 * 		on performance to use mostly flash stuff, as loading and unloading images is quite bothersome in AS2
 * 		couple that with the fact that there is no bitmap data class or 
 * 
*/
//{ REGION : IMPORTS:
import cryflash.Core.CryConsoleDisplay;
import cryflash.Core.CryConsoleNav;
import cryflash.*;
import cryflash.CryObjects.Buttons.CryButton;
import cryflash.CryObjects.CryBaseObject;
import cryflash.Events.CryEvent;
import cryflash.CryObjects.Text.CryTextField;
import cryflash.CryObjects.Lists.CryListbox;
import cryflash.CryObjects.Text.CryLabel;
import cryflash.CryObjects.Various.CryImage;
import cryflash.CryObjects.Various.CryItemSelect;
import cryflash.CryObjects.CryDialog;
import cryflash.Examples.menuDialog;
import cryflash.Examples.menuImage;
import cryflash.Examples.menuItemSelect;
import cryflash.Examples.menuListBox;
import cryflash.utils.ParticleEmitter;
import cryflash.CryObjects.Text.CryChatBox;
import cryflash.Examples.menuApplyButton;
import cryflash.Examples.menuBackButton;
import cryflash.Examples.menuButton;
import cryflash.Examples.menuLabel;
import cryflash.Examples.menuResetButton;
import cryflash.Examples.menuSeperator;
import cryflash.Examples.menuSlider;
import cryflash.Examples.menuSwitch;
import caurina.transitions.*; 
import caurina.transitions.properties.DisplayShortcuts;
import cryflash.Examples.menuTextField;
import flash.filters.GlowFilter;
import src.CryFlash.baseObjects.BaseObject;
//}

							
/**
 *  - cryFlash.Main class 		- used as a inline class to call functions from flowgraph.
 */
class cryflash.Main 
{
	private var oldPageNameY:Number;
	private var LastEditable:CryBaseObject;
	
	//{ REGION : SYSTEM VARIABLES AND OBJECTS:------------------------------------------ DONE!
	/**
	 * 
	 *  Console Display Object - See CryConsoleDisplay.
	 *  @see  	CryConsoleDisplay
	 */
	private var consoleDisplay	:CryConsoleDisplay;
	/**
	 *  CRYCONSOLENAV
	 *  Console Navigation System.
	 * 	@see 	CryConsoleNav
	 */
	private var consoleNav		:CryConsoleNav;
	/**
	 * PARTICLEEMITTER<br>
	 *  Particle System reference.
	 * 	@see 	CryConsoleNav
	 */
	private var particles		:ParticleEmitter;
	/**
	 *  ENABLE3D<br>
	 *  Class for handling 2.5D effects supported by the GFX loader.
	 * 	@see 	CryConsoleNav
	 */
	private var enable			:Enable3Di;
	//{ Native Flash Variables:
	/**
	 *  Definitions<br>
	 *  Definitions Reference for this Implementation.
	 * 	@see 	Definitions
	 */
	private var defs				:Definitions;
	/**
	 * 	MOVIECLIP <br>
	 *  Preloader MovieClip Reference (just for display purposes).
	 * 	@see 	--
	 */
	private var preloader		:MovieClip;
	/**
	 *  BOOLEAN <br>
	 *  Was Back Disabled?
	 * 	@see 	--
	 */
	private var backwasdisabled	:Boolean;
	/**
	 *  BOOLEAN <br>
	 *  Was Quit Disabled?
	 * 	@see 	--
	 */
	private var quitwasdisabled	:Boolean;
	/**
	 * 	BOOLEAN <br>
	 *  Is Level Navigation up? 
	 * 	@see 	--
	 */
	private var levelNavUP		:Boolean;
	/**
	 *  MOVIECLIP <br>
	 *  Cursor MovieClip Reference - Not defined in the implementation.
	 * 	@see 	--
	 */
	private var Cursor			:MovieClip;
	
	private var activeLevelBox:Boolean;
	private var activeLevelList:Array;
	private var glow:GlowFilter;
	//}
	
	//}
	
	//{ REGION : Console Controller Variables:------------------------------------------ DONE!
	
	/** Key for Console */
	private var eCIE_Up				:Number			= 0;
	/** Key for Console */
	private var eCIE_Down			:Number			= 1;
	/** Key for Console */
	private var eCIE_Left			:Number			= 2;
	/** Key for Console */
	private var eCIE_Right			:Number			= 3;
	/** Key for Console */
	private var eCIE_Action			:Number			= 4;
	/** Key for Console */
	private var eCIE_Back			:Number			= 5;
	/** Key for Console */
	private var eCIE_Start			:Number			= 6;
	/** Key for Console */
	private var eCIE_Select			:Number			= 7;
	/** Key for Console */
	private var eCIE_ShoulderL1		:Number			= 8;
	/** Key for Console */
	private var eCIE_ShoulderL2		:Number			= 9;
	/** Key for Console */
	private var eCIE_ShoulderR1		:Number			= 10;
	/** Key for Console */
	private var eCIE_ShoulderR2		:Number			= 11;
	/** Key for Console */
	private var eCIE_Button3		:Number			= 12;
	/** Key for Console */
	private var eCIE_Button4		:Number			= 13;
	//}
	private var PS3		= "PS3";
	private var XBOX	= "XBox";
	private var PC		= "pc";
	
	//{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  CONSTRUCT
	/**
	 *  Main is the ROOT object class for this implentation of CryFlash.
	 */
	public static var active:Main;
	public function Main()
	{
		//NO CONSTRUCTOR!
		//AnimateVarious();
		active 			= this;
		
	}
	//}
	private var tempValues:Array;
	
	public function storeTempVal(id:String, value):Void
	{
		if (tempValues.length > 0)
		{
			for (var i = 0; i < tempValues.length; i++)
			{
				var curTemp = tempValues[i];
				if (curTemp.ID == id)
				{
					curTemp.Value = value;
					return;
				}
			}
		}
		var tempObj:Object 	= new Object();
		tempObj.ID 			= id;
		tempObj.Value 		= value;
		tempValues.push(tempObj);
	}
	public function getTempVal(id:String):String
	{
		for (var i = 0; i < tempValues.length; i++)
		{
			var curTempVal = tempValues[i];
			if (curTempVal.ID == id)
			{
				return curTempVal.Value;
			}
		}
		return "";
	}
	//{ REGION : Initialize methods and clean-up handles:------------------------------- DONE!

		//{ INITIALIZE:---------------------------- DONE!
		/**
		 * CryInit (Inits the whole menu system - Based on the CryEngine SDK example scene).
		 * @param	sys What system is are we initializing? (PC/Xbox/PS).
		 */
		public function cryInit(sys):Void
		{
			//trace("[CryFlash] - Loading UI.");
			defs 							= new cryflash.Definitions();
			
			
			tempValues 						= new Array();
			Cursor 							= new MovieClip();
			//trace("[CryFlash] - Setup Registry and perform init.");
			defs.defineCryReg();
			defs.cleanArrays();
			//trace("[CryFlash] - CryRegistry cleaned");
			preloader						= _root.preloader;
			oldPageNameY 					= CryRegistry.CryPageName._y;
			
			
			// SET STATE(S):
			CryStates.DIAG_ACTIVE 			= false;
			
			// Set up Level List Handler:
			activeLevelBox 					= false;
			activeLevelList 				= new Array();
			
			// Set up particle emitter:
			particles 						= new ParticleEmitter(25, 2, 2);
			showParticles();
			
			// Set up 3Di system:
			enable 							= new Enable3Di();
			enable.init();
			
			// Set up Focus Navigation:
			consoleDisplay 					= new CryConsoleDisplay(CryRegistry.CryConsoleHandler);
			consoleDisplay.initialize(sys);
			consoleNav						= new CryConsoleNav(consoleDisplay);
			
			// Start Couroutine:
			hideSpinner		();
			//trace("[CryFlash] - CryFlash finished setup...");
			
			CryRegistry.CryBGPlane = _root.bg_plane;
			CryRegistry.cry_system = sys;
			glow = new GlowFilter(0x000000, 100, 15, 15, 100, 1, false, false);
			
		}
		//}

		//{ CLEAR SCREEN:-------------------------- DONE!
		/**
		*  Clears the current menu screen.
		*/
		public function cryCleanScreen():Void
		{
			var i:Number;
			//{ REGION : CLEAN ALL OBJ ARRAYS:
			if(CryRegistry.leftObjects.length > 0)
			{
				for (var i = 0; i < CryRegistry.leftObjects.length; i++)
				{
					CryRegistry.leftObjects[i].Destruct();
				}
				CryRegistry.leftObjects = new Array();
			}
			if ( CryRegistry.middleObjects.length > 0)
			{
				for (var i = 0; i < CryRegistry.middleObjects.length; i++)
				{
					CryRegistry.middleObjects[i].Destruct();
				}
				CryRegistry.middleObjects = new Array();
			}
			if (CryRegistry.rightObjects.length > 0)
			{
				for (var i = 0; i < CryRegistry.rightObjects.length; i++)
				{
					CryRegistry.rightObjects[i].Destruct();
				}
				CryRegistry.rightObjects = new Array();
			}
			if (CryRegistry.applyObjects.length > 0)
			{
				for (var i = 0; i < CryRegistry.applyObjects.length; i++)
				{
					CryRegistry.applyObjects[i].Destruct();
				}
				CryRegistry.applyObjects = new Array();
			}	
			if (CryRegistry.resetObjects.length > 0)
			{
				for (var i = 0; i < CryRegistry.resetObjects.length; i++)
				{
					CryRegistry.resetObjects[i].Destruct();
				}
				CryRegistry.resetObjects = new Array();
			}
			if (CryRegistry.backObjects.length > 0)
			{
				for (var i = 0; i < CryRegistry.backObjects.length; i++)
				{
					CryRegistry.backObjects[i].Destruct();
				}
				CryRegistry.backObjects = new Array();
			}	
			if (CryRegistry.CryDialogs.length > 0)
			{
				for (var i = 0; i < CryRegistry.CryDialogs.length; i++)
				{
					CryRegistry.CryDialogs[i].Destruct();
				}	
				CryRegistry.CryDialogs = new Array();
			}	
			//}
			if (CryRegistry.CryImages.length > 0)
			{
				for (var i = 0; i < CryRegistry.CryImages.length; i++)
				{
					var curImage:CryImage = CryRegistry.CryImages[i];
					if (curImage.isVisible == true)
					{
						hideImage(curImage._ID);
					}
				}
			}
			
			//{ REGION : Clear all CryReg arrays / make them ready for new screen.
			defs.cleanArrays();
			CryRegistry.CryToolTip.text		= "";
			_root.listBoxCaptions 			= new Array();
			_root.listBoxValues				= new Array();
			activeLevelList					= new Array();
			activeLevelBox					= false;
			
			consoleDisplay.ResetAction 		= ""; 	// Set the current set action to nothing.
			consoleDisplay.ApplyAction 		= "";	// Set the current apply action to nothing.
			consoleDisplay.BackAction 		= "";	// Set the current back action to nothing.
			//}
			
			consoleDisplay.clear();
			
			if (active != this)
			{
				trace("[CryFlash] - Error: this instance of Main.as is no longer the only instance in the menu. Recursion might occur.");
			}
		}
		//}

	//}

	//{ REGION : INTERNAL Helper Methods for placemnt of Objects:----------------------- DONE!

		
		//{                        COLUMN:
		/**
		 * getColumn			Gets a reference to a Array based on a string reference.
		 * @param	$given		STRING______string reference.
		 * @return				ARRAY_______returns a predefined array to use.
		 */	
		private function getColumn($given:String):Array
		{
			if ($given == "left")
			if ($given == "left")
			{
				return CryRegistry.leftObjects;
			}
			if ($given == "middle")
			{
				return CryRegistry.leftObjects;
			}
			if ($given == "right")
			{
				return CryRegistry.leftObjects;
			}
			
			
			if ($given == "back")
			{
				return CryRegistry.backObjects;
			}
			if ($given == "apply")
			{
				return CryRegistry.applyObjects;
			}
			if ($given == "reset")
			{
				return CryRegistry.resetObjects;
			}
			if ($given == "image")
			{
				return CryRegistry.leftObjects;
			}
			else 
			{
				return CryRegistry.leftObjects;
			}
		}
		//}
		//{                         GUIDE:
		/**
		 * getGuide				Get's a helper movieClip reference based on a string refference.
		 * @param	$given		STRING______string reference.
		 * @return				MOVIECLIP___returns a predefined MovieClip Reference to use as guide.
		 */
		private function getGuide($given):MovieClip
		{
			if ($given == "left")
			{
				return CryRegistry.leftColumn;
			}
			if ($given == "middle")
			{
				return CryRegistry.leftColumn;
			}
			if ($given == "right")
			{
				return CryRegistry.leftColumn;
			}
			if ($given == "back")
			{
				return CryRegistry.BackGuide;
			}
			if ($given == "apply")
			{
				return CryRegistry.ApplyGuide;
			}
			if ($given == "reset")
			{
				return CryRegistry.ResetGuide;
			}
			if ($given == "image")
			{
				return CryRegistry.leftColumn;
			}
			else
			{
				return CryRegistry.leftColumn;
			}
		}
		//}

	//}

	//{ REGION : Event Handlers ( ONLY SEND TO FLOWGRAPH):------------------------------ DONE!
	/**
	 * -------------------------------------
	 */
	private function onSimpleButton(e:CryEvent):Void
	{
		//trace("BUTTON CLICK");
		fscommand("onSimpleButton", e.target._ID);
	}
	/**
	 * -------------------------------------
	 */
	private function onSimpleRoll(e:CryEvent):Void
	{
		consoleNav.Clear();
	}
	/**
	 * -------------------------------------
	 */
	private function onConfirm(e:CryEvent):Void
	{
		var args:Array = new Array();
		args.push(e.target._ID);
		args.push(true);
		fscommand("onConfirm", args);
	}
	/**
	 * -------------------------------------
	 */
	private function onDecline(e:CryEvent):Void
	{
		var args:Array = new Array();
		args.push(e.target._ID);
		args.push(false);
		fscommand("onConfirm", args);
	}
	/**
	 * -------------------------------------
	 */
	private function onClose(e:CryEvent):Void
	{
		fscommand("onSimpleButton", e.target._ID);
	}
	/**
	 * -------------------------------------
	 */
	private function onChange(e:CryEvent):Void
	{
		var args:Array = new Array();
		args.push(e.target._ID);
		args.push(e.target.CurrentValue);
		fscommand("onControl", args);
	}
	/**
	 * -------------------------------------
	 */
	private function onLevelButton(e:CryEvent):Void
	{
		fscommand("onLevelButton", e.target._ID);
	}
	/**
	 * -------------------------------------
	 */
	private function onTextFieldChanged(e:CryEvent):Void
	{
		var args:Array = new Array();
		args.push		(e.target._ID);
		var text:Array = e.target.storedText.split(",");
		var correctedText:String = new String();
		
		for (var i:Number = 0; i < text.length; i++)
		{
			if (i == 0)
			{
				correctedText = text[0] + ".";
			}
			else
			{
				correctedText += text[i] + ".";
			}
		}
		args.push		(correctedText);
		//trace			(args);
		fscommand		("textfield_changed", args);
	}

	//}

	//{ REGION:  Helper functions ( ONLY CALLED FROM FLOWGRAPH):------------------------ DONE!
			
		//{ 						SINGLE CALLS:
		/**
		 * showParticles - Starts showing the Background Particle effects.
		 */
		public function showParticles():Void
		{
			particles.startParticles();
		}
		/**
		 * hideParticles - stops and hides the Background Particle effects.
		 */
		public function hideParticles():Void
		{
			particles.stopParticles();
		}
		/**
		 * showSpinner - shows the pre-load spinner.
		 */
		public function showSpinner():Void
		{
			preloader._visible = true;
		}
		/**
		 * hideSpinner - hides the pre-load spinner.
		 */
		public function hideSpinner():Void
		{
			preloader._visible = false;
		}
		/**
		 * Sets the background Object (Deprecated).
		 */
		public function setBackgroundObject():Void
		{
			//trace("Deprecated....");
		}
		//}
		
		//{                   GET / SET Controls:
		/**
		 * getControlVal		STRING______Gets the value of given control.
		 * @param	_id			STRING______ID of the control to get the Value From.
		 * @return				STRING______Returns a string with the value.
		 */
		public function getControlVal(_id:String):String
		{
			//trace("Getting Value");
			for (var i:Number = 0; i < CryRegistry.CrySliders.length; i++)
			{
				if (CryRegistry.CrySliders[i]._ID == _id)
				{
					return CryRegistry.CrySliders[i].getValue();
				}
						
			}	
			for (var i:Number = 0; i < CryRegistry.CrySwitches.length; i++ )
			{
				if (CryRegistry.CrySwitches[i]._ID == _id)
				{
					return CryRegistry.CrySwitches[i].getValue();
				}
			}
			for (var i:Number = 0; i < CryRegistry.CryListboxes.length; i++)
			{
				if (CryRegistry.CryListboxes[i]._ID == _id)
				{
					//trace("Returning selected ListItem:" + CryRegistry.CryListboxes[i].getCurrent());
					return CryRegistry.CryListboxes[i].getCurrent();
				}
			}
			return "-1";
		}
		/**
		 * setControlValue		Sets the value of the given control.
		 * @param	_ID			STRING______ID of the control to modify.
		 * @param	_Value		STRING______Value to modify by.
		 * @return 				____________Does not Return Anything.
		 */
		public function setControlVal(_ID, _Value):Void
		{
			//trace("________START_________");
			//trace("Setting Value for SLIDER/SWITCH");
			//trace("VALUE : " + _Value);
			//trace("ID	 : " + _ID);
			//trace("_____________________");
			for (var i:Number = 0; i < CryRegistry.CrySliders.length; i++)
			{
				var curSlider:menuSlider = CryRegistry.CrySliders[i];
				//trace("CURRENT ID = " + curSlider._ID);
				if (curSlider._ID == _ID)
				{
					//trace("ITS A MATCH!");
					CryRegistry.CrySliders[i].setValue(_Value);
					return; // Found it and changed it, go back!
				}
			}
			for (var i:Number = 0; i < CryRegistry.CrySwitches.length; i++)
			{
				var curSwitch:menuSwitch = CryRegistry.CrySwitches[i];
				//trace("CURRENT ID = = " + curSwitch._ID);
				if (_ID == CryRegistry.CrySwitches[i]._ID)
				{
					//trace("ITS A MATCH!");
					CryRegistry.CrySwitches[i].setValue(_Value);
					return; // Found it and changed it, go back!
				}
			}
			//trace("_____________________");
			//trace("No valid Control Objects found!");
			//trace("_________END_________");
		}
		//}


	//}

	//{ REGION : Methods for adding new objects to the menu:---------------------------- NOT DONE
		
		
		//{ REGION : SiMPLE BUTTON --------------- DONE!
		/**
		 * addSimpleButton		Adds A simple Button to the current Menu Screen.
		 * @param	_Caption	STRING______Caption of the Button.
		 * @param	_Tooltip 	STRING______Tooltip the button should display (if Any).
		 * @param	_ID			STRING______ID to give the Button.
		 * @param	_Column 	STRING______Column to add the button to (Right, Middle, Left ect).
		 * @return 				____________Does not Return Anything.
		 */
		public function addButtonSimple	( _Caption:String,_Tooltip:String,_ID:String, _Column:String):Void
		{
			// Create New Button:
			var newButton:menuButton = new menuButton(_ID, _Caption, _Tooltip, getColumn(_Column), getGuide(_Column));
			// Add Event Listeners:
			
			newButton.addEventListener	(CryEvent.ON_RELEASE, this, "onSimpleButton");
			newButton.addEventListener	(CryEvent.ON_ROLLOVER, this, "onSimpleRoll");
			newButton.addEventListener	(CryEvent.CLOSE, this, "onClose");
			
			if (consoleDisplay.getSys() == "XBox" || consoleDisplay.getSys() == "PS3")
			{
				consoleDisplay.addActionButton("Press to select", "_____");
			}
			////trace(newButton.SELECTABLE);
			consoleNav.Reset();
		}
		public function removeButton(id:String):Void
		{
			var curButton:CryButton;
			for (var i = 0; i < CryRegistry.leftObjects.length; i++)
			{
				curButton = CryRegistry.leftObjects[i];
				if (curButton._ID == id)
				{
					curButton.Destruct();
					CryRegistry.leftObjects.splice(i, 1);
					return;
				}
			}
			for (var i = 0; i < CryRegistry.middleObjects.length; i++)
			{
				curButton = CryRegistry.middleObjects[i];
				if (curButton._ID == id)
				{
					curButton.Destruct();
					CryRegistry.middleObjects.splice(i, 1);
					return;
				}
			}
			for (var i = 0; i < CryRegistry.rightObjects.length; i++)
			{
				curButton = CryRegistry.rightObjects[i];
				if (curButton._ID == id)
				{
					curButton.Destruct();
					CryRegistry.rightObjects.splice(i, 1);
					return;
				}
			}
		}

		//}

		//{ REGION : SEPERATOR-------------------- DONE!
		/**
		* addSeperator			Adds a simple Seperator object to the current Menu Screen.
		* @param	_Caption	STRING______Caption of the Seperator.
		* @param	_Tooltip 	STRING______Tooltip the seperator should display (if Any).
		* @param	_ID			STRING______ID to give the Seperator.
		* @param	_Column 	ARRAY_______Column to add the Seperator to (Right, Middle, Left ect).
		* @return 				___________Does not Return Anything.
		*/
		public function addSeparator(_Caption:String,_ID:String, _Tooltip:String, _Column:String):Void
		{
			var newSeparator:menuSeperator = new menuSeperator(_ID, _Caption, getColumn(_Column), getGuide(_Column));
			consoleNav.Reset();
		}
		//}

		//{ REGION : INPUT TEXTFIELD-------------- DONE!
		/**
		* addTextFieldSimple	Adds a simple textField object to the current menu screen.
		* @param	_Caption	STRING______Caption of the textField.
		* @param	_Tooltip 	STRING______Tooltip the textField should display (if Any).
		* @param	_ID			STRING______ID to give the textField.
		* @param	_Column 	ARRAY_______Column to add the textField to (Right, Middle, Left ect).
		* @param	isSender	BOOLEAN_____Wether this textfield sends text, or just stores it.(Set to true, if it's supposed to send).
		* @return 				____________Does not Return Anything.
		*/
		public function addTextFieldSimple	(_Caption:String, _Tooltip:String, _ID:String, _Column:String, isSending:Boolean):Void
		{
			var newTextField:menuTextField = new menuTextField(_ID, getColumn(_Column), getGuide(_Column), isSending);
			newTextField.setText(_Caption);
			newTextField.addEventListener(CryEvent.CHANGE, this, "onTextFieldChanged");
			CryRegistry.CryTextFields.push(newTextField);
		}
		/**
		 * setTextFieldText 	Sets the value of the specified TextField.
		 * @param	_ID 		STRING______ID of the Textfield to change.
		 * @param	_Value 		STRING______The text to insert.
		 */
		public function setTextFieldText(_ID, _Value):Void
		{
			//trace("Trying to set Text");
			for (var i:Number = 0; i < CryRegistry.CryTextFields.length; i++)
			{
				if (CryRegistry.CryTextFields[i]._ID == _ID)
				{					
					CryRegistry.CryTextFields[i].setText(_Value);
				}
			}
		}
		/**
		* GetTextFieldText		Gets the current value of the specified TextField.
		* @param	_ID			STRING______The ID of the TextField to retrieve from.
		* @return				STRING______Returns a String containing the TextField Value.
		*/
		public function getTextFieldText(_ID):String
		{
			for (var i:Number = 0; i < CryRegistry.CryTextFields.length; i++)
			{
				if (CryRegistry.CryTextFields[i]._ID == _ID)
				{
					var returnval:String = CryRegistry.CryTextFields[i].getText();
					return returnval;
				}
			}
		}
		//}

		//{ REGION : LEVEL LIST BOX--------------- NOT DONE
		
		/**
		* addLevelButton		Adds a simple Level List Button - Ellaborate system just for this menu system (shoulc/could be replaced).
		* @param	_Caption	STRING______Caption of the Level Button.
		* @param	_Tooltip	STRING______Tooltip of the level Button.
		* @param	_ID			STRING______ID of the levelButton.
		* @param	_Column		ARRAY_______Collumn to place the LevelButton (and all subsequent ones - for the current screen.)
		*/
		public function addLevelButton		( _Caption:String, _Tooltip:String, _ID:String, _Column:String):Void
		{
			if (activeLevelBox == false)
			{
				var newLevelList:menuListBox = new menuListBox("LevelList", "Level Select", getColumn(_Column), getGuide(_Column));
				
				activeLevelList.push(newLevelList);
				newLevelList.addEventListener(CryEvent.ON_RELEASE, this, "onLevelButton");
				newLevelList.addItem(_Caption, _Tooltip, _ID);
				activeLevelBox = true;
				consoleNav.Reset();
			}
			else
			{
				//trace("Trying to add menu item");
				var currentList:menuListBox = activeLevelList[0];
				currentList.addItem(_Caption, _Tooltip, _ID);
				consoleNav.Reset();
			}
		}		
		//{ REGION : SWITCH ---------------------- DONE!
		/**
		* dds a simple switch to the current menu screen.
		* @param	_Caption	STRING______Caption of the Switch.
		* @param	_Tooltip	STRING______Tooltip of the Swithc.
		* @param	Val			*ARB*_______Start Value of the Switch.
		* @param	_ID			STRING______ID of the Switch to create.
		* @param	_Column		ARRAY_______Column to place the Switch.
		*/
		public function addSwitchSimple	(_Caption:String,_Tooltip:String, Val ,_ID:String, _Column:String):Void
		{
			var newSwitch:menuSwitch = new menuSwitch(_ID, _Caption, _Tooltip, getColumn(_Column), getGuide(_Column));
			
			newSwitch.addEventListener(CryEvent.ON_ROLLOVER, this, "onSimpleRoll");
			newSwitch.addEventListener(CryEvent.CHANGE, this, "onChange");
			
			CryRegistry.CrySwitches.push(newSwitch);
			consoleNav.Reset();
		}
		/**
		* @param	_ID			STRING______ID of the Switch to add an option to.
		* @param	_Caption	STRING______Caption of the Switch Option.
		* @param	Val			*ARB*_______Start Value of the Switch.
		*/
		public function addSwitchOption	(_ID:String, _Caption:String, _Value:String):Void
		{
			for (var i:Number = 0; i < CryRegistry.CrySwitches.length; i++)
			{
				if (_ID == CryRegistry.CrySwitches[i]._ID)
				{
					CryRegistry.CrySwitches[i].addSwitchOption(_Caption, _Value);
					return;
				}
			}
			// No switch found!
		}
		/**
		* 
		* @param	_IDX		STRING______ID of the Switch to add several options to.
		* @param	_Options	STRING______String containing all the options
		* @param	_delimit	STRING______Delimiter used to seperate the options.
		*/
		public function addSwitchOptionsFromString(_IDX:String, _Options:String, _delimit:String):Void
		{
			var edOptions:Array = new Array();
			edOptions = _Options.split(_delimit);
			if (edOptions.length > 0)
			{
				for (var i:Number = 0; i < edOptions.length; i++)
				{
					addSwitchOption(_IDX, edOptions[i], edOptions[i]);
				}		
			}
		}
		/**
		 * clearSwitchOptions	- Clears Specified Switch of all options.
		 * @param	_ID			STRING______The ID of the Switch to clear.
		 * @return 				____________Does not Return Anything.
		 */
		public function clearSwitchOptions	(_ID):Void
		{
			for (var i:Number = 0; i < CryRegistry.CrySwitches.length; i++)
			{
				if (CryRegistry.CrySwitches[i]._ID == _ID)
				{
					CryRegistry.CrySwitches[i].clearSwitch();
				}
			}
		}
	//} 

	//{ REGION : SLIDER ---------------------- DONE!
	/**
	* 
	* @param	_Caption		STRING______Caption of the Slier.
	* @param	_Tooltip		STRING______Tooltip of the slider.
	* @param	min				NUMBER______Minimum value for the slider.
	* @param	max				NUMBER______Maximum value for the slider.
	* @param	step			NUMBER______Step to increment the slider in.
	* @param	val				NUMBER______Initial value of the Slider.
	* @param	_ID				STRING______ID of the Slider.
	* @param	_Column			ARRAY_______Column to place the Slider in.
	*/
	public function addSliderSimple	(_Caption:String, _Tooltip:String, min, max, step, val, _ID:String, _Column:String):Void
	{
		//trace("Adding Slider with ID: " + _ID);
		//trace("tooltip was:" + _Tooltip);
		var newSlider:menuSlider = new menuSlider(_ID, min, max, _Caption, _Tooltip, getColumn(_Column), getGuide(_Column));
		newSlider.addEventListener(CryEvent.ON_ROLLOVER, this, "onSimpleRoll");
		CryRegistry.CrySliders.push(newSlider);
		//trace("Slider list is :" + CryRegistry.CrySliders);
		consoleNav.Reset();
	}
	//}
		//{ REGION : LIST BOX -------------------- DONE!
		/**
		* @param	_Caption		STRING______Caption of the Listbox.
		* @param	_Tooltip		STRING______Tooltip of the Listbox.
		* @param	_ID				STRING______ID of the Listbox.
		* @param	_Column			ARRAY_______Column to place the Listbox in.
		**/
		private function onListItem(e:CryEvent):Void
		{
			//trace("List Item Selected");
			fscommand("onButtonSimple", e.target._CAPTION);
		}
		public function addListbox			(_ID:String,_Caption:String,_Tooltip:String, _Column:String):Void
		{
			var newList:menuListBox = new menuListBox(_ID, _Caption, getColumn(_Column), getGuide(_Column));
			CryRegistry.CryListboxes.push(newList);
			newList.addEventListener		(CryEvent.ON_RELEASE, this, "onButtonSimple");
			consoleNav.Reset				();
		}
		/**
		* @param	_Caption		STRING______Caption of the ListboxItem.
		* @param	_Tooltip		STRING______Tooltip of the ListboxItem.
		* @param	_ID				STRING______ID of the ListboxItem.
		* @param	_IDX			STRING______IDX of the Listbox to add the item too..
		* @param	_Column			ARRAY_______Column to place the Listbox in.
		**/
		public function addListboxItem(_IDX:String, _Caption:String, _Tooltip:String):Void
		{
			for (var i:Number = 0; i < CryRegistry.CryListboxes.length; i++)
			{
				var curList:menuListBox = CryRegistry.CryListboxes[i];
				if (_IDX == curList._ID)
				{
					curList.addItem(_Caption, _Tooltip);
				}
			}
			return;
		}
		/**
		* @param	_IDX			STRING______IDX of the Listbox to add the items(from array) to..
		*/
		public function addListboxItems	(_idx:String):Void
		{
			var copyCaptions:Array	 	= _root.listBoxCaptions;
			var copyValues:Array		= _root.listBoxValues;
			//trace("Adding List Box Items");
			if (copyCaptions.length < 0 || copyValues.lenth < 0)
			{
				return;
			}
			//trace("Length of Captions and Values: " + copyCaptions.length + "," + copyValues.length);
			for (var i:Number = 0;  i < copyCaptions.length; i++ )
			{
				//trace("Currently at: " + i + "Adding List Item!");
				addListboxItem(_idx, copyCaptions[i], copyValues[i]);
			}
			//trace("finished adding new items!");
		}
		/**
		* @param	_IDX			STRING______IDX of the Listbox to Clear.
		*/
		public function clearListbox		(ID:String):Void
		{
			for (var i:Number = 0; i < CryRegistry.CryListboxes.length; i++)
			{
				if (CryRegistry.CryListboxes[i]._ID == ID)
				{
					CryRegistry.CryListboxes[i].clearList();
				}
			}
		}
		//}

		//{ REGION : LABEL ----------------------- DONE!
		/**
		* @param	_Caption		STRING______Caption of the Label.
		* @param	_Tooltip		STRING______Tooltip of the Label.
		* @param	_ID				STRING______ID of the Label.
		* @param 	_Column			ARRAY_______Array to add the Label to.
		*/
		public function addScreenText(_ID:String, _Caption:String, _Tooltip:String, _Column:String):Void
		{
			var newLabel:menuLabel = new menuLabel(_ID, _Caption, getColumn(_Column), getGuide(_Column));
			consoleNav.Reset();
			resizeSwing();
		}
		//}

		//{ REGION : NAVIGATION BUTTONS ---------- DONE!	
		/**
		* @param	_ID				STRING______ID of the BackButton.
		*/
		public function addBackButton		(_ID:String):Void
		{			
			if (consoleDisplay.getSys() == "XBox" || consoleDisplay.getSys() == "PS3")
			{
				consoleDisplay.addBackButton("Back", _ID);
			}			
			else
			{
				var newBackButton:menuBackButton = new menuBackButton(_ID, "BACK", "BACK");
				newBackButton.addEventListener(CryEvent.ON_RELEASE, this, "onSimpleButton");
			}
			consoleDisplay.BackAction = _ID;
			
		}
		/**
		* 
		* @param	_Caption		STRING______Caption of the ApplyButton.
		* @param	_Tooltip		STRING______Tooltip of the ApplyButton.
		* @param	_ID				STRING______ID of the ApplyButton.
		*/
		public function addApplyButton		(_Caption:String, _Tooltip:String, _ID:String):Void
		{			
			if (consoleDisplay.getSys() == "XBox" || consoleDisplay.getSys() == "PS3")
			{
				consoleDisplay.addApplyButton(_Caption, _ID);
			}
			else
			{
				var newApplyButton:menuApplyButton = new menuApplyButton(_ID, _Caption, _Tooltip);
				newApplyButton.addEventListener(CryEvent.ON_RELEASE, this, "onSimpleButton");
			}
			consoleDisplay.ApplyAction = _ID;
		}
		/**
		* @param	_Caption		STRING______Caption of the DefaultButton.
		* @param	_Tooltip		STRING______Tooltip of the DefaultButton.
		* @param	_ID				STRING______ID of the DefaultButton.
		*/
		public function addDefaultButton	(_Caption:String, _Tooltip:String, _ID:String):Void
		{		
			if (consoleDisplay.getSys() == "XBox" || consoleDisplay.getSys() == "PS3")
			{
				consoleDisplay.addResetButton(_Caption, _ID);
			}	
			else
			{
				var newDefaultButton:menuResetButton = new menuResetButton(_ID, _Caption, _Tooltip);
				newDefaultButton.addEventListener(CryEvent.ON_RELEASE, this, "onSimpleButton");
			}
			consoleDisplay.ResetAction = _ID;
		}
		/**
		* @param	_Caption		STRING______Caption of the QuitButton.
		* @param	_Tooltip		STRING______Tooltip of the QuitButton.
		* @param	_ID				STRING______ID of the QuitButton.
		*/
		public function addQuitButtonSimple(_Caption:String, _Tooltip:String, _ID:String):Void
		{			
			if (consoleDisplay.getSys() == "XBox" || consoleDisplay.getSys() == "PS3")
			{
				consoleDisplay.addQuitButton(_Caption, _ID);
			}
			else
			{
				var newBackButton:menuBackButton = new menuBackButton(_ID, _Caption, _Tooltip);
				newBackButton.addEventListener(CryEvent.ON_RELEASE, this, "onSimpleButton");
			}
			consoleDisplay.BackAction = _ID;
		}
		//}

		//{ REGION : IMAGES ---------------------- NOT DONE
		/**
		* 
		* @param	_path		STRING______Path of the image to load.
		* @param	_id			STRING______ID of the image.
		* @param	xpos		NUMBER______X Position of the image.
		* @param	ypos		NUMBER______Y Position of the image.
		* @param	_Width		NUMBER______Width of the image.
		* @param	_Height		NUMBER______Height of the image.
		*/
		public function addImage			(_path:String, _id:String, xpos:Number, ypos:Number, $width:Number, $height:Number):Void
		{
			//trace("Arguments inside Main Class : X:" + xpos + ",Y:" + ypos + ", Width:" + $width + ", Height:" + $height);
			var exists:Boolean = false;
			if (CryRegistry.CryImages > 0)
			{
				//trace("XY: " + xpos + "," + ypos);
				for (var i:Number = 0; i < CryRegistry.CryImages.length; i++)
				{
					if (CryRegistry.CryImages[i]._ID == _id)
					{
						exists = true;
					}
				}
			}	
			else
			{
				//trace("XY: " + xpos + "," + ypos);
				var nImg:menuImage = new menuImage(_id, _path, $width, $height, xpos, ypos);
				exists = true;
				//nImg.moveImage(xpos, ypos);
				CryRegistry.CryImages.push(nImg);

			}
			
			if (exists == false)
			{
				//trace("XY: " + xpos + "," + ypos);
				var nImg:menuImage = new menuImage(_id, _path, $width, $height, xpos, ypos);
				//nImg.moveImage(xpos, ypos);
				CryRegistry.CryImages.push(nImg);
			}
		}
		/**
		* Hides the image given with the ID.
		* @param	_ID		STRING______ID of the image you want to show.
		*/
		public function showImage(_ID):Void
		{
			for (var i:Number = 0; i < CryRegistry.CryImages.length; i++)
			{
				if (CryRegistry.CryImages[i]._ID == _ID)
				{
					CryRegistry.CryImages[i].showImage();
				}
			}
		}
		/**
		* Hides the image given with the ID.
		* @param	_ID		STRING______ID of the image you want to show.
		*/
		public function hideImage(_ID):Void
		{
			for (var i:Number = 0; i < CryRegistry.CryImages.length; i++)
			{
				if (CryRegistry.CryImages[i]._ID == _ID)
				{
					CryRegistry.CryImages[i].hideImage();
				}
			}
		}
		//}

		
	//}

	//{ REGION : Chat Functionality (BETA)---------------------------------------------- NOT DONE
		/**
		* 
		* @param	_Caption
		* @param	_Tooltip
		* @param	_ID
		* @param	_Column
		*/
		public function addChatSimple		(_Caption, _Tooltip, _ID, _Column):Void
		{
			//var newChat:CryChatBox = new CryChatBox(_ID, _Tooltip, CryRegistry.CryLibChatbox, CryRegistry.CryButtonHolder, getColumn(_Column), getGuide(_Column));
			//CryRegistry.CryChatBoxes.push(newChat);
			//
		}
		/**
		* 
		* @param	_ID
		* @param	_MSG
		*/
		public function sendMessage(_ID:String, _MSG:String):Void
		{	
			//for (var i:Number = 0; i < CryRegistry.CryChatBoxes.length; i++)
			//{
				//if (CryRegistry.CryChatBoxes[i]._ID == _ID)
				//{
					//CryRegistry.CryChatBoxes[i].recieveMessage(_MSG);
				//}
			//}
			//trace("If nothing is showing, nothing was found");
		}
	//}

	//{ REGION : Various methods related to SDK MainMenu and flowgraph: ---------------- DONE!
		/**
		* 
		*/
		public function hideConfirmDiag	():Void
		{
			if (CryRegistry.CryDialogs.length > 0)
			{
				while (CryRegistry.CryDialogs.length > 0)
				{
					
					CryRegistry.CryDialogs[0].removeAllEventListeners(CryEvent.ON_RELEASE);
					CryRegistry.CryDialogs[0].removeAllEventListeners(CryEvent.ON_ROLLOUT);
					CryRegistry.CryDialogs[0].removeAllEventListeners(CryEvent.ON_ROLLOVER);
					CryRegistry.CryDialogs[0].Destruct();
					CryRegistry.CryDialogs.splice(0, 1);
				}
			}			
			if (CryRegistry.leftObjects.length > 0)
			{
				for (var i = 0; i < CryRegistry.leftObjects.length; i++)
				{
					var curItem:CryBaseObject = CryRegistry.leftObjects[i];
					curItem.enactHandlers();
				}
			}
			if (CryRegistry.middleObjects.length > 0)
			{
				for (var i = 0; i < CryRegistry.middleObjects.length; i++)
				{
					var curItem:CryBaseObject = CryRegistry.middleObjects[i];
					curItem.enactHandlers();
				}
			}
			if (CryRegistry.rightObjects.length > 0)
			{
				for (var i = 0; i < CryRegistry.rightObjects.length; i++)
				{
					var curItem:CryBaseObject = CryRegistry.rightObjects[i];
					curItem.enactHandlers();
				}
			}
			enable.bringForward();
			CryStates.DIAG_ACTIVE = false;	
		}
		/**
		 * 
		 * @param	msg
		 * @param	btn1
		 * @param	btn2
		 * @param	id
		 */
		public function showConfirmDiag	(msg:String, btn1:String, btn2:String, id:String):Void
		{
			var newDiag:menuDialog = new menuDialog(id, msg, btn1, btn2);
			
			newDiag.addEventListener(CryEvent.ACCEPTED, this, "onConfirm");
			newDiag.addEventListener(CryEvent.DECLINED, this, "onDecline");
			if (CryRegistry.cry_system == XBOX)
			{
				newDiag.xbExtra._alpha = 100;
			}
			else if (CryRegistry.cry_system == PS3)
			{
				newDiag.psExtra._alpha = 100;
			}
			
			enable.pushBack();
			CryStates.DIAG_ACTIVE 	= true;
			CryRegistry.CryDialogs.push(newDiag);
			if (CryRegistry.leftObjects.length > 0)
			{
				for (var i = 0; i < CryRegistry.leftObjects.length; i++)
				{
					var curItem:CryBaseObject = CryRegistry.leftObjects[i];
					curItem.suspendHandlers();
				}
			}
			if (CryRegistry.middleObjects.length > 0)
			{
				for (var i = 0; i < CryRegistry.middleObjects.length; i++)
				{
					var curItem:CryBaseObject = CryRegistry.middleObjects[i];
					curItem.suspendHandlers();
				}
			}
			if (CryRegistry.rightObjects.length > 0)
			{
				for (var i = 0; i < CryRegistry.rightObjects.length; i++)
				{
					var curItem:CryBaseObject = CryRegistry.rightObjects[i];
					curItem.suspendHandlers();
				}
			}
		}


	/**
	* 
	* @param	_ID
	* @param	_Caption
	* @param	_Tooltip
	* @param	_Column
	*/
	public function addItemSelect(_ID:String, _Caption:String, _Tooltip:String, _Column:String ):Void
	{
		var newItemSelect:menuItemSelect = new menuItemSelect(_ID, _Caption, _Tooltip, getColumn(_Column), getGuide(_Column));
		CryRegistry.CryItemSelects.push(newItemSelect);
		
	}
	/**
	* 
	* @param	_ID
	* @param	_Caption
	* @param	_Value
	*/
	public function addSelectItem(_ID:String, _Caption:String, _Value:String):Void
	{
		for (var i:Number = 0; i < CryRegistry.CryItemSelects.length; i++)
		{
			var itemSelector:menuItemSelect = CryRegistry.CryItemSelects[i];
			if (itemSelector._ID == _ID)
			{
				itemSelector.addSwitchOption(_Caption, _Value);
			}
		}
	}
	/**
	* 
	* @param	_imageFile
	*/
	private var holder:MovieClip;
	private var hWidth:Number;
	private var hHeight:Number;
	private var imgListen:Object;
	private var imgLoader:MovieClipLoader;
	
	public function setupLoadingLevel	(_imageFile):Void
	{
		_root.loading_screen.img_holder._alpha 	= 0;
		var actualPath:String 					= "img://" + _imageFile;
		if (actualPath == "img://")
		{
			return;
		}		
		holder					= _root.loading_screen.img_holder;
		hWidth 					= holder._width;
		hHeight					= holder._height;
		
		
		imgLoader 				= new MovieClipLoader();
		
		imgListen				= new Object();
		imgListen.onLoadInit	= cryflash.Delegates.create(this, loaded);
		
		imgLoader.addListener(imgListen);
		imgLoader.loadClip(actualPath, holder);
		
		
	}
	private function loaded(target:MovieClip):Void
	{
		if (target)
		{
			_root.loading_screen.img_holder._alpha = 100;
			target._width 	= hWidth;
			target._height 	= hHeight;
		}
		return;
	}
	public function showLoader():Void
	{
		_root.loading_screen._alpha = 100;
		_root.loading_screen.gotoAndPlay(1);
	}
	public function hideLoader():Void
	{
		_root.loading_screen._alpha = 0;
		
		
	}
	public function hideBG():Void
	{
		_root.bg_image._alpha = 0;
	}
	public function showBG():Void
	{
		_root.bg_image._alpha = 100;
	}
	//}

	//{ REGION : Assorted methods:------------------------------------------------------ DONE!
	
	/**
	 * Sets on the cryPlatform (basically just "sets" the platform number.
	 * @param	_platform
	 */
	public function cry_onSetup(_platform:Number):Void
	{
		
		switch(_platform)
		{
			case 0: 
				//trace("Init as PC");
				cryInit(PC);
				break;
				
			case 1: 
				//trace("Init as XBOX");
				cryInit(XBOX);
				break;
			case 2: 
				//trace("Init as PS3");
				cryInit(PS3);
				break;				
		}
	}
	//}

	//{ REGION : SDK MainMenu specific methods: ---------------------------------------- CLEAN UP (BUT DONE!)
	/**
	 *  Sets the version to display in the main menu if one is there.
	 * @param	ver
	 */
	public function setVersion(ver:String):Void
	{
		CryRegistry.CryStaticElements.version.text = ver;
	}
	/**
	* 	Set up a new screen with the given name. (clears the previous one.)
	* @param	_ScreenName Name of the Screen.
	*/
	public function setupScreenSimple	(_ScreenName:String):Void
	{
		cryCleanScreen();
		var pnFormat:TextFormat = new TextFormat();
		pnFormat.letterSpacing  = 10;
		CryRegistry.CryPageName.text 		= _ScreenName;
		
		CryRegistry.CryPageName._y 			= CryRegistry.CryPageName._y - 50;
		CryRegistry.CryPageName._alpha 		= 0;
		CryRegistry.CryButtonHolder._alpha	= 0;
		CryRegistry.CryPageName.setNewTextFormat(pnFormat);
		CryRegistry.CryPageName.text 		= _ScreenName;
		resizeSwing();		
	}
	private function resizeSwing():Void
	{
		Tweener.addTween(CryRegistry.CryPageName, { _y:oldPageNameY, _alpha:100, time:0.5} );
		Tweener.addTween(CryRegistry.CryButtonHolder, {_alpha:100, time:0.5 } );
	}
	private function backsizeSwing():Void
	{
		
	}
	//}
	//{ REGION NAVIGATION FOR FOCUS NAV:
	/**
	 * The navigation system input reciever.
	 * @param	iButton 	- the button that was pressed.
	 * @param	bReleased 	- if the button was also released.
	 */
	public function cry_onController(iButton:Number, bReleased:Boolean)
	{
		//trace("Cry_onController is called");
		if (bReleased)
		{
			return;
		}
		switch(iButton)
		{		
			case eCIE_Up:
			{				
				consoleNav.Navigate("up");
				break;
			}
			case eCIE_Down:
			{
				consoleNav.Navigate("down");
				break;
			}
			case eCIE_Left:
			{
				consoleNav.Navigate("left");
				break;
			}
			case eCIE_Right:
			{
				consoleNav.Navigate("right");
				break;
			}
			case eCIE_Action:	
			{	
				if (CryStates.DIAG_ACTIVE == true)
				{
					var args:Array = new Array();
					args.push(CryRegistry.CryDialogs[0]._ID)
					args.push(true);
					fscommand("onConfirm", args);
					return;
				}
				else 
				{
					consoleNav.Navigate("action");
				}				
				break;
			}
			case eCIE_Back:
			{
				if (CryStates.DIAG_ACTIVE == true)
				{
					var args:Array = new Array();
					args.push(CryRegistry.CryDialogs[0]._ID)
					args.push(false);
					fscommand("onConfirm", args);
					
					return;
				}
				else
				{
					fscommand("onSimpleButton", consoleDisplay.BackAction);
				}								
				break;
			}
			case eCIE_Button3:
			{
				consoleNav.Navigate("apply");	
				//fscommand("onSimpleButton", consoleDisplay.ApplyAction);
				break;
			}
			case eCIE_Button4:
			{
				consoleNav.Navigate("reset");
				//fscommand("onSimpleButton", consoleDisplay.ResetAction);
				break;
			}
		}
	}

	//}
	//{ REGION : TestCase setup (for testing offline / In Flash)------------------------ MESSY// - NOT DONE!}	
}

