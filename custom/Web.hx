package custom;

import flixel.FlxG;
import openfl.utils.Assets;
import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
#if sys
import sys.io.File;
import sys.FileSystem;
#else
import openfl.utils.Assets;
#end

using StringTools;

class Web {
	/**
	 * A cross platform way to open a website.
	 * @param	site	The website to open.
	 */
    public static function openURL(site:String) {
		#if linux
		Sys.command('/usr/bin/xdg-open', [site]);
		#else
		FlxG.openURL(site);
		#end
		trace('opening url $site');
	}

	/**
	 * Check to see if the user can connect to the internet.
	 */
	public static function checkConnection():Bool {
		var sucessful:Bool;
		var http = new haxe.Http("https://raw.githubusercontent.com/SlickFromMars/Slick-Addons/main/onlineCheck.txt");

        http.onData = function(data:String)
        {
            if(data.trim() == 'among') {
				sucessful = true;
			} else {
				sucessful = false;
			}
        }

        http.onError = function(error) {
            sucessful = false;
        }

        http.request();

        return sucessful;
	}
}