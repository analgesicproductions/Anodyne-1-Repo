# Code Guide

This file should help you with figuring out how Anodyne is generally put together. By reading it you should be able to generally be able to cross reference something that happens in-game with a particular source code file (using DAME level editor will help a lot with this).

To that end, check out the level editor guide I made. Some of the Anodyne 1 levels use codenames ,which aren't super obvious, but you can see the entire level layout by looking at the level in DAME (the level editor)

# Initialization and Game Loop

This game uses the Flixel ActionScript 3 engine. If you're interested in modifying the code, familiarize yourself with Flixel: http://www.flixel.org/ . It's a simple 2D engine that uses blitting in Flash.

Flash is a fairly simple engine: it uses the notion of "FlxGame" and "FlxState": FlxGame is an outer logic loop with some functionality that can manage containers ("FlxStates") of sprites, text, etc. By default, flixel loads up a FlxState (e.g. Title Screen, PlayState, Credits) and lets the player interact with that.

A "FlxState" is just a group of class instances. In most flxstates, I'm adding various instances (like the player, or an enemy) to the FlxState. super.update() is called in the FlxState's update() code: this actually goes up to a higher-level loop which will iterate through each object I added to the FlxState, and call each of those objects' class-specific update() functions. I believe there's also a separate function draw() called in some of the files (which FlxStates manage)

## Main.as

- Initializes the Flash stage
- Checks the application descriptor to determine if the game is mobile or not
- Initializes joystick code based on player OS
- Creates a FlxGame (Intra.as). 

## Intra.as

- This is the outermost game logic loop. It initializes some things like the sounds, dialogue.
- In particular, the super() call here initializes the first FlxState the game will begin to update. By default this is TitleState, or the title screen.
- If you wanted, you could edit code here to let you start in any map of the game (see the super() calls, CURRENT_MAP_NAME, etc.)
- Contains touch controls for mobile. I never want to make a mobile game again
- Contains window-resizing code for desktop
- Contains "debug mode' ("Fuck it mode") stuff
- Joypad/controller management code

# Game Flow

## TitleState.as

- The title screen. Fairly straightforward code, but the initialization of this file will call Save.load() to load the player's most recent data.
- The player can enter PlayState.as from here (the main state that loads enemies, levels, etc)

## Save.as

- Saving/loading functions. There's a 'noairSave.as' file that you'd have to use if you wanted to build a standalone SWF version of the game

## PlayState.as

- the game is almost always in this state except during the credits and title screen
- Creates the player, the UI, the tilemaps, and the FlxGroups that hold enemies and entities.
-  Adds all sprites to the state in init_add()
- update() contains the main game loop
- Handles pause menu (PauseState.as) , handles dialogue box (DialogueState.as) showing up. Note that "states' can be added within each other, which is what I do for pause menu/dialogue box
- glitchy out of bounds effect, heat wave effect
- part of the player death handling
- camera scrolling
- song fading
- going from one level to the next (see transition_out())
- loading the Intra.xml data file, parsing it to load in the enemies for an area
- loading CSV data and initializing tilemaps
- saving/loading state data of gates/treasure boxes etc

## Enemy loading

- See "SpriteFactory.as". This is run from PlayState, and will parse the XML tree  (Intra.xml, exported from Intra.dam via DAME level editor). Based on the xml tree entries for a particular level, SpriteFactory creates an instance of an enemy/entity class  and adds it to a FlxGroup that PlayState will then update (until the player leaves a level via a Door entity)
- Pretty much everything in the game is spawned via this class, so if you're curious how something works - check what it's called (use DAME), then trace it to the necessary .as file.

## All the other script files

- If you have particular questions about how a certain file works, feel free to ask.
- The other files (entity/, helper) - those are called/used by instances of classes created via SpriteFactory. If you're curious how something works just use FlashDevelop to find where a certain function is invoked, etc
