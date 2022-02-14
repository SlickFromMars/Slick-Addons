package custom.mods;

import haxe.macro.Expr.Metadata;
#if sys
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

import custom.mods.ModSystem;
import custom.mods.ModMeta;

/**
 * Handles the config files for mods.
 */
class ModConfig
{
    /**
     * Trace a greeting from greeting.txt
     * @param item The mod to check.
     */
    public static function greet(item:String) {
        var greetingFile = ModSystem.checkMods('greeting.txt', [item]);
        if(greetingFile != null) trace(File.getContent(greetingFile));
    }

    /**
     * Gets the version of a specified mod and returns it.
     * Creates a version file if it can't find one.
     * @param item The mod to check.
     * @return The version.
     */
    public static function getVersion(item:String):String {
        var versionFile = ModSystem.checkMods('current.txt', [item]);
        
        if(versionFile == null) {
            File.saveContent(versionFile, 'ver');
        }

        return File.getContent(versionFile);
    }

    /**
     * Get the description of a mod.
     * @param item The mod to check.
     * @return The description.
     */
    public static function getDescription(item:String):String {
        var descriptionFile = ModSystem.checkMods('config/description.txt', [item]);

        if(descriptionFile == null) {
            File.saveContent(descriptionFile, 'No description provided.');
        }

        return File.getContent(descriptionFile);
    }

    /**
     * Get the dependencies of the mod.
     * @param mod The mod to check.
     * @return The dependencies.
     */
    public static function getDependencies(mod:String):Array<String> {
        var depFile = ModSystem.checkMods('config/dependencies.txt', [mod]);

        if(depFile == null) {
            File.saveContent(depFile, '');
        }

        var list = File.getContent(depFile).split("\n");

        return(list);
    }

    /**
     * Get the meta of any mod.
     * @param mod The mod to check.
     * @return The meta.
     */
    public static function getMeta(mod:String):ModMeta {
        var meat = new ModMeta();
        meat.name = mod;
        meat.description = getDescription(mod);
        meat.modVersion = getVersion(mod);
        meat.dependencies = getDependencies(mod);
        meat.description = getDescription(mod);

        greet(mod);

        return meat;
    }
}