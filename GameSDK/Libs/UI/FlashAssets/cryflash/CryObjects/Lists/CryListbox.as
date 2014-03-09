import cryflash.CryObjects.CryBaseObject;
import cryflash.CryObjects.Lists.CryListItem;
import cryflash.Events.CryEvent;
import cryflash.Delegates;

/**
 * ...
 * @author RuneRask
 */
class cryflash.CryObjects.Lists.CryListbox extends cryflash.CryObjects.CryBaseObject
{
	//{ REGION : Private Variables:
	private var numberOfLines		:Number;
	private var numDisp				:Number;
	private var linesSet			:Boolean;
	// Navigation Counters:
	private var displayCounter		:Number;
	private var SuperCounter		:Number;
	private var index				:Number;
	// Item Arrays:
	private var currentItems		:Array;
	private var allItems			:Array;
	// VARIOUS CONTROL:
	private var _LISTOBJ			:String;
	private var _LISTOBJFIELD		:String;
	private var _LISTOBJHB			:String;
	private var listX				:Number;
	private var listY				:Number;
	private var MAXHEIGHT			:Number;
	// MovieClip Dependencies
	private var UpArrow				:MovieClip;	//Down Arrow.
	private var DownArrow			:MovieClip;	//Up Arrow.
	private var scroller			:MovieClip;
	private var scrollBar			:MovieClip;
	private var CaptionText			:TextField;	//Caption Text.
	private var tooltipHolder		:TextField;
	//}
	
	public var SELECTED				:CryListItem;// Currently highlighted item.
	
	
	private var FADEMASK:MovieClip;
	private var LISTHOLDER:MovieClip;
	private var LISTENER:Object;
	
	
	//{ REGION : Constructor:
	/**
	 * CryListBox - Simple barebones ListBox.<br>
	 * @param	$id 	- ID of the Listbox (must be Unique).<br>
	 * @param	$libobj - Library Object Reference to use for this Object.<br>
	 * @param	$parent - Parent MovieClip of this Object.<br>
	 */
	public function CryListbox($id:String, $libobj:String, $parent:MovieClip) 
	{
		super($id, $libobj, $parent);
	
		displayCounter 	= 0;
		SuperCounter	= 0;
		index			= 0;
		currentItems	= new Array();
		allItems		= new Array();
		
		numberOfLines	= 0;
		numDisp			= 0;
		linesSet		= false;
		SCROLLER		= true;
		INSTANT			= false;
		listX 			= 0;
		listY 			= 0;
		SELECTABLE 		= true;
		
		LISTENER = new Object();
		LISTENER.onMouseWheel = Delegates.create(this, onWheel);
		Mouse.addListener(LISTENER);
		
	}
	//}
	
	//{ REGION : Listbox Definition methods:
	/**
	 * Define the ListBox elements.
	 * @param	upArrow 	- Reference string to a upArrow Button.
	 * @param	downArrow 	- Reference string to a downArrow Button.
	 */
	public function defineListbox(upArrow:String, downArrow:String):Void
	{
		UpArrow		= _CHILD[upArrow];
		DownArrow 	= _CHILD[downArrow];
		
		// Custom hack:
		
		FADEMASK 					= _CHILD["fadeMask"];
		LISTHOLDER 					= _CHILD["listHolder"];
		
		
		LISTHOLDER.cacheAsBitmap 	= true;
		FADEMASK.cacheAsBitmap 		= true;
		LISTHOLDER.setMask(FADEMASK);
		
		//
		createHandlers();
	}
	public function getCurrent():String 
	{
		if (SELECTED != undefined)
		{
			return SELECTED.getCaption();
		}
		else {
			return "ERROR";
		}
	}
	/**
	 * Add a Title to the ListBox 
	 * @param	titleID - Reference String to the Title Textfield.
	 * @param	text 	- The value of the title.
	 */
	public function addTitle(titleID:String, text:String):Void
	{
		CaptionText 		= _CHILD[titleID];
		CaptionText.text 	= text;
	}
	public function addScroller(scrollerID:String, scrollBarID:String):Void
	{
		scroller 	= _CHILD[scrollerID]; 
		scrollBar 	= _CHILD[scrollBarID];
	}
	/**
	 * DefineListItem - Defines what item to use for the ListBox.
	 * @param	item - Item Type/Class.
	 */
	public function defineListItem(item:String, itemCaptionField:String, hitbox:String ):Void
	{
		_LISTOBJ 		= item;
		_LISTOBJHB		= hitbox;
		_LISTOBJFIELD 	= itemCaptionField;
	}
	/**
	 * Set's the maxHeight of the listBox.
	 * @param	_height
	 */
	public function setMaxHeight($height:Number):Void
	{
		MAXHEIGHT = $height;
	}
	public function setTooltipRef(id:TextField):Void
	{
		tooltipHolder = id;
	}
	//}
	private function onScrollBar():Void
	{
		var scrollHit:Number = scrollBar._height - scrollBar._ymouse;
		var scrollPerc:Number = 100 - (Math.round((scrollHit / scrollBar._height) * 100));
		
		if (scrollPerc <= 1)
		{
			scrollPerc = 1;
		}
		if (scrollPerc > 100)
		{
			scrollPerc = 100;
		}
		
		////trace(scrollPerc);
		index	 	= Math.round((scrollPerc / 100) * (allItems.length - (numberOfLines / 2)));
		if (index > allItems.length - (numberOfLines / 2))
		{
			index = allItems.length- (numberOfLines / 2);
		}
		updateList(false);
	}
	
