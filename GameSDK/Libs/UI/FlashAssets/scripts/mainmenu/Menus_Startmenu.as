import org.flashdevelop.utils.TraceLevel;
import scripts.mainmenu.RelocateImage;

_global.gfxExtensions = true;
import caurina.transitions.Tweener;				// Import Tweener Class

var m_zDepthsText = 200;
var m_zDepthsTextOver = -500;
var m_zDepthsArt = 500;
var m_zDepthsImages = -200;

var m_data:Array = new Array();
var m_buttonArray:Array = new Array();
var m_navigationInputArray:Array = new Array();
var m_scrollAbleButtonArray:Array = new Array();
var m_ImageArray:Array = new Array();
var m_Relocators:Array = new Array();
var m_Listboxes:Array = new Array();
var m_ListboxCount:Number = 0;
var m_ImageCount:Number = 0;
var m_curHighlight:Number = -1;
var m_buttonCount:Number = 0;
var Tooltip:String = "";
var Title:String = "";
var TopRightCaption = "";		// Text in the top right

var m_scrollableTop:Number = 0;
var m_scrollable:Boolean = false;

var m_hasButtonGroup:Boolean = false;

var m_expandableButtonPopUp:MovieClip;
var m_lastButtonArray:Array = new Array();
var m_lastHighlight:Number = -1;

var m_buttonAlignment:Number = 0;	// 0: Center, 1: Below, 2: Above
var m_buttonsXPos:Number = -500;
var m_buttonsYPos:Number = -0;
var m_buttonsChange:Number = 40;
var m_maxButtons:Number = 0;
var m_showLine:Boolean = true;
var SavingMessage:String = "@menu_savingmessage_saving_content_dont_turn_console_off";
var m_CurrTextField:Object = null;

var m_platform:String;	// XBox, PS3, pc
var enable3Di:Boolean = true;

Root.SaveProgress._visible = false;			
Root.PadButtonsDisplay._visible = false;			
Particles._visible = false;
Root.HeaderTextfield._z = 500;
Root.PadButtonsDisplay._z = 500;
Root.ToolTipTextfield._z = 500;
light_bg._z = 2;
RSSFeed._visible = false; 

var audioChannel:Number = 1

var m_consoleButtons:Array = new Array();
m_consoleButtons[0] = _root.Root.PadButtonsDisplay.Button1;
m_consoleButtons[1] = _root.Root.PadButtonsDisplay.Button2;
m_consoleButtons[2] = _root.Root.PadButtonsDisplay.Button3;
m_consoleButtons[3] = _root.Root.PadButtonsDisplay.Button4;
m_consoleButtons[4] = _root.Root.PadButtonsDisplay.Button5;
m_consoleButtons[5] = _root.Root.PadButtonsDisplay.Button6;
var m_currConsoleButtonIndex = 0;

var	m_bAllowControllerAction = false;
var m_bAllowControllerBack = false;
var m_bAllowControllerReset = false;
var m_bAllowControllerApply = false;

var m_ControllerActionAction = "---";
var m_ControllerBackAction = "---";
var m_ControllerResetAction = "---";
var m_ControllerApplyAction = "---";

Root.PCInvite.Background.onRelease = function() { fscommand("gotoFriendsMenu",""); }

Root.tabEnabled = false;

//------------------------------------------------------------------------
// PC Button Positions		(PC buttons use these values to place themselves along the bottom of the screen - Benjo)
//------------------------------------------------------------------------
var PCButtons_Y = 300;	// Share the same Y

// Quit/Back
var PCButton_LeftX:Number = -490;
var PCButton_LeftY:Number = PCButtons_Y;

// Apply
var PCButton_RightX:Number = 350;
var PCButton_RightY:Number = PCButtons_Y;

// 1 Middle Buttons
var PCButton_MiddleX:Number = -80;
var PCButton_MiddleY:Number = PCButtons_Y;

// 2 Middle Buttons
var PCButton_MiddleLeftX:Number = -180;
var PCButton_MiddleLeftY:Number = PCButtons_Y;
var PCButton_MiddleRightX:Number = 30;
var PCButton_MiddleRightY:Number = PCButtons_Y;



// Matches enum EControlScheme
var CONTROL_SCHEME_NOT_SPECIFIED:Number		= 0;
var CONTROL_SCHEME_KEYBOARD:Number				= 1;
var CONTROL_SCHEME_KEYBOARD_MOUSE:Number	= 2;
var CONTROL_SCHEME_XBOX_CONTROLLER:Number = 3;
var CONTROL_SCHEME_PS3_CONTROLLER:Number	= 4;
var m_controlScheme:Number = CONTROL_SCHEME_NOT_SPECIFIED;

IsConsoleControlScheme = function()
{
	return (m_controlScheme==CONTROL_SCHEME_XBOX_CONTROLLER || m_controlScheme==CONTROL_SCHEME_PS3_CONTROLLER);
}

IsPCControlScheme = function()
{
	return (m_controlScheme==CONTROL_SCHEME_KEYBOARD || m_controlScheme==CONTROL_SCHEME_KEYBOARD_MOUSE);
}

IsMouseControlScheme = function()
{
	return (m_controlScheme==CONTROL_SCHEME_KEYBOARD_MOUSE);
}

ControlSchemeChanged = function(controlScheme:Number)
{
	m_controlScheme = controlScheme;

	if (Root.SubScreenCurrent.ControlSchemeChanged)
	{
		Root.SubScreenCurrent.ControlSchemeChanged(controlScheme);
	}
}
var m_processMouseEvents:Boolean = true
ShouldProcessMouse = function()
{
	// Since mouse cursor is manually controlled, ignore it if not using cursor
	// Otherwise can trigger onrollover even if not moving mouse
	// No easy way to disable handling in AS2, so onRollOver functions should use this

	return m_processMouseEvents;
}

//////////////////////////////////////////////////////////////////////
// SubScreen Preloading Start
//////////////////////////////////////////////////////////////////////
var m_subScreens:Array = new Array();

preloadSubScreen = function(filePath:String)
{
	var numSubScreens:Number = m_subScreens.length;
	var subScreen:MovieClip = Root["SubScreen"+numSubScreens.toString()];
	if(subScreen != undefined)
	{
		var obj:Object = new Object();
		obj.path = filePath;
		obj.movie = subScreen;
		subScreen.loadMovie(filePath);
		subScreen._visible = false;
		m_subScreens.push(obj);
	}
	else
	{
		trace("Trying to preloadSubScreen '"+filePath+"' ("+numSubScreens+") but no more SubScreen instances available. Increase the number of SubScreen instances in menus_startmenu.gfx.");
	}
}

unloadAllSubScreens = function()
{
	for(var i:Number=0; i<m_subScreens.length; ++i)
	{
		m_subScreens[i].movie.unloadMovie();
	}
	m_subScreens.splice(0);
}
//////////////////////////////////////////////////////////////////////
// SubScreen Preloading End
//////////////////////////////////////////////////////////////////////

showParticles = function (Value:Boolean)
{
	Particles._visible = Value;
}



//      _/_/_/    _/_/_/    _/   
//           _/  _/    _/        
//      _/_/    _/    _/  _/     
//         _/  _/    _/  _/      
//  _/_/_/    _/_/_/    _/       
//
//	Extention by Karsten Klewer
//  added on 05/17/2010

var transitionType:String = "easeOutCirc";
var transitionTime:Number = 0.25;

var ox:Number = 0;
var oy:Number = 0;
var orx:Number = 0;
var ory:Number = 0;
var mouseListener:Object = new Object;

function Init3DMenu()
{
	if(enable3Di == true)
	{
		Root._z = 0;
		Root.HUDElement._z = 500;
		Root.CrynetSystemsLogo._z = 500;
		Root.ButtonAnim.ButtonContainer._yrotation = -10;
	}	
	if(m_platform != "pc")
	{
		MyMouseCursor._visible = false;
	}
	else
	{
		Mouse.hide(); 
	}
}
Init3DMenu();

mouseListener.onMouseMove = function() 
{
	XMousePos = _root._xmouse - Stage.width / 2;
	YMousePos = _root._ymouse - Stage.height / 2;
	
	//if(m_platform == "pc")
	{
		MyMouseCursor._x = _xmouse;
		MyMouseCursor._y = _ymouse;
		//if(_root.enable3Di == true)
		{
			Root._yrotation = XMousePos / 150;
			Root._xrotation = -YMousePos / 120;	
			background._yrotation = XMousePos / 150;
			background._xrotation = -YMousePos / 120;	
			Particles._yrotation = XMousePos / 150;
			Particles._xrotation = -YMousePos / 120;	
		}
	}
}
Mouse.addListener(mouseListener);

consoleScreenRotationX = function(xValue:Number)
{
	if(_root.enable3Di == true /*&& m_platform != "pc"*/)
	{
		Root._yrotation = -xValue / 150;
		background._yrotation = -xValue / 150;
		Particles._yrotation = -xValue / 150;
	}
}
consoleScreenRotationY = function(yValue:Number)
{
	if(_root.enable3Di == true /*&& m_platform != "pc"*/)
	{
		Root._xrotation = -yValue / 120;	
		background._xrotation = -yValue / 120;	
		Particles._xrotation = -yValue / 120;	
	}
}


	
mouseListener.onMouseDown = function() 
{
	MouseFireAnimation();
}


fadeMenuOut = function()
{
	Tweener.addTween(Root, {_z:6000, _alpha:30, time:1, transition:"easeOutQuart" } );
	//Tweener.addTween(RSSFeed, {_z:6000, _alpha:30, time:1, transition:_root.transitionType } );
	Tweener.addTween(background, {_z:6000, _alpha:30, time:1, transition:"easeOutQuart"  } );
	Tweener.addTween(Particles, {_z:500, time:1, transition:"easeOutQuart"  } );
	//m_processMouseEvents = false;	
}


fadeMenuIn = function ()
{
	//m_processMouseEvents = true;
	Tweener.addTween(Root, {_z:0, _alpha:100, time:1, transition:"easeOutQuart" } );
	//Tweener.addTween(RSSFeed, {_z:0, _alpha:100, time:1, transition:_root.transitionType } );
	Tweener.addTween(background, {_z:0, _alpha:100, time:1, transition:"easeOutQuart"  } );
	Tweener.addTween(Particles, {_z:0, time:1, transition:"easeOutQuart"  } );
}

