package custom;

@:enum abstract CustomAssetType(String)
{
	/**
	 * if the asset type is none, result is null;
	 */
	public var NONE = 'NONE';

	/**
	 * File types that contain `.png`.
	 */
	public var IMAGE = 'IMAGE';

	/**
	 * File types that contain `.ogg`, if it's web, the type is `.mp3`.
	 */
	public var SOUND = 'SOUND';

	/**
	 * File types that contain `.ogg`, if it's web, the type is `.mp3`.
	 */
	public var MUSIC = 'MUSIC';

	/**
	 * Font, type is `.ttf`.
	 */
	public var FONT = 'FONT';

	/**
	 * Text files, type is `.txt`.
	 */
	public var TEXT = 'TEXT';

	/**
	 * Json files, type is `.json`.
	 */
	public var JSON = 'JSON';

	/**
	 * Xml files, type is `.xml`.
	 */
	public var XML = 'XML';

	/**
	 * :troll:
	 */
	public var LUA = 'LUA';

	/**
	 * For video files, type is `.mp4`.
	 */
	public var VIDEO = 'VIDEO';
}
