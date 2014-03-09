/**
 * ...
 * @author RuneRask
 */
import cryflash.Events.CryDispatcher;
import mx.data.encoders.Num;
class CryMC extends CryDispatcher
{
	private var _mcRoot:MovieClip;
	private var children:Array;
	
	public function CryMC(holder:MovieClip):Void
	{
		_mcRoot 		= holder.createEmptyMovieClip("cryMC", holder.getNextHighestDepth());
		children 		= new Array();
	}
	
	public function addChild(id:String, name:String):Void
	{
		newChild 		= _mcRoot.attachMovie(id, name, _mcRoot.getNextHighestDepth());
		newChild.name 	= name;
		children.push(newChild);
	}
	public function getChild(name:String):MovieClip
	{
		var found:Boolean = false;
		for (var i = 0; i < children.length; i++)
		{
			var currentChild:MovieClip = children[i];
			if (currentChild.name == name)
			{
				return currentChild;
			}
			else
				continue;
		}
		if (!found)
			return null;
	}
	public function removeChild(name:String):Void
	{
		for (var i = 0; i < children.length; i++)
		{
			var currentChild:MovieClip = children[i];
			if (currentChild.name == name)
			{
				_mcRoot.removeMovieClip(currentChild);
			}
			else
				continue;
		}
	}
	public function reorderChild(name:String):Void
	{
		for (var i = 0; i < children.length; i++)
		{
			var currentChild:MovieClip = children[i];
			if (currentChild.name == name)
			{
				currentChild.getNextHighestDepth();
			}
			else
				continue;
		}
	}
	
	
	//{ REGION : Get/Set 
	// _____________________________________X
	public function set X(value:Number):Void
	{
		_mcRoot._x = value;
	}
	public function get X():Number
	{
		return _mcRoot._x;
	}
	// _____________________________________Y
	public function set Y(value:Number):Void
	{
		_mcRoot._y = value;
	}
	public function get Y():Number
	{
		return _mcRoot._y;
	}	
	// _____________________________________ALPHA
	public function set ALPHA(value:Number):Void
	{
		_mcRoot._alpha = value;
	}
	public function get ALPHA():Number
	{
		return _mcRoot._alpha;
	}
	// _____________________________________HEIGHT
	public function set HEIGHT(value:Number):Void
	{
		_mcRoot._height = value;
	}
	public function get HEIGHT():Number
	{
		return _mcRoot._height;
	}
	// _____________________________________WIDTH
	public function set WIDTH(value:Number):Void
	{
		_mcRoot._width = WIDTH;
	}
	public function get WIDTH():Number
	{
		return _mcRoot._width;
	}
	// _____________________________________X_SCALE
	public function set XSCALE(value:Number):Void
	{
		_mcRoot._xscale = value;
	}
	public function get XSCALE():Number
	{
		return _mcRoot._xscale;
	}
	// _____________________________________Y_SCALE
	public function set YSCALE(value:Number):Void
	{
		_mcRoot._yscale = value;
	}
	public function get YSCALE():Number
	{
		return _mcRoot._yscale;
	}
	//}
}

class simpleButton extends CryMC
{
	
}