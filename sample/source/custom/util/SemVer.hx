package custom.util;

using StringTools;

class SemVer
{
	public var original:String;

	public var major:Int;
	public var minor:Int;
	public var patch:Int;

	public var isPre:Bool = false;
	public var preRelease:PreRelease;

	public static function fromString(input:String):SemVer
	{
		var v = new SemVer();
		v.original = input;

		var acrossAr:Array<String> = input.split('-');
		var arr:Array<Dynamic> = [];

		for (item in acrossAr[1].split('.'))
		{
			arr.push(Std.parseInt(item));
		}

		if (arr.length != 3 || arr.contains(null))
			throw 'This is not a proper version.';

		if (acrossAr.length == 2)
		{
			var among:Array<Dynamic> = acrossAr[2].split('.');

			var pre:PreRelease;

			pre.type = switch (among[0])
			{
				case 'alpha':
					ALPHA;
				case 'beta':
					BETA;
				case 'rc':
					CANIDATE;
				default:
					throw 'Improper prerelease type in your version.';
			};

			if (among[1] != null)
			{
				var tempVer = Std.parseInt(among[1]);
				if (tempVer == null)
				{
					throw 'Improper prelease type in your version.';
				}
				else
				{
					pre.iteration = tempVer;
				}
			}
			else
			{
				pre.iteration = 0;
			}

			v.isPre = true;
			v.preRelease = pre;
		}

		for (ii in 0...arr.length)
		{
			var balls:String = switch (ii)
			{
				case 0:
					'major';
				case 1:
					'minor';
				case 2:
					'patch';
				default:
					throw 'what the actual fuck';
			}

			switch (balls)
			{
				case 'major':
					v.major = arr[ii];
				case 'minor':
					v.minor = arr[ii];
				case 'patch':
					v.patch = arr[ii];
				default:
					throw 'bro how the hell did you manage this';
			}
		}

		if (v.major == null || v.minor == null || v.patch == null)
		{
			throw 'bruh you idiot';
		}

		return v;
	}

	public function compare(other:SemVer):Int
	{
		if (major == -1 || other.major == -1)
			return 0;
		if (major > other.major)
			return -1;
		if (major < other.major)
			return 1;
		if (minor == -1 || other.minor == -1)
			return 0;
		if (minor > other.minor)
			return -1;
		if (minor < other.minor)
			return 1;
		if (patch == -1 || other.patch == -1)
			return 0;
		if (patch > other.patch)
			return -1;
		if (patch < other.patch)
			return 1;
		if (doThe(preRelease.type) > doThe(other.preRelease.type))
			return -1;
		if (doThe(preRelease.type) < doThe(other.preRelease.type))
			return 1;
		if (preRelease.iteration == 0 || other.preRelease.iteration == 0)
			return 0;
		if (preRelease.iteration > other.preRelease.iteration)
			return -1;
		if (preRelease.iteration < other.preRelease.iteration)
			return -1;
		return 0;
	}

	public function new()
	{
		// balls
	};

	private function doThe(amongusinreallife:PreTypes):Int
	{
		return switch (amongusinreallife)
		{
			case ALPHA:
				1;
			case BETA:
				2;
			case CANIDATE:
				3;
			default:
				0;
		}
	}
}

typedef PreRelease =
{
	type:PreTypes,
	?iteration:Int
}

enum PreTypes
{
	ALPHA;
	BETA;
	CANIDATE;
}
