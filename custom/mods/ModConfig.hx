package custom.mods;

#if sys
import sys.io.File;
import sys.FileSystem;
#end

import custom.mods.ModSystem;

/**
 * Handles the config files for mods.
 */
class ModConfig
{
    public static function greet(list:Array<String>) {
        for(item in list) {
            var greetingFile = ModSystem.checkMods('greeting.txt', [item]);
            if(greetingFile != null) trace(File.getContent(greetingFile));
        }
    }
}