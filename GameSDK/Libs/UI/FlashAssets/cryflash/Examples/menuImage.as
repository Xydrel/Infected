import cryflash.CryObjects.Various.CryImage;
import cryflash.Events.CryEvent;
import flash.filters.GlowFilter;
import cryflash.CryRegistry;
import cryflash.Definitions;

/**
 * ...
 * @author RuneRask
 */
class cryflash.Examples.menuImage extends CryImage
{
	private var outline:GlowFilter;
	
	public function menuImage(id:String, path:String, imgWidth:Number, imgHeight:Number, $imgX:Number, $imgY:Number) 
	{
		super(id, "EmptyHolder", CryRegistry.CryImageHolder);
		//trace("Arguments Inside Image Class: X:" + $imgX + ",Y:" + $imgY + ", Width:" + imgWidth + ", Height:" + imgHeight);
		setImage(path, $imgX, $imgY, imgWidth, imgHeight);
		outline 			= new GlowFilter(0x000000, 10, 12, 12, 150, 1, false, false);
		
		
		
		createHandlers();
		this.addEventListener(CryEvent.COMPLETE, this, "onComplete");
	}
	public function moveImage(_x:Number, _y:Number):Void
	{
		_Xpos = _x;
		_Ypos = _y;
	}
	public function inlineImage(column:Array, guide:MovieClip):Void
	{
		placeObject(column, guide);
	}
	private function onComplete():Void
	{
		//_CHILD.filters 		= [outline];
		actImage.filters 		= [outline];		
	}
	
}