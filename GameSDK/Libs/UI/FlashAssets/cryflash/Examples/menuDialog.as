import cryflash.CryObjects.CryDialog;
import cryflash.CryRegistry;
import cryflash.Definitions;
import cryflash.Delegates;
import caurina.transitions.Tweener;

/**
 * ...
 * @author RuneRask
 */
class cryflash.Examples.menuDialog extends CryDialog
{
	
	private var anim1:MovieClip;
	private var anim2:MovieClip;
	public var psExtra:MovieClip;
	public var xbExtra:MovieClip;
	
	public function menuDialog(id:String, message:String, option1:String, option2:String) 
	{
		super(id, Definitions.Dialog, CryRegistry.CryDialogHolder);
		
		defineDialog(Definitions.diagButton1, Definitions.diagButton2, Definitions.dBtn1Txt, Definitions.dBtn2Txt, Definitions.diagMessage);
		defineContent(message, option1, option2);
		defineTooltip(CryRegistry.CryToolTip);		
		
		anim1 		= _CHILD["anim1"];
		anim2 		= _CHILD["anim2"];
		psExtra 	= _CHILD["ps_diag"];
		xbExtra 	= _CHILD["xbox_diag"];
		createHandlers();		
	}
	private function onRollOver1():Void
	{
		
		super.onRollOver1();
		Option1Box.textColor = 0xFFFFFF;
		Tweener.addTween(anim1, { _alpha:100, time:1 } );
		
	}
	private function onRollOver2():Void
	{
		super.onRollOver2();
		Option2Box.textColor = 0xFFFFFF;
		Tweener.addTween(anim2, {_alpha:100, time:1 } );
	}
	
	private function onRollOut1():Void
	{
		super.onRollOut1();
		Option1Box.textColor = 0x000000;
		Tweener.addTween(anim1, {_alpha:0, time:1 } );
	}
	private function onRollOut2():Void
	{
		super.onRollOut2();
		Option2Box.textColor = 0x000000;
		Tweener.addTween(anim2, {_alpha:0, time:1 } );
	}
	
}