MyMouseCursor.Right_Lightning._alpha = 0;
MyMouseCursor.Left_Lightning._alpha = 0;
MyMouseCursor.Top_Lightning._alpha = 0;
MyMouseCursor.Down_Lightning._alpha = 0;
	
function MouseFireAnimation()
{
	MyMouseCursor.Right_Lightning._alpha = 60;
	MyMouseCursor.Left_Lightning._alpha = 60;
	MyMouseCursor.Top_Lightning._alpha = 60;
	MyMouseCursor.Down_Lightning._alpha = 60;
 	MyMouseCursor.Right_Lightning._x = 20;
	MyMouseCursor.Left_Lightning._x = -20;
	MyMouseCursor.Top_Lightning._y = -20;
	MyMouseCursor.Down_Lightning._y = 20;
	Tweener.addTween(MyMouseCursor.Right_Lightning, {_x:600, _alpha:00, time:3, transition:"easeOutExpo"});
	Tweener.addTween(MyMouseCursor.Left_Lightning, {_x:-600, _alpha:00, time:3, transition:"easeOutExpo"});
	Tweener.addTween(MyMouseCursor.Top_Lightning, {_y:-600, _alpha:00, time:3, transition:"easeOutExpo"});
	Tweener.addTween(MyMouseCursor.Down_Lightning, {_y:600, _alpha:00, time:3, transition:"easeOutExpo"});
}


//      _/      _/                                               _/_/_/_/_/                      _/  _/   
//     _/_/  _/_/    _/_/    _/    _/    _/_/_/    _/_/             _/      _/  _/_/    _/_/_/      _/   
//    _/  _/  _/  _/    _/  _/    _/  _/_/      _/_/_/_/           _/      _/_/      _/    _/  _/  _/   
//   _/      _/  _/    _/  _/    _/      _/_/  _/                 _/      _/        _/    _/  _/  _/       
//  _/      _/    _/_/      _/_/_/  _/_/_/      _/_/_/           _/      _/          _/_/_/  _/  _/  
//                                                       
// by Karsten Klewer
//  added on 05/17/2010
var m_run = 0.0;
var m_run = 0.0;
/*
onEnterFrame = function()
{
	if(enable3Di == true)
	{
		if(m_platform != "pc")
		{
			m_run += 0.02;
			var zvar = (5.0 * Math.sin(m_run*0.5));
			var zvar2 = (5.0 * Math.sin(m_run*0.9));
			Root._yrotation = zvar2;
			Root._xrotation = -zvar
		}
	}
}
*/
function setGameMode(_gameMode:String)
{
	/*
	if(_gameMode == "singleplayer" || _gameMode == "Singleplayer")
	{
		Root.Header.C3.gotoAndStop(1);
		Root.Header.C4.gotoAndStop(2);
	}
	else
	{
		Root.Header.C3.gotoAndStop(2);
		Root.Header.C4.gotoAndStop(1);
	}
	*/
}


function CrynetSystemsConnection(_Connection:Boolean)
{
	/*
	if(_Connection)
	{
		Root.Header.C5.gotoAndStop(2);
	}
	else
	{
		Root.Header.C5.gotoAndStop(1);
	}
	*/
}

setupScreenSimple = function(_caption:String, _showLine:Boolean, _maxButtons:Number, _buttonsXPos:Number, _buttonsYPos:Number, _buttonsOffset:Number)
{
	clearButtons();
	clearImages();
	clearListboxes();
	Root.LoadingImage._visible = false;
	addScreen(_buttonsXPos, _buttonsYPos, _showLine, _maxButtons, _caption, 0, _buttonsOffset);
}

addScreen = function(_buttonsXPos:Number, _buttonsYPos:Number, _showLine:Boolean, _maxButtons:Number, _title:String, _buttonAlignment:Number, _buttonsChange:Number)
{
	Root.ButtonAnim.gotoAndPlay("intro");
	m_buttonAlignment = (_buttonAlignment==undefined) ? 0 : _buttonAlignment;
	m_buttonsXPos = _buttonsXPos;	// See CMenuData. Default in code, overriden on screen xml
	m_buttonsYPos = _buttonsYPos;

	m_maxButtons = _maxButtons;
	m_showLine = _showLine;

	if (_buttonsChange!=undefined)
		m_buttonsChange = _buttonsChange;

	Title = (_title==undefined) ? "" : _title;
	TopRightCaption = "";
	
	Root.MenuLine._visible = _showLine;
	Root.MenuLine._x = m_buttonsXPos;
	Root.ButtonAnim._x = m_buttonsXPos;
}

addButtonSimple = function(_caption:String,  _tooltip:String, _id:String)
{
	addButton(_caption, _tooltip, "onSimpleButton", _id, 0, "", "");
}

addLevelButton = function(_caption:String,  _tooltip:String, _id:String)
{
	addButton(_caption, _tooltip, "onLevelButton", _id, 0, "", "");
	
}



addButton = function(_caption:String, _tooltip:String, _action:String, _param:String, _disabled:Boolean, _highlightAction:String, _highlightParam:String)
{
	var newObj = addBaseObject("Button", _caption, _tooltip, _disabled);
	newObj.rollOverAllowed = true;
	newObj.keepHighlighted = false;	 // Previously highlighted

	newObj.actionArray = new Array();
	newObj.highlightAction = _highlightAction;
	newObj.highlightParam = _highlightParam;
	
	var actionObj:Object = new Object();
	actionObj.action = _action;
	actionObj.param = _param;

	newObj.actionArray.push(actionObj);

	newObj.onRelease = function()
	{	
		
		if(newObj.disabled != true)
		{
			var i = 0;
			var num = newObj.actionArray.length;
			for (i=0; i<num;++i)
			{
				fscommand(newObj.actionArray[i].action, newObj.actionArray[i].param);
			}
		}

	}
	newObj.DeHighLight = function()
	{
		newObj.gotoAndStop(1);
		newObj.rollOverAllowed = true;
		//trace(rollOverAllowed);
	}
	
	newObj.setHighlighted = function(_id)
	{	
		trace(_id);
		newObj.gotoAndStop(6);
		newObj.rollOverAllowed = false;
		//trace(rollOverAllowed);
		
		
	}

	
	registerControl(newObj, true);
	repositionButton();

	return newObj;
}

addListbox = function(_ObjId:String, _caption:String, _ObjX:Number, _ObjY:Number)
{
	var newListBox:MovieClip = _root.Root.attachMovie("ListBox", "ListBox"+m_ListboxCount++, _root.Root.getNextHighestDepth());

	newListBox._id = _ObjId;
	newListBox._x = _ObjX;
	newListBox._y = _ObjY;
	//Init 1 frame later
	newListBox.onEnterFrame = function()
	{
		newListBox.SetTitle(_caption);
		newListBox.Clear();
		delete newListBox.onEnterFrame;
	}
	
	newListBox.navigate = function(_where:String)
	{
		if (_where == "left")
			newListBox.SelectPrevious();
		else if (_where == "right")
			newListBox.SelectNext();
	}

	
	m_Listboxes.push(newListBox);
	trace("register listbox");
	registerControl(newListBox, true);
}

addListboxItem = function(_ObjId:String, _caption:String, _value:String)
{
	for (var i:Number = 0;  i< m_Listboxes.length; i++) 
	{
		if (m_Listboxes[i]._id == _ObjId)
		{
			m_Listboxes[i].AddItem(_caption, _value);
			return;
		}
	}
}

var listBoxCaptions = new Array();
var listBoxValues = new Array();

addListboxItems = function(_ObjId:String)
{
	for (var i:Number = 0;  i < listBoxCaptions.length; i++ )
	{
		addListboxItem(_ObjId, listBoxCaptions[i], listBoxValues[i]);
	}
}

clearListbox = function(_ObjId:String)
{
	for (var i:Number = 0;  i< m_Listboxes.length; i++) 
	{
		if (m_Listboxes[i]._id == _ObjId)
		{
			m_Listboxes[i].Clear();
			return;
		}
	}
}

hideImage = function(_id:String, _fadeOutTime:Number)
{
	var selectedImage:MovieClip = _root.ImageHolderMC[_id];
	if (selectedImage != undefined)
	{
		var Relocator:RelocateImage = new RelocateImage();
		
		//Clear and reasign relocator to make sure instances of hidden and show relocators are not ran at the same time
		//causes unwanted behaviours
		ClearRelocator(selectedImage);			
		Relocator.HideImage(selectedImage, _fadeOutTime);	
		assignRelocator(selectedImage, Relocator);
	}
}

showImage = function(_id:String, _fadeInTime:Number)
{
	var selectedImage:MovieClip = _root.ImageHolderMC[_id];
	if (selectedImage != undefined)
	{
		var Relocator:RelocateImage = new RelocateImage();
		
		ClearRelocator(selectedImage);		
		Relocator.ShowImage(selectedImage, _fadeInTime);
		assignRelocator(selectedImage, Relocator);
	}
}

//Hack: Relocators had to be stored in an array in order not to be lost
//      workaround by storing a relocator slot for each image (same indices)
function ClearRelocator(image:MovieClip)
{
	var i:Number = 0;
	for (i = 0; i < m_ImageArray.length; i++)
	{
		if (image == m_ImageArray[i])
		{
			m_Relocators[i].Clear();
		}
	}
}

//Assign a new relocator to the correct imageslot
function assignRelocator(image:MovieClip, reloc:RelocateImage)
{
	var i:Number = 0;
	for (i = 0; i < m_ImageArray.length; i++)
	{
		if (image == m_ImageArray[i])
		{
			m_Relocators[i] = reloc;
		}
	}
}

addImage = function(_path:String, _id:String, _xpos:Number, _ypos:Number, _imagewidth:Number, _imageheight:Number)
{
	if (_path != "")
	{
		//Create new movieclip and load image into it
		var new_image = _root.ImageHolderMC.attachMovie("Button", _id, _root.ImageHolderMC.getNextHighestDepth());
			new_image._visible = false;
			new_image._alpha = 0;
		loadMovie("img://" + _path, new_image);		
		
		//Hack: Setup a relocator which will resize/relocate the image after 100ms (it needs minimal 1 frame between creation and relocation)
		var Relocator:RelocateImage = new RelocateImage();
		Relocator.Setup(new_image, _xpos, _ypos, _imagewidth, _imageheight);
		
		//Add it to our list
		m_ImageCount++;
		m_ImageArray.push(new_image);
		m_Relocators.push(Relocator);
	}
}

