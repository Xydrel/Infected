import cryflash.Core.CryConsoleDisplay;
import cryflash.CryObjects.CryBaseObject;
import cryflash.CryRegistry;
import cryflash.Delegates;
/**
 * ...
 * @author RuneRask
 */
class cryflash.Core.CryConsoleNav
{
	
	//{ Navigation Helpers:
	private var curObj			:CryBaseObject;
	private var curIndex		:Number;
	private var curColumn		:Array;
	private var displayer		:CryConsoleDisplay;
	
	
	private var LISTENERA:Object;
	//}
	
	//{ REGION : Navigation Direction Variables:
	private static var Left		:String = "left";
	private static var Right	:String = "right";
	private static var Up		:String = "up";
	private static var Down		:String = "down";
	private static var Action	:String = "action";
	private static var BackAct	:String = "back";
	private static var ApplyAct	:String = "apply";
	private static var ResetAct	:String = "reset";
	//}
	
	//{ REGION : Constructor:
	/**
	 * Constructor for the console nav<br>
	 * System is pretty hardcoded / non-generic, - hard to extend, modify this file or create your own system.<br>
	 * @param	Display - A reference to a Active CryConsoleDisplay (to update current info ect).<br>
	 */
	public function CryConsoleNav(Display:CryConsoleDisplay) 
	{
		curColumn				= 	new Array();
		curColumn				= 	CryRegistry.leftObjects;
		curIndex				= 	0;
		displayer 				= 	Display;
		
		LISTENERA 				= 	new Object();
		LISTENERA.onMouseWheel 	=	Delegates.create(this, onWheel);
		Mouse.addListener(LISTENERA);
	}
	//}
	
	//{ REGION : Navigation:
	/**
	 * Navigates the focus navigation system - not parralell.
	 * System is pretty hardcoded / non-generic, - hard to extend, modify this file or create your own system.
	 * 
	 * @param	$Direction The direction to navigate. For the basic system left, right, up and down i supported - however it's limited by target.
	 */
	
