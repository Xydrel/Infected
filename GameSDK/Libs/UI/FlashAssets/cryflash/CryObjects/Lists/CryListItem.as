import cryflash.CryObjects.Buttons.CryButton;
import cryflash.CryObjects.CryBaseObject;
import cryflash.CryObjects.Lists.CryListbox;
import cryflash.Events.CryEvent;
import caurina.transitions.*; 
import cryflash.*;;

/**
 * ...
 * @author RuneRask
 */
class cryflash.CryObjects.Lists.CryListItem extends cryflash.CryObjects.Buttons.CryButton
{
	//{ REGION : Parent handling (nested children)
	private var ParentList:CryListbox;
	private var CaptionText:TextField;
	public var 	needsDefine:Boolean;
	//}
	
	//{ REGION : Constructor:
	public function CryListItem($id:String, $libobj:String, $parent:MovieClip, $parentList:CryListbox) 
	{		
		super($id,$libobj, $parent);
		ParentList 	= $parentList;
		needsDefine = true;
		_CHILD.cacheAsBitmap = true;
	}
	//}
	
	//{ REGION : Interaction Methods:
	public function createHandlers():Void
	{
		super.createHandlers();
		_CHILD.onRollOver 	= cryflash.Delegates.create	(this, onRollOver);
		_CHILD.onRollOut 	= cryflash.Delegates.create	(this, onRollOut);
		_CHILD.onRelease	= cryflash.Delegates.create	(this, onRelease);
		
	}
	private function onRelease():Void
	{
		super.onRelease();
		select();		
	}
	public function select():Void
	{		
		dispatchEvent(new CryEvent(CryEvent.ON_RELEASE, this));
		//Do select animation:
		Tweener.addTween(_CHILD["SelectBar"], {_alpha:100 } );
	}
	public function deselect():Void
	{
		//Do Deselect animation:
		Tweener.addTween(_CHILD["SelectBar"], {_alpha:0 } );
	}
	//}
	
	//{ REGION : Overwrite roll over / roll out:
	private function onRollOver():Void
	{
		super.onRollOver();
		if (ParentList.SELECTED == this)
		{
			return;
		}
		else
		{
			// Do Animation :
			Tweener.addTween(_CHILD["SelectBar"], { _alpha:50 } );
		}
	}
	
	private function onRollOut():Void
	{
		super.onRollOut();
		if (ParentList.SELECTED == this)
		{
			return;
		}
		else
		{
			// Do Animation :
			Tweener.addTween(_CHILD["SelectBar"], {_alpha:0 } );
		}		
	}
	//}
	public function getCaption():String 
	{
		return _CAPTION;
	}

	public function addCaption(txtID:String, value:String):Void
	{
		_CAPTION			= value;
		CaptionText 		= _CHILD[txtID];
		CaptionText.text 	= value;
	}
	public function setCaption(text:String):Void
	{
		CaptionText.text	= text;
	}
}