addSelectLanguageButton = function(_caption:String, _tooltip:String, _action:String, _param:String, _disabled:Boolean, _highlightAction:String, _highlightParam:String, _controllerBtn:Number)
{
	var newObj = addBaseObject("SelectLanguageBtn", _caption, _tooltip, _disabled);

	newObj.keepHighlighted = false;	 // Previously highlighted

	newObj.actionArray = new Array();
	newObj.highlightAction = _highlightAction;
	newObj.highlightParam = _highlightParam;
		
	var actionObj:Object = new Object();
	actionObj.action = _action;
	actionObj.param = _param;

	newObj.actionArray.push(actionObj);

	newObj.onRelease = function()
	{	
		if(newObj.disabled != true)
		{
			var i = 0;
			var num = newObj.actionArray.length;
			for (i=0; i<num;++i)
			{
				fscommand(newObj.actionArray[i].action, newObj.actionArray[i].param);
			}
		}
	}
	
	
	newObj.ControllerBtnIcon.Icons.gotoAndStop(_controllerBtn);
	
	registerControl(newObj, true);
	repositionButton();

	return newObj;
}

addQuitButtonSimple = function(_caption:String,  _tooltip:String, _id:String)
{
	addQuitButton(_caption, _tooltip, "onSimpleButton", _id, 0, "", "");
}

addQuitButton = function(_caption:String, _tooltip:String, _action:String, _param:String, _disabled:Boolean, _highlightAction:String, _highlightParam:String)
{
	if (_root.m_platform == "pc")
	{
		var newObj = _root.Root.defaultButtonHolder.attachMovie("QuitButton", "QuitButton",Root.defaultButtonHolder.getNextHighestDepth());
		newObj.tabEnabled = false;
		
		newObj.actionArray = new Array();
		var actionObj:Object = new Object();
		actionObj.action = _action;
		actionObj.param = _param;
		newObj.actionArray.push(actionObj);

		newObj.Description = _caption;
		newObj._x = PCButton_LeftX;
		newObj._y = PCButton_LeftY;

		newObj.onRollOver = function()
		{
			if (ShouldProcessMouse() == false)
			{
				return;
			}
			
			fscommand("FrontEnd_Move");
			this.gotoAndStop("over");
			_root.Tooltip = _tooltip;
			
		}
		newObj.onRollOut = function()
		{
			this.gotoAndStop(1);
			_root.Tooltip = "";
		}
		newObj.onDragOver = function()
		{
			this.gotoAndStop("over");
			_root.Tooltip = _tooltip;
		}
		newObj.onDragOut = function()
		{
			this.gotoAndStop(1);
			_root.Tooltip = "";
		}
		newObj.onRelease = function()
		{
			
			this.gotoAndStop(1);
			if(newObj.disabled != true)
			{
				var i = 0;
				var num = newObj.actionArray.length;
				for (i=0; i<num;++i)
				{
					fscommand(newObj.actionArray[i].action, newObj.actionArray[i].param);
				}
			}

		}
		newObj.navigate = function(_where:String)
		{
			if (_where == "left")
				navigate("up");
			else if (_where == "right")
				navigate("down");
		}
		newObj.overButton = function()
		{
			newObj.onRollOver();
		}
		newObj.outButton = function()
		{
			newObj.onRollOut();
		}
		registerControl(newObj, false);
	}
	else if (_root.m_platform == "XBox")
	{
		addConsoleButton("X360_B", _caption);
	}
	else if (_root.m_platform == "PS3")
	{
		addConsoleButton("PS3_Circle", _caption);
	}
	m_ControllerBackAction = _param;
	m_bAllowControllerBack = true;
}

addBackButton = function(_id:String)
{
	var newObj = null;
	if (_root.m_platform == "pc")
	{
		newObj = _root.Root.defaultButtonHolder.attachMovie("PCBackBtn", "PCBackBtn",Root.defaultButtonHolder.getNextHighestDepth());
		newObj.tabEnabled = false;

		newObj._x = PCButton_LeftX;
		newObj._y = PCButton_LeftY;
		
		// Now using expanding button
		newObj.AlignRight = true;
		if (newObj.SetDescription)
		{
			newObj.SetDescription("@ui_back");
		}
		else
		{
			newObj.Description = "@ui_back";
		}

		newObj.ReleaseFunction = function()
		{
			fscommand("onSimpleButton", _id);
		}
		
		newObj.navigate = function(_where:String)
		{
			if (_where == "left")
				navigate("up");
			else if (_where == "right")
				navigate("down");
		}
		newObj.overButton = function()
		{
			newObj.onRollOver();
		}
		newObj.outButton = function()
		{
			newObj.onRollOut();
		}		
		registerControl(newObj, false);
	}
	else if (_root.m_platform == "XBox")
	{
		addConsoleButton("X360_B", "@ui_back");
	}
	else if (_root.m_platform == "PS3")
	{
		addConsoleButton("PS3_Circle", "@ui_back");
	}
	m_ControllerBackAction = _id;
	m_bAllowControllerBack = true;
	return newObj;
}

addApplyButton = function(_caption:String, _tooltip:String, _id:String)
{
	var newObj = null;
	if (_root.m_platform == "pc")
	{
		newObj = _root.Root.defaultButtonHolder.attachMovie("PCApplyBtn", "PCApplyBtn",Root.defaultButtonHolder.getNextHighestDepth());
		newObj.Description = _caption;
		newObj._x = PCButton_RightX;
		newObj._y =	PCButton_RightY;
		newObj.tabEnabled = false;

		newObj.onRollOver = function()
		{
			if (ShouldProcessMouse() == false)
			{
				return;
			}
			_root.Tooltip = _tooltip;
			fscommand("FrontEnd_Move");
			this.gotoAndStop("over");
		}
		newObj.onRollOut = function()
		{
			_root.Tooltip = "";
			this.gotoAndStop("out");
		}
		newObj.onDragOver = function()
		{
			_root.Tooltip = _tooltip;
			this.gotoAndStop("over");
		}
		newObj.onDragOut = function()
		{
			_root.Tooltip = "";
			this.gotoAndStop("out");
		}
		newObj.onRelease = function()
		{
			this.gotoAndStop("down");
			fscommand("onSimpleButton", _id);
		}

		newObj.navigate = function(_where:String)
		{
			if (_where == "left")
				navigate("up");
			else if (_where == "right")
				navigate("down");
		}
		newObj.overButton = function()
		{
			newObj.onRollOver();
		}
		newObj.outButton = function()
		{
			newObj.onRollOut();
		}		
		registerControl(newObj, false);
	}
	else if (_root.m_platform == "XBox")
	{
		addConsoleButton("X360_Y", _caption);
	}
	else if (_root.m_platform == "PS3")
	{
		addConsoleButton("PS3_Triangle", _caption);
	}
	m_ControllerApplyAction = _id;
	m_bAllowControllerApply = true;
	return newObj;
}

addApplyNoCmdButton = function()
{
	var newObj = _root.Root.defaultButtonHolder.attachMovie("PCApplyBtn", "PCApplyBtn",Root.defaultButtonHolder.getNextHighestDepth());

	newObj.Description = "@ui_apply";
	newObj._x = PCButton_RightX;
	newObj._y =	PCButton_RightY;
	newObj.tabEnabled = false;
	
	newObj.onRollOver = function()
	{
		if (ShouldProcessMouse() == false)
		{
			return;
		}
		_root.Tooltip = "@ui_applyTT";
		this.gotoAndStop("over");
	}
	newObj.onRollOut = function()
	{
		this.gotoAndStop("out");
	}
	newObj.onDragOver = function()
	{
		_root.Tooltip = "@ui_applyTT";
		this.gotoAndStop("over");
	}
	newObj.onDragOut = function()
	{
		this.gotoAndStop("out");
	}
	newObj.onRelease = function()
	{
		this.gotoAndStop("down");
		fscommand("applynocmd");
	}

}

addDeleteButton = function(_id:String)
{
	var newObj = _root.Root.defaultButtonHolder.attachMovie("PCDeleteBtn", "PCDeleteBtn",Root.defaultButtonHolder.getNextHighestDepth());

	newObj.Description = "@ui_delete";
	newObj._x = PCButton_MiddleLeftX;
	newObj._y =	PCButton_MiddleLeftY;
	newObj.tabEnabled = false;
	
	newObj.onRollOver = function()
	{
		if (ShouldProcessMouse() == false)
		{
			return;
		}

		this.gotoAndStop("over");
		_root.Tooltip = "@ui_deleteTT";
	}
	newObj.onRollOut = function()
	{
		this.gotoAndStop("out");
		_root.Tooltip = "";
	}
	newObj.onDragOver = function()
	{
		this.gotoAndStop("over");
		_root.Tooltip = "@ui_deleteTT";
	}
	newObj.onDragOut = function()
	{
		this.gotoAndStop("out");
		_root.Tooltip = "";
	}
	newObj.onRelease = function()
	{
		this.gotoAndStop("down");
		fscommand("onSimpleButton", _id);
	}
}

 
 
addDefaultButton = function(_caption:String, _tooltip:String, _id:String)
{
	var newObj = null;
	if (_root.m_platform == "pc")
	{
		newObj = _root.Root.defaultButtonHolder.attachMovie("PCDefaultBtn", "PCDefaultBtn",Root.defaultButtonHolder.getNextHighestDepth());

		newObj.Description = _caption;
		newObj._x = PCButton_MiddleRightX;
		newObj._y =	PCButton_MiddleRightY;
		newObj.tabEnabled = false;
		

		
		newObj.onRollOver = function()
		{
			if (ShouldProcessMouse() == false)
			{
				return;
			}
				
			fscommand("FrontEnd_Move");
			this.gotoAndStop("over");
			_root.Tooltip = _tooltip;
			

		}
		newObj.onRollOut = function()
		{
			this.gotoAndStop("out");
			_root.Tooltip = "";
		}
		newObj.onDragOver = function()
		{
		
			this.gotoAndStop("over");
			_root.Tooltip = _tooltip;
		}
		newObj.onDragOut = function()
		{
			this.gotoAndStop("out");
			_root.Tooltip = "";
		}
		newObj.onRelease = function()
		{
			this.gotoAndStop("down");
			fscommand("onSimpleButton", _id);
			this.onDehighlight();
		}
		
		newObj.navigate = function(_where:String)
		{
			if (_where == "left")
				navigate("up");
			else if (_where == "right")
				navigate("down");
		}
		newObj.overButton = function()
		{
			newObj.onRollOver();
		}
		newObj.outButton = function()
		{	
			
			newObj.onRollOut();
						
		}		
		registerControl(newObj, false);
	}
	else if (_root.m_platform == "XBox")
	{
		addConsoleButton("X360_X", _caption);
	}
	else if (_root.m_platform == "PS3")
	{
		addConsoleButton("PS3_Square", _caption);
	}
	m_ControllerResetAction = _id;
	m_bAllowControllerReset = true;
	return newObj;
}

