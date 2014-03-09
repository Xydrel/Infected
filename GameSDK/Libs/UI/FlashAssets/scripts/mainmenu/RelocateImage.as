//This can be seen as a worker thread, started by the main menu when an image needs to be shown, resized or hidden
//It boots this class with a reference to the image and the task it wants to handle, this class will take care of it and then die

class scripts.mainmenu.RelocateImage
{
	var newx = 0;
	var newy = 0;
	var newwidth = 0;
	var newheight = 0;
	var fadeInTime = 0;
	var fadeOutTime = 0;
	var newimage:MovieClip;
	private var resizeImageInterval:Number = 0;
	private var showImageInterval:Number = 0;
	private var hideImageInterval:Number = 0;
	
	//Constructor
	public function RelocateableImage()
	{
	}

	//Setup the relocator and call relocation after 100ms
	public function Setup(image:MovieClip, x:Number, y:Number, width:Number, height:Number)
	{
		newx = x;
		newy = y;
		newwidth = width;
		newheight = height;
		newimage = image;
		this.resizeImageInterval = setInterval(resizeImage, 100, this);
	}
	
	public function ShowImage(image:MovieClip, _fadeInTime:Number)
	{
		newimage = image;
		fadeInTime = _fadeInTime;
		this.showImageInterval = setInterval(showImage, 40, this);
	}
	
	public function HideImage(image:MovieClip, _fadeOutTime:Number)
	{
		newimage = image;
		fadeOutTime = _fadeOutTime;
		this.hideImageInterval = setInterval(hideImage, 40, this);
	}
	
	public function Clear()
	{
		//resize should never be cleared
		clearInterval(hideImageInterval);
		clearInterval(showImageInterval);
	}
	
	//Relocate image and remove callback and myself
	private function resizeImage(_this)
	{
		_this.newimage._visible = false;
		_this.newimage._alpha = 0;
		_this.newimage._x = _this.newx;
		_this.newimage._y = _this.newy;
		_this.newimage._width = _this.newwidth;
		_this.newimage._height = _this.newheight;
		_this.newimage.isInit = 1;
		clearInterval(_this.resizeImageInterval);
	}
	
	private function showImage(_this)
	{
		if (_this.newimage.isInit == undefined)
		{
			_this.newimage._alpha = 0;
			_this.newimage._visible = false;
			return;
		}

		if (_this.fadeInTime <= 0)
		{
			_this.newimage._alpha = 100;
			_this.newimage._visible = true;
			clearInterval(_this.showImageInterval);
		}
		else
		{
			_this.newimage._visible = true;
			_this.newimage._alpha += 100/(_this.fadeInTime*25);

			if (_this.newimage._alpha >= 100)
			{
				_this.newimage._alpha = 100;
				clearInterval(_this.showImageInterval);
			}
		}
	}
	
	private function hideImage(_this)
	{
		if (_this.fadeOutTime <= 0)
		{
			_this.newimage._alpha = 0;
			_this.newimage._visible = false;
			clearInterval(_this.hideImageInterval);
		}
		else
		{
			_this.newimage._alpha -= 100/(_this.fadeInTime*25);

			if (_this.newimage._alpha <= 0)
			{
				_this.newimage._visible = false;
				_this.newimage._alpha = 0;
				clearInterval(_this.hideImageInterval);
			}
		}
	}
}
