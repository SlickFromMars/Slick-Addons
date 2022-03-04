package;

// import custom.animateatlas.AtlasFrameMaker;
import custom.Web;
import flixel.FlxSprite;
import flixel.FlxState;
import custom.SlickAddons;

class PlayState extends FlxState
{
	var logo:FlxSprite;
	var booba:FlxSprite;

	override public function create()
	{
		SlickAddons.checkIfOutdated();

		/* var path = Path.getPath('SLICK_LOGO', IMAGE);
			trace('Getting an image from ' + path);

			logo = new FlxSprite(0, 0).loadGraphic(path);
			logo.screenCenter();

			add(logo);
		 */
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