addActionButton = function(_caption:String, _id:String)
{
	if (_root.m_platform == "pc")
	{
		addConsoleButton("PC_Enter", _caption);
	}
	else if (_root.m_platform == "XBox")
	{
		addConsoleButton("X360_X", _caption);
	}
	else if (_root.m_platform == "PS3")
	{
		addConsoleButton("PS3_Cross", _caption);
	}
	m_ControllerActionAction = _id;
	m_bAllowControllerAction = true;
}

// Added 06.Oct by Dean Claassen
addAssetButton = function(_caption:String, _tooltip:String, _desc:String, _action:String, _param:String, _disabled:Boolean, _highlightAction:String, _highlightParam:String, _image:String, _audio:String, _video:String, _newUnlocked:Boolean, _locked:Boolean)
{
	var newObj = addButton(_caption, _tooltip, _action, _param, _disabled, _highlightAction, _highlightParam);

	newObj.assetDesc = _desc;
	newObj.image = _image;
	newObj.audio = _audio;
	newObj.video = _video;
	newObj.locked = _locked;
	newObj.newUnlocked = _newUnlocked;

	newObj.onRelease = function()
	{	
		// Only want to fire confirm if dont have an action attached
		if (newObj.actionArray.length < 2)
		{			
			// Need to check 1st one because could be empty since thats default
			var actionName:Object = newObj.actionArray[0].action;
							
			if (actionName == undefined || actionName == "")
			{
				_root.Root.SubScreenCurrent.navigate("confirm");				
			}
		}
		
		if(newObj.locked != true && newObj.disabled != true)
		{				
			var i = 0;
			var num = newObj.actionArray.length;
			for (i=0; i<num;++i)
			{
				fscommand(newObj.actionArray[i].action, newObj.actionArray[i].param);
			}
		}
	}

	return newObj;
}
// End adding!

// Added 08.July by Karsten Klewer
addKeybindButton = function(_caption:String, _tooltip:String, _action:String, _param:String, _disabled:Boolean, _highlightAction:String, _highlightParam:String, _value:String)
{
	var newObj = addBaseObject("Keybind", _caption, _tooltip, _disabled);

	newObj.keepHighlighted = false;	 // Previously highlighted

	newObj.actionArray = new Array();
	newObj.highlightAction = _highlightAction;
	newObj.highlightParam = _highlightParam;
	newObj.Value = _value;
	
	var actionObj:Object = new Object();
	actionObj.action = _action;
	actionObj.param = _param;

	newObj.actionArray.push(actionObj);

	newObj.onRelease = function()
	{	
		if(newObj.disabled != true)
		{
			var i = 0;
			var num = newObj.actionArray.length;
			for (i=0; i<num;++i)
			{
				fscommand(newObj.actionArray[i].action, newObj.actionArray[i].param);
			}
		}
	}
	
	registerControl(newObj, true);
	repositionButton();

	return newObj;
}
// End adding!

// Added 12.July by Karsten Klewer
addSeparator = function(_caption:String, _style:Number)
{
	var newObj;
	if (_style==undefined)
	{
		newObj = addBaseObject("Header", _caption, "", true);
	}
	else
	{
		newObj = addBaseObject("Header_" + _style, _caption, "", true);
	}
	newObj.soundEnabled = false;

	//newObj.keepHighlighted = false;	 // Previously highlighted

	newObj.actionArray = new Array();
	newObj.highlightAction = _highlightAction;
	newObj.highlightParam = _highlightParam;
	newObj.disableHighlighting = true; // Wan't to be ignored in highlighting
	
	registerControl(newObj, true);
	repositionButton();

	return newObj;
}
// End adding!


// Added 28.October by Ben Johnson
addNewDisplayButton = function(_caption:String, _tooltip:String, _action:String, _param:String, _disabled:Boolean, _highlightAction:String, _highlightParam:String, _newUnlocked:Boolean )
{
	var newObj = addButton( _caption, _tooltip, _action, _param, _disabled, _highlightAction, _highlightParam );

	newObj.newUnlocked = _newUnlocked;

	return newObj;
}
// End adding!

// Added 16.December by Ben Johnson
addLockedTokenButton = function(_caption:String, _tooltip:String, _action:String, _param:String, _lockedAction:String, _lockedParam:String, _highlightAction:String, _highlightParam:String, _hasTokens:Boolean, _tokenType:String)
{
	var newObj:MovieClip = addLockedButton(_caption, _tooltip, _action, _param, _lockedAction, _lockedParam, _highlightAction, _highlightParam);
	if (newObj && _hasTokens==true)
	{
		newObj.showToken = true;

		newObj.Token.TokenType = _tokenType;
		newObj.Token.Icon.loadMovie("/libs/ui/cw2_menus_unlocktokens_small.gfx");
	}
}

addLockedButton = function(_caption:String, _tooltip:String, _action:String, _param:String, _lockedAction:String, _lockedParam:String, _highlightAction:String, _highlightParam:String)
{
	var newObj = addBaseObject("Button", _caption, _tooltip, true);

	newObj.locked = true;
	


	newObj.actionArray = new Array();
	newObj.highlightAction = _highlightAction;
	newObj.highlightParam = _highlightParam;

	newObj.lockedAction = _lockedAction;
	newObj.lockedParam = _lockedParam;

	var actionObj:Object = new Object();
	actionObj.action = _action;
	actionObj.param = _param;

	newObj.actionArray.push(actionObj);

	newObj.onRelease = function()
	{
		if (newObj.locked == true)
		{
			fscommand(newObj.lockedAction, newObj.lockedParam);
		}
		else if (newObj.disabled != true)
		{
			var i = 0;
			var num = newObj.actionArray.length;
			for (i=0; i<num;++i)
			{
				fscommand(newObj.actionArray[i].action, newObj.actionArray[i].param);
			}
		}
	}
	
	registerControl(newObj, true);
	repositionButton();

	return newObj;
}


addAssessmentButton = function(_caption:String, _tooltip:String, _action:String, _param:String, _highlightAction:String, _highlightParam:String, level:Number, totalLevels:Number )
{
	var newObj = addButton( _caption, _tooltip, _action, _param, false, _highlightAction, _highlightParam );


	newObj.assessmentLevel = level;
	newObj.assessmentLevelTotal = totalLevels;

	var frameLabel:String = "Level"+level+"_";

	if (totalLevels == 1)
	{
		frameLabel = frameLabel + "1";
	}
	else if (totalLevels == 2)
	{
		frameLabel = frameLabel + "2";
	}
	else if (totalLevels == 3)
	{
		frameLabel = frameLabel + "3";
	}
	else
	{
		frameLabel = frameLabel + "8";
	}

	newObj.Tiers._visible=true;
	newObj.Tiers.gotoAndStop(1);
	newObj.Tiers.gotoAndStop(frameLabel);

	return newObj;
}

addFriendListButton = function(_caption:String, _tooltip:String, _action:String, _param:String, _highlightAction:String, _highlightParam:String, _online:Boolean, _havePendingInvite:Boolean )
{
	var newObj = addButton( _caption, _tooltip, _action, _param, false, _highlightAction, _highlightParam );

	newObj.onlineStatus._alpha = 100;
	if( _online )
	{
		newObj.onlineStatus.gotoAndStop("online");
	}
	else
	{
		newObj.onlineStatus.gotoAndStop("offline");
	}

	if( _havePendingInvite )
	{
		newObj.inviteStatus._alpha = 100;
	}

	return newObj;
}

addProfileButton = function(_caption:String, _tooltip:String, _action:String, _param:String, _index:String, _date:String, _selected:Boolean, _disabled:Boolean)
{
	var newObj = addBaseObject("ProfileButton", _caption, _tooltip, _disabled);
	newObj.ListIndex = _index;
	newObj.ListDate = _date;
	newObj.isSelected = _selected;

	newObj.actionArray = new Array();
	
	var actionObj:Object = new Object();
	actionObj.action = _action;
	actionObj.param = _param;
	

	newObj.actionArray.push(actionObj);

	newObj.onRelease = function()
	{	
		if(newObj.disabled != true)
		{
			var i = 0;
			var num = newObj.actionArray.length;
			for (i=0; i<num;++i)
			{
				fscommand(newObj.actionArray[i].action, newObj.actionArray[i].param);
			}
		}
	}
	
	registerControl(newObj, true);
	repositionButton();
}

addButtonAction = function(_caption:String, _action:String, _param:String)
{
	for(var i:Number = 0; i < m_buttonArray.length; ++i)
	{
		var curObj:MovieClip = m_buttonArray[i];
		if(curObj.Description != _caption)
			continue;

		var actionObj:Object = new Object();
		actionObj.action = _action;
		actionObj.param = _param;

		curObj.actionArray.push(actionObj);

		return;
	}
}

addSwitchSimple = function(_caption:String, _tooltip:String, _value:String, _id:String)
{
	addSwitch(_caption, _tooltip, _id, false, _value);
}

addSwitch = function(_caption:String, _tooltip:String, _action:String, _disabled:Boolean, _value:String)
{
	var newObj = addBaseObject("Switch", _caption, _tooltip, _disabled);
	newObj.action = _action;
	newObj.m_current = _value;
	registerControl(newObj, true);
	repositionButton();

	newObj.onRelease = function()
	{	
		if(newObj.disabled != true)
		{
			if(newObj.doHitAction)
			{
				newObj.doHitAction();
			}
		}
	}
}

addSwitchOptionsFromString = function(_id:String, _options:String, _delimiter:String)
{
	var i:Number = 0;
	if (_options == "")
	{
		addSwitchOption(_id, "None", "None");
	}
	else
	{
		var elements = new Array();
		elements = _options.split(_delimiter);
		
		if (elements.length > 0)
		{
			for (i = 0; i < elements.length; i++)
			{
				addSwitchOption(_id, elements[i], elements[i]);
			}
		}
	}
}

