package custom;

import custom.util.SemVer;
import haxe.Json;

class SlickAddons
{
	private static var frameWorkVersion:String = '2.0.0';

	private static var hasChecked:Bool = false;

	public static function checkIfOutdated()
	{
		var sucessful:Bool;
		var http = new haxe.Http("https://raw.githubusercontent.com/SlickFromMars/Slick-Addons/main/docs/current.txt");

		http.onData = function(data:String)
		{
			var before:SemVer = SemVer.fromString(frameWorkVersion);
			var after:SemVer = SemVer.fromString(StringTools.trim(data));

			switch (after.compare(before))
			{
				case 1:
					trace('Current version is newer. WTF?');
				case -1:
					trace('Current Slick Addons version is outdated.');
				case 0:
					trace('Slick Addons is up to date.');
			}

			trace(before.original + ' ---> ' + after.original);
		}

		http.onError = function(error)
		{
			trace('ERROR GETTING SLICK ADDONS META!! Check your router ya dingus');
		}

		http.request();
	}
}

// this is stupid sorry :(
typedef HaxelibJSON =
{
	name:String,
	url:String,
	license:String,
	tags:Array<String>,
	description:String,
	version:String,
	releasenote:String,
	contributors:Array<String>,
	?dependencies:Array<Dynamic>,
	?classPath:String,
	?main:String
}
