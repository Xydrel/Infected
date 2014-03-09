
/**
 * ...
 * @author RuneRask
 * 
 * CrySprite is the most basic object used in CryFlash.
 * It works to simulate basic display list functionality (though it does not actually have a display list).
 * Features include:
	 * Event Dispatching. 				- you can add, remove and listen for events on all CrySprites and children of the CrySprite.
	 * Single Containment				- add any type of Flash IDE object to the CrySprite (textfields/movieclips/buttons).
	 * Simple parenting 				- Use any other CrySprite objects to define the parent of any CrySprite object.
	 * Simple manipulation.				- change most common parameters of the object (scale/position/alpha ect).
	 * Deep reaching manipulation		- classes extending CrySprite can take advantage of the _ROOT / _CHILD objects to get acces to all normal movieclip parameters.
 * 
 * 	 - CrySprite does NOT:
	 * create a real displayList - Everything basically is just a isolated hirachy system - and a very linear one.
	 * things like addChild / RemoveChild is currently not supported.
	 * Most of the normal limitations of AS2 still exists and this system mostly elleviates scope/event handling.
 **/
import cryflash.Events.CryDispatcher;
import cryflash.Events.CryEvent;

class cryflash.CrySprite extends cryflash.Events.CryDispatcher
{
	//{ REGION : Public Variables								:
	public 	var _ID				:String;
	//}
	
	//{ REGION : Private Variables								:
	private var _Xpos			:Number;
	private var _Ypos			:Number;
	private var _ALPHAs			:Number;
	private var _HEIGHTN		:Number;
	private var _WIDTHN			:Number;
	private var VISIBLES		:Boolean;	
	private var _ROOT			:MovieClip;
	private var _$PRIVATELIST	:Array; // TODO.
	private var _PARENT			:MovieClip;
	private var _CHILD			:MovieClip;
	//}
	
	//{ REGION : BETA DisplayList 29/05/2013
	private var outerChildren:Array;
	//}
	
	//{ REGION : CONSTRUCTOR									:
	/** CrySprite is the base object of all CryObjects.
	* @param $id		ID of the Object
	* @param $parent	Parent MovieClip (Container for this object).
	**/
	public function CrySprite($id:String, $parent:MovieClip) 
	{
		super();
		if ($parent == undefined)
		{
			trace(cryflash.CryErrors.PARENT_MISSING);
		}
		_ID 			= $id;	
		_PARENT			= $parent;
		_Xpos			= 0;
		_Ypos			= 0;
		_ALPHAs			= 100;
		_HEIGHTN		= 0;
		_WIDTHN			= 0;
		VISIBLES		= true;
		if (_PARENT)
		{
			_ROOT 		= _PARENT.createEmptyMovieClip("CrySprite[" + _ID + "]", _PARENT.getNextHighestDepth());
		}
		outerChildren = new Array();
	}
	//}
	
	//{ REGION : BETA
	/**
	 *  BETA - Simplified displayList - // WIP.
	 * @param	object
	 */
	public function addChild(object:CrySprite):Void
	{
		outerChildren.push(object);
		object.PARENT = this.PARENT;
	}
	/**
	 *  BETA - Simplified displayList - // WIP.
	 * @param	id
	 */
	public function removeChild(id:String):Void
	{
		if (outerChildren.length > 0)
		{
			for (var i = 0; i < outerChildren.length; i++)
			{
				if (outerChildren[i]._ID == id)
				{
					outerChildren[i].Destruct();
					outerChildren.pop(outerChildren[i]);
					trace("Successfully removed item");
					return;
				}
				else
				{
					continue;
				}
			}
		}
	}
	//}
	
	//{ REGION : Initialize methods								:	
	/** Attaches a Library Object as the CHILD of the CrySprite.
	*	@param $name		Name of library item to attach.
	**/
	public function attachLibObject($name:String):Void
	{
		if (_ROOT)// If we have a root object add the object here.
		{
			_CHILD 		= _ROOT.attachMovie($name, "CrySprite[" + _ID + "]FIRSTBORN", _ROOT.getNextHighestDepth());
			_WIDTHN 	= _CHILD._width;
			_HEIGHTN 	= _CHILD._height;
		}	
		else
		{
			trace("[CryFlash] Error : No Root available for this object.");
		}
	}
	/**
	 * 	Desctruct the object, and makes it available for garbage collection.
	 */
	public function Destruct():Void
	{
		removeAllEventListeners(CryEvent.ON_ACTION);
		removeAllEventListeners(CryEvent.ON_RELEASE);
		removeAllEventListeners(CryEvent.ON_ROLLOUT);
		removeAllEventListeners(CryEvent.ON_ROLLOVER);
		
		if (_CHILD)
		{
			removeMovieClip(_CHILD);
		}
		if (_ROOT)
		{
			removeMovieClip(_ROOT);
		}		
		delete this;
	}
	//}
	
	//{ REGION : Getters and Setters for base child operations 	:
	public function set X($x:Number):Void
	{
		_Xpos 		= $x;
		_ROOT._x 	= _Xpos;
	}
	public function get X():Number
	{
		return _Xpos;
	}	
	public function set Y($y:Number):Void
	{
		_Ypos 		= $y;
		_ROOT._y 	= _Ypos;
	}
	public function get Y():Number
	{
		return _Ypos;
	}
	public function set ALPHA($alpha:Number):Void
	{
		_ALPHAs 		= $alpha;
		_ROOT._alpha 	= _ALPHAs;
	}
	public function get ALPHA():Number
	{
		return _ALPHAs;
	}
	public function set PARENT($parent:MovieClip):Void
	{
		_PARENT = $parent;
	}
	public function get PARENT():MovieClip
	{
		if (_PARENT)
		{
			return _PARENT;
		}
		else
		{
			//trace("[ERROR]: " + this + " Does not have a parent");
		}
	}
	public function set HEIGHT($height:Number):Void
	{
		_HEIGHTN 		= $height;
		_ROOT._height 	= _HEIGHTN;
	}
	public function get HEIGHT():Number
	{
		return _HEIGHTN;
	}
	public function set WIDTH($width:Number):Void
	{
		_WIDTHN 		= $width;
		_ROOT._width 	= _WIDTHN;
	}
	public function get WIDTH():Number
	{
		return _WIDTHN;
	}
	public function set VISIBLE($visible:Boolean):Void
	{
		VISIBLES = $visible;
		_CHILD._visible = VISIBLES;
	}
	public function get VISIBLE():Boolean
	{
		return VISIBLES;
	}
	//}
	
}