	//{ REGION : Interaction Methods:
	
	/**
	 * 	- Select (Selects current item - throwback from a listItem).
	 */
	public function select():Void
	{
		super.select();
		currentItems[0].select();
	}
	/**
	 * 	- actActivate (Activate the Listbox).
	 */
	public function actActivate():Void
	{
		ACTIVE = true;
		currentItems[0].select();
	}
	/**
	 * ActDown - Rolls down the list when activated.
	 * @param	nav the nav sceheme sending the command.
	 */
	public function actDown(nav):Void
	{
		displayCounter++;
		if (displayCounter > MAXHEIGHT - 1)
		{
			onDown();
			displayCounter = MAXHEIGHT - 1;
		}
		currentItems[displayCounter].select();
	}
	/**
	 * ActUp - Rolls up the list when activated.
	 * @param	nav the nav sceheme sending the command.
	 */
	public function actUp(nav):Void
	{
		displayCounter--;
		if (displayCounter < 0)
		{
			onUp();
			displayCounter = 0;
		}
		currentItems[displayCounter].select();
	}
	/**
	 * 	Clears the listbox completely.
	 */
	public function clearList():Void
	{
		//trace("Clearing Listbox");
		if (allItems.length > 0)
		{
			for (var i = 0; i < allItems.length; i++)
			{
				if (allItems[i] != undefined)
				{
					allItems[i].Destruct();
					allItems[i] = undefined;
				}
				
			}
			allItems.splice(0, allItems.length);
		}
		if (currentItems.length > 0)
		{
			for (var i:Number = 0; i < currentItems.length; i++)
			{
				if (currentItems[i] != undefined)
				{
					currentItems[i].Destruct();
					currentItems[i] = undefined;
				}
				
			}
			currentItems.splice(0, currentItems.length);
		}	
		displayCounter 	= 0;
		SuperCounter	= 0;
		index			= 0;
		
		currentItems	= new Array();
		allItems		= new Array();
		
		numberOfLines	= 0;
		numDisp			= 0;
		listX 			= 0;
		listY 			= 0;
		//trace("Finished Clearing Listbox");
	}
	//}	
	private function onScrollerStopDrag():Void
	{
		scroller.stopDrag();
		var scrollHit:Number = scrollBar._height - scroller._y;

		var scrollPerc:Number = 100 - (Math.round((scrollHit / scrollBar._height) * 100));
		if (scrollPerc <= 1)
		{
			scrollPerc = 1;
		}
		if (scrollPerc > 100)
		{
			scrollPerc = 100;
		}
		////trace(scrollPerc);
		index	 	= Math.round((scrollPerc / 100) * (allItems.length - (numberOfLines / 2)));
		if (index > allItems.length - (numberOfLines / 2))
		{
			index = allItems.length	- (numberOfLines / 2);
		}
		//superIndex 	= Math.round((scrollPerc / 100) * allItems.length);		
		updateList(true);
	}
	private function onScrollerStartDrag():Void
	{
		scroller.startDrag(true, scrollBar._x, scrollBar._y, scrollBar._x, (scrollBar._y + scrollBar._height - scroller._height))
	}
	//{ REGION : Internal Handlers:
	private function createHandlers():Void
	{
		super.createHandlers		();
		DownArrow.onRelease 		= Delegates.create(this, onDown); 
		UpArrow.onRelease 			= Delegates.create(this, onUp); 
		scrollBar.onRelease			= Delegates.create(this, onScrollBar);
		
		//scroller.onMouseDown		= Delegates.create(this, onScrollerStartDrag);
		//scroller.onRelease		= Delegates.create(this, onScrollerStopDrag);
	}
	
