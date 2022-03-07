package custom.video;

import flixel.FlxG;
import flixel.FlxState;
import openfl.events.Event;
import openfl.media.Video;
import openfl.net.NetStream;
import systools.Dialogs;

class MP4Handler
{
	public static var video:Video;
	public static var netStream:NetStream;
	public static var finishCallback:Void->Void;

	public function new()
	{
		FlxG.autoPause = false;
	}

	public function playMP4(path:String, callback:Void->Void, ?loop:Bool = false):Void
	{
		#if html5
		FlxG.autoPause = false;

		finishCallback = callback;

		video = new Video();
		video.x = 0;
		video.y = 0;

		FlxG.addChildBelowMouse(video);

		var nc = new NetConnection();
		nc.connect(null);

		netStream = new NetStream(nc);
		netStream.client = {onMetaData: onMetaData};

		nc.addEventListener("netStatus", onNetStatus);

		netStream.play(path);
		#else
		trace('Sorry kiddo, but videos appear to be html5 exclusive for now.');
		#end
	}

	function onMetaData(path)
	{
		video.attachNetStream(netStream);

		video.width = FlxG.width;
		video.height = FlxG.height;
	}

	function onNetStatus(path)
	{
		if (path.info.code == "NetStream.Play.Complete")
		{
			finishVideo();
		}
	}

	function finishVideo()
	{
		netStream.dispose();

		if (FlxG.game.contains(video))
		{
			FlxG.game.removeChild(video);
		}

		if (finishCallback != null)
		{
			finishCallback();
		}
	}
}
