package custom;

import openfl.utils.ByteArray;
import lime.math.Rectangle;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import flixel.FlxG;
import openfl.geom.Matrix;
import flixel.addons.util.PNGEncoder;
#if sys
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;
using DateTools;

class Screenshot
{
    public static var recent:Bitmap;
    static var bounds:Rectangle;

    /**
     * Takes a screenshot.
    */
    public static function take() {
        bounds = new Rectangle(0, 0, FlxG.stage.stageWidth, FlxG.stage.stageHeight);
        var temp = new Bitmap(new BitmapData(Std.int(bounds.width), Std.int(bounds.height), true, 0x0));

        var m:Matrix = new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y);

        var mouseVisible = FlxG.mouse.visible;
        FlxG.mouse.visible = false;

        temp.bitmapData.draw(FlxG.stage, m);

        FlxG.mouse.visible = mouseVisible;

        recent = temp;
    
        save();
    }

    static function save():Void {
        if (recent.bitmapData == null) {
            return;
        }

        var date = DateTools.format(Date.now(), "%F");
        var now = DateTools.format(Date.now(), "%T");

        var path = 'screenshots/$date/$now.png';

        #if sys
        FileSystem.createDirectory('screenshots/$date');

        var png:ByteArray = PNGEncoder.encode(recent.bitmapData);

        File.saveBytes(path, png);
        #end
    }
}