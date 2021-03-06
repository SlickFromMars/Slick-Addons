package scripts;

import haxe.Json;
import custom.SlickAddons;

class RunScript
{
	static var meta:Balls;

	public static function main()
	{
		SlickAddons.checkIfOutdated();

		var args = Sys.args();
		var cwd = args.pop();
		Sys.setCwd(cwd);

		trace('Updating self... \n');

		Sys.command("haxelib", ["update", "slick_addons"].concat(args));

		trace('Self update complete, now installing all haxelibs. \n');

		getMetaFile();

		var libs:Array<Array<String>> = meta.libraries;

		for (lib in libs)
		{
			if (lib.length == 1)
			{
				Sys.command("haxelib", ["install", lib[0]].concat(args));
			}
			else
			{
				Sys.command("haxelib", ["git", lib[0], lib[1]].concat(args));
			}

			Sys.command("haxelib", ["update", lib[0]].concat(args));
		}

		trace('All installs and updates completed! \n \n Now running some extra commands. \n');

		for (command in meta.commands)
		{
			var commandTwo:Array<String> = [];

			for (i in 1...command.length)
			{
				commandTwo.push(command[i]);
			}

			Sys.command(command[0], commandTwo);
		}
	}

	static function getMetaFile()
	{
		var listThing:Array<Array<String>> = [];

		var http = new haxe.Http("https://raw.githubusercontent.com/SlickFromMars/Slick-Addons/nightly/docs/metaDoc.json");

		http.onData = function(data:String)
		{
			meta = Json.parse(StringTools.trim(data));
		}

		http.onError = function(error)
		{
			trace('Error getting command list. \n');
		}

		http.request();

		return listThing;
	}
}

typedef Balls =
{
	commands:Array<Array<String>>,
	libraries:Array<Array<String>>
}
