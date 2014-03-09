_global.gfxExtensions = true;
import caurina.transitions.Tweener;				// Import Tweener Class


var FadeInTime = 1;
var FadeOutTime = 0.5;

var _diagArray = new Array();
var _diagStack = new Array();
var _currDiag = -1;

function addDialog(id:Number, type:String, titleStr:String, messageStr:String, paramString1:String, paramString2:String)
{
	//trace("Add Diag [" + id + "]");
	var diagmode = -1;
	switch(type)
	{
		case "Wait":
			diagmode = 0;
			break;
		case "Warning":
		case "Confirm":
		case "Okay":
		case "Error":
		case "AcceptDecline":
			diagmode = paramString2 == "" ? 1 : 2;
			break;
		case "Input":
			diagmode = 3;
			trace("INPUT DIALOG NOT SUPPORTED YET!!!");
			break;
	}

	if (_diagArray[id])
		_diagArray[id].removeMovieClip();
	
	for (var diag in _diagArray)
	{
		if (_diagArray[diag])
		{
			Tweener.addTween(_diagArray[diag], { _alpha:0,time:FadeOutTime, delay:0, transition:"linear" } );
			_diagArray[diag].disableInp();
		}
	}

	_diagArray[id] = _root.attachMovie("DialogBox", "DialogBox"+id, _root.getNextHighestDepth());
	_diagArray[id]._alpha = 0;
	_diagArray[id]._x = Stage.width/2;
	_diagArray[id]._y = Stage.height/2;
	
	_diagStack.push(id);
	_currDiag = id;
	
	Tweener.addTween(_diagArray[id], { _alpha:100,time:FadeInTime, delay:0, transition:"linear" } );
	setupDialog(_diagArray[id], id, diagmode, titleStr, messageStr, paramString1, paramString2);
}

function removeDialog(id:Number)
{
	//trace("Remove Diag [" + id + "]");
	if (_diagArray[id])
	{
		Tweener.addTween(_diagArray[id], { _alpha:0,time:FadeOutTime, delay:0, transition:"linear" } );
		_diagArray[id].disableInp();
	}
	if (_currDiag == id)
	{
		_diagStack.pop();
		if (_diagStack.length > 0)
		{
			Tweener.addTween(_diagArray[_diagStack[_diagStack.length-1]], { _alpha:100,time:FadeInTime, delay:0, transition:"linear" } );
			_diagArray[_diagStack[_diagStack.length-1]].enableInp();
			_currDiag = _diagStack[_diagStack.length-1];
		}
		else
			_currDiag = -1;
	}
	else
	{
		_diagStack.splice(getIndexForData(_diagStack, id),1);
	}
}

function getIndexForData(arr:Array, data):Number
{
	for (i=0; i<arr.length; ++i)
	{
		if (arr[i] == data)
			return i;
	}
	return -1;
}

/*
 iMode:
 0 = no button (spinner)
 1 = one button
 2 = two buttons
 3 = input (not supported yet!)
*/

function setupDialog(diag:MovieClip, id:Number, iMode:Number, titleStr:String, messageStr:String, paramString1:String, paramString2:String)
{
	diag.main_title.text = titleStr;
	diag.main_message.text = messageStr;
	diag.btn_one.Description = paramString1;
	diag.btn_two.Description = paramString2;
	diag._myid = id;
	diag._iMode = iMode;
	switch (iMode)
	{
		case 0:
			diag.spinner._visible = true;
			diag.btn_one._visible = false;
			diag.btn_two._visible = false;
			break;
		case 1:
			diag.spinner._visible = false;
			diag.btn_two._visible = false;
			diag.btn_one._x = -80;
			break;
		case 2:
			diag.spinner._visible = false;
			diag.btn_one._x = -185;
			diag.btn_two._x = 15;
			diag.btn_two._visible = true;
			break;
	}
}

cry_onController = function(iButton:Number, bReleased:Boolean)
{
	if (_diagArray[_currDiag])
		_diagArray[_currDiag].onControllerInp(iButton, bReleased);
}

var iClosing = 0;
function cry_onShow()
{
	iClosing = -1000;
	trace("show");
}

function cry_requestHide()
{
	iClosing = 0;
	onEnterFrame = function()
	{
		if (iClosing < 0)
		{
			delete onEnterFrame;
		}
		else if (iClosing > 300)
		{
			fscommand("cry_hideElement");
			delete onEnterFrame;
		}
		iClosing++;
	}
}

