//----------------------------- Defaults ------------------------------
_global.gfxExtensions = true;
import caurina.transitions.Tweener;

//--------------------------------------------------------------------------
//----------------------------- Ext Functions ------------------------------
//--------------------------------------------------------------------------
// weapon info
function setWeapon(_weaponName:String, _ammoTypeName:String, _isMelee:Boolean, _poolAmmo:Number, _maxAmmo:Number)
{
	m_weaponName = _weaponName;
	m_ammoTypeName = _ammoTypeName;
	m_isMelee = _isMelee;
	m_poolAmmo = _poolAmmo;
	m_maxAmmo = _maxAmmo;
	_updateCurrentAmmo();
}

// ammo count
function setAmmo(_currAmmo:Number)
{
	m_currAmmo = _currAmmo;
	_updateCurrentAmmo();
}

// health info
function setHealth(_intHitpointsPercent:Number)
{
  AmmoHealth.Energy_Bar.energyBarFill.gotoAndStop(_intHitpointsPercent);
  _root.Energy = _intHitpointsPercent * 1;
}

// video transmission
function playVideo(_videoFile:String)
{
	//Tweener.addTween(VideoPlayer, {_alpha:100, time:1, transition:"easeOutQuart" } );
	//MoviePath = _videoFile;
	//VideoPlayer.VideoPlayer.SelectAudioChannel(0); // disable sound!
	//VideoPlayer.VideoPlayer._visible = true;
	//VideoPlayer.VideoPlayer.Play();
	trace("VIDEO PLAYER DISABLED!");
	fscommand("onPlay");
}

// radar functions
function setupMiniMap(_strPathToMiniMap:String, _intMapSizeX:Number, _intMapSizeY:Number)
{
	loadMovie("img://"+ _strPathToMiniMap, Root_Radar.MiniMap.MapArea.Map);
	
	m_MapSizeX = _intMapSizeX;
	m_MapSizeY = _intMapSizeY;
	scaleMap(m_MapScale);
}

function scaleMap(_floatScale:Number)
{
	m_MapScale = _floatScale;
	Root_Radar.MiniMap.MapArea.Map._xscale = _floatScale*100;
	Root_Radar.MiniMap.MapArea.Map._yscale = _floatScale*100;
}

function clamp(val:Number, min:Number, max:Number){
    return Math.max(min, Math.min(max, val))
}
 
function setPlayerPos(_floatPosx:Number, _floatPosy:Number, _intRot:Number)
{	
	var shiftX = _floatPosy * m_MapSizeX * m_MapScale; // since map is rotated about -90 degree, switch x and y coordinates
	var shiftY = _floatPosx * m_MapSizeY * m_MapScale;
	
	Root_Radar.MiniMap.MapArea._x = -shiftX;
	Root_Radar.MiniMap.MapArea._y = -shiftY;
	
	Root_Radar.MiniMap._rotation = _intRot;
	
	// Update entities that fell off the radar or came back on
	for(var item in m_MinimapItems)
	{
		// transform object's original point into the mask
		var myPoint:Object = {x:m_MinimapItems[item].originalX, y:m_MinimapItems[item].originalY};
		Root_Radar.MiniMap.MapArea.localToGlobal(myPoint);
		Root_Radar.MaskAnim.globalToLocal(myPoint);
		
		// custom mask values to tweak the visibility of radar icons that fell off the radar
		// these are the values for the mask shape inside MaskAnim
		var maskX:Number = 0;
		var maskY:Number = -5;
		var maskW:Number = 207.3;
		var maskH:Number = -140.45;
		
		// visibility check
		if((myPoint.x - m_MinimapItems[item]._width > maskX && myPoint.x + m_MinimapItems[item]._width < maskW) && (myPoint.y + m_MinimapItems[item]._height < maskY && myPoint.y - m_MinimapItems[item]._height > maskH))
		{
			m_MinimapItems[item]._alpha = 100;
		}
		else
		{
			m_MinimapItems[item]._alpha = 25;
		}
		
		// clamp original point and transform back to local icon point
		myPoint.x  = clamp(myPoint.x , maskX + m_MinimapItems[item]._width, maskW  - m_MinimapItems[item]._width);
		myPoint.y  = clamp(myPoint.y, maskH  + m_MinimapItems[item]._height, maskY - m_MinimapItems[item]._height);
		Root_Radar.MaskAnim.localToGlobal(myPoint);
		Root_Radar.MiniMap.MapArea.globalToLocal(myPoint);
		
		// set real pos to clamped
		m_MinimapItems[item]._x = myPoint.x;
		m_MinimapItems[item]._y = myPoint.y;
	}
	
	_setCompass(_intRot);
}