clearSwitchOptions = function(_id:String)
{
	for(var i:Number = 0; i < m_buttonArray.length; ++i)
	{
		var curObj:MovieClip = m_buttonArray[i];
		if(curObj.action == _id)
		{
			curObj.m_options = new Array();
		}
	}
}

addSwitchOption = function(_action:String, _caption:String, _value:String)
{
	for(var i:Number = 0; i < m_buttonArray.length; ++i)
	{
		var curObj:MovieClip = m_buttonArray[i];
		if(curObj.action != _action)
			continue;
			
		if(curObj.m_options == undefined)
		{
			curObj.m_options = new Array();
		}
		var obj:Object = new Object();
		obj.m_caption = _caption;
		obj.m_value = _value;
		
		obj.actionArray = new Array();
		
		var actionObj:Object = new Object();
		actionObj.action = _action;
		actionObj.param = _value;
		
		obj.actionArray.push(actionObj);
		
		curObj.m_options.push(obj);
		if (curObj.updateValue)
			curObj.updateValue();

		return;
	}
}


addSwitchAction = function(_switchAction:String, _optionCaption:String, _optionAction:String, _value:String)

{
	for(var i:Number = 0; i < m_buttonArray.length; ++i)
	{
		var curSwitch:MovieClip = m_buttonArray[i];
		if(curSwitch.action != _switchAction)
			continue;

		if(curSwitch.m_options == undefined)
			continue;
			
		for(var j:Number = 0; j < curSwitch.m_options.length; ++j)
		{
			var curOption:Object = curSwitch.m_options[j];

			if(curOption.m_caption != _optionCaption)
				continue;
				
			if(curOption.actionArray == undefined)
			{
				curOption.actionArray = new Array();
			}
			
			var actionObj:Object = new Object();
			actionObj.action = _optionAction;
			actionObj.param = _value;

			curOption.actionArray.push(actionObj);
			return;
		}
	}
}

getControlVal = function(_id:String):String
{
	for(var i:Number = 0; i < m_buttonArray.length; ++i)
	{
		var curSwitch:MovieClip = m_buttonArray[i];
		if(curSwitch.action != _id)
			continue;
			
		return curSwitch.m_current;
	}
	
	for(var i:Number = 0; i < m_Listboxes.length; ++i)
	{
		var curLB:MovieClip = m_Listboxes[i];
		if(curLB._id != _id)
			continue;
			
		return curLB.GetSelectedValue();
	}
	
	return "-1";
}

getTextFieldText = function(_id:String):String
{
	for(var i:Number = 0; i < m_buttonArray.length; ++i)
	{
		var currTextField:MovieClip = m_buttonArray[i];
		if(currTextField.action != _id)
			continue;
			
		return currTextField.TextEntryField;
	}
	return "";
}

setTextFieldText = function(_id:String, _value:String)
{
	for(var i:Number = 0; i < m_buttonArray.length; ++i)
	{
		var currTextField:MovieClip = m_buttonArray[i];
		if(currTextField.action != _id)
			continue;
			
		currTextField.TextEntryField = _value;
	}
}

setControlVal = function(_id:String, _value:String)
{
	for(var i:Number = 0; i < m_buttonArray.length; ++i)
	{
		var curSwitch:MovieClip = m_buttonArray[i];
		if(curSwitch.action != _id)
			continue;
		curSwitch.m_current22 = _value;
		curSwitch.m_current = _value;
		if (curSwitch.setValue)
			curSwitch.setValue(_value);
	}
}

addSliderSimple = function(_caption:String, _tooltip:String, _min:Number, _max:Number, _step:Number, _value:String, _id:String)
{
	addSlider(_caption, _tooltip, _id, _min, _max, _step, false, _value, false)

}

addSlider = function(_caption:String, _tooltip:String, _action:String, _min:Number, _max:Number, _step:Number, _disabled:Boolean, _value:String, _zeroBased:Boolean)
{
	var newObj = addBaseObject("Slider", _caption, _tooltip, _disabled);
	newObj.action = _action;
	newObj.m_min = _min;
	newObj.m_max = _max;
	newObj.m_step = _step;
	newObj.m_zeroBased = _zeroBased;
	registerControl(newObj, true);
	newObj.m_current = _value;
	repositionButton();

	newObj.onRelease = function()
	{	
		if(newObj.disabled != true)
		{
			if(newObj.doHitAction)
			{
				newObj.doHitAction();
			}
		}
	}
}

addExpandingButton = function(_caption:String, _tooltip:String, _disabled:Boolean, _xPos:Number, _yPos:Number, _bgHeight:Number)
{
	var newObj = addBaseObject("Button", _caption, _tooltip, _disabled);

	newObj.subButtonArray = new Array();
	
	newObj.onRelease = function()
	{	
		if(newObj.disabled != true)
		{
			var curObj = _root.Root.ButtonAnim.ButtonContainer.attachMovie("ExpandingButton", "CurObj"+m_buttonCount,Root.ButtonAnim.ButtonContainer.getNextHighestDepth());
			curObj.tabEnabled = false;

			++m_buttonCount;
			//trace("adding expanding button, current count: " + m_buttonCount);

			m_expandableButtonPopUp = curObj;

			m_lastHighlight = m_curHighlight;
			m_lastButtonArray = m_buttonArray;
			m_buttonArray = [];

			curObj.Heading.text  = _caption;
			curObj._x = 0; // Uses container X pos not the specified one _xPos;
			curObj._y = _yPos;
			//curObj.Background._height = _bgHeight;

			var num = newObj.subButtonArray.length;
			for (var i:Number=0; i<num;++i)
			{
				var subButton:Object = newObj.subButtonArray[i];
				addExpandableSubButton(subButton);
			}

			highlightButton(-1, 0);
		}
	}
	
	registerControl(newObj, true);
	repositionButton();
}

addExpandingSubButtonDefinition = function(_parentCaption:String, _caption:String, _tooltip:String, _action:String, _param:String, _disabled:Boolean)
{
	for(var i:Number = 0; i < m_buttonArray.length; ++i)
	{
		var curObj:MovieClip = m_buttonArray[i];
		if(curObj.Description != _parentCaption)
			continue;

		var subButtonObj:Object = new Object();
		subButtonObj.caption = _caption;
		subButtonObj.tooltip = _tooltip;
		subButtonObj.disabled = _disabled;
		subButtonObj.actionArray = new Array();

		var actionObj:Object = new Object;
		actionObj.action = _action;
		actionObj.param = _param;

		subButtonObj.actionArray.push(actionObj);

		curObj.subButtonArray.push(subButtonObj);

		return;
	}
}

addExpandingSubButtonAction = function(_parentCaption:String, _caption:String, _action:String, _param:String)
{
	for(var i:Number = 0; i < m_buttonArray.length; ++i)
	{
		var curObj:MovieClip = m_buttonArray[i];
		if(curObj.Description != _parentCaption)
			continue;

		for(var j:Number = 0; j < curObj.subButtonArray.length; ++j)
		{
			var curSubObj:MovieClip = curObj.subButtonArray[j];
			if (curSubObj.caption != _caption)
				continue;

			var actionObj:Object = new Object();
			actionObj.action = _action;
			actionObj.param = _param;

			curSubObj.actionArray.push(actionObj);

			return;
		}
	}
}

addExpandableSubButton = function(_subButton:Object)
{
	var newObj = addBaseObject("Button", _subButton.caption, _subButton.tooltip, _subButton.disabled);

	newObj.actionArray = _subButton.actionArray;

	newObj.onRelease = function()
	{	
		if(newObj.disabled != true)
		{
			var i = 0;
			var num = newObj.actionArray.length;
			for (i=0; i<num;++i)
			{
				fscommand(newObj.actionArray[i].action, newObj.actionArray[i].param);
			}
			
			closeExpandableButton();
		}
	}

	newObj._y = m_expandableButtonPopUp._y + (m_buttonArray.length * (newObj._height + 5));
	newObj._x = m_expandableButtonPopUp._x;

	registerControl(newObj, true);
}

addTextFieldSimple = function(_caption:String, _tooltip:String, _id:String, _defaultText:String, _textfieldWidth:Number)
{
	addTextField(_caption, _tooltip, _id, "param", false, "_highlightAction", "_highlightParam", _defaultText, "", "", _textfieldWidth);
}


addTextField = function(_caption:String, _tooltip:String, _action:String, _param:String, _disabled:Boolean, _highlightAction:String, _highlightParam:String, _defaultText:String, _maxChars:String, _restrictChars:String, _textfieldWidth:Number)
{
	var newObj = addBaseObject("TextField", _caption, _tooltip, _disabled);

	newObj.keepHighlighted = false;	 // Previously highlighted

	newObj.action = _action;
	newObj.param = _param;
	newObj.highlightAction = _highlightAction;
	newObj.highlightParam = _highlightParam;
	newObj.TextEntryMC.TextEntryMCTextfield.tabEnabled = false;

	newObj.TextEntryFieldDefault = _defaultText;
	newObj.TextEntryField = _defaultText;

	if (_maxChars!=undefined)
		newObj.TextEntryMC.TextEntryMCTextfield.maxChars = _maxChars;

	if (_restrictChars!=undefined && _restrictChars!="")
		newObj.TextEntryMC.TextEntryMCTextfield.restrict = _restrictChars;

	if (_textfieldWidth!=undefined)
	{
		newObj.TextEntryMC.TextEntryMCTextfield._width = _textfieldWidth;
		newObj.Background._width = _textfieldWidth;
		newObj.TextFieldWidth = _textfieldWidth;
	}

	newObj.onRelease = function()
	{
		if(newObj.disabled != true)
		{
			if (_root.m_platform == "pc")
			{
				if (Selection.getFocus() == newObj.TextEntryMC.TextEntryMCTextfield)
				{
					if (newObj.TextEntryField != newObj.TextEntryFieldDefault)
					{
						newObj.TextEntryFieldDefault = newObj.TextEntryField;
						var res = new Array();
						res.push(newObj.action);
						res.push(newObj.TextEntryField)
						fscommand("textfield_changed", res);
					}
					Selection.setFocus(null);
				}
				else
				{
					Selection.setFocus(newObj.TextEntryMC.TextEntryMCTextfield);
					Selection.setSelection(newObj.TextEntryMC.TextEntryMCTextfield.length, newObj.TextEntryMC.TextEntryMCTextfield.length);
				}
			}
			else
			{
				var args:Array = new Array();
				args.push("Default");
				args.push(_caption);
				args.push(newObj.TextEntryField);
				args.push(_textfieldWidth);
				m_CurrTextField = newObj;
				fscommand("cry_virtualKeyboard", args); // internal fscommand to display virtual keyboard;
			}
		}
	}

	newObj.onRollOver = function()
	{
		if (ShouldProcessMouse() == false)
		{
			return;
		}

		_root.highlightButton(_root.m_curHighlight, newObj.buttonIndex, "mouse");
	}

	newObj.onRollOut = function()
	{
		if(newObj.buttonIndex != _root.m_curHighlight)
			return;

		_root.highlightButton(newObj.buttonIndex, undefined);
	}

	if (_root.m_platform == "pc")
	{
		newObj.overButton = function()
		{
			if (Selection.getFocus() != newObj.TextEntryMC.TextEntryMCTextfield)
			{
				Selection.setFocus(newObj.TextEntryMC.TextEntryMCTextfield);
				Selection.setSelection(newObj.TextEntryMC.TextEntryMCTextfield.length, newObj.TextEntryMC.TextEntryMCTextfield.length);
			}
		}

		newObj.outButton = function()
		{
			if (Selection.getFocus() == newObj.TextEntryMC.TextEntryMCTextfield)
			{
				Selection.setFocus(null);
			}

			if (newObj.TextEntryField != newObj.TextEntryFieldDefault)
			{
				newObj.TextEntryFieldDefault = newObj.TextEntryField;
				res.push(newObj.action);
				res.push(newObj.TextEntryField)
				fscommand("textfield_changed", res);
			}
		}
	}
	
	registerControl(newObj, true);
	repositionButton();

	return newObj;
}

