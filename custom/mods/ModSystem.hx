package custom.mods;

#if sys
import sys.FileSystem;
#end

/**
 * A dynamic modding system, integrated into the Path class.
 * Use the init function to activate.
 */
class ModSystem
{
    public static var modsList:Array<String> = [];

    public static var modsRoot:String = "";

    public static var initialized:Bool = false;

    static var ignored:Array<String> = [
        'config'
    ];
    
    /**
     * Initialize the modding system.
     * @param   root    The root folder of the mod system.
     */
    public static function init(root:String) {
        if(FileSystem.readDirectory(modsRoot) != null) {
            reloadFolders();
            
            if(modsList.length > 0) initialized = true;
        }
    }

    /**
     * Detect what mods are in the root folder.
     */
    public static function reloadFolders() {
        for(item in FileSystem.readDirectory(modsRoot)) {
            var path = modsRoot + '/' + item;

            if(FileSystem.isDirectory(path) && ignored.contains(item) == false && modsList.contains(item) == false) {
                modsList.push(item);
            }
        }
    }

    /**
     * Checks mod folders for a specified file and returns what mod it found it in, if any.
     * @param input The path to check.
     * @return The new path, or null if it couldn't find a modded file.
     */
    public static function modPath(input:String):String {
        for(item in modsList) {
            var path = modsRoot + '/' + item + '/' + input;

            if(FileSystem.exists(path)) {
                return path;
            }
        }
        return null;
    }
}