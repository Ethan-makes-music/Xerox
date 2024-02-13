package;

import flixel.text.FlxText;

class WaterMark extends FlxText
{
	public function new()
	{
		super();
		this.width = 32;
		this.size = 16;
		this.text = "Xerox V1.0";
		this.y = 575;
	}
}