	 public function Navigate($Direction:String):Void
	{
		trace("- Navigate in : " + $Direction);
		var leftColumn		:Array 	= CryRegistry.leftObjects;
		var middleColumn	:Array 	= CryRegistry.middleObjects;
		var rightColumn		:Array 	= CryRegistry.rightObjects;
		
		var i:Number;
		if ($Direction == Left)
		{
			if (curObj.ACTIVE == true)
			{
				curObj.actLeft(this);
			}
			else
			{
				if (curColumn == leftColumn)
				{
					return;
				}
				if (curColumn == middleColumn)
				{
					// Move to left Column.
					if (leftColumn.length > 0)
					{
						for (i = 0; i < leftColumn.length; i++)
						{
							if (leftColumn[i].SELECTABLE == true)
							{
								if(curObj)
									curObj.deselect();
								curObj = leftColumn[i];
								if (curObj.select)
								{
									curObj.select();
								}
								
								curColumn = leftColumn;
								return;
							}
							if (curObj.SCROLLER == true)
							{
								curObj.actUp();
								return;
							}
							if (curObj.ISMANIP)
							{
								if (curObj.ISMANIP == true)
								{
									curObj.actActivate();
								}
							}
						}
						return;
					}
					else
					{
						return;
					}
				}
				if (curColumn == rightColumn)
				{
					// Move to middle Column.
					if (middleColumn.length > 0)
					{
						for (i = 0; i < middleColumn.length; i++)
						{
							if (middleColumn[i].SELECTABLE == true)
							{
								if(curObj)
									curObj.deselect();
								curObj = middleColumn[i];
								if (curObj.select)
								{
									curObj.select();
								}
								
								curColumn = middleColumn;
								return;
							}
							if (curObj.SCROLLER == true)
							{
								curObj.actUp();
								return;
							}
							if (curObj.ISMANIP)
							{
								if (curObj.ISMANIP == true)
								{
									curObj.actActivate();
								}
							}
						}
						return;
					}
					else
					{
						return;
					}
				}
			}
		}
		if ($Direction == Right)
		{
			if (curObj.ACTIVE == true)
			{
				curObj.actRight(this);
			}
			else
			{				
				if (curColumn == leftColumn)
				{
					// Move to middle Column;
					if (middleColumn.length > 0)
					{
						for (i = 0; i < middleColumn.length; i++)
						{
							if (middleColumn[i].SELECTABLE == true)
							{
								if(curObj)
									curObj.deselect();
								curObj = middleColumn[i];
								if (curObj.select)
								{
									curObj.select();
								}								
								curColumn = middleColumn;
								return;
							}
							if (curObj.SCROLLER == true)
						{
							curObj.actUp();
							return;
						}
						if (curObj.ISMANIP)
						{
							if (curObj.ISMANIP == true)
							{
								curObj.actActivate();
							}
						}
						}
						return;
					}
				}
				if (curColumn == middleColumn)
				{
					// Move to right Column.
					if (rightColumn.length > 0)
					{
						for (i = 0; i < rightColumn.length; i++)
						{
							if (rightColumn[i].SELECTABLE == true)
							{
								if(curObj)
									curObj.deselect();
								curObj = rightColumn[i];
								if (curObj.select)
								{
									curObj.select();
								}
								
								curColumn = rightColumn;
								return;
							}
							if (curObj.SCROLLER == true)
						{
							curObj.actUp();
							return;
						}
						if (curObj.ISMANIP)
						{
							if (curObj.ISMANIP == true)
							{
								curObj.actActivate();
							}
						}
						}
						return;
					}
				}
				if (curColumn == rightColumn)
				{
					return;
				}
			}
		}
		if ($Direction == Up)
		{
			if (curObj.ACTIVE == true)
			{
				curObj.actUp(this);
				return;
			}
			else
			{
				// Move up in 	CurrentColumn.
				curIndex--;
				if (curIndex < 0)
				{
					curIndex = curColumn.length;
				}
				if (curColumn.length > 0)
				{
					if (curColumn[curIndex].SELECTABLE == true)
					{
						if(curObj)
							curObj.deselect();;
						curObj = curColumn[curIndex];
						if (curObj.select)
						{
							curObj.select();
						}
						if (curObj.Y < 0)
							{
								moveUp();
								moveUp();
								moveUp();
							}
						if (curObj.SCROLLER == true)
						{
							curObj.actUp();
							return;
						}
						if (curObj.ISMANIP)
						{
							if (curObj.ISMANIP == true)
							{
								curObj.actActivate();
							}
						}
					}
					else
					{
						Navigate(Up);
					}
				}
				else
				{
					return;
				}
			}
		}
		if ($Direction == Down)
		{
			if (curObj.ACTIVE == true)
			{
				curObj.actDown(this);
			}
			else
			{
				// Move down in Current Column.
				curIndex++;
				if (curIndex > curColumn.length)
				{
					curIndex = 0;
				}
				if (curColumn.length > 0)
				{
					if (curColumn[curIndex].SELECTABLE == true)
					{
						if(curObj)
							curObj.deselect();
							curObj = curColumn[curIndex];
							if (curObj.select)
							{
								curObj.select();
							}
							if (curObj.Y > 450)
							{
								moveDown();
								moveDown();
								moveDown();
							}
						if (curObj.SCROLLER == true)
						{
							curObj.actUp();
							return;
						}
						if (curObj.ISMANIP)
						{
							if (curObj.ISMANIP == true)
							{
								curObj.actActivate();
							}
						}
					}
					else
					{
						Navigate(Down);
					}
				}
				else
				{
					return;
				}	
			}	
			
		}
		if ($Direction == Action)
		{
			if (curObj.ACTIVE == true)
			{
				curObj.actAct(this);
				return;
			}
			else if (curObj.SELECTABLE == true)
			{
				if (curObj.INSTANT == true)
				{
					curObj.actAct(this);
					return;
				}
				//trace("Was not selected, selecting now!");
				curObj.actActivate();
				return;
			}			
		}
		if ($Direction == BackAct)
		{
			if (curObj.ACTIVE == true)
			{
				curObj.ACTIVE = false;
				//fscommand("onSimpleButton", displayer.BackAction);
				return;
			}
			else
			{
				fscommand("onSimpleButton", displayer.BackAction);
				return;
			}
		}
		if ($Direction == ApplyAct)
		{
			//trace(displayer.ApplyAction);
			fscommand("onSimpleButton", displayer.ApplyAction);
			return;
		}
		if ($Direction == ResetAct)
		{
			//trace(displayer.ResetAction);
			fscommand("onSimpleButton", displayer.ResetAction);
			return;
		}
	}
	/**
	 *  Completely resets the nav system.\
	 * 	Enforced by state/screen swithhing.
	 */
	public function Reset():Void
	{
		////trace("Trying to reset");
		var leftColumn		:Array 	= cryflash.CryRegistry.leftObjects;
		var middleColumn	:Array 	= cryflash.CryRegistry.middleObjects;
		var rightColumn		:Array 	= cryflash.CryRegistry.rightObjects;
		var i:Number;
		
		if (leftColumn.length > 0)
		{
			////trace("Column isnt empty");
			for (i = 0; i < leftColumn.length; i++)
			{
				////trace(leftColumn[i] + "Status is: " + leftColumn[i].SELECTABLE);
				if (leftColumn[i].SELECTABLE == true)
				{
					if(curObj)
						curObj.deselect();					
					if (curObj.select)
					{
						curObj.select();
					}
					curObj 		= leftColumn[i];
					curColumn 	= leftColumn;
					if (curObj.SCROLLER == true)
					{
						curObj.actActivate();
					}
					if (curObj.ISMANIP)
						{
							if (curObj.ISMANIP == true)
							{
								curObj.actActivate();
							}
						}
					return;
				}
			}
			////trace("But no items is valid");
			return;
		}
		if (middleColumn.length > 0)
		{
			////trace("Column isnt empty");
			for (i = 0; i < middleColumn.length; i++)
			{
				////trace(middleColumn[i] + "Status is: " + middleColumn[i].SELECTABLE);
				if (middleColumn[i].SELECTABLE == true)
				{
					if(curObj)
						curObj.deselect();
					curObj 		= middleColumn[i];
					if (curObj.select)
					{
						curObj.select();
					}
					curColumn 	= middleColumn;
					if (curObj.SCROLLER == true)
					{
						curObj.actActivate();
					}
					if (curObj.ISMANIP)
						{
							if (curObj.ISMANIP == true)
							{
								curObj.actActivate();
							}
						}
					return;
					
				}
			}
			////trace("But no items is valid");
			return;
			
		}
		if (rightColumn.length > 0)
		{
			////trace("Column isnt empty");
			for (i = 0; i < rightColumn.length; i++)
			{
				////trace(rightColumn[i] + "Status is: " + rightColumn[i].SELECTABLE);
				if (rightColumn[i].SELECTABLE == true)
				{
					if(curObj)
						curObj.deselect();
					curObj = rightColumn[i];
					if (curObj.select)
					{
						curObj.select();
					}
					curColumn = rightColumn;
					if (curObj.SCROLLER == true)
					{
						curObj.actActivate();
					}
					if (curObj.ISMANIP)
						{
							if (curObj.ISMANIP == true)
							{
								curObj.actActivate();
							}
						}
					return;
				}
			}
			////trace("But no items is valid");
			return;
			
		}
	}
	/**
	 *  Clears the selection. - Usefull for when switching screens, and or when switching between mouse/controller on pc.
	 */
	public function Clear():Void
	{
		if (curObj.SELECTABLE == true)
		{
			if(curObj)
				curObj.deselect();
		}
	}
	//}
	private function onWheel(delta):Void
	{
		//trace("Called and delta is:" + delta);
		if (delta > 0)
		{
			moveUp();
		}
		else if (delta < 0)
		{
			moveDown();
		}
	}
	private function moveDown():Void
	{
		if (curColumn[curColumn.length -1].Y < 450)
		{
			return;
		}
		for (var i = 0; i < curColumn.length; i++)
		{
			curColumn[i].Y -= 10;
		}
	}
	private function moveUp():Void
	{
		if (curColumn[0].Y > 50)
		{
			return;
		}
		for (var i = 0; i < curColumn.length; i++)
		{
			curColumn[i].Y += 10;
		}
	}
	
}