m_MinimapItems = new Array();
function addMiniMapItem(_id, _strType)
{
  if (m_MinimapItems[_id] == null)
	m_MinimapItems[_id] = Root_Radar.MiniMap.MapArea.attachMovie(_strType, "Entity" + _id, Root_Radar.MiniMap.MapArea.getNextHighestDepth() );
  else
    trace("Warning item with " + _id + "already exists!");
}

function updateMiniMapItem(_id, _posx, _posy, _rot)
{
  if (m_MinimapItems[_id] != null)
  {
    m_MinimapItems[_id]._x = _posy * m_MapSizeX * m_MapScale;
    m_MinimapItems[_id]._y = _posx * m_MapSizeY * m_MapScale;
    m_MinimapItems[_id].originalX = _posy * m_MapSizeX * m_MapScale;
    m_MinimapItems[_id].originalY = _posx * m_MapSizeY * m_MapScale;	
    m_MinimapItems[_id]._rotation = -_rot;
  }
 }

function removeMiniMapItem(_id)
{
  if (m_MinimapItems[_id] != null)
  {
    m_MinimapItems[_id].removeMovieClip();
    m_MinimapItems[_id] = null;
  }
}

// message
function displayMessage(_message:String)
{
	_root.HudMsg = _message;
	Tweener.addTween(Messages, {_alpha:100, time:1, transition:"easeOutQuart" } );
}

function hideMessage()
{
	Tweener.addTween(Messages, {_alpha:0, time:1, transition:"easeOutQuart" } );
}

// mp messages
function addMessageItem(_msgType:String, _str1:String, _str2:String)
{
	_addMessageItem(_msgType, _str1, _str2);
}

//--------------------------------------------------------------------------
//--------------------------- internal functions ---------------------------
//--------------------------------------------------------------------------

//----------------------------- weapon  ------------------------------
var m_weaponName:String;
var m_ammoTypeName:String;
var m_poolAmmo:Number;
var m_maxAmmo:Number;
var m_isMelee:Boolean;
var m_currAmmo:Number;

function _updateCurrentAmmo()
{
	_root.Pool = m_poolAmmo;
	_root.AmmoAdd = m_currAmmo > m_maxAmmo ? "+" + (m_currAmmo - m_maxAmmo) : "0";
	_root.Ammo = m_currAmmo > m_maxAmmo ? m_maxAmmo : m_currAmmo;
	
	var ammoPercent = m_maxAmmo > 0 ? m_currAmmo / m_maxAmmo : 1;
	Warning._visible = !m_isMelee && ammoPercent < 0.2 && (m_currAmmo > 0 || m_poolAmmo == 0);
	_root.WarningMsg = m_currAmmo > 0 ? "@hud_low_ammo" : "@hud_out_of_ammo";
	
	AmmoHealth.AmmoDisplay._visible = !m_isMelee;
	AmmoHealth.AmmoLeftBG_red._visible = !m_isMelee && m_currAmmo == 0;
	AmmoHealth.AmmoRightBG_red._visible = !m_isMelee && m_poolAmmo == 0;
	
	if (!m_isMelee && m_currAmmo == 0 && m_poolAmmo == 0)
		AmmoHealth.AmmoDisplay.gotoAndStop(3);
	else if (!m_isMelee && m_currAmmo == 0)
		AmmoHealth.AmmoDisplay.gotoAndStop(2);
	else if (!m_isMelee && m_poolAmmo == 0)
		AmmoHealth.AmmoDisplay.gotoAndStop(4);
	else
		AmmoHealth.AmmoDisplay.gotoAndStop(1);
	
	var ammotype:String = m_ammoTypeName != "" ? m_ammoTypeName : "empty";
	if (AmmoHealth.FireModeIcon.m_newFireMode != ammotype)
	{
		AmmoHealth.FireModeIcon.m_newFireMode = ammotype;
		AmmoHealth.FireModeIcon.gotoAndPlay(1);
	}
	
	var weaponName:String = m_weaponName != "" ? m_weaponName : "empty";
	if (WeaponSelect.WeaponRoll.m_newWeapon != weaponName)
	{
		WeaponSelect.WeaponRoll.m_newWeapon = weaponName;
		WeaponSelect.WeaponRoll.gotoAndPlay("left");
	}

}

