package;

// import custom.animateatlas.AtlasFrameMaker;
import custom.Web;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	var logo:FlxSprite;
	var booba:FlxSprite;

	override public function create()
	{
		var path = Path.getPath('SLICK_LOGO', 'image');
		trace('Getting an image from ' + path);

		logo = new FlxSprite(0, 0).loadGraphic(path);
		logo.screenCenter();

		add(logo);

		Web.openURL("https://www.youtube.com/watch?v=dQw4w9WgXcQ");

		/*booba = new FlxSprite();
			booba.frames = AtlasFrameMaker.construct('assets/dynamic/images/minus_sakuroma_assets_full');

			booba.animation.addByPrefix('idle', 'idle', 24);
			booba.animation.play('idle');

			add(booba);
		 */

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
