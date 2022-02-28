package custom.loading;

import custom.loading.EnumShit;
import flixel.FlxState;

typedef ScreenParams =
{
	/**
	 * The style of your loading screen.
	 */
	style:Format,

	/**
	 * Images to shuffle between.
	 */
	?backgrounds:Array<String>,
	/**
	 * The style to scale the background image.
	 */
	?scaleStyle:ScaleStyle,
	/**
	 * The minimum time to spend in the loading screen.
	 */
	?minTime:Float,
	/**
	 * The fun helpful tips to shuffle between.
	 */
	?tips:Array<String>
}
