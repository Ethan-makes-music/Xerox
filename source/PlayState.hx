// Xerox Version 1.0
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import haxe.Timer;
#if sys
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
#end

var rpgButtonSPR:FlxSprite;
var platformerButtonSPR:FlxSprite;
var templateCreated:FlxSprite;
var backGround:FlxSprite;
var waterMark:FlxText;
var rpgGitDir:String = "RpgTemplate";
var platformerGitDir:String = "PlatformerTemplate";
var repositoryUrl = "https://github.com/Ethan-makes-music/Rpg-Template.git";
var repositoryUrlPlatformer = "https://github.com/Ethan-makes-music/Platformer-Template.git";
var destination = null;
var click:FlxSound;
#if sys
var rpgPath:String = sys.FileSystem.fullPath("Rpg Template");
var platformerPath:String = sys.FileSystem.fullPath("Platformer Template");
#end

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();

		rpgButtonSPR = new FlxSprite(246, 200, AssetPaths.createRpg__png);
		platformerButtonSPR = new FlxSprite(186, 258, AssetPaths.createPlatform__png);
		templateCreated = new FlxSprite(355, 457, AssetPaths.templateCreated__png);
		backGround = new FlxSprite(-123, -51, AssetPaths.backGround__png);
		click = FlxG.sound.load(AssetPaths.click__ogg);

		add(backGround);
		add(rpgButtonSPR);
		add(platformerButtonSPR);
		waterMark = new WaterMark();
		add(waterMark);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(rpgButtonSPR) && FlxG.mouse.justPressed)
		{
			click.play();
			#if sys
			if (!FileSystem.exists(rpgGitDir))
			{
				trace("Rpg Created!");
				destination = rpgGitDir;
				cloneRepository(repositoryUrl, destination);
				add(templateCreated);
				wait(1000, deleteTemplate);
			}
			else
			{
				trace("Rpg Creation Failed");
			}
			#end
		}
		else if (FlxG.mouse.overlaps(platformerButtonSPR) && FlxG.mouse.justPressed)
		{
			click.play();
			#if sys
			if (!FileSystem.exists(platformerGitDir))
			{
				trace("Platformer Created!");
				destination = platformerGitDir;
				cloneRepository(repositoryUrlPlatformer, destination);
				add(templateCreated);
				wait(1000, deleteTemplate);
			}
			else
			{
				trace("Platformer Creation Failed.");
			}
			#end
		}
	}

	static function cloneRepository(repositoryUrl:String, destination:String):Void
	{
		var gitCommand = "git clone " + repositoryUrl + " " + destination;

		#if sys
		var result = Sys.command(gitCommand);
		trace(result);
		#end
	}

	public function deleteTemplate()
	{
		remove(templateCreated);
	}

	function wait(milliseconds:Int, callback:Void->Void):Void
	{
		Timer.delay(callback, milliseconds);
	}
}
