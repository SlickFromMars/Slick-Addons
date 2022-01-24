package slick_modding.screenFX;

import flixel.FlxG;
import lime.graphics.Image;
import flixel.FlxSprite;
import flixel.FlxCamera;
import slick_modding.Path;

class Jumpscare extends FlxSprite
{
    public function new(key:String, shake:Float = 0.05, duration:Int = 1) {
        this.loadGraphic(Path.getPath('jumpscares/$key', 'image'));
        this.setGraphicSize(FlxG.width, FlxG.height);
        this.updateHitbox();
        this.antialiasing = false;
        super();
        FlxG.camera.shake(shake, duration, function() {
            this.kill();
        });
    }
}