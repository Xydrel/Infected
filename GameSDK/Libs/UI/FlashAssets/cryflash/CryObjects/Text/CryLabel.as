import cryflash.CryObjects.CryBaseObject;
/**
 * ...
 * @author RuneRask
 */
class cryflash.CryObjects.Text.CryLabel extends cryflash.CryObjects.CryBaseObject
{
	private var CaptionText		:TextField;
	private var TitleText		:TextField;
	private var ScaleBox		:MovieClip;
	
	private var TextLines		:Array;
	private var caption			:String;
	
	/**
	 * Textlabel Class 	- Base class for adding a simple Label Textbox (non-interactive).
	 * @param	$id		- ID of the Label (Must be a Unique string).
	 * @param	$libobj - Library Object Reference to use for this Object.
	 * @param	$parent - Parent MovieClip of this Object.
	 */
	public function CryLabel($id:String,$libObj:String, $parent:MovieClip) 
	{
		super($id, $libObj, $parent);		
	}
	/**
	 * Defines the label elements/parts
	 * @param	txtID		- Name of the textfield that holds the text.
	 * @param	titleID		- Name of the textfield that holds the title (if any).
	 * @param	bg			- Background movieclip of the textfield (used if you want to have scaling background).
	 */
	public function defineLabel(txtID:String, titleID:String, text:String, bg:String):Void
	{
		CaptionText = _CHILD[txtID];
		TitleText	= _CHILD[titleID];
		ScaleBox	= _CHILD[bg];
		
		formatText(text);
	}
	/**
	 *  Sets the text of the label.
	 * @param	text - Text to set.
	 */
	public function setText(text:String):Void
	{
		formatText(text);
	}
	/**
	 * Formats the current label. Using <br> to create a newline. (internal).
	 * @param	text - Text to set the text box to (overwrites previous assigned text - if any).
	 */
	private function formatText(text:String):Void
	{
		TextLines  	= text.split("<br>");
		for (var i:Number = 0; i < TextLines.length; i++)
		{
			if (i == 0)
			{
				CaptionText.text = TextLines[0] + newline;
			}
			else
			{
				CaptionText.text += TextLines[i] + newline;
			}
		}
		CaptionText._height = CaptionText.textHeight;
		ScaleBox._height 	= CaptionText._height + 10;
	}
	
}