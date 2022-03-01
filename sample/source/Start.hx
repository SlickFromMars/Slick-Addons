package;

import custom.LoadingScreen;
import flixel.FlxState;

class Start extends FlxState
{
    override function create() {
        super.create();

        LoadingScreen.parameters = {
            style: STANDARD,
            backgrounds: ['CloseCall', 'hey'],
            scaleStyle: SMART,
            minTime: 5.0,
            tips: ['among us', 'balls']
        };

        openSubState(new custom.LoadingScreen(new PlayState()));
    }
}