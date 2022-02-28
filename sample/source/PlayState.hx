package;

import custom.Web;
import custom.AttachedSprite;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	var logo:FlxSprite;
	var attatchedText:AttachedSprite;

	override public function create()
	{
		var path = Path.getPath('SLICK_LOGO', 'image');
		trace('Getting an image from ' + path);

		logo = new FlxSprite(0, 0).loadGraphic(path);
		logo.screenCenter();
		
		add(logo);

		Web.openURL("https://www.youtube.com/watch?v=dQw4w9WgXcQ");

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
