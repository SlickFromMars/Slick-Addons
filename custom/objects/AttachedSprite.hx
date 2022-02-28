package custom.objects;

import flixel.FlxSprite;

/**
 * A sprite that will track and stick to a parent sprite.
 */
class AttachedSprite extends FlxSprite
{
	/**
	 * The sprite to track.
	 */
	public var sprTracker:FlxSprite;

	/**
	 * The x offset of the object.
	 */
	public var myX:Float = 0;

	/**
	 * The y offset of the object.
	 */
	public var myY:Float = 0;

	public function new()
	{
		super();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
		{
			setPosition(sprTracker.x + myX, sprTracker.y + myY);
			scrollFactor.set(sprTracker.scrollFactor.x, sprTracker.scrollFactor.y);
		}
	}
}
