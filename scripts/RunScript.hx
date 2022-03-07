package scripts;

import custom.SlickAddons;

class RunScript
{
	static var libs:Array<String> = [
		"lime",
		"openfl",
		"flixel",
		"flixel-addons",
		"flixel-ui",
		"hscript",
		"systools",
		"polymod"
	];

	static var gitLibs:Array<String> = ["linc_luajit", "discord_rpc"];

	static var gitLinks:Array<String> = [
		"https://github.com/AndreiRudenko/linc_luajit",
		"https://github.com/Aidan63/linc_discord-rpc"
	];

	public static function main()
	{
		SlickAddons.checkIfOutdated();

		var args = Sys.args();
		var cwd = args.pop();
		Sys.setCwd(cwd);

		trace('Updating self... \n');

		Sys.command("haxelib", ["update", "slick_addons"].concat(args));

		trace('Self update complete, now installing all haxelibs. \n');

		for (lib in libs)
		{
			Sys.command("haxelib", ["install", lib].concat(args));
			Sys.command("haxelib", ["update", lib].concat(args));
		}

		for (lib in gitLibs)
		{
			var link = gitLinks[gitLibs.indexOf(lib)];
			Sys.command("haxelib", ["git", lib, link].concat(args));
			Sys.command("haxelib", ["update", lib].concat(args));
		}

		trace('Self update complete! Have a nice day :)');
	}
}
