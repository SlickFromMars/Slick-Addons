package custom;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.FlxSubState;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.utils.Assets;
#if sys
import sys.FileSystem;
#end

import custom.loading.EnumShit;
import custom.loading.ScreenParams;

class LoadingScreen extends FlxSubState
{
	public static var parameters:ScreenParams;

	private var remember:Bool;

	var loadingGrp:FlxSpriteGroup;
	var bg:FlxSprite;

	public function new(destination:FlxState) {
		remember = FlxG.mouse.visible;
        FlxG.mouse.visible = false;

		super();

		loadingGrp = new FlxSpriteGroup();

		bg = new FlxSprite();
		if(parameters.backgrounds != null) {
			bg.loadGraphic(FlxG.random.getObject(parameters.backgrounds));
		} else {
			bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		}

		var scaleStyle = parameters.scaleStyle;

		switch (scaleStyle) {
			default:
				//do nothing
			case STRETCH:
				bg.setGraphicSize(FlxG.width, FlxG.height);
			case FITX:
				bg.setGraphicSize(FlxG.width, 0);
			case FITY:
				bg.setGraphicSize(0, FlxG.height);
			case SMART:
				bg.setGraphicSize(FlxG.width, 0);
				if(bg.height < FlxG.height) bg.setGraphicSize(0, FlxG.height);
		}

		loadingGrp.add(bg);

		var blackBar = new FlxSprite(0, 727).loadGraphic(Path.getPath('ui/loading/blackbar', 'image'));
        blackBar.setGraphicSize(Std.int(blackBar.width * 1.3), 0);
        blackBar.scrollFactor.set(0, 0);
        blackBar.updateHitbox();
        blackBar.screenCenter(X);
		blackBar.antialiasing = true;

        var bar:FlxSprite = new FlxSprite(0, 727).loadGraphic(Path.getPath('ui/loading/bar', 'image'));
        bar.setGraphicSize(Std.int(bg.width * 1.3), 0);
        bar.scrollFactor.set(0, 0);
        bar.updateHitbox();
        bar.screenCenter(X);

		var helpMe:FlxText = new FlxText(0, 750, 0, '', 16);
        helpMe.setFormat(Path.getPath('opensans', 'font'), 35, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        helpMe.text = FlxG.random.getObject(parameters.tips);
        helpMe.scrollFactor.set(0, 0);
        helpMe.borderSize = 1;
        helpMe.screenCenter(X);
        add(helpMe);

		switch(parameters.style) {
			case STANDARD: {
				loadingGrp.add(blackBar);
				loadingGrp.add(bar);
			}
		}
	}
}
