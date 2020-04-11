Version 1.0
Last updated 4/11/2020. 
I likely missed a step or two here... if so, let me know on Discord.
- Melos Han-Tani

TODO:
- Tilemap callback details
- Details on using DAME
- Integrating level into Nexus doors
---

1. Make the level inside of DAME. I want to do a writeup for this, but I think it's figure-out-able.

2. Export the level, make sure its .CSV file shows up and that it's present in the exported Intra.xml file

## Making sure the level's tilemap data can be generated in-game:

3a. Embed the CSV data into *CSV_Data.as*. Just follow what you see in this file. You'll need to make one embed per CSV file you exported (so if you have a BG, BG2 and FG layer, you'll need to add three lines.)

e.g.:
		[Embed(source = "../csv/BLUE_BG.csv", mimeType = "application/octet-stream")] public static var BLUE_BG:Class;

3b. If the level has a minimap CSV (these are edited in the other .dam file), add an embed line, as well as the key:value pair to the *minimap_csv* object.

e.g.

		[Embed(source = "../csv/Minimap_Redsea.csv", mimeType = "application/octet-stream")] public static var MM_Redsea:Class;


3c. Add your level's name to the *maps_with_fg* and *maps_with_bg2* arrays. The name should match the layer's name inside of DAME.


3d. in getMap, add a conditional block to generate the needed CSV objects.  Just copy what another conditional block does.


## Music

4. If you want music to play in the level, in SoundData.as, add a conditional block to start_song_from_title(). I think the game by default tries to play the current level's name, so the point of this function is to override that (by reassigning the variable "*title*"). Then starting at line 704, it uses *title* to determine what song to actually play.

4b. Also add the new level's name to do_music() in Console.as if you want it to show up in the sound test.

## Minimap state


5. In MinimapState.as, you'll need to update some of the arrays with the level's name if you want it to have a minimap whose state can be saved between game play sessions.
-update 'visited'
-update 'minimap_areas'
-add a line to save_delete_routine()

## Dungeon entrance

6. In Registry.as, if your level is a'dungeon' that you want to have a 'dungeon entrance' marker on, update DUNGEON_ENTRANCES.


## Dungeon key state (only needed if your level is a 'dungeon' with keys)

7a. For bizarre reasons beyond me, the game uses an extremely awful method of managing keys you're holding. You'll have to update the get_nr_keys() and change_nr_keys() functions in Registry.as, if you want to add keys to your level.

7b. Also add your level to *is_dungeon()* so the game flags the level as a dungeon.

7c. Depending how many dungeons you add, you may need to update the *nr_keys* array to be bigger.


## Adding in a new tileset

8a. Only need to do this if you added a new .png tileset.

8b. Add it to TileData.as as an embed.

8c. Add tile collisions. Update *set_tile_properties()* by adding a conditional block for your tileset. You can just copy what you see. "FlxObject.NONE" means no collisions, "FlxObject.ANY" means the tile has collisions. I believe the game sets all tiles to "ANY" by default. Most of the "setTileProperties()" calls are being used to give the tile a special callback (like hole or conveyer), which are used so the player can be affected in special ways (falling into holes or having velocity modified).

8d. Note if you want conveyer tiles, you also have to set CUR_MAP_HAS_CONVEYERS to true inside of the new conditional block.

8e. TODO: There's some finicky stuff you might have to do within the conveyer() or hole() functions to get the behavior working...  too tired to explain/figure that out right now.

## Animated tiles

9a. If you have animated tiles, add them around line 136 in the TileData.as. You'll also have to add what indices in your tileset should become animated tiles (update *animtiles_indices_dict*).

e.g. TERMINAL: new Array(20, 21, 22, 150, 151, 152, 153),

9b. Update *make_anim_tile()* in TileData.as. Just follow what you see to add a new conditional block for your new map. For each tile with an animation, it both has to loadGraphic() the tileset to get its image data from, and addAnimation() to determine what animation to play. See Flixel documentation for how those work.

## Deciding what tileset a level should use

10a. Add a conditional block to setTileset() in TileData.as. This should match the one you use in DAME.


## Nexus doors

11. If you want to integrate your level into the Nexus door system, you'll need to modify Door.as. TODO: explain this


## Moving cards / adding cards 

12. In PauseState.as , add the card locations to *card_data*