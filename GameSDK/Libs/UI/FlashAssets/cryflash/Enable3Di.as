/**
 * ...
 * @author RuneRask
 */
import caurina.transitions.*; 
import cryflash.*;
import caurina.transitions.properties.DisplayShortcuts;

class cryflash.Enable3Di
{
	// Listener Object.
	private var Mover:Object;
	// Mouse Mover.
	private var MouseXpos:Number;
	private var MouseYpos:Number;
	
	public function Enable3Di() 
	{}
	public function init()
	{
		setUp();
	}
	private function setUp():Void
	{
		// set initial Z depth :
		//cryflash.CryRegistry.CryButtonHolder._z 				= -100;
		//cryflash.CryRegistry.CryStaticElements._z 				= -100;
		//_root.swing._z 											= -100;
		
		//Mover = new Object();
		//Mover.onMouseMove = cryflash.Delegates.create(this, moveStage);
		
		//Mouse.addListener(Mover);
	}
	
	private function moveStage():Void
	{
			//MouseXpos 												= _root._xmouse - Stage.width / 2;
			//MouseYpos 												= _root._ymouse - Stage.height / 2;
			//cryflash.CryRegistry.CryButtonHolder._yrotation 			= MouseXpos  	/ 150;
			//cryflash.CryRegistry.CryButtonHolder._xrotation 			= -MouseYpos  	/ 120;
			//cryflash.CryRegistry.CryStaticElements._yrotation 		= MouseXpos 	/ 150;
			//cryflash.CryRegistry.CryStaticElements._xrotation 		= -MouseYpos  	/ 120;

			//_root.swing._yrotation 									= MouseXpos 	/ 150;
			//_root.swing._xrotation 									= -MouseYpos  	/ 120;	
	}
	public function pushBack():Void
	{
		Tweener.addTween(cryflash.CryRegistry.CryButtonHolder, 		{ _alpha:0, 	_z:3000, time:1 } );
		Tweener.addTween(cryflash.CryRegistry.CryStaticElements, 	{ _alpha:0, 	_z:2600, time:1 } );
		Tweener.addTween(_root.swing, 								{ _alpha:0,  	_z:2600, time:1 } );
		Mouse.removeListener(Mover);
	}
	public function bringForward():Void
	{
		Tweener.addTween(cryflash.CryRegistry.CryButtonHolder, 		{_alpha:100, 	_z: -100, time:1 } );
		Tweener.addTween(cryflash.CryRegistry.CryStaticElements, 	{_alpha:100, 	_z: -100, time:1 } );
		Tweener.addTween(_root.swing, 								{_alpha:75, 	_z: -100, time:1 } );
		Mouse.addListener(Mover);
	}
}