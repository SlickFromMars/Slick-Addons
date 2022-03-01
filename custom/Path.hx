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

	public static var type_array:Array<String> = [];
	public static var type_array2:Array<String> = [SOUND_EXT, VIDEO_EXT, "png", "xml", "ttf", "json", "txt"];
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

	#if !OLD_PATH_SYSTEM
	/**
	 * Among us is sus!!111!11!1
	 * @param file 			file you want to get.
	 * @param type 			type of the file.
	 * @param library 		library, if it exists.
	 * @param use_openfl 	use openflassets, default is true.
	 */
	static public function getPath(file:String, type:CustomAssetType = NONE, ?library:Null<String> = null, ?use_openfl:Bool = true)
	{
		var path:String = 'assets/';
		var folder = '';
		var Extention_string:String = '';
		if (library != null)
			return _includeLibraryPath(file, library);

		if (type != NONE)
		{
			for (value in EXT_MAP.keys())
			{
				var eminem = EXT_MAP[value];
				type_array.push(eminem);
				for (types in 0...type_array.length)
				{
					var eminemV2 = type_array[types];
					if (type_array.length > -1)
					{
						switch (type)
						{
							case NONE:
								eminemV2 = null;
							case IMAGE:
								eminemV2 = 'png';
							case SOUND | MUSIC:
								eminemV2 = SOUND_EXT;
							case FONT:
								eminemV2 = 'ttf';
							case TEXT:
								eminemV2 = 'txt';
							case JSON:
								eminemV2 = 'json';
							case XML:
								eminemV2 = 'xml';
							case LUA:
								eminemV2 = null;
							case VIDEO:
								eminemV2 = VIDEO_EXT;
						}
						if (!Extention_MAP.exists(type))
							Extention_MAP.set(type, eminemV2);
					}
					Extention_string = '.' + Extention_MAP.get(type);
					return getPath('$file$Extention_string');
				}
			}
		}

		for (folders in 0...folder_array.length)
		{
			var folderss = folder_array[folders];
			if (folder_array.length > -1)
			{
				for (value in FOLDER_MAP.keys())
				{
					folder_array.push(value);
					if (!Folders_MAP.exists(value))
						Folders_MAP.set(value, folderss);

					folder = Folders_MAP.get(value.toLowerCase());
				}
			}
		}

		path = 'assets/$folder/$file$Extention_string';

		if (use_openfl)
		{
			if (fileExists(file, type))
				return getPath(file, type, library);
			else
				return getPath(null, NONE, 'dynamic');
		}
		else
		{
			if (fileExists(file, type, false))
				return getPath(file, type, library, false);
			else
				return getPath(null, NONE, 'dynamic', false);
		}
		return path;
	}

	static public function _includeLibraryPath(file:String, library:String)
	{
		return '$library:assets/$library/$file';
	}
	#else

	/**
	 * A dynamic cutom pathing system made for Project Expansion, but compatible with other projects as well.
	 * @param	key		The name of the file you want to get.
	 * @param	type	The type of file that it is.
	 * @param	library	The hardcoded library that it is in (if any).
	 * @return The determined path.
	 */
	inline static public function getPath(key:String, type:String = 'none', ?library:String)
	{
		var EXT:String = '';
		if (type != 'none')
			EXT = '.' + EXT_MAP.get(type.toUpperCase());

		var FOLDER:String = FOLDER_MAP.get(type.toLowerCase());
		var LIB:String = '';

		if (library != null)
			FOLDER = '$library/';

		var PATH:String = 'assets/$LIB$FOLDER/$key$EXT';

		if (#if sys !FileSystem.exists #else !Assets.exists #end (PATH) && library == 'none')
		{
			return getPath('$key$EXT', 'none', 'dynamic');
		}
		return PATH;
	}
	#end

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
		return FlxAtlasFrames.fromSparrow(getPath(key, 'image', library), getPath(key, 'xml', library));
	}
}
