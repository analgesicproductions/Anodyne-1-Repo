This is a complete repository of Anodyne, the 2013 game made by Analgesic Productions, compiled by Melos Han-Tani on April 4th, 2020. Find me on Twitter https://twitter.com/han_tani. 

For license info, see LICENSE.md.

If you have questions ask in our discord https://discordapp.com/invite/analgesic

Note that while anyone is free to browse the game assets and codebase, only paid owners of Anodyne may download and use the game assets (see below for detail.) Anyone can use the source code, though.

- Purchase the game here: https://store.steampowered.com/app/234900/Anodyne/
- or here: https://han-tani.itch.io/anodyne

Important Files Related to Installation/Editing Game
-------------
- LICENSE.md contains license/usage info.
- Installation.md contains how to download and install all the files to compile and run Andyne.
- FAQ.md will contain questions answering questions about the code.
- USING LEVEL EDITOR.md contains some info on how to compile/download DAME, the level editor for Anodyne.
- CODEGUIDE.md features some info on how the code architecture works, if you'd like to get started making changes.

Questions? Found some code comments I should delete (I tried to catch most)? feel free to e-mail me at hello@analgesic.productions and I'll answer questions or make updates.

Guide to game files
------------

### mp3/, sfx/
- Contains the music and sound effects

### intra/
- Source code and game asset library.

Explanation of files in intra/
--------------------

### bat/
- Contains batch scripts needed to prepare the game for distribution on Play Store or prepare the game for testing via the FlashDevelop IDE. There's nothing particular specific to Anodyne in terms of building it as a standalone EXE so I'm not including instructions on how to do that (look up Adobe AIR). However the "PackageApp_Win" script SHOULD still work if you want to make an .exe on Windows. Mac is a little more irritating, I actually didn't include that script here, but you just need to use command line options with adt

###  bin/ 
- This will contain the game once you've built it with FlashDevelop.
- It also contains joyquery which the Windows version uses for controller support

### obj/
- I still don't understand what this folder is for. I think it stores temp files for compilation from FlashDevelop.

### src/
- The game's source code and assets. More on that soon.

###  txt/
- Various notes to myself, these might be enlightening or amusing. Some are to-do lists, some are early planning.

### xml_app/
- .xml files needed for packaging the game as a standalone .exe file by using Adobe AIR and Flex.



Top Level files:
-----------

Analgesic Music Source Files - this is all of the original music source files which you can open in REAPER and play back using the free sfz plugin with some freely available soundfont files. There's more instructions inside! REAPER lets you easily export these projects as MIDI files to use in other DAWs, even if you don't have the original plugins.

Intra.dam - The level data. You'll need to figure out how to build a working version of DAME level editor, unfortunately, but I did include the source code for that.

Intra-AIR.as3proj - the flashdevelop IDE file.
Minimaps.dam - Level data for the in-game minimaps

various .bat files: These are used for packaging the game (as an .exe or .apk), or for testing the game using flash player. You could play the game in mobile-size with on screen buttons by running RunMobile.bat, but if you wanted to build an APK you'd need to install android SDK and update the .bat files SDK paths accordingly

Z_HELP.txt  - various ramblings to myself about updating the game or how to build stuff. some of this is out of date, I'm not sure. maybe amusing.

Source code and Assets ("src/" folder)
--------------

### awerwer, ca, com 
-various extensions for mac controllers, steam. none of these are integrated into this public version so this is obsolete i think)

### csv/
-tilemap data for the levels. you could edit these with DAME (the level editor). Note that collision data is elsewhere

### data/
- Contains both uncompiled dialogue (.txt) and compiled dialogues (NPC_Data_EN.as), which the game loads. Dialogue can be compiled with the make_npc_data.bat script, which runs the gen_npc.py python script. You shouldn't need to compile these unless you're modifying dialogue. You can also just directly edit the .as files to add new dialogue scenes
- The other .as scripts contain embeds for sprites that are used by other game code, or loading in game audio. If you want to add music you'd do that here. TileData lets you change collision info of tilemaps. CSV_Data contains embedded .csv files (tilemap data). Common_sprites contain some sprite embeds

### entity/
- decoration -  Various visual effects
- enemy - Enemies, bosses.
- gadget - dungeon entities (buttons, doors, holes, etc)
- interactive - NPCs, most cutscenes
- player - stuff relating to Young (brooms, swap, player movement)

### extension - code for joyquery

### global
- input management (keys.as), gamestate, flags, saving code, font data. in particular:
- Registry - contains functions for conversion of level data XML into a parsable format for the game (which SpriteFactory then uses)

### helper 
- misc files - e.g. windmill cutscene, achievements, dialogue state management, helper functions for events/cutscenes, shaders for SUBURB... in particular
- SpriteFactory - this code helps load data from the level data .xml to spawn enemies. If you wanted to port anodyne's level data to some other format, you might need to edit this at some point

### lua 
-Exporters for use with DAME level editor.

### org
-Contains the open source Flixel engine. I might have made some modifications here, idk.

### res 
-art assets for the game

### states 
-various inner game loops. Using the "State" system from flixel (essentially groups of related objects that can be added/removed from the game). PlayState contains the game's most important loop, where the player and enemies are added and stuff, level loading. Some of these files aren't used I think

### xml 
-the exported level data (exported from the .dam file via DAME, which needs to be compiled to be used)

## Loose top-level files in src/

### Main.as 
-Entry point of the code -initializing the flash stage.

### Intra.as 
-The FlxGame of Anodyne (if you are familiar with the Flixel engine). The vast majority of this is mobile touch controls, but some game loop management is here too

### buildmap.py

- This was a Python script made by a fan that can create .pngs of every map in the game




