package states 
{
	import data.CSV_Data;
	import data.SoundData;
	import data.TileData;
	import entity.player.Foot_Overlay;
	import entity.player.Player;
	import global.*;
	import helper.Cutscene;
	import helper.DH;
	import helper.EventScripts;
	import helper.ScreenFade;
	import helper.SpriteFactory;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	
	
	public class RoamState extends FlxState 
	{
		
		
		private var keywatch:Keys;
		private var stateful_mapXML:XML;
		private var stateless_mapXML:XML;
		public var  map:FlxTilemap;
		public var map_bg_2:FlxTilemap = new FlxTilemap();
		public var map_fg:FlxTilemap = new FlxTilemap();
		public var curMapBuf:FlxTilemap; //probably deprecated
		public var player:Player;
		public var player_group:FlxGroup = new FlxGroup();
		public var entities:Array = new Array();
		public var anim_tiles_group:FlxGroup = new FlxGroup();
		public var statelesses:Array; //deprecated
		public var sortables:FlxGroup = new FlxGroup();
		public var bg_sprites:FlxGroup = new FlxGroup();
		public var fg_sprites:FlxGroup = new FlxGroup(); //stuff from ceiling
		
		
		public var state:int = 5;
		
		public var S_EXITING:int = -1;		
		public var SWITCH_MAPS:Boolean = false;
		private var cleaned_up_before_exit:Boolean = false;
		
		public var S_NORMAL:int = 0;
		public var S_TRANSITION:int = 1;
		public var S_PAUSED:int = 2;
		public var pause_state:PauseState = new PauseState();
		public var pause_timer:Number = 0.2;
		
		
		public var S_OPEN_TREASURE:int = 3;
		public var S_PLAYER_DIED:int = 4;
		private var death_fadein:FlxSprite;
		private var death_text:FlxBitmapFont;
		private var played_death_sound:Boolean = false;
		private var start_death_fade_out:Boolean = false;
		
		public var S_JUST_ENTERED_MAP:int = 5;
		public var S_DIRECT_CONTROLS:int = 6;
		
		
		private var S_CUTSCENE:int = 7;
		private var cutscene:Cutscene;
		
		public var S_DIALOGUE:int = 8;
		public var load_dialogue:Boolean = false;
		public var dialogue_state:DialogueState = new DialogueState();
		public var dialogue_latency:Number = 0.3;
		
		//header ccrap
        [Embed (source = "../res/sprites/menu/autosave_icon.png")] public static var autosave_icon_embed:Class;
		public var header_group:FlxGroup = new FlxGroup();
		public var header:FlxSprite = new FlxSprite(0, 0);
        public var number_of_keys_text:FlxBitmapFont;
		public var autosave_icon:FlxSprite;
		
		// graphical overlay stuff
		public var darkness:FlxSprite = new FlxSprite(0, 0);
		private var downsample_fade:ScreenFade;
		private var upsample_fade:ScreenFade;
		private var black_overlay:FlxSprite = new FlxSprite(0, 0);
		
		// misc
		public var noScrollPt:FlxPoint = new FlxPoint(0, 0);

		public function RoamState() {
			
		}
		
		override public function create():void 
		{
			trace("Creating roamstate");
			
			// Add the keywatch
			if (Registry.keywatch == null) {
				Registry.keywatch = new Keys();
			}
				
			keywatch = Registry.keywatch;
			Registry.GAMESTATE = this;
			
			// Load the background if needed. 
			
			//Determine the proper CSV and tileset to use.
			//Load a tilemap and add it.
			var csv:String = CSV_Data.getMap(Registry.CURRENT_MAP_NAME);
			map = new FlxTilemap();
			TileData.setTileset(Registry.CURRENT_MAP_NAME)
			map.loadMap(csv, TileData.Tiles, 16, 16);
			map.y += Registry.HEADER_HEIGHT;
			TileData.set_tile_properties(map);
			make_anim_tiles(map, anim_tiles_group);
			add(map);
			
			map_bg_2.loadMap(CSV_Data.getMap(Registry.CURRENT_MAP_NAME, 2), TileData.Tiles, 16, 16);
			map_bg_2.y += Registry.HEADER_HEIGHT;
			TileData.set_tile_properties(map_bg_2);
			
			map_fg.loadMap(CSV_Data.getMap(Registry.CURRENT_MAP_NAME, 3), TileData.Tiles, 16, 16)
			map_fg.y += Registry.HEADER_HEIGHT;
			
			// Make darkness
			darkness = new FlxSprite(0, Registry.HEADER_HEIGHT);
			darkness.scrollFactor = noScrollPt;
			set_darkness(darkness);
			
			
			// Find the entrance and make the player there. Done before
			// sprite init because sprites use the player ref.
			player = new Player(0, 0, keywatch, darkness, this);
			player.foot_overlay = new Foot_Overlay(player);
			player.foot_overlay.map = map;
			player.x = Registry.ENTRANCE_PLAYER_X;
			player.y = Registry.ENTRANCE_PLAYER_Y;
			
			//Grab the relevant chunk of XML.
			initXML();
			//Instantiate and add all sprites to sortables here.
			
			Registry.reset_subgroups();  //clear from prev state
			load_entities(0, 0, true);
			
			
			add(anim_tiles_group);
			add(map_bg_2);
			add(bg_sprites);
			
			statelesses = entities;
			curMapBuf = map; //for now...
			
			// Draw player on top of everything.
			player.init_player_group(player_group, player, map);
			sortables.add(player_group);
			add(sortables);
			add(fg_sprites);
			
			//Add fg
			add(map_fg);
			
			
			// Make the  header
            header.loadGraphic(PlayState.Header, false, false, 160, 20);
			header.scrollFactor = noScrollPt;
			number_of_keys_text = EventScripts.init_bitmap_font("x" + Registry.get_nr_keys().toString(), "left", 42,7, null, "apple_white");
			
			autosave_icon = EventScripts.init_autosave_icon(autosave_icon, autosave_icon_embed);
			
			header_group.add(autosave_icon);
			header_group.add(header);
			header_group.add(number_of_keys_text);
			header_group.add(player.health_bar);
			add(header_group);
			
			//Death entities
			
			death_fadein = new FlxSprite(0, 0); death_fadein.scrollFactor = noScrollPt;
			death_fadein.makeGraphic(Registry.SCREEN_WIDTH_IN_PIXELS, Registry.SCREEN_HEIGHT_IN_PIXELS + Registry.HEADER_HEIGHT, 0xffffffff);
			death_fadein.alpha = 0;
			
			death_text = EventScripts.init_bitmap_font("Keep exploring?", "center", 0, 60, null, "apple_black");
			death_text.visible = false;
			
			add(death_fadein);
			add(death_text);
			
			// Add the darkness
			add(darkness);
			
			// add screen fade effects
			
			downsample_fade = new ScreenFade(Registry.SCREEN_WIDTH_IN_PIXELS, Registry.SCREEN_HEIGHT_IN_PIXELS + Registry.HEADER_HEIGHT, this as FlxState, ScreenFade.T_DS);
			upsample_fade = new ScreenFade(Registry.SCREEN_WIDTH_IN_PIXELS, Registry.SCREEN_HEIGHT_IN_PIXELS + Registry.HEADER_HEIGHT, this as FlxState, ScreenFade.T_US);
			black_overlay.makeGraphic(Registry.SCREEN_WIDTH_IN_PIXELS, Registry.SCREEN_HEIGHT_IN_PIXELS + Registry.HEADER_HEIGHT, 0xff000000);
			black_overlay.alpha = 1;
			black_overlay.scrollFactor = noScrollPt;
			add(black_overlay);
			
			// Add the death overlay objects.
			
			
			// Play song.
			if (Registry.sound_data == null) {
				Registry.sound_data  = new SoundData();
			}
			Registry.sound_data.start_song_from_title(Registry.CURRENT_MAP_NAME);
			
			// Make the camera follow the player
			
			FlxG.camera.follow(player);
			FlxG.camera.setBounds(0, 0,map.width,map.height + 20, true);
			FlxG.camera.deadzone = new FlxRect(50, 80, 160 - 100, 160 - 120);
			
		}
		
		override public function update():void 
		{
			/* First, the bare minimum. */
			if (SWITCH_MAPS) state = S_EXITING;
			
			// State if-then.
			if (state == S_NORMAL) {
				FlxG.collide(curMapBuf, player);
				FlxG.collide(map_bg_2, player);
				keywatch.update();
				 state_normal();
				 
			} else if (state == S_PAUSED) {
				Registry.sound_data.current_song.volume = FlxG.volume * Registry.volume_scale;
				keywatch.update();
				pause_state.update();
				if (pause_state.done) {
					pause_state.done = false;
					state = S_NORMAL;
					remove(pause_state, true);
				}
				return;
			
				
				
			} else if (state == S_DIRECT_CONTROLS) {
				pause_state.controls_state.update();
				keywatch.update();
				if (!pause_state.controls_state.updating && ( Registry.keywatch.JUST_PRESSED_PAUSE || FlxG.keys.justPressed("ESCAPE"))) {
					state = S_NORMAL;
					pause_state.controls_state.pop(this);
				}
			} else if (state == S_EXITING) {
				state_exiting();
				return;
			} else if (state == S_JUST_ENTERED_MAP) {
				state_just_entered_map();
				return;
			} else if (state == S_DIALOGUE) {
				player.state = player.S_INTERACT;
				keywatch.update();
				dialogue_state.update();
				if (dialogue_state.is_finished) {
					player.state = player.S_GROUND;
					player.dontMove = false;
					dialogue_state.is_finished = false;
					state = S_NORMAL;
					dialogue_latency =  0.3;
					dialogue_state.reset();
					Registry.E_Dialogue_Just_Finished = true;
					dialogue_state.pop(this as FlxState);
				}
			}  else if (state == S_OPEN_TREASURE) {
				state_open_treasure();
				return;
			} else if (state == S_PLAYER_DIED) {
				state_player_died();
			} else if (state == S_CUTSCENE) {
				
			}
			
			
            Registry.sound_data.current_song.volume = FlxG.volume * Registry.volume_scale;
			check_events();
			// Check entity's distances from player to determine if need to update 
			// - exists vs. not
			
			// When enemies refactored, will call update.
			super.update();
		}
		
		private function check_events():void {
			if (Registry.EVENT_CHANGE_VOLUME_SCALE) {
				if (EventScripts.send_property_to(Registry, "volume_scale", Registry.EVENT_CHANGE_VOLUME_SCALE_TARGET, 0.01))
					Registry.EVENT_CHANGE_VOLUME_SCALE = false;
			}
			
			
			if (Registry.E_Load_Cutscene) { 
				state = S_CUTSCENE;
				Registry.E_Load_Cutscene = false;
				cutscene = new Cutscene(this);
				cutscene.push(this as FlxState);
				
			}
			
		}
		
		private function state_normal():void 
		{
			/* Only pause or enter controls if we're not in the middle of a transition */
		   if (pause_timer < 0 && (keywatch.JUST_PRESSED_PAUSE || FlxG.keys.justPressed("ESCAPE"))) {
			   
				Registry.sound_data.play_sound_group(Registry.sound_data.pause_sound_group);
				pause_timer = 0.2;
				if (FlxG.keys.justPressed("ESCAPE")) {
					state = S_DIRECT_CONTROLS;
					pause_state.controls_state.push(this);
				} else {
					state = S_PAUSED;
					add(pause_state);
					pause_timer = 0.2;
				}
		   } else {
			   pause_timer -= FlxG.elapsed;
		   }
			//triggered by an npc or whatever
			if (dialogue_latency > 0) {
				dialogue_latency -= FlxG.elapsed;
			}
			if (load_dialogue) {
			   load_dialogue = false;
				if (dialogue_latency < 0) {
					state = S_DIALOGUE;
					player.dontMove = true;
					dialogue_state.push(this as FlxState);
					
				}
			}
			
			if (player.health_bar.cur_health <= 0) {
				player.play("die");
				player.ANIM_STATE = player.ANIM_DEAD;
				player.alive = false;
				var pt:FlxPoint = player.getScreenXY();
				player.scrollFactor = noScrollPt;
				player.x = pt.x;
				player.y = pt.y;
				Registry.sound_data.stop_current_song();
				player.velocity.x = player.velocity.y = 0;
				
				remove(player, true);
				add(player);
				state = S_PLAYER_DIED;
			}
		}
		
		private function state_exiting():void {
			/* Mark all sprites to be cleaned up, reset any events set,
			 * reset grid state, determine beginning state of the transition */
			if (!cleaned_up_before_exit) {
					Registry.reset_events();
					for (var i:int = 0; i < entities.length; i++) {
						entities.pop();
					}	
					
					cleaned_up_before_exit = true;
					player.dontMove = true;
				
				if (Registry.E_Enter_Whirlpool_Down) {
					
				} else {
					Registry.EVENT_FADE_BEGUN = true;
				}
						
				if (Registry.FUCK_IT_MODE_ON) {
					Registry.EVENT_FADE_OVER = true;
					Registry.EVENT_FADE_BEGUN = false;
				//	black_overlay.alpha = 1;
				}
			}
			/* Fade out the song and other sounds playing */
			Registry.sound_data.current_song.volume -= 0.03;
			if (Registry.sound_data.current_song.playing && Registry.sound_data.current_song.volume < 0.05) {
				Registry.sound_data.stop_current_song();
				if (Registry.CURRENT_MAP_NAME == "BEACH") { 
					Registry.sound_data.waves.stop();
				}
			}
			
			/* Do door-specific stuff here (events, etc) */
			if (Registry.CURRENT_MAP_NAME == "BLANK") {
				black_overlay.alpha += 0.01;
			} else if (Registry.E_Enter_Whirlpool_Down) {
				
				super.update();
				player.play('whirl');
				if (player.framePixels_y_push != 15) {
					player.framePixels_y_push++;
				}
				if (player.framePixels_y_push >= 15) { 
					black_overlay.alpha += 0.015;
					Registry.EVENT_FADE_BEGUN = true;
				}
			} else {
				black_overlay.alpha += 0.02;
			}
			
			/* Actually make the transition when the overlay is completely 
			 * opaque and the downsampling is done */
			if (black_overlay.alpha >= 0.99 && !Registry.sound_data.current_song.playing && Registry.EVENT_FADE_OVER) {
				Registry.EVENT_FADE_OVER = Registry.EVENT_FADE_BEGUN = false;
				
				DH.reset_scenes_on_map_change();
				Registry.CURRENT_MAP_NAME = Registry.NEXT_MAP_NAME;
				Registry.set_is_playstate(Registry.CURRENT_MAP_NAME);
				if (Registry.is_playstate) {
					//FlxG.switchState(Registry.PLAYSTATE);
					FlxG.switchState(new PlayState);
				} else {
					FlxG.switchState(new RoamState);
				}
			}
		
		
		}
		
		private function state_just_entered_map():void {
			Registry.EVENT_FADE_BEGUN = true;
			black_overlay.alpha -= 0.02;
			player.dontMove = true;
			if (Registry.FUCK_IT_MODE_ON) {
				Registry.EVENT_FADE_BEGUN = false;
				Registry.EVENT_FADE_OVER = true;
			}
			if (black_overlay.alpha <= 0 && Registry.EVENT_FADE_OVER) { 
				state = S_NORMAL; player.dontMove = false; 
				Registry.EVENT_FADE_BEGUN = Registry.EVENT_FADE_OVER = false;
			}
			
			super.update();
		}
		
		
		public function state_player_died():void {
			Registry.keywatch.update();
			
			
			
			EventScripts.send_property_to(player, "x", 80, 0.5);
			EventScripts.send_property_to(player, "y", 100, 0.5);
			if (player.frame == player.DEATH_FRAME && !played_death_sound) {
				played_death_sound = true;
				Registry.sound_data.player_hit_1.play();
				Registry.sound_data.GameOver.play();
				death_text.visible = true;
				
				death_text.setText("Keep exploring?\n" + "Press " + Registry.controls[Keys.IDX_ACTION_1], true, 0, 0, "center", true);
			}
			death_fadein.visible = true;
			if (death_fadein.alpha < 1) death_fadein.alpha += 0.03;
			if (death_fadein.alpha > 0.7) { 
				death_text.visible = true;
				
			}
			if (start_death_fade_out || (played_death_sound && Registry.keywatch.JP_ACTION_1 && death_text.visible )) {
				
				start_death_fade_out = true;
				black_overlay.alpha += 0.02;
				player.alpha -= 0.02;
				death_text.alpha -= 0.02;
				if (black_overlay.alpha == 1) {
					Registry.sound_data.GameOver.stop();
					Registry.sound_data.GameOver = new FlxSound();
					Registry.sound_data.GameOver.loadEmbedded(SoundData.GameOver_Song, false);
					Registry.ENTRANCE_PLAYER_X = Registry.checkpoint.x;
					Registry.ENTRANCE_PLAYER_Y = Registry.checkpoint.y;
					Registry.CURRENT_MAP_NAME = Registry.checkpoint.area;
					Registry.CUR_HEALTH = Registry.MAX_HEALTH;
					player.health_bar.modify_health(Registry.MAX_HEALTH);
					Registry.set_is_playstate(Registry.CURRENT_MAP_NAME);
					if (Registry.is_playstate) {
						//FlxG.switchState(Registry.PLAYSTATE);
						FlxG.switchState(new PlayState);
					} else {
						FlxG.switchState(new RoamState);
					}
				}
				
			}
			
		}
		
		private function state_open_treasure():void {
			Registry.keywatch.update(); // o_O
			state = S_NORMAL;
		}
		
        private function initXML():void {
            var map:XML;
            for each (map in Registry.statefulXML.map) {
                if (map.@name == Registry.CURRENT_MAP_NAME) {
                    stateful_mapXML = map; break;
                }
            }
            for each (map in Registry.statelessXML.map) {
                if (map.@name == Registry.CURRENT_MAP_NAME) {
                    stateless_mapXML = map; break;
                }
            }
        }
		
		private function load_entities(gx:int, gy:int, load_all:Boolean = false):void {
            if (stateless_mapXML != null) {
				add_from_xml(stateless_mapXML.grid,gx,gy,load_all);
			}
			
			if (stateful_mapXML != null) {
				add_from_xml(stateful_mapXML.grid,gx,gy,load_all);
			}
		}
		
		private function add_from_xml(xml:XMLList,gx:int,gy:int,load_all:Boolean=false):void 
		{
			var prev_len:int = entities.length;
			for each (var grid:XML in xml) {
				if (load_all || (parseInt(grid.@grid_x) == gx && parseInt(grid.@grid_y) == gy)) {
					for (var i:int = 0; i < grid.child("*").length(); i++) {
						SpriteFactory.makeSprite(grid.child("*")[i], i, entities, entities, player, this, darkness);
						if (entities.length != prev_len) {
							while (prev_len < entities.length) {
								if (entities[prev_len].hasOwnProperty("gx")) {
									entities[prev_len].gx = parseInt(grid.@grid_x);
									entities[prev_len].gy = parseInt(grid.@grid_y);
								}
								sortables.add(entities[prev_len]);
								prev_len++;
							}
						}
					}
				}
			}
		}
		
		
		/* Check if the tile is an animated tile, change the tilemap tile if needed,
		 * and then also implicitly add the animated tile to the group. */
		private function make_anim_tiles(_map:FlxTilemap, _anim_tiles_group:FlxGroup):void {
			for (var i:int = 0; i < _map.totalTiles; i++) {
				var tile_type:int = _map.getTileByIndex(i);
				TileData.make_anim_tile(_anim_tiles_group, Registry.CURRENT_MAP_NAME, tile_type,  16 * (i % _map.widthInTiles), 20 + 16 * int(i / _map.widthInTiles));
				_map.setTileByIndex(i, tile_type, true);
			}
		}
		
	
		
		override public function destroy():void {
			
			remove(keywatch, true);
			// Might change this to use recycling.
			entities = null;
			statelesses = null;
			if (downsample_fade != null) downsample_fade.destroy();
			downsample_fade = null;
			if (upsample_fade != null) upsample_fade.destroy();
			upsample_fade = null;
			if (pause_state != null) pause_state.destroy();
			pause_state = null;
			if (dialogue_state != null) dialogue_state.destroy();
			dialogue_state = null;
			if (cutscene != null) cutscene.destroy();
			cutscene = null;
			
			number_of_keys_text = null;
			autosave_icon = null;
			curMapBuf = map = map_bg_2 = map_fg = null;
			noScrollPt = null;
			
			
			noScrollPt = null
			super.destroy();
		}
		
		private function set_darkness(_darkness:FlxSprite):void {
			if (Registry.CURRENT_MAP_NAME == "BEACH") {
				_darkness.makeGraphic(Registry.SCREEN_WIDTH_IN_PIXELS, Registry.SCREEN_HEIGHT_IN_PIXELS, 0xffef8100);
				_darkness.blend = "overlay";
				_darkness.alpha = 1;
				_darkness.visible = false;
			} else {
				_darkness.makeGraphic(Registry.SCREEN_WIDTH_IN_PIXELS, Registry.SCREEN_HEIGHT_IN_PIXELS, 0x00ef8100);
				_darkness.blend = "overlay";
				_darkness.alpha = 1;
				_darkness.visible = false;
				
			}
		}
		override public function draw():void 
		{
			if (Registry.CURRENT_MAP_NAME  == "BEACH") {
				darkness.fill(0xff000000);
			}
			// effects and wahtnot
			sortables.sort("y_bottom", ASCENDING);
			super.draw();
			
			if (Registry.EVENT_FADE_BEGUN && state == S_EXITING) {
				if (downsample_fade.do_effect() == ScreenFade.DONE) {
					Registry.EVENT_FADE_OVER = true;
				}
			}	else if (Registry.EVENT_FADE_BEGUN && state == S_JUST_ENTERED_MAP) {
				if (upsample_fade.do_effect() == ScreenFade.DONE) {
					Registry.EVENT_FADE_OVER = true;
					
				}
			}
		}
		
		
	}

}