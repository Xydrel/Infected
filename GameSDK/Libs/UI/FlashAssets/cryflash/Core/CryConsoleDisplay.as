/**
 * ...
 * @author RuneRask
 */
class cryflash.Core.CryConsoleDisplay
{
	//{ REGION : References:
	public 	var 	CONSOLE_HANDLER	:MovieClip;
	private var 	Parent			:Object
	//}
	
	//{ REGION : Actions and Helper Variables:
	public var 			BackAction		:String;
	public var 			ApplyAction		:String;
	public var 			ActionAction	:String;
	public var 			QuitAction		:String;
	public var 			ResetAction		:String;
	
	private var 		Spot1Text		:TextField;
	private var 		Spot2Text		:TextField;
	private var 		Spot3Text		:TextField;
	private var 		Spot4Text		:TextField;
	
	private var 		Spot1Symbol		:MovieClip;
	private var 		Spot2Symbol		:MovieClip;
	private var 		Spot3Symbol		:MovieClip;
	private var 		Spot4Symbol		:MovieClip;
	
	private var 		nr1isadd		:Boolean;
	private var 		nr2isadd		:Boolean;
	private var 		nr3isadd		:Boolean;
	private var 		nr4isadd		:Boolean;
	
	private var 		SYSTEM			:String;
	
	private static var 	PC				:String = "pc";
	private static var 	XBOX			:String = "XBox";
	private static var 	PS3				:String = "PS3";
	//}
	
