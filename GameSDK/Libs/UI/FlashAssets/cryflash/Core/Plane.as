import flash.geom.Point;
/**
 * ...
 * @author RuneRask<br>
 * - Test case MovieClip Class for creating a interactive plane..<br>
 * - No use. TODO - make a 3D holder for items (buttons ect).<br>
 */
class cryflash.Core.Plane
{
	//{ REGION : GeoDefines:
	var vertices:Array;
	
	var p1:Point;
	var p2:Point;
	var p3:Point;
	var p4:Point;
	
	var v1:MovieClip;
	var v2:MovieClip;
	var v3:MovieClip;
	var v4:MovieClip;
	
	var holder:MovieClip;
	var L1:MovieClip;
	var L2:MovieClip;
	var L3:MovieClip;
	var L4:MovieClip;
	var L5:MovieClip;
	//}
	
	//{ REGION : Handlers:
	var isDraging:Boolean;
	//}
	
	//{ REGION : Constructor:
	public function Plane() 
	{
		p1 = new Point(0, 0);
		p2 = new Point(0, 100);
		p3 = new Point(100, 0);
		p4 = new Point(100, 100);
		
		
		
		holder = CryRegistry.CryStaticElements.attachMovie("TestPlane", "Holder", CryRegistry.CryStaticElements.getNextHighestDepth());
		v1 = holder["v1"];
		v2 = holder["v2"];
		v3 = holder["v3"];
		v4 = holder["v4"];
		isDraging = false;
		v1.onRelease = Delegates.create(this, onStartDrag, v1);
		v2.onRelease = Delegates.create(this, onStartDrag, v2);
		v3.onRelease = Delegates.create(this, onStartDrag, v3);
		v4.onRelease = Delegates.create(this, onStartDrag, v4);
	
		holder.onEnterFrame = Delegates.create(this, drawPlane);
		
		
	}
	//}
	
	//{ REGION : Change Rect:
	private function onStartDrag(t:MovieClip):Void
	{
		if (!isDraging)
		{
			t.startDrag();
			isDraging = true;
		}
		else if (isDraging)
		{
			t.stopDrag();
			isDraging = false;
		}
		
		
	}
	private function onStopDrag(t:MovieClip):Void
	{
	
	}
	private function drawPlane():Void
	{
		/////////////////////
		L1.removeMovieClip();
		L2.removeMovieClip();
		L3.removeMovieClip();
		L4.removeMovieClip();
		L5.removeMovieClip();
		/////////////////////
		L1 = holder.createEmptyMovieClip	("L_1MC", holder.getNextHighestDepth());
		L2 = holder.createEmptyMovieClip	("L_2MC", holder.getNextHighestDepth());
		L3 = holder.createEmptyMovieClip	("L_3MC", holder.getNextHighestDepth());
		L4 = holder.createEmptyMovieClip	("L_4MC", holder.getNextHighestDepth());
		L5 = holder.createEmptyMovieClip	("L_5MC", holder.getNextHighestDepth());
		/////////////////////
		L1.lineStyle		(1, 0x9AD5B7, 100);
		L2.lineStyle		(1, 0x9AD5B7, 100);
		L3.lineStyle		(1, 0x9AD5B7, 100);
		L4.lineStyle		(1, 0x9AD5B7, 100);
		L5.lineStyle		(1, 0x9AD5B7, 100);
		////////////////////
		L1.moveTo			(v1._x, v1._y);
		L1.lineTo			(v2._x, v2._y);
		
		L2.moveTo			(v2._x, v2._y);
		L2.lineTo			(v4._x, v4._y);
		
		L3.moveTo			(v4._x, v4._y);
		L3.lineTo			(v3._x, v3._y);
		
		L4.moveTo			(v3._x, v3._y);
		L4.lineTo			(v1._x, v1._y);
		
		L5.moveTo			(v3._x, v3._y);
		L5.lineTo			(v2._x, v2._y);			
	}
	//}
}