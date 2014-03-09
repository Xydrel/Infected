
/**
 * ...
 * @author RuneRask
 */
class cryflash.CryObjects.Various.CrySeparator extends cryflash.CryObjects.CryBaseObject
{	
	private var CaptionText:TextField;
	
	public function CrySeparator($id:String, $libobj:String, $parent:MovieClip) 
	{
		super($id, $libobj, $parent);
	}
	public function addCaption(txtID:String , value:String)
	{
		CaptionText 		= _CHILD[txtID];
		CaptionText.text 	= value;
	}
	
}