import cryflash.Events.CryEvent;
/**
 * ...
 * @author RuneRask
 */
class cryflash.CryObjects.CryDialog extends cryflash.CryObjects.CryBaseObject
{
	/**
	 *  Reference Objects and defined bool.
	 */
	private var isDefined	:Boolean;
	private var tooltipRef	:TextField;
	
	/**
	 * 	String Objects for the dialog box. - Undefined by Default.
	 */
	private var Option1		:String;
	private var Option2		:String;
	private var Message		:String;
	
	/**
	 * 	parsed objects for the dialog box - Define to use.
	 */
	private var MessageBox	:TextField;
	public var Option1Box	:TextField;
	public var Option2Box	:TextField;
	public var Button1		:MovieClip;	
	public var Button2		:MovieClip;	
	
	//{ REGION : Constructor:
	/**
	 * A gerneric Dialog box, with two options and a message.<br>
	 * This dialog is very generic and should be extended and defined for more usability.<br>
	 * @see {@link menuDialog} <br>
	 * Which is a example extension (and is in fact the one used in the SDK menu).
	 *
	 * @param	$id			- ID of the Dialog box. (Must be a Unique String).
	 * @param	$libobj		- Library object reference of the Dialog.
	 * @param	$parent		- parent movieclip object.
	 */
	public function CryDialog($id:String, $libobj:String, $parent:MovieClip)  
	{
		super($id, $libobj, $parent);
		X = (Stage.width 	/ 2) 	- 	(_CHILD._width 	/ 2);
		Y = (Stage.height 	/ 2) 	- 	(_CHILD._height / 2);
	}
	//}
	
	//{ REGION : Define Dialog methods:
	
	/**
	 * Defines the Dialog. These params are the default and can be overwritten in 
	 * a class that extends this.
	 * 
	 * @see 	{@link menuDialog} - For more Information on how to use this class.
	 * @param	btn1		- The reference object that defines Button 1 
	 * @param	btn2		- The reference object that defines Button 2 
	 * @param	btn1msg		- The refference to Button 1 textfield (if it has a textField).
	 * @param	btn2msg		- The refference to Button 2 textfield (if it has a textField).
	 * @param	messageBox	- The overall message textfield in the dialogBox.
	 */
	public function defineDialog(btn1:String, btn2:String, btn1msg:String, btn2msg:String , messageBox:String):Void
	{
		Button1 	= _CHILD[btn1];
		Button2 	= _CHILD[btn2];
		MessageBox	= _CHILD[messageBox];
		Option1Box	= _CHILD[btn1msg];
		Option2Box	= _CHILD[btn2msg];
		
		
		isDefined 	= true;
	}
	/**
	 * Defines the content to be displayed in the aforementioned objects.<br>
	 * The default is that the content is strings. To change this you should make your own class extending this and change this.<br>
	 * @param	message
	 * @param	option1
	 * @param	option2
	 */
	public function defineContent(message:String, option1:String, option2:String):Void
	{
		Option1 	= option1;
		Option2 	= option2;
		Message 	= message;
		
		if (isDefined)
		{
			Option1Box.text = Option1;
			Option2Box.text = Option2;
			MessageBox.text = Message;
		}
	}
	/**
	 * Define a tooltip reference. <br>
	 * A tooltip reference is in this case a textfield for displaying a tooltip when u hover over the different elements.
	 * 
	 * @param	tooltip Textfield to use.
	 */
	public function defineTooltip(tooltip:TextField):Void
	{
		tooltipRef = tooltip;
	}
	//}
	
	/**
	 * 	Creates handlers for interactivity. Call this once you have set up the define methods.
	 */
	public function createHandlers():Void
	{
		super.createHandlers();
		Button1.onRelease 	= cryflash.Delegates.create(this, onAccept);
		Button2.onRelease 	= cryflash.Delegates.create(this, onDecline);
		Button1.onRollOver 	= cryflash.Delegates.create(this, onRollOver1);
		Button2.onRollOver 	= cryflash.Delegates.create(this, onRollOver2);
		Button1.onRollOut 	= cryflash.Delegates.create(this, onRollOut1);
		Button2.onRollOut 	= cryflash.Delegates.create(this, onRollOut2);
	}

	//{ REGION : Interactive Methods:
	/**
	 * onRollOver1 - 
	 */
	private function onRollOver1():Void
	{
		if (tooltipRef)
		{
			tooltipRef.text = Option1;
		}
		
	}
	/**
	 * onRollOver2 -
	 */
	private function onRollOver2():Void
	{
		if (tooltipRef)
		{
			tooltipRef.text = Option2;
		}
		
	}
	/**
	 *  onRollOut1 - 
	 */
	private function onRollOut1():Void
	{
		if (tooltipRef)
		{
			tooltipRef.text = "";
		}
	}
	/**
	 *  onRollOut2 - 
	 */
	private function onRollOut2():Void
	{
		if (tooltipRef)
		{
			tooltipRef.text = "";
		}
	}
	/**
	 *  onAccept - 
	 */
	private function onAccept():Void
	{
		dispatchEvent(new CryEvent(CryEvent.ACCEPTED, this));
	}
	/**
	 *  onDecline - 
	 */
	private function onDecline():Void
	{
		dispatchEvent(new CryEvent(CryEvent.DECLINED, this));
	}
	//}
}