	private function updateList($scrolled:Boolean):Void
	{
		//trace("Current Index: " + index);
		var i:Number;
		if($scrolled == false)
		{
			scroller._y = scrollBar._y + ((index / 10) * scrollBar._height - scroller._height);
			if (scroller._y < scrollBar._y)
			{
				scroller._y = scrollBar._y;
			}
		}
		
		//trace("Scroller Y = " + scroller._y);
		if (allItems.length > currentItems.length && linesSet)
		{
			for (i = 0; i < numberOfLines; i++)
			{
				currentItems[i].VISIBLE		= false;
				currentItems[i] 			= allItems[i + index];
			}
			for (i = 0; i < currentItems.length; i++)
			{
				currentItems[i].VISIBLE = true;
				if (currentItems[i] == currentItems[0])
				{
					currentItems[i].Y = listY;
				}
				else
				{
					currentItems[i].Y = currentItems[i - 1].Y + currentItems[i].HEIGHT;
				}
			}
		}	
		else
		{
			return;
		}
		
	}
	//}
	
	//{ REGION : Event Handlers:
	/**
	 *  - onItem - eventListener for when u click a listboxItem. - a pseudo bubble solution.
	 * @param	e - the event object. contains a reference to the item.
	 */
	private function onItem(e:CryEvent):Void
	{
		if (SELECTED != undefined)
		{
			SELECTED.deselect();
		}		
		SELECTED = e.target;
		dispatchEvent(new CryEvent(CryEvent.ON_RELEASE, e.target));
	}
	/**
	 * 	onUp - goes up the list (if activated).
	 */
	private function onUp():Void
	{
		index--;
		if (index < 0)
		{
			index = 0;
		}
		updateList(false);
	}
	/**
	 *  onDown - goes down the list (if activated).
	 */
	private function onDown():Void
	{
		index++;
		if (linesSet)
		{
			if (index > allItems.length - (numberOfLines / 2))
			{
				index = allItems.length- (numberOfLines / 2);
			}
		}
		else
		{
			index--;
		}		
		updateList(false);
	}
	//}
	
	//{ Public Methods for list handling:
	
	/**
	 * public method to add a item to the listBox. - listObject needs to be defined.
	 * @param	$id 		- local ID of the ListItem
	 * @param	$caption 	- Caption of the ListItem.
	 * @param	$tooltip 	- Tooltip of the ListItem.
	 */
	public function addItem($caption:String, $tooltip:String, $ID:String):Void
	{
		var newID = allItems.length + 1;
		if ($ID != undefined)
		{
			newID = $ID;
		}		
		var newItem:CryListItem = new CryListItem(newID, _LISTOBJ, LISTHOLDER, this); 
		if (newItem.needsDefine)
		{
			newItem.addHitbox(_LISTOBJHB);
			newItem.addCaption(_LISTOBJFIELD, $caption);
			newItem.createHandlers();		
			newItem.addTooltip(tooltipHolder, $caption);
		}
		else
		{
			newItem.setCaption($caption);
		}
		newItem.X = listX;
		if (allItems.length > 0)
		{			
			newItem.Y = (allItems[numDisp-1].Y + allItems[numDisp-1].HEIGHT);
			numDisp++
			if (currentItems.length > MAXHEIGHT)
			{
				newItem.VISIBLE = false;
				allItems.push(newItem);
				if (linesSet == false)
				{
					numberOfLines = currentItems.length;
					linesSet = true;
				}
			}
			else
			{
				allItems.push(newItem);
				currentItems.push(newItem);
			}
		}
		else
		{
			newItem.Y = listY;
			currentItems.push(newItem);
			allItems.push(newItem);
			numDisp++;
		}		
		newItem.addEventListener(CryEvent.ON_RELEASE, this, "onItem");
	}
	
	private function onWheel(delta):Void
	{
		if (delta > 0)
		{
			onUp();
		}
		else if (delta < 0)
		{
			onDown();
		}
	}
	//}
	
}