//----------------------------- video  ------------------------------
/*
var NetC = new NetConnection();
NetC.connect(null);

var MoviePath:String = "";

_global.eVideoStatus_PrePlaying = 0;
_global.eVideoStatus_Playing = 1;
_global.eVideoStatus_Stopped = 2;
_global.eVideoStatus_Finished = 3;
_global.eVideoStatus_Error = 4;

var m_status:Number = eVideoStatus_PrePlaying;

function HandleStop( bVideoFinished:Boolean )
{
	Tweener.addTween(VideoPlayer, {_alpha:0, time:1, transition:"easeOutQuart" } );
	VideoPlayer.VideoPlayer._visible = false;
	VideoPlayer.VideoPlayer.UnloadVideo();
	fscommand("onVideoStop");
}
VideoPlayer._alpha = 0;
*/

//----------------------------- radar  ------------------------------
var m_MapScale = 0.5;
var m_MapSizeX = 2048;
var m_MapSizeY = 2048;

var RADAR_COMPASS_LOWPIXELRANGE = 17;
var RADAR_COMPASS_HIGHPIXELRANGE = 512;
var RADAR_COMPASS_PIXELRANGE = RADAR_COMPASS_HIGHPIXELRANGE - RADAR_COMPASS_LOWPIXELRANGE;
var PI2 = Math.PI*2;

function _setCompass(_fPlayerRot:Number)
{
	_fPlayerRot = _fPlayerRot * (Math.PI/180);
	var fInterpolatedPercent = 0;
	if (_fPlayerRot < 0) fInterpolatedPercent = _fPlayerRot*(-1)/PI2;
	else                 fInterpolatedPercent = (PI2 - _fPlayerRot) / PI2;
	Root_Radar.radarCompass.Compass._x = (1-fInterpolatedPercent) * RADAR_COMPASS_PIXELRANGE + RADAR_COMPASS_LOWPIXELRANGE;
}


//----------------------------- mp messages  ------------------------------
var MSG_KILL:String = "kill";
var MSG_JOIN:String = "join";
var MSG_LEAVE:String = "left";

var m_activeMessages:Array = new Array();

function _addMessageItem(_msgType:String, _str1:String, _str2:String)
{
	var iconstr = "cross";
	var messagestr = "";
	switch (_msgType)
	{
		case MSG_KILL:
			iconstr = _str1 == _str2 ? "cross" : "kill";
			messagestr = _str1 == _str2 ? _str1 + " @hud_mp_self_killed" : _str1 + " @hud_mp_killed " + _str2;
			break;
		case MSG_JOIN:
			iconstr = "player";
			messagestr = _str1 + " @hud_mp_joined_game";
			break;
		case MSG_LEAVE:
			iconstr = "player";
			messagestr = _str1 + " @hud_mp_left_game";
			break;
	}
	var mc = _root.MPMessages.attachMovie("MP_MessageItem", "MsgItem"+_root.MPMessages.getNextHighestDepth(),_root.MPMessages.getNextHighestDepth());
	mc.iconmc.gotoAndStop(iconstr);
	mc.messagemc.text = messagestr;
	Tweener.addTween(mc, {_alpha:0, time:8, transition:"easeOutQuart" } );
	
	m_activeMessages.push(mc);
	
	var x = 15;
	var y = 0;
	var dy = 32;
	var count = 0;
	
	for (var i:Number = m_activeMessages.length - 1; i >= 0; --i)
	{
		if (m_activeMessages[i]._alpha > 0)
		{
			m_activeMessages[i]._x = x;
			m_activeMessages[i]._y = y;
			y += dy;
			count++;
			if (count > 4)
				m_activeMessages[i]._visible = false;
		}
	}
	
	var found = true;
	while (found)
	{
		found = false;
		for (var i:Number = 0; i < m_activeMessages.length; ++i)
		{
			if (m_activeMessages[i]._alpha == 0)
			{
				found = true;
				m_activeMessages[i].removeMovieClip();
				m_activeMessages.splice(i,1);
				break;
			}
		}
	}
}