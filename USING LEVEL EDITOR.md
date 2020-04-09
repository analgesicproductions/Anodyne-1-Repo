Instructions for DAME Are included in its source code (download here and open index.html in the help folder) https://github.com/XanderXevious/DAME

Summary: Anodyne uses Intra.xml and the csv/ files to load level data. DAME is a software that can be used to edit Intra.dam, a file that contains level data. DAME can then export the contents of Intra.dam to Intra.xml and the csv/ files.

Steps for using DAME with Anodyne's files:

1. You'll need to have a copy of DAME (Deadly Alien Map Editor) available. I uploaded a pre-built executable to the Google Drive folder I linked in the Installation instructions. If you want to run the editor on Mac or Linux you'll have to build from source yourself (probably doable on Mac, not sure about Linux.) Instructions on that are in the Installation instructions.

2. Once you have DAME downloaded, open DAME. You can then use this to open intra/Intra.dam or intra/Minimaps.dam

3. DAME is used to edit the levels and enemy placement. There should be guides on how to use it, but generally the left side ("Layers") features all of the game's level data. You tick on a top-level box to show that level. Usually there are then four tilemap layers from back to front, then two layers of entities. I believe that "stateful" entities refer to things like Gates and Treasure Chests whose state need to be saved across game exits/loads. Stateless refers to stuff like enemies, which always respawn when re-entering a level.

3.5 - if you want to add your own entities or behaviors or tilesets, you can! just read up on how to use DAME. You'll have to edit TileData.as (in the source code) and some other stuff to get things hooked up with the game though. See the README for some more info on that. If you're gonna get serious with modding and have questions here feel free to ping me on the analgesic discord.

4. To export, first specify the path of the custom LUA exporters I made. (File > Specify Custom Exporters Path). Set this to intra/src/lua . Note that you can add your own lua exporters!

5. MAKE A BACKUP OF THE CSV AND XML FILES (this next step will overwrite them)

6. Set the "Xml dir" (Export directory) for the level data. This should be something like C:\Users\hantani\Documents\Anodyne 1 Repo\intra\src\xml

7. hit export. the editor should generate a bunch of CSV files and one xml file, which Anodyne can then read and load. There is some work that would need to be done in the code if you want to add entirely new levels.