// handle virtual keyboard
cry_onVirtualKeyboard = function(_success:Boolean, _input:String)
{
	if (m_CurrTextField != null && _success)
	{
		m_CurrTextField.TextEntryField = _input;
		m_CurrTextField.TextEntryFieldDefault = m_CurrTextField.TextEntryField;
		var res = new Array();
		res.push(m_CurrTextField.action);
		res.push(m_CurrTextField.TextEntryField)
		fscommand("textfield_changed", res);
	}
	m_CurrTextField = null;
}

addPasswordField = function(_caption:String, _tooltip:String, _action:String, _param:String, _disabled:Boolean, _highlightAction:String, _highlightParam:String, _defaultText:String, _maxChars:String, _restrictChars:String, _textfieldWidth:Number)
{
	var newObj = addBaseObject("PasswordField", _caption, _tooltip, _disabled);

	newObj.keepHighlighted = false;	 // Previously highlighted

	newObj.action = _action;
	newObj.param = _param;
	newObj.highlightAction = _highlightAction;
	newObj.highlightParam = _highlightParam;

	newObj.TextEntryFieldDefault = _defaultText;
	newObj.TextEntryField = _defaultText;

	if (_maxChars!=undefined)
	{
		newObj.TextEntryMC.TextEntryMCTextfield.maxChars = _maxChars;
	}

	if (_restrictChars!=undefined && _restrictChars!="")
	{
		newObj.TextEntryMC.TextEntryMCTextfield.restrict = _restrictChars;
	}

	if (_textfieldWidth!=undefined)
	{
		newObj.TextEntryMC.TextEntryMCTextfield._width = _textfieldWidth;
		newObj.Background._width = _textfieldWidth;
		newObj.TextFieldWidth = _textfieldWidth;
	}

	newObj.onRelease = function()
	{
		if(newObj.disabled != true)
		{
			if (_root.m_platform == "pc")
			{
				if (Selection.getFocus() == newObj.TextEntryMC.TextEntryMCTextfield)
				{
					if (newObj.TextEntryField != newObj.TextEntryFieldDefault)
					{
						newObj.TextEntryFieldDefault = newObj.TextEntryField;
						fscommand("textfield_changed", newObj.TextEntryField);
					}
					Selection.setFocus(null);
				}
				else
				{
					Selection.setFocus(newObj.TextEntryMC.TextEntryMCTextfield);
					Selection.setSelection(newObj.TextEntryMC.TextEntryMCTextfield.length, newObj.TextEntryMC.TextEntryMCTextfield.length);
				}
			}
			else
			{
					fscommand(newObj.action, newObj.param);
			}
		}
	}

	newObj.onRollOver = function()
	{
		if (ShouldProcessMouse() == false)
		{
			return;
		}

		_root.highlightButton(_root.m_curHighlight, newObj.buttonIndex, "mouse");
	}

	newObj.onRollOut = function()
	{
		if(newObj.buttonIndex != _root.m_curHighlight)
			return;

		_root.highlightButton(newObj.buttonIndex, undefined);
	}

	if (_root.m_platform == "pc")
	{
		newObj.overButton = function()
		{
			if (Selection.getFocus() != newObj.TextEntryMC.TextEntryMCTextfield)
			{
				Selection.setFocus(newObj.TextEntryMC.TextEntryMCTextfield);
				Selection.setSelection(newObj.TextEntryMC.TextEntryMCTextfield.length, newObj.TextEntryMC.TextEntryMCTextfield.length);
			}
		}

		newObj.outButton = function()
		{
			if (Selection.getFocus() == newObj.TextEntryMC.TextEntryMCTextfield)
			{
				Selection.setFocus(null);
			}

			if (newObj.TextEntryField != newObj.TextEntryFieldDefault)
			{
				newObj.TextEntryFieldDefault = newObj.TextEntryField;
				fscommand("textfield_changed", newObj.TextEntryField);
			}
		}
	}
	
	registerControl(newObj, true);
	repositionButton();

	return newObj;
}

addTextFieldEntryText = function(_caption:String, _entryText:String)
{
	for(var i:Number = 0; i < m_buttonArray.length; ++i)
	{
		var curObj:MovieClip = m_buttonArray[i];
		if(curObj.Description != _caption)
			continue;

		curObj.TextEntryField = _entryText;
		curObj.TextEntryFieldDefault = _entryText;

		if (_root.m_platform == "pc")
		{
			if (Selection.getFocus() == curObj.TextEntryMC.TextEntryMCTextfield)
			{
				Selection.setSelection(_entryText.length, _entryText.length);
			}
		}

		return;
	}
}

closeExpandableButton = function()
{
	if (m_expandableButtonPopUp != undefined)
	{
		m_expandableButtonPopUp.removeMovieClip();
		m_expandableButtonPopUp = undefined;

		while(m_buttonArray.length)
			m_buttonArray.pop().removeMovieClip();

		m_buttonArray = m_lastButtonArray;
		m_lastButtonArray = [];

		highlightButton(-1, m_lastHighlight);
	}
}


addBaseObject = function(_template:String, _caption:String, _tooltip:String, _disabled:Boolean):MovieClip
{
	var rollOverAllowed:Boolean;
	var curObj = _root.Root.ButtonAnim.ButtonContainer.attachMovie(_template, "CurObj"+m_buttonCount,Root.ButtonAnim.ButtonContainer.getNextHighestDepth());		// 3Di
	curObj.Description  = _caption;
	curObj.Tooltip = _tooltip;
	curObj.disabled = _disabled;
	curObj.buttonIndex = m_buttonArray.length;
	curObj.soundEnabled = true;
	curObj.tabEnabled = false;
	curObj.rollOverAllowed = true;
	
	++m_buttonCount;
	
	
	
	if(_disabled == true)
	{
		curObj.gotoAndStop(4);
	}

	curObj.onRollOver = function()
	{
		if(this.rollOverAllowed)
		{
		if (ShouldProcessMouse() == false)
		{
		return;
		}
		
		_root.highlightButton(_root.m_curHighlight, curObj.buttonIndex, "mouse");
		
		if(curObj.soundEnabled==true)
		fscommand("FrontEnd_Move");
			
		if(curObj.doHitTest)
		{
			curObj.onEnterFrame = function()
		{
			curObj.doHitTest();
		}
		}
		}

		

	}

	curObj.onRollOut = function()
	{	
		if(this.rollOverAllowed)
		{
		if(curObj.buttonIndex != _root.m_curHighlight)
		return;

		_root.highlightButton(curObj.buttonIndex, undefined);
		
		if(curObj.doHitTest)
		{
			delete curObj.onEnterFrame;
		}
		}

		

	}
	
	return curObj;
}

registerControl = function(_control:Object, _scrollAble:Boolean)
{
	if (_scrollAble)
		m_scrollAbleButtonArray.push(m_buttonArray.length);

	m_buttonArray.push(_control);
}

getScrollableIndex = function(_buttonIndex:Number)
{
	for (var i = 0; i < m_scrollAbleButtonArray.length; ++i)
	{
		if (m_scrollAbleButtonArray[i] == _buttonIndex)
			return i;
	}
	return -1;
}

addNavigationInput = function(_navigation:String, _action:String, _param:Boolean)
{
	var newObj:Object = new Object();
	newObj.m_navigation = _navigation;
	newObj.m_action = _action;
	newObj.m_param = _param;

	m_navigationInputArray.push(newObj);
}

repositionButton = function(updateScrollbar:Boolean)
{
	var numButtons:Number = m_scrollAbleButtonArray.length;
	var numButtonsDisplay:Number = m_scrollAbleButtonArray.length;

	DragObject.maxscroll = 0;

	if (m_maxButtons > 0 && numButtons > m_maxButtons)
	{
		numButtonsDisplay = m_maxButtons;
		DragObject.maxscroll = numButtons - m_maxButtons;


		if (!m_scrollable)
		{
			m_scrollable = true;
		}
	}
	else
	{
		m_scrollable = false;
	}

	var pos:Number = 0;
	var change:Number = m_buttonsChange;

	var useButtonXPos:Number = 0; // ButtonContainer uses m_buttonsXPos now instead;
	
	if (m_buttonAlignment==1)
		pos = m_buttonsYPos;                            // place below
	else if (m_buttonAlignment==2)
		pos = m_buttonsYPos - numButtonsDisplay * change;   // place above
	else
		pos = m_buttonsYPos - numButtonsDisplay * (change/2);   // center

	Root.ButtonAnim.Scrollbar.setHeight(numButtonsDisplay * change);
	Root.ButtonAnim.Scrollbar._y = pos + 20; // + arrow padding
	if (updateScrollbar==undefined || updateScrollbar==true)
	{
		Root.ButtonAnim.Scrollbar.Refresh();
	}

	for(var i:Number = 0; i < numButtons; ++i)	
	{
		m_buttonArray[m_scrollAbleButtonArray[i]]._y = pos;
		m_buttonArray[m_scrollAbleButtonArray[i]]._x = useButtonXPos;

		if (m_scrollable && (i >= m_scrollableTop + numButtonsDisplay) || (i < m_scrollableTop) )
		{
			m_buttonArray[m_scrollAbleButtonArray[i]]._visible = false;
		}
		else
		{
			m_buttonArray[m_scrollAbleButtonArray[i]]._visible = true;
			pos = pos+change;
		}
	}
}



