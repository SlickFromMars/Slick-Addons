package custom.mods;

#if sys
import sys.io.File;
import sys.FileSystem;
#end

import custom.mods.ModConfig;
import custom.mods.ModMeta;

/**
 * A dynamic modding system, integrated into the Path class.
 * Use the init function to activate.
 */
class ModSystem
{
    public static var modsList:Array<String> = [];
    public static var metaList:Array<ModMeta> = [];

    public static var modsRoot:String = "";

    public static var initialized:Bool = false;

    static var ignored:Array<String> = [
        'config'
    ];
    
    /**
     * Initialize the modding system.
     * @param   root    The root folder of the mod system.
     */
    public static function init(root:String):Void {
        trace('initializing');
        
        if(FileSystem.readDirectory(modsRoot) != null) {
            reloadFolders();
            
            if(modsList.length > 0) {
                initialized = true;
            }
        }
    }

    /**
     * Detect what mods are in the root folder.
     */
    public static function reloadFolders():Void {
        trace('reloading folders');

        for(item in FileSystem.readDirectory(modsRoot)) {
            var path = modsRoot + '/' + item;

            if(FileSystem.isDirectory(path) && ignored.contains(item) == false && modsList.contains(item) == false) {
                trace('loading mod $item');
                modsList.push(item);
                metaList.push(ModConfig.getMeta(item));
            }
        }
    }

    /**
     * Checks mod folders for a specified file and returns what mod it found it in, if any.
     * @param input The path to check.
     * @param list The mods to check. If left blank it will use the modsList instead.
     * @return The new path, or null if it couldn't find a modded file.
     */
    public static function checkMods(input:String, ?list:Array<String>):String {
        var listyBoi = list;
        if(listyBoi != null) listyBoi = modsList;

        for(item in listyBoi) {
            var path = modPath(input, item);

            if(FileSystem.exists(path)) {
                return path;
            }
        }
        return null;
    }

    /**
     Appends a mod directory to a path.
     @param input Path to start with.
     @param mod Mod to append.
     @return The appended path.
     */
    public static function modPath(input:String, mod:String):String {
        var path = modsRoot + '/' + mod + '/' + input;

        return path;
    }
}