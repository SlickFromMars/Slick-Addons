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
			bg.loadGraphic(parameters.backgrounds[Std.random(parameters.backgrounds.length)]);
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
		}

		loadingGrp.add(bg);

		switch(parameters.style) {
			default: {
				
			}
		}
	}
}
