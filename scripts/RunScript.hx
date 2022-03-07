package scripts;

import custom.SlickAddons;
import custom.Web;

class RunScript
{
	public static function main()
	{
		SlickAddons.checkIfOutdated();
		Web.openURL('https://www.youtube.com/watch?v=dQw4w9WgXcQ');
	}
}