highlightButton = function(_prev:Number, _index:Number, _moveType:String)
{
	var roundCheck:Number = 0;
	var valid:Number = _index;
	var found:Boolean = false;
	
	if(valid!=undefined)
	{
		while(found == false && roundCheck < m_buttonArray.length)
		{
			if(valid < 0)
			{
				if (m_scrollable)
					valid = 0;
				else
					valid = m_buttonArray.length - 1;
			}

			if(valid >= m_buttonArray.length)
			{
				if (m_scrollable)
					valid = m_buttonArray.length - 1;
				else
					valid = 0;
			}
	
			var disableHighlighting:Boolean = m_buttonArray[valid].disableHighlighting;
			if(disableHighlighting != undefined && disableHighlighting == true)
			{
				if (_moveType == "down")
				{
					valid = valid + 1;
				}
				else if (_moveType == "up")
				{
					valid = valid - 1;
				}
				else if (_moveType == "mouse")
				{
					valid = -1;
					break;
				}
			}
			else
			{
				found = true;
				break;
			}
/*
			if(m_buttonArray[valid].disabled == false)
			{
				found = true;
			}
			else
			{
				valid = valid + (_index - _prev);
			}
*/
			++roundCheck;
		}
	}
	else
	{
		valid = -1;
		found = true;
	}
	var scrollIndex = getScrollableIndex(valid);
	if(found == true)
	{
		if (m_scrollable && scrollIndex!=-1 && m_expandableButtonPopUp==undefined && scrollIndex != -1)
		{
			if (scrollIndex < m_scrollableTop)
			{
				m_scrollableTop = scrollIndex;
				DragObject.scroll = m_scrollableTop;
				repositionButton();
			}
			else if (scrollIndex >= m_scrollableTop + m_maxButtons)
			{
				m_scrollableTop = Math.max(0, scrollIndex - m_maxButtons + 1);
				DragObject.scroll = m_scrollableTop;
				repositionButton();
			}
		}

		m_curHighlight = valid;

		if(_prev != -1)
		{
			outButton( m_buttonArray[_prev] );
		}
		if(valid != -1)
		{
			overButton( m_buttonArray[valid] );
		}

		if (m_hasButtonGroup==true)
			fscommand("menu_set_highlight_buttongroup", m_curHighlight);
		else
			fscommand("menu_set_highlight", m_curHighlight);
	}

	if(Root.SubScreenCurrent.highlightButton)
		Root.SubScreenCurrent.highlightButton(_prev, m_curHighlight);
}



overButton = function(_movie:MovieClip)
{
	if (_movie.disabled)
		_movie.gotoAndStop(5);
	else
		_movie.gotoAndStop(2);

	//Tweener.addTween(_movie, { _xscale:100, _yscale:120, time:1, delay:0, transition:"easeOutElastic" } );
	_root.Tooltip = _movie.Tooltip;	// 3Di

	// TODO Perhaps move the above into an overButton set by AddBaseObject so buttons can have their own custom impl
	if (_movie.overButton)
	{
		_movie.overButton()
	}

	if (_movie.highlightAction && _movie.highlightAction!="")
	{
		fscommand(_movie.highlightAction, _movie.highlightParam);
	}
}


outButton = function(_movie:MovieClip)
{
	if(!_movie.rollOverAllowed)
	{
		return;
	}
	if (_movie.disabled)
		_movie.gotoAndStop(4);
	else
	_movie.gotoAndStop(1);

	//Tweener.addTween(_movie, { _xscale:100, _yscale:100, time:1, delay:0, transition:"easeOutElastic" } );
	_root.Tooltip = "";				// 3Di

	// TODO Perhaps move the above into an outButton set by AddBaseObject so buttons can have their own custom impl
	if (_movie.outButton)
	{
		_movie.outButton()
	}
}

addButtonGroup = function()
{
	closeExpandableButton();

	clearButtonsWithoutSubScreen();

	m_hasButtonGroup = true;
}

closeButtonGroup = function()
{
	closeExpandableButton();

	clearButtonsWithoutSubScreen();

	m_hasButtonGroup = false;
}

addConsoleButton = function(_button:String, _label:String)
{
	if (m_currConsoleButtonIndex < m_consoleButtons.length)
	{
		Root.PadButtonsDisplay._visible	= true;
		m_consoleButtons[m_currConsoleButtonIndex]._visible = true;
		m_consoleButtons[m_currConsoleButtonIndex].Icon.gotoAndStop(_button);
		m_consoleButtons[m_currConsoleButtonIndex].Caption.text = _label;
		m_currConsoleButtonIndex++;
	}
}

clearListboxes = function()
{
	while (m_Listboxes.length)
	{
		m_Listboxes.pop().removeMovieClip();
	}
	
	m_ListboxCount = 0;
}

clearButtons = function()
{
	Root.SaveProgress._visible = false;
	clearButtonsWithoutSubScreen();
	m_currConsoleButtonIndex = 0;
	for(var i:Number=0; i<m_consoleButtons.length; ++i)
		m_consoleButtons[i]._visible = false;
	Root.PadButtonsDisplay._visible	= false;

	m_bAllowControllerAction = false;
	m_bAllowControllerBack = false;
	m_bAllowControllerReset = false;
	m_bAllowControllerApply = false;
	
	for(var i:Number=0; i<m_subScreens.length; ++i)
	{
		m_subScreens[i].movie._visible = false;
	}

	if(Root.SubScreen.IsThisTheCredits)
	{
		fscommand("play_sound", "FrontEnd_Music_EnterMenu");
	}

	//Root.SubScreen.unloadMovie();
	//Root.SubScreenCurrent = null;
	Root.Title = "";
}

clearImages = function()
{
	var i:Number = 0;
	
	//Clear relocators
	while (m_Relocators.length)
	{
		m_Relocators.pop().Clear();
	}
	
	while (m_ImageArray.length)
	{
		m_ImageArray.pop().removeMovieClip();
	}
	m_ImageCount = 0;
}

var lastSelected;

// Added by Rune Rask - simple stay highlighted functionality for new buttons.
// function accesible in the UIactions function called doHighlightBtn
// exists in the flowgraph must be called in the flowgraph.

doHighlightBtn = function(_id:String)
{

	for (var i:Number = 0; i < m_buttonArray.length; i++)
	{
		for (var j:Number = 0; j < m_buttonArray[i].actionArray.length; j++)
		{
			if (m_buttonArray[i].actionArray[j].param == _id)
			{
				//trace(lastSelected);	//To see what was selected last uncomment this line
				
				if(lastSelected)
				{
					lastSelected.DeHighLight();
				}
				m_buttonArray[i].setHighlighted(_id);
				lastSelected = m_buttonArray[i];
				
				//trace(m_buttonArray[i]);	//To see what is selected now uncomment this line
				
			}
		}
	}	
}

removeButton = function(_id:String)
{
	for (var i:Number = 0; i < m_buttonArray.length; i++)
	{
		for (var j:Number = 0; j < m_buttonArray[i].actionArray.length; j++)
		{
			if (m_buttonArray[i].actionArray[j].param == _id)
			{
				m_buttonArray[i].removeMovieClip();
				m_buttonArray.splice(i, 1);
				
				m_scrollAbleButtonArray.pop();
				//Todo: make sure we can keep clicking the one we have highlighted!!!
			}
		}
	}
	
	
}

clearButtonsWithoutSubScreen = function()
{
	while(m_buttonArray.length)
	{
		m_buttonArray.pop().removeMovieClip();
	}
	m_scrollAbleButtonArray= [];

	while(m_lastButtonArray.length)
		m_lastButtonArray.pop().removeMovieClip();

	if (m_expandableButtonPopUp != undefined)
	{
		m_expandableButtonPopUp.removeMovieClip();
		m_expandableButtonPopUp = undefined;
	}

	m_navigationInputArray = [];

	m_scrollable = false;
	m_scrollableTop = 0;

	DragObject.scroll = 0;
	DragObject.maxscroll = 0;
	Root.ButtonAnim.Scrollbar.Refresh();

	_root.Tooltip = "";
	
	if(_root.Root.defaultButtonHolder.PCBackBtn)
		_root.Root.defaultButtonHolder.PCBackBtn.removeMovieClip(this);
	
	if(_root.Root.defaultButtonHolder.PCApplyBtn)
		_root.Root.defaultButtonHolder.PCApplyBtn.removeMovieClip(this);
	
	if(_root.Root.defaultButtonHolder.PCDeleteBtn)
		_root.Root.defaultButtonHolder.PCDeleteBtn.removeMovieClip(this);
		
	if(_root.Root.defaultButtonHolder.PCDefaultBtn)
		_root.Root.defaultButtonHolder.PCDefaultBtn.removeMovieClip(this);
	
	if(_root.Root.defaultButtonHolder.QuitButton)
		_root.Root.defaultButtonHolder.QuitButton.removeMovieClip(this);
}

var eCIE_Up:Number		= 0;
var eCIE_Down:Number	= 1;
var eCIE_Left:Number	= 2;
var eCIE_Right:Number	= 3;
var eCIE_Action:Number	= 4;
var eCIE_Back:Number	= 5;
var eCIE_Start			= 6;
var eCIE_Select			= 7;
var eCIE_ShoulderL1		= 8;
var eCIE_ShoulderL2		= 9;
var eCIE_ShoulderR1		= 10;
var eCIE_ShoulderR2		= 11;
var eCIE_Button3		= 12;
var eCIE_Button4		= 13;

