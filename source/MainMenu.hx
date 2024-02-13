package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.sound.FlxSound;
import flixel.text.FlxText;

class MainMenu extends FlxState
{
	var title:FlxSprite = new FlxSprite(250, 50, AssetPaths.xerox__png);
	var start:FlxSprite = new FlxSprite(130, 160, AssetPaths.start__png);
	var bg:FlxSprite = new FlxSprite(0, 0, AssetPaths.backGround__png);
	var waterMark:FlxText;
	var click:FlxSound;

	override function create()
	{
		super.create();

		add(bg);
		add(title);
		add(start);

		click = FlxG.sound.load(AssetPaths.click__ogg);
		waterMark = new WaterMark();
		add(waterMark);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER)
		{
			click.play();
			FlxG.switchState(new PlayState());
		}
	}
}
