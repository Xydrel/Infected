import cryflash.CryObjects.CryBaseObject;
/**
 * ...
 * @author RuneRask
 */
class cryflash.CryObjects.Text.CryChatBox extends cryflash.CryObjects.CryBaseObject
{	
	//{ REGION : Private Variables:
	private var chatLines	:TextField;
	private var _title		:TextField;
	private var MAX_LINES	:Number;
	private var lines		:Array;
	//}
	
	//{ REGION : Constructor:
	/**
	 *  Creates a simple barebones chatbox.<br>
	 * 	It does not do much besides just recieving and displaying single strings.<br>
	 *  Currently the chatbox does not save text outside of it's bounds, so as soon as a session goes beyond maxLines<br>
	 * 	the text is gone. <br><br>
	 * 
	 * 	TODO - make the chatbox work with scrolling, history, logging and color support.<br>
	 * 
	 * @param	$id		- ID of the Button (Must be a Unique string).<br>
	 * @param	$libobj - Library Object Reference to use for this Object.<br>
	 * @param	$parent - Parent MovieClip of this Object.<br>
	 */
	public function CryChatBox($id:String, $libObj:String, $parent:MovieClip) 
	{
		super($id, $libObj, $parent, false);
		lines 			= new Array();
		
	}
	//}
	
	//{ REGION : Define Chatbox Methods:
	/**
	 * 
	 * @param	messageAreaID TextBox where the chatlines exist.
	 * @param	titleID Title TextBox.
	 * @param	title	Title of the title textbox.
	 */
	public function defineChatbox(messageAreaID:String, titleID:String, title:String ):Void
	{
		chatLines 		= _CHILD[messageAreaID];
		_title			= _CHILD[titleID];
		_title.text		= title;
	}
	public function setMaxLines(num:Number):Void
	{
		MAX_LINES = num;
	}
	//}
	
	//{ REGION : Interactive Methods:
	public function recieveMessage(_msg:String):Void
	{
		if (lines.length <= 0)
		{
			chatLines.text = "";
		}
		lines.push(_msg);

		if (lines.length > MAX_LINES)
		{
			var newText:String;
			lines.shift();
			newText = "";
			for (var i:Number = 0; i < lines.length; i++)
			{
				newText += lines[i] + newline;
			}
			chatLines.text = newText;
		}
		else
		{
			chatLines.text += _msg + newline;
		}
	}
	//}
}