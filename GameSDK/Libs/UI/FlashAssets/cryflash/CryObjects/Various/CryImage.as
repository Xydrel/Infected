import cryflash.CryObjects.CryBaseObject;
import cryflash.Events.CryEvent;
/**
 * ...
 * Edited 	on 		12-06-2013. By Rune Rask
 */
class cryflash.CryObjects.Various.CryImage extends cryflash.CryObjects.CryBaseObject
{
	private var imageHolder		:MovieClip;
	private var actImage		:MovieClip;
	private var _XAHH			:Number;
	private var _YAHH			:Number;
	
	
	private var refWidth		:Number;
	private var refHeight		:Number;
	private var Path			:String;
	
	private var Column			:Array;
	private var Guide			:MovieClip;
	
	public var isVisible		:Boolean;
	
	private var imgLoader		:MovieClipLoader;
	private var imgListen		:Object;
	
	public function CryImage($id:String, $libObj:String, $parent:MovieClip) 
	{
		super($id, $libObj, $parent)
		imgListen				= new Object();
		imgListen.onLoadInit 	= cryflash.Delegates.create(this, loaded);
		imgLoader 				= new MovieClipLoader();
	}
	
	public function setImage(path:String, imgX:Number, imgY:Number, imgWidth:Number, imgHeight:Number):Void
	{
		_XAHH 					= imgX;
		_YAHH					= imgY;
		refHeight 				= imgHeight;
		refWidth 				= imgWidth;
		Path 					= path;
		
		imgLoader.addListener(imgListen);
		imgLoader.loadClip("img://" + Path, _ROOT)
	}
	private function loaded(target:MovieClip):Void
	{		
		//trace("Loaded, Proceed to position");
		actImage 			= target;
		actImage._alpha		= 0;
		actImage._x			= _XAHH;
		actImage._y			= _YAHH;
		actImage._width		= refWidth;
		actImage._height	= refHeight;
		dispatchEvent		(new CryEvent(CryEvent.COMPLETE, this));
		//trace(_ID + ", is Width : " + actImage._width);
		//trace(_ID + ", is Height : " + actImage._height);
		//trace(_ID + ", is X : " + actImage._x);
		//trace(_ID + ", is Y : " + actImage._Y);
	}
	public function createHandlers():Void
	{
		super.createHandlers();
	}
	private function onRollOver():Void
	{
	}	
	private function onRollOut():Void
	{
	}
	public function hideImage():Void
	{
		isVisible 	= false;
		actImage._alpha 		= 0;
	}
	public function showImage():Void
	{		
		isVisible 	= true;
		actImage._alpha		= 100;
	}
	
}