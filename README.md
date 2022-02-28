# Slick Addons - A Quality Of Life Haxelib

![](https://github.com/SlickFromMars/Slick-Addons/blob/main/include/images/SLICK_LOGO_SMALL.png)

## Features

* A dynamic pathing system. (with a new one coming soon)
* Cross platform options for everyday functions.
* Attached Sprites!
* Cool transitions!

## Setup

### Installation
 
```shell
haxelib install slick_addons
```

Be sure to update often as new features are added!

### Project.xml

Example Path Settings in the `Project.xml` that are compatible with the pathing system

```xml
<!-- _____________________________ Path Settings ____________________________ -->

	<set name="BUILD_DIR" value="export/dev" if="debug" />
	<set name="BUILD_DIR" value="export/full" unless="debug" />
	<set name="BUILD_DIR" value="export/32bit" if="32bits" />

	<source path="source" />

	<assets path="assets/main" rename="assets" exclude="*.ogg" if="web"/>
	<assets path="assets/main" rename="assets" exclude="*.mp3" unless="web"/>

	<assets path="assets/dynamic"   library="dynamic"   exclude="*.ogg" if="web"/>
	<assets path="assets/dynamic"   library="dynamic"   exclude="*.mp3" unless="web"/>

	<assets path='example_mods' rename='mods' embed='false' if="MODS_ALLOWED"/>

	<library name="dynamic"   preload="true" />

	<assets path="assets/fonts" embed='true'/>
```

Add these lines in the haxe defines if you want to go back to the old pathing system.

```xml
<!--Use the old pathing system.-->
<haxedef name="OLD_PATH_SYSTEM" />
```

## About

Made specifically for Project Expansion, but can be used in other Haxe projects.

https://lib.haxe.org/p/slick_addons/
