package custom.loading;

/**
	The style of your loading screen. More will be added eventually.
 */
enum Format
{
    /**
    * A standard loading screen.
    */
    STANDARD;
}

enum ScaleStyle
{
    /**
    * No scaling.
    */
    NONE;
    /**
    * Stretch to fit the screen.
    */
    STRETCH;
    /**
    * Stretch only on the X axis.
    */
    FITX;
    /**
    * Stretch only on the Y axis.
    */
    FITY;
    /**
     * Smart scaling. Will scale to fit the screen, but will not stretch the image at all.
     *
     * NOTE: May clip off portions of the image.
     */
    SMART;
}