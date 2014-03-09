/**
 * ...
 * @author RuneRask
 * 
 *  Class for adding additional functinality for scoping issues in AS2.
 * 	Enables you to delegate a function with several paremeters to stay 
 *  within the scope of the document it is used in.
 */


class cryflash.Delegates
{
	/**
	 * Creates a delegate for the object(scope) and defines a reference function. 
	 * @param	target 	The object that the function should delegate back to.
	 * @param	method	The Function to be called.
	 * @return			returns the modified function.
	 */
	public static function create(target:Object, method:Function):Function
    {
        var _arguments:Array = arguments.slice(2);
        var _function:Function = function():Void
        {
            var _newArguments:Array = arguments.concat(_arguments);
            method.apply(target, _newArguments);
			
        };
        return _function;
    }

}
/* Usage 
 * 
 *  Using Delegates this way, basically just makes scope issues non-existing(well almost) within class types(It still does not provide a true event or callback, only a reference).
 * 
 *  example:
	 * class myClass extends MovieClip
	 * {
	 * 	private var myObject = MovieClip;
	 * 
	 * 	public function myClass()
	 * 	{	
	 * 		myObject = new MoviwClip();
	 * 		myObject.onRelease = Delegates.create(this, callback);
	 * 	}
	 * 	private function callback():Void
	 * 	{
	 * 		//trace("myObject clicked!");
	 * 	}
	 * 	
	 * }
	 *
	 *
 * 
 * 
 * 
 * */