	//{ REGION : Constructor:
	/**
	* CryConsoleDisplay handles displaying graphics and button representation for consoles.<br>
	* Not too genereric or powerfull, so to modify and or change, you would need to edit this as extending it would create .<br>
	* 
	* <br>
	* @param	$handler  - Handler is the MovieClip reference to the library symbol containing all the buttons.<br>
	*/
	public function CryConsoleDisplay($handler:MovieClip) 
	{
		CONSOLE_HANDLER = $handler;
		BackAction 		= "";
		ApplyAction 	= "";
		ResetAction 	= "";
		QuitAction		= "";
		Spot1Symbol		= CONSOLE_HANDLER.Symbol1;
		Spot2Symbol 	= CONSOLE_HANDLER.Symbol2;
		Spot3Symbol 	= CONSOLE_HANDLER.Symbol3;
		Spot4Symbol 	= CONSOLE_HANDLER.Symbol4;
		
		Spot1Text		= CONSOLE_HANDLER.Caption1;
		Spot2Text		= CONSOLE_HANDLER.Caption2;
		Spot3Text		= CONSOLE_HANDLER.Caption3;
		Spot4Text		= CONSOLE_HANDLER.Caption4;
		
		nr1isadd 		= false;
		nr2isadd 		= false;
		nr3isadd 		= false;
		nr4isadd 		= false;
		Spot1Text.text	= "";
		Spot2Text.text	= "";
		Spot3Text.text	= "";
		Spot4Text.text	= "";
		Spot1Symbol.gotoAndStop("NONE");
		Spot2Symbol.gotoAndStop("NONE");
		Spot3Symbol.gotoAndStop("NONE");
		Spot4Symbol.gotoAndStop("NONE");
		
		
		
	}
	//}
	public function getSys():String
	{
		return SYSTEM;
	}
	//{ REGION : Screen handler and updates:
	/**
	 * Initializes the system with a given system (PC, PS, XBox).
	 * @param	$system
	 */
	public function initialize($system:String):Void
	{
		SYSTEM = $system;
		
	}
	/**
	 * Clears the current screen.
	 */
	public function clear():Void
	{
		Spot1Text.text	= "";
		Spot2Text.text	= "";
		Spot3Text.text	= "";
		Spot4Text.text	= "";
		Spot1Symbol.gotoAndStop("NONE");
		Spot2Symbol.gotoAndStop("NONE");
		Spot3Symbol.gotoAndStop("NONE");
		Spot4Symbol.gotoAndStop("NONE");
	}
	/**
	 * adds a console backbutton.
	 * @param	$caption 	- Caption of the back button.
	 * @param	$action		- Action of the button.
	 * @return Returns wether or not the button could be added. (maybe some button was already in use or the system is PC).
	 */
	public function addBackButton($caption:String, $action:String):Boolean
	{
		if (SYSTEM 		== PC)
		{
			return false;
			
		}
		else if (SYSTEM == XBOX)
		{
			//Spot4Symbol._alpha 	= 100;
			//Spot4Text._alpha 	= 100;
			
			Spot3Symbol.gotoAndStop("XB_B");
			Spot3Text.text = $caption;
			BackAction = $action;
			return true;
		}
		else if (SYSTEM == PS3)
		{
			//Spot4Symbol._alpha 	= 100;
			//Spot4Text._alpha 	= 100;
			
			Spot3Symbol.gotoAndStop("PS_CIRCLE");
			Spot3Text.text 	= $caption;
			BackAction 		= $action;
			return true;
		}
	}
	/**
	 * adds a console backbutton.
	 * @param	$caption 	- Caption of the reset button.
	 * @param	$action		- Action of the button.
	 * @return Returns wether or not the button could be added. (maybe some button was already in use or the system is PC).
	 */
	public function addResetButton($caption:String, $action:String):Boolean
	{	
		if (SYSTEM 		== PC)
		{
			return false;
		}
		else if (SYSTEM == XBOX)
		{
			//Spot2Symbol._alpha 	= 100;
			//Spot2Text._alpha 	= 100;
			
			Spot2Symbol.gotoAndStop("XB_X");
			
			Spot2Text.text 	= $caption;
			ResetAction 	= $action;
			return true;
		}
		else if (SYSTEM == PS3)
		{
			Spot2Symbol._alpha 	= 100;
			Spot2Text._alpha 	= 100;
			
			Spot2Symbol.gotoAndStop("PS_SQUARE");
			
			Spot2Text.text 	= $caption;
			ResetAction 	= $action;
			return true;
		}
	}
	/**
	 * adds a console Applybutton.
	 * @param	$caption 	- Caption of the apply button.
	 * @param	$action		- Action of the button.
	 * @return Returns wether or not the button could be added. (maybe some button was already in use or the system is PC).
	 */
	public function addApplyButton($caption:String, $action:String):Boolean
	{		
		if (SYSTEM 		== PC)
		{
			return false;
		}
		else if (SYSTEM == XBOX)
		{
			//Spot4Symbol._alpha 	= 100;
			//Spot4Text._alpha 	= 100;
			Spot4Symbol.gotoAndStop("XB_Y");
			
			Spot4Text.text 	= $caption;
			ApplyAction		= $action;
			return true;
		}
		else if (SYSTEM == PS3)
		{
			//Spot4Symbol._alpha 	= 100;
			//Spot4Text._alpha 	= 100;
			Spot4Symbol.gotoAndStop("PS_TRIANGLE");
			
			Spot4Text.text 	= $caption;
			ApplyAction		= $action;
			return true;
		}
	}
	/**
	 * adds a console QuitButton.
	 * @param	$caption 	- Caption of the quit button.
	 * @param	$action		- Action of the button.
	 * @return Returns wether or not the button could be added. (maybe some button was already in use or the system is PC).
	 */
	public function addQuitButton($caption:String, $action:String):Boolean
	{
		if (SYSTEM 		== PC)
		{
			return false;
		}
		else if (SYSTEM == XBOX)
		{
			//Spot3Symbol._alpha = 100;
			//Spot3Text._alpha = 100;
			Spot3Symbol.gotoAndStop("XB_B");
			
			Spot3Text.text 	= $caption;
			QuitAction		= $action;
			return true;
		}
		else if (SYSTEM == PS3)
		{
			//Spot3Symbol._alpha 	= 100;
			//Spot3Text._alpha 	= 100;
			Spot3Symbol.gotoAndStop("PS_CIRCLE");
			
			Spot3Text.text 	= $caption;
			QuitAction		= $action;
			return true;
		}
	}
	/**
	 * adds a console Actionbutton.
	 * @param	$caption 	- Caption of the action button.
	 * @param	$action		- Action of the button.
	 * @return Returns wether or not the button could be added. (maybe some button was already in use or the system is PC).
	 */
	public function addActionButton($caption:String, $action:String):Boolean
	{
		if (SYSTEM 		== PC)
		{
			return false;
		}
		else if (SYSTEM == XBOX)
		{
			//Spot1Symbol._alpha = 100;
			//Spot1Text._alpha = 100;
			Spot1Symbol.gotoAndStop("XB_A");
			
			Spot1Text.text 	= $caption;
			ActionAction	= $action;
			return true;
		}
		else if (SYSTEM == PS3)
		{
			//Spot1Symbol._alpha = 100;
			//Spot1Text._alpha = 100;
			Spot1Symbol.gotoAndStop("PS_CROSS");
			
			Spot1Text.text 	= $caption;
			return true;
		}
	}
	public function resetDisplay()
	{
		Spot1Text.text	= "";
		Spot2Text.text	= "";
		Spot3Text.text	= "";
		Spot4Text.text	= "";
		Spot1Symbol.gotoAndStop("NONE");
		Spot2Symbol.gotoAndStop("NONE");
		Spot3Symbol.gotoAndStop("NONE");
		Spot4Symbol.gotoAndStop("NONE");
		
	}
	//]
}