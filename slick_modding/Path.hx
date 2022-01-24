package slick_modding;

import haxe.io.Path;
import flixel.FlxSubState;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;
import lime.utils.Assets;
#if sys
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

class Path {
	inline public static var SOUND_EXT:String = #if web "mp3" #else "ogg" #end;

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
	 * A dynamic cutom pathing system made for Project Expansion.
	 * Put the name of your file first, then the type of file, and the library (if any.)
	*/
	inline static public function getPath(key:String, ?type:String = 'none', ?library:String)
	{
		var EXT:String = '';
		if (type != 'none') EXT = '.' + EXT_MAP.get(type.toUpperCase());

		var FOLDER:String = FOLDER_MAP.get(type.toLowerCase());
		var LIB:String = '';

		if (library != null)
			FOLDER = '$library/';

		var PATH:String = '$LIB$FOLDER/$key$EXT';
		var pathPrefix:String = 'assets/';

		#if debug trace('getting something from $pathPrefix$PATH'); #end
			
		if (!FileSystem.exists(pathPrefix + PATH) && library == 'none') {
			return getPath('$key$EXT', 'none', 'dynamic');
		}
		return pathPrefix + PATH;
	}

	inline static public function fileExists(key:String, type:String, ?library:Null<String>)
	{
		if(OpenFlAssets.exists(Path.getPath(key, type, library))) {
			return true;
		}
		return false;
	}

	inline static public function getSparrowAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSparrow(getPath(key, 'image', library), getPath(key, 'xml', library));
	}
}