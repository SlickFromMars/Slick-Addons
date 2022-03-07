package scripts;

import custom.SlickAddons;

class RunScript
{
	public static function main()
	{
		SlickAddons.checkIfOutdated();

		var args = Sys.args();
		var cwd = args.pop();
		Sys.setCwd(cwd);

		trace('Updating self... \n');

		Sys.command("haxelib", ["update", "slick_addons"].concat(args));

		trace('Self update complete, now installing all haxelibs. \n');

		var libs:Array<Array<String>> = checkForDeps();

		for (lib in libs)
		{
			if (lib.length == 1)
			{
				Sys.command("haxelib", ["install", lib[0]].concat(args));
				Sys.command("haxelib", ["update", lib[0]].concat(args));
			}
			else
			{
				Sys.command("haxelib", ["git", lib[0], lib[1]].concat(args));
				Sys.command("haxelib", ["update", lib[0]].concat(args));
			}
		}

		trace('All installs and updates completed! \n Have a nice day :)');
	}

	static function checkForDeps():Array<Array<String>>
	{
		var secondList:Array<Array<String>> = [];

		var http = new haxe.Http("https://raw.githubusercontent.com/SlickFromMars/Slick-Addons/main/docs/current.txt");

		http.onData = function(data:String)
		{
			var raw:String = StringTools.trim(data);
			var firstList = raw.split('\n');

			for (item in firstList)
			{
				secondList.push(item.split(' --> '));
			}
		}

		http.onError = function(error)
		{
			trace('Error getting dependency list, this step will be skipped \n');
		}

		http.request();

		return secondList;
	}
}
