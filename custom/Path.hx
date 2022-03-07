package custom;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.graphics.frames.FlxAtlasFrames;
import haxe.io.Path;
import lime.utils.Assets;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;
import custom.CustomAssetType;

using StringTools;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

/**
 * The dynamic pathing system.
 * Can generate paths for tons of files.
 */
class Path
{
	/**
	 * The sound file extension.
	 * When on the web is .mp3
	 * Noramlly .ogg
	 */
	inline public static var SOUND_EXT:String = #if web "mp3" #else "ogg" #end;

	inline public static var VIDEO_EXT:String = "mp4";

	#if (haxe >= "4.0.0")
	public static var Extention_MAP:Map<CustomAssetType, String> = new Map();
	public static var Folders_MAP:Map<String, String> = new Map();
	#else
	public static var Extention_MAP:Map<CustomAssetType, String> = new Map<CustomAssetType, String>();
	public static var Folders_MAP:Map<String, String> = new Map<String, String>();
	#end
	public static var folder_array:Array<String> = [];

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
	 * Among us is sus!!111!11!1
	 * @param file 			file you want to get.
	 * @param type 			type of the file.
	 * @param library 		library, if it exists.
	 * @param use_openfl 	use openflassets, default is true.
	 */
	static public function getPath(file:String, type:CustomAssetType = NONE, ?library:Null<String> = null, ?use_openfl:Bool = true)
	{
		if (library != null)
			return _includeLibraryPath(file, library);

		if (type != NONE)
		{
			var unique:Bool = false;
			if (!unique)
			{
				if (type == SOUND || type == MUSIC)
				{
					file_funny = SOUND_EXT;
					if (type == SOUND)
						return getPath('sounds/$file.$file_funny', SOUND);
					else
						return getPath('music/$file.$file_funny', MUSIC);
				}
				else if (type == FONT)
				{
					file_funny = 'ttf';
					return getPath('fonts/$file.$file_funny', FONT);
				}
				else if (type == VIDEO)
				{
					file_funny = VIDEO_EXT;
					return getPath('videos/$file.$file_funny', VIDEO);
				}
			}
			else
			{
				if (type == IMAGE)
				{
					file_funny = "png";
				}
				else if (type == TEXT)
				{
					file_funny = 'txt';
				}
				else if (type == JSON)
				{
					file_funny = 'json';
				}
				else if (type == LUA)
				{
					file_funny = 'lua';
				}
				return getPath('$file.$file_funny', type);
			}
			if (!Extention_MAP.exists(type))
			{
				Extention_MAP.set(type, file_funny);
			}
		}
		else
		{
			file_funny = '';
		}

		if (use_openfl)
		{
			if (OpenFlAssets.exists(getPath(file, type)))
			{
				return getPath(file, type, library);
			}
			else
				return getPath(null, NONE, 'dynamic');
		}
		else
		{
			#if sys
			if (FileSystem.exists(getPath(file, type)))
			#else
			if (Assets.exists(getPath(file, type)))
			#end
			{
				return getPath(file, type, library);
			}
		else
		{
			return getPath(null, NONE, 'dynamic');
		}
		}
		return path;
	}

	static public function getModsPath(file:String, type:CustomAssetType = NONE, ?use_openfl:Bool = true) {}

	static public function _includeLibraryPath(file:String, library:String)
	{
		return '$library:assets/$library/$file';
	}

	/**
	 * Checks to see if a file exists.
	 * @param	file	The path of the file you want to check.
	 */
	static public function fileExists(file:String, type:CustomAssetType = NONE, ?use_openfl:Bool = true, ?library:String):Bool
	{
		if (use_openfl)
		{
			if (OpenFlAssets.exists(getPath(file, type)))
			{
				return true;
			}
		}
		else
		{
			#if sys
			if (FileSystem.exists(getPath(file, type)))
			#else
			if (Assets.exists(getPath(file, type)))
			#end
			{
				return true;
			}
		}
		return false;
	}

	/**
		*Gets sparrow atlas from an image and xml.
		* @param	key		The name of your xml and image.
		* @param	key		The hardcoded library it is located in.
	 */
	inline static public function getSparrowAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSparrow(getPath(key, IMAGE, library), getPath(key, XML, library));
	}
}
