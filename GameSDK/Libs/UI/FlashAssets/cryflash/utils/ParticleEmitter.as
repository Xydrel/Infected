import cryflash.utils.HeavyParticle;
/**
 * ...
 * @author RuneRask
 */
class cryflash.utils.ParticleEmitter
{
	private var amount	:Number;
	private var wind	:Number;
	private var fade	:Number;
	
	private var objPool:Array;
	
	public function ParticleEmitter(_amount:Number, _wind:Number, _fade:Number) 
	{
		amount 		= _amount;
		wind 		= _wind;
		fade 		= _fade;
		objPool		= new Array();
		createParticles(amount);
	}
	private function createParticles(amount:Number):Void
	{
		for (var i:Number = 0; i < amount; i++)
		{
			var newParticle:HeavyParticle = new HeavyParticle(i, "cloudParticle");
			newParticle.updrift = Math.random() * 2;
			newParticle.wind 	= 0;
			newParticle.fade 	= Math.random() * 1;
			objPool.push(newParticle);
			
		}
		for (var i:Number = 0; i < amount - 10; i++)
		{
			var newParticle:HeavyParticle = new HeavyParticle(i, "sparkle");
			newParticle.updrift = Math.random() * 2;
			newParticle.wind 	= 0;
			newParticle.fade 	= Math.random() * 1;
			objPool.push(newParticle);
			
		}
		

	}
	public function stopParticles():Void
	{
		for (var i:Number = 0; i < objPool.length; i++)
		{
			if (objPool[i].isRunning)
			{
				objPool[i].stop();
			}
			
		}
	}
	public function startParticles():Void
	{
		for (var i:Number = 0; i < objPool.length; i++)
		{
			if (!objPool[i].isRunning)
			{
				objPool[i].start();
			}
			
		}
	}
	
}