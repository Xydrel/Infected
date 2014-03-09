import cryflash.*;

/**
 * ...
 * @author RuneRask
 */
class cryflash.utils.HeavyParticle
{
	private var particleMC:MovieClip;
	
	// Factors:
	public var wind			:Number;
	public var updrift		:Number;
	public var fade			:Number;
	private var speed		:Number;
	private var rotateSpeed	:Number;
	
	public var isRunning:Boolean;
	
	public function HeavyParticle(ID:Number, type:String, _wind, _updrift, _fade) 
	{
		wind 	= _wind;
		updrift = _updrift;
		fade 	= _fade;
		speed	= 0;
		//
		var scale:Number 	= 100 + (Math.random() * 125);
		particleMC._xscale 	= scale;
		particleMC._yscale 	= scale;
		rotateSpeed 		= Math.random() * 5;
		particleMC 			= CryRegistry.CryParticleHolder.attachMovie(type, "particle" + ID, CryRegistry.CryParticleHolder.getNextHighestDepth());
		
		// Initial Position of Particle:
		particleMC._x 			= 	Math.random() * Stage.width;;
		particleMC._y 			=  	Stage.height + particleMC._height;
		particleMC.onEnterFrame = 	Delegates.create(this, move);
		isRunning = true;
		reset();
	}

	private function reset(depth:Number):Void
	{		
		speed				= 1 + Math.random() * 3;
		var scale:Number 	= 100 + (Math.random() * 125);
		particleMC._alpha	= 0;
		particleMC._xscale 	= scale;
		particleMC._yscale 	= scale;
		particleMC._y 		= Stage.height + particleMC._height;
		particleMC._x 		= Math.random() * Stage.width;;
		
		
	}
	private function move():Void
	{
		particleMC._y 			-= speed;
		particleMC._x 			+= speed;
		particleMC._alpha 		+= 1;
		
		if (particleMC._y < 800)
		{
			particleMC._alpha		+= 0.5;
		}
		if (particleMC._alpha >= 50)
		{
			particleMC._alpha = 50;
		}
		if (particleMC._x > Stage.width, + particleMC._width)
		{
			particleMC._alpha	-=	0.5;
		}		
		if (particleMC._x > Stage.width + particleMC._width + 500)
		{
			reset();
			
		}
	}
	public function stop():Void
	{
		delete particleMC.onEnterFrame;
		particleMC._x 		= 	Math.random() * Stage.width;
		particleMC._y 		= 	720 + particleMC._height + 200;
		isRunning = false;
	}
	public function start():Void
	{
		particleMC.onEnterFrame = Delegates.create(this, move);
	}
	
}