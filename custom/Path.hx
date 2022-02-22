package custom;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.graphics.frames.FlxAtlasFrames;
import haxe.io.Path;
import lime.utils.Assets;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

/**
 * The dynamic pathing system.
 * Can generate paths for tons of files.
 */
class Path {
	/**
	 * The sound file extension.
	 * When on the web is .mp3
	 * Noramlly .ogg
	 */
	inline public static var SOUND_EXT:String = #if web "mp3" #else "ogg" #end;

	/**
		*Assigns file extensions to files
	 */
	public static var EXT_MAP:Map<String, String> = [
		'SOUND' => SOUND_EXT,
		'MUSIC' => SOUND_EXT,
		'VIDEO' => "mp4",
		'IMAGE' => 'png',
		'XML' => 'xml',
		'FONT' => 'ttf',
		'JSON' => 'json',
		'TEXT' => 'txt'
	];

	/**
	 * This map assigns folders to each asset type
	 */
	public static var FOLDER_MAP:Map<String, String> = [
		'sound' => 'sounds',
		'music' => 'music',
		'video' => 'videos',
		'image' => 'images',
		'xml' => 'images',
		'font' => 'fonts',
		'json' => 'data',
		'text' => 'data'
	];

	/**
	 * A dynamic cutom pathing system made for Project Expansion, but compatible with other projects as well.
	 * @param	key		The name of the file you want to get.
	 * @param	type	The type of file that it is.
	 * @param	library	The hardcoded library that it is in (if any).
	 * @return The determined path.
	 */
	inline static public function getPath(key:String, type:String = 'none', ?library:String) {
		var EXT:String = '';
		if (type != 'none')
			EXT = '.' + EXT_MAP.get(type.toUpperCase());

		var FOLDER:String = FOLDER_MAP.get(type.toLowerCase());
		var LIB:String = '';

		if (library != null)
			FOLDER = '$library/';

		var PATH:String = 'assets/$LIB$FOLDER/$key$EXT';

		if (#if sys !FileSystem.exists #else !Assets.exists #end (PATH) && library == 'none') {
			return getPath('$key$EXT', 'none', 'dynamic');
		}
		return PATH;
	}

	/**
	 * Checks to see if a file exists.
	 * @param	key		The path of the file you want to check.
	 */
	inline static public function fileExists(key:String) {
		if (OpenFlAssets.exists(key)) {
			return true;
		}
		return false;
	}

	/**
	 *Gets sparrow atlas from an image and xml.
	 * @param	key		The name of your xml and image.
	 * @param	key		The hardcoded library it is located in.
	 */
	inline static public function getSparrowAtlas(key:String, ?library:String) {
		return FlxAtlasFrames.fromSparrow(getPath(key, 'image', library), getPath(key, 'xml', library));
	}
}