cry_onController = function(iButton:Number, bReleased:Boolean)
{
	if (Root.SubScreen._visible)
	{
		Root.SubScreen.onController(iButton, bReleased);
		return;
	}
	if (bReleased) return;
	
	switch(iButton)
	{
		case eCIE_Up:
			navigate("up");
			break;
		case eCIE_Down:
			navigate("down");
			break;
		case eCIE_Left:
			navigate("left");
			break;
		case eCIE_Right:
			navigate("right");
			break;
		case eCIE_Action:
			if (m_bAllowControllerAction)
				fscommand("onSimpleButton", m_ControllerActionAction);			
			else
				navigate("confirm");
			break;
		case eCIE_Back:
			if (m_bAllowControllerBack)
				fscommand("onSimpleButton", m_ControllerBackAction);			
			break;
		case eCIE_Button3:
			if (m_bAllowControllerApply)
				fscommand("onSimpleButton", m_ControllerApplyAction);			
			break;
		case eCIE_Button4:
			if (m_bAllowControllerReset)
				fscommand("onSimpleButton", m_ControllerResetAction);			
			break;
	}
}

navigate = function(_where:String)
{
	if(_where == "up")
	{
		if (m_curHighlight==-1 && m_scrollable==true)
		{
			highlightButton(m_curHighlight, m_scrollAbleButtonArray[m_scrollableTop]-1, "up");
		}
		else
		{
			highlightButton(m_curHighlight, m_curHighlight-1, "up");
		}
		fscommand("FrontEnd_Move");
	}
	else if(_where == "down")
	{
		if (m_curHighlight==-1 && m_scrollable==true)
		{
			highlightButton(m_curHighlight, m_scrollAbleButtonArray[m_scrollableTop]+1, "down");
		}
		else
		{
			highlightButton(m_curHighlight, m_curHighlight+1, "down");
		}

		fscommand("FrontEnd_Move");
	}
	else if(_where == "confirm")
	{
		if(m_buttonArray[m_curHighlight].onRelease)
			m_buttonArray[m_curHighlight].onRelease();
		fscommand("FrontEnd_Confirm");
	}
	else if(_where == "back")
	{
		if (m_expandableButtonPopUp != undefined)
		{
			closeExpandableButton();
		}
		else if (m_hasButtonGroup==true)
		{
			fscommand("back_group");
		}
		else
		{
			fscommand("back");
		}
	}
	else if(_where == "scrolldown")
	{
		if (m_scrollable==true)
		{
			scrollDown();
			fscommand("FrontEnd_Move");
		}
	}
	else if(_where == "scrollup")
	{
		if (m_scrollable==true)
		{
			scrollUp();
			fscommand("FrontEnd_Move");
		}
	}
	else
	{
		trace("NAVIGATE SPECIAL: " + _where);
		if(m_buttonArray[m_curHighlight].navigate)
			m_buttonArray[m_curHighlight].navigate(_where);
	}
}



provideData = function(_id:String, _data:String)
{
	if(Root.SubScreenCurrent.provideData)
		Root.SubScreenCurrent.provideData(_id, _data);

	m_data[_id] = _data;
}



retrieveData = function(_id:String)
{
	return m_data[_id];
}
var m_displaced = false;
Root.SubScreen._visible = false;
showConfirmDiag = function(_message:String, _btnOkCaption:String, _btnCancelCaption:String, _id:String)
{
	highlightButton(m_curHighlight, undefined);
	Root.SubScreen.loadMovie("/libs/ui/Menus_Confirmation.swf");
	if (!m_displaced)
	{
		Root.SubScreen._x += 350;
		Root.SubScreen._y += 200;
		m_displaced = true;
	}
	Root.SubScreen._z = -24000;
	Root.SubScreen._visible = false;
	Root.SubScreen.gotoAndStop(0);
	fadeMenuOut();
	var __tzset = 0;

	onEnterFrame = function()
	{
		Root.SubScreen._msg = _message;
		Root.SubScreen._btnOk = _btnOkCaption;
		Root.SubScreen._btnFail = _btnCancelCaption;
		Root.SubScreen._visible = false;
		Cursor._x = _xmouse;
		Cursor._y = _ymouse;
		if (__tzset++ > 10)
		{
			Root.SubScreen.gotoAndPlay("BeginMessage");
			Root.SubScreen._msg = _message;
			Root.SubScreen._btnOk = _btnOkCaption;
			Root.SubScreen._btnFail = _btnCancelCaption;
			Root.SubScreen._myid = _id;
			Root.SubScreen._visible = true;
			Root.SubScreen._alpha = 400;				
			onEnterFrame = function()
			{
				Cursor._x = _xmouse;
				Cursor._y = _ymouse;
			}
		}
		
	}
}

onEnterFrame = function()
{
	Cursor._x = _xmouse;
	Cursor._y = _ymouse;
}

hideConfirmDiag = function()
{
	fadeMenuIn();
	Root.SubScreen.gotoAndPlay("FadeMessage");
	var __tzset = 0;
	onEnterFrame = function()
	{
		Cursor._x = _xmouse;
		Cursor._y = _ymouse;
		if (__tzset++ > 10)
		{
			Root.SubScreen._visible = false;
			onEnterFrame = function()
			{
				Cursor._x = _xmouse;
				Cursor._y = _ymouse;
			}

		}
	}
}




addSubScreen = function(_path:String)
{
	var found:Boolean = false;
	for(var i:Number=0; i<m_subScreens.length; ++i)
	{
		if(m_subScreens[i].path == _path)
		{
			m_subScreens[i].movie._visible = true;
			if(m_subScreens[i].movie.showSubScreen)
			{
				m_subScreens[i].movie.showSubScreen();
			}
			Root.SubScreenCurrent = m_subScreens[i].movie;
			found = true;
			trace(m_subScreens[i].movie+" found.");
			return;
		}
	}
	trace(_path+" not found. Calling loadMovie().");
	Root.SubScreen.loadMovie(_path);
	Root.SubScreenCurrent = Root.SubScreen;
}

setTopRightCaption = function(_caption:String)
{
	_root.TopRightCaption = _caption;
}

setTooltip = function(_tooltip:String)
{
	_root.Tooltip = _tooltip;
}

cry_onSetup = function(_platform:Number)
{
	switch(_platform)
	{
		case 0: _root.m_platform = "pc"; break;
		case 1: _root.m_platform = "XBox"; break;
		case 2: _root.m_platform = "PS3"; break;	
	}
	_root.Root.m_platform = _root.m_platform;
}

// MP Function
UpdateButtonsDisplay = function()
{
	var buttonIndex:Number = 1;
	var button:MovieClip = Root.PadButtonsDisplay["Button"+buttonIndex];

	Root.PadButtonsDisplay._visible = true;

	var indexNumber = 0;
	var size:Number = m_allValues.length;

	for(index=0; index < size; index += 1)	// Don't forget to keep this number in sync with C++
	{
		if (button==undefined)
			break;	
	
		button.Caption.text = m_allValues[index];								// 1
		
		button._visible = true;

		++buttonIndex;
		button = Root.PadButtonsDisplay["Button"+buttonIndex];
	}

	while(button!=undefined)
	{
		button._visible = false;
		
		++buttonIndex;
		button = Root.PadButtonsDisplay["Button"+buttonIndex];
	}
	
	m_allValues = [];
}

DogtagLoadedCallback = function(dogtag:MovieClip)
{
	Root.DogTagLoader._z = -500;
	fscommand("mp_dogtag_menu_dogtag_loaded", dogtag.toString());
}


scrollDown = function()
{
	var newTop = Math.min(m_scrollableTop+1, (m_scrollAbleButtonArray.length) - m_maxButtons);

	if(newTop != m_scrollableTop)
	{
		m_scrollableTop = newTop;
		DragObject.scroll = newTop;
		repositionButton();
	}
}

scrollUp = function()
{
	var newTop = Math.max(m_scrollableTop-1, 0);
	if(newTop != m_scrollableTop)
	{
		m_scrollableTop = newTop;
		DragObject.scroll = newTop;
		repositionButton();
	}
}

setVisible = function(_isVisible:Boolean)
{
	Particles._visible = _isVisible;
	Root._visible = _isVisible;
}

setBackgroundObject = function(shouldLoad:Boolean)
{
	if(shouldLoad == true)
	{
		background.loadMovie("Menus_Background.swf");
	}
	else
	{
		background.unloadMovie();
	}
	Root.lineOverlay._visible = shouldLoad;
}

showSpinner = function(_caption:String)
{
	Root.SaveProgress._visible = true;
	Root.SaveProgress.TextMCTextfield.text = _caption;
}

hideSpinner = function()
{
	Root.SaveProgress._visible = false;
}

navigateShip = function(_where:String,_value:Number)
{
	if(Root.SubScreenCurrent.navigateShip)
	{
		Root.SubScreenCurrent.navigateShip(_where, _value);
	}
}

Root.LoadingImage._visible = false;
function setupLoadingLevel(_imageFile)
{
	Root.LoadingImage._visible = false;

	if (_imageFile != "")
	{
		var px = Root.LoadingImage.ImageHolder._x;
		var py = Root.LoadingImage.ImageHolder._y;
		loadMovie("img://"+ _imageFile, Root.LoadingImage.ImageHolder);
		Root.LoadingImage.ImageHolder._x = -2000;
		Root.LoadingImage.ImageHolder._y = -2000;
		
		// flash will not load the image if resize happens at same frame
		var stupidFlash = 0;
		Root.LoadingImage.onEnterFrame = function()
		{
			if (stupidFlash++ > 0)
			{
				Root.LoadingImage._visible = true;
				_root.Root.LoadingImage._z = 2000;
				_root.Root.LoadingImage.ImageHolder._width = 820;
				_root.Root.LoadingImage.ImageHolder._height = 400;
				_root.Root.LoadingImage.ImageHolder._x = px;
				_root.Root.LoadingImage.ImageHolder._y = py;
				delete _root.Root.LoadingImage.onEnterFrame;
			}
		}
	}
}

//------------------------------------------------------------------------
// Button list scrollbar handing. Added by Benjo 29/12/10
//------------------------------------------------------------------------
var DragObject:Object = new Object();
DragObject.scroll = 0;
DragObject.maxscroll = 0;

DragObject.Update = function(newScoll:Number)
{
	//trace("DragObject Update " + DragObject.scroll);
	m_scrollableTop = newScoll;
	DragObject.scroll = newScoll;
	repositionButton(false);
}

Root.ButtonAnim.Scrollbar.dragObject = DragObject;
