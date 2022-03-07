package scripts;

import custom.SlickAddons;
import custom.Web;

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

	static var gitLibs:Array<String> = ["linc_luajit"];

	static var gitLinks:Array<String> = ["https://github.com/AndreiRudenko/linc_luajit"];

	public static function main()
	{
		SlickAddons.checkIfOutdated();

		var args = Sys.args();
		var cwd = args.pop();
		Sys.setCwd(cwd);

		Sys.command("haxelib", ["update", "slick_addons"].concat(args));

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
	}
}
