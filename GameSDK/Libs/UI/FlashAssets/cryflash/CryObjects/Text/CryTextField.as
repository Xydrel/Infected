import cryflash.CryObjects.CryBaseObject;
import cryflash.Events.CryEvent;

/**
 * ...
 * @author RuneRask
 */
class cryflash.CryObjects.Text.CryTextField extends CryBaseObject
{
	private var inputField	:TextField;
	private var enterBtn	:MovieClip;
	
	public 	var storedText	:String;
	
	private var listener	:Object;
	private var isSending	:Boolean;
	private var isDefined	:Boolean;
	
	//{ REGION : Constructor:
	/**
	 * TextField Class - Base class for adding a input textfield. supports keyboard sending and a optional enter button for console.
	 * @param	$id		- ID of the TextField (Must be a Unique string).
	 * @param	$libobj - Library Object Reference to use for this Object.
	 * @param	$parent - Parent MovieClip of this Object.
	 */
	public function CryTextField($id:String, $libobj:String, $parent:MovieClip) 
	{
		super($id, $libobj, $parent);
		listener				= new Object();
		storedText				= new String();
		isDefined				= false;
	}
	//}
	
	//{ REGION :  Setup:
	/**
	 *  Overwrite for createHandlers (inherited)
	 *  Made to enable simple key and enterkey support.
	 */
	public function createHandlers():Void
	{
		super.createHandlers();
		inputField.onChanged 	= cryflash.Delegates.create(this, onText);
		listener.onKeyDown 		= cryflash.Delegates.create(this, onKeyDown);
		inputField.onSetFocus 	= cryflash.Delegates.create(this, setFocus);
		inputField.onKillFocus 	= cryflash.Delegates.create(this, finFocus);
	}
	
	//}
	
	//{ REGION : Interaction methods:
	/**
	 *  overwrite for actAct (inherited).
	 */
	private function actAct():Void
	{
		var args:Array = new Array();
		args.push("Default");
		args.push(inputField.text);
		args.push(inputField);
		args.push(inputField._width);
		fscommand("cry_virtualKeyboard", args);
	}
	/**
	 *  Activates the textfield.
	 */
	private function actActivate():Void
	{
		ACTIVE = true;
	}
	/**
	 *  update stored text when the text changes from input.
	 */
	private function onText():Void
	{
		storedText = inputField.text;
	}
	/**
	 *  If enter is released dispatch a event so that the rest of the system and flowgraph can accord accordingly.
	 */
	private function onKeyDown() 
	{
		
		if (Key.isDown(Key.ENTER))
		{
			storedText = inputField.text;
			if (isSending)
			{
				inputField.text = "";
				dispatchEvent(new CryEvent(CryEvent.CHANGE, this));
			}
			else
			{
				dispatchEvent(new CryEvent(CryEvent.CHANGE, this));
			}
			
		}
		storedText = inputField.text;
	}
	/**
	 * Sets the text of the textfield (for example Player profile name is retrieved and displayed).
	 * @param	_Value The string to insert (overwrites previous assignment - if any).
	 */
	public function setText(_Value):Void
	{
		if (_Value == undefined)
		{
			if (isDefined)
			{
				inputField.text = "";
			}			
			storedText = "";
		}
		else
		{
			if (isDefined)
			{
				inputField.text = String(_Value);
			}			
			storedText = _Value;
			
		}
		
	}
	/**
	 * Gets the current string contained in the textfield (as it was last confirmed/ entered - not dynamic - stupid as2)
	 * @return
	 */
	public function getText():String
	{
		return storedText;
	}
	/**
	 *  Set the focus on this textfield (used by focus nav).
	 */
	private function setFocus():Void
	{
		Key.addListener(listener);
	}
	/**
	 *  Cancels the focus on this textfield(used by focus nav).
	 */
	private function finFocus():Void
	{
		//Key.removeListener(listener);
	}
	//}
	
	//{ REGION : Define Object Methods:
	/**
	 * Defines wethe or not the textfield is meant to send it's information or just store it.
	 * For example a chat box input field would send it's text (so whatever is entered dissapears when clicking enter).
	 * whereas a field for inputting name, would just hold the information for display and retrieval from other systems.
	 * 
	 * @param	value Set to true if the object is sending.
	 */
	public function setIsSending(value:Boolean):Void
	{
		isSending 	= value;
	}
	/**
	* Defines the textfield that is used for focus/input.
	* @param	txtID 		- the name of the textfield to be used.
	* @param	enterButton	- the name of the Enter Button (if any).
	*/
	public function addInputTextfield(txtID:String, enterButton:String):Void
	{
		inputField 	= _CHILD[txtID];
		enterBtn	= _CHILD[enterButton];
		isDefined 	= true;
		createHandlers();
	}
	//}
}