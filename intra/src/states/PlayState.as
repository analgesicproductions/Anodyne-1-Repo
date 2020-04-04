package states 
{
	import adobe.utils.CustomActions;
	import data.*;
	import entity.*;
	import entity.decoration.*;
	import entity.enemy.hotel.Eye_Boss;
	import entity.gadget.*;
	import entity.player.*;
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.filters.ShaderFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	import global.*;
	import helper.*;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import states.*;
	

	
	
	public class PlayState  extends FlxState {	
		
		public function PlayState() {
			
		}
		
		private var BACK_TEXT_MOBILE:FlxBitmapFont;
		// shaders
		private var static_shader:Shader = new Shader(new Common_Sprites.static_shader);
		private var static_shaderFilter:ShaderFilter;
		
		private var noScrollPt:FlxPoint;
		private var keyWatch:Keys;
		public var player:Player;
		public var player_group:FlxGroup;
		public var last_song_time:Number; // Hacky, used to check if the song has been "stuck" at the end and force a loop
		private var t_last_song_pos_checked:Number = 0;
		private var ambience:FlxSound = new FlxSound();
		private var has_ambient_sound:Boolean = false;
		
		
        private var stateful_mapXML:XML;
        public var stateful_gridXML:XML;
        public var statefuls:Array; // The current statefuls being interacted with
        private var stateless_mapXML:XML;
        private var stateless_gridXML:XML;
        public var statelesses:Array;
		public var anim_tiles_group:FlxGroup;
		
		/* movable flat gadgets - dust basically */
		public var intra_bg_bg2_sprites:FlxGroup;
		public var bg_sprites:FlxGroup;
		public var fg_sprites:FlxGroup;//stuff from ceiling
        public var otherObjects:Array; //Holds sub-sprites, like a lser of wall laser
		private var oldObjects:Array; // A buffer that holds the next to be loaded..
		private var oldStateless:Array;
		private var oldOthers:Array;
		public var sortables:FlxGroup;
		//BG anim_tiles BG2 flat_tiles sortables etc...
        
		/* BG */
		[Embed (source = "../res/sprites/decoration/BLANK_BG.png")] public static var BLANK_BG:Class;
		public var bg:FlxSprite; //background sprite
		public var has_bg:Boolean = false;
		public var map:FlxTilemap;
		private var mapData:Array;
		public var curMapBuf:FlxTilemap;
		public var prevMapBuf:FlxTilemap;
		public var map_bg_2:FlxTilemap; //on top of the bg map
		public var map_fg:FlxTilemap; // on top of all sprites but below darkness
        public var SWITCH_MAPS:Boolean = false;
		
		
		/* State vars and associated objects */
		public var state:int;
		public var S_NORMAL:int = 0;
		public var S_TRANSITION:int = 1;
        private var justTransitioned:Boolean = false;
		public static var dont_change_songs:Boolean = false;

        public var S_PAUSED:int = 2;
		public var pause_state:PauseState;
		private var pause_timer:Number = 0.2;
		
		private var S_PLAYER_DIED:int = 4;
		private var death_fadein:FlxSprite;
		private var death_text:FlxBitmapFont;
		private var played_death_sound:Boolean;
		private var start_death_fade_out:Boolean;
		
		private var S_JUST_ENTERED_MAP:int = 5;

		
		private var S_DIRECT_CONTROLS:int = 6;
		private var S_CUTSCENE:int = 7;
		private var cutscene:Cutscene;
		
		public var S_DIALOGUE:int = 8;
		public var load_dialogue:Boolean = false;
		public var dialogue_state:DialogueState;
		public var dialogue_latency:Number = 0.3;
		
		public var S_MINIMAP:int = 9;
		
		// reset sprites/arrays/etc before leavign
		private var cleaned_up_before_exit:Boolean;
		
		public  var upperBorder:int;
		public  var lowerBorder:int;
		public  var rightBorder:int;
		public  var leftBorder:int;
		public var Scroll_Increment:int = 4;
		
		public var debugText:FlxText;

		/* UI/Header entities */
        [Embed (source = "../res/sprites/inventory/header.png")] public static var Header:Class;
        [Embed (source = "../res/sprites/menu/autosave_icon.png")] public static var autosave_icon_embed:Class;
		public var header_group:FlxGroup;
		public var header:FlxSprite;	
		public var mm_map:Miniminimap;
		public var item_placeholder_1:FlxSprite;
		public var item_placeholder_2:FlxSprite;
        public var number_of_keys_text:FlxBitmapFont;
		public var autosave_icon:FlxSprite;
		
		/* Various graphical effect entities */
	
		public var darkness:FlxSprite;
		public var darkness_timer:Number = 1.5;
		public var black_overlay:FlxSprite;
		public var downscale:int = 1;
		public var downsample_fade:ScreenFade; 
		public var upsample_fade:ScreenFade;
		public var dec_over:FlxSprite;
		public var has_decor_overlay:Boolean;
		public var made_overlay:Boolean;
		public var fg_solid:Boolean = false;
		public var before_fg_overlay:FlxSprite;
		
		private var ran_constructors:Boolean = false;
		private var ran_Add:Boolean = false;
		private var playtime_timer:Number = 0;

		/**
		 * Allocate memory for everything. This should only be done ONCE
		 * over the entire life of the program.
		 */
		private function run_constructors():void {
			if (ran_constructors) return;
			trace("RUNNING CONSTRUCTORS");
			if (Registry.keywatch == null) {
				Registry.keywatch = new Keys();
			}
				//BACK_TEXT_MOBILE = EventScripts.init_bitmap_font("Press BACK again\nto exit.\nUnsaved progress\nwill be lost.", "center", 21, 22, null,"apple_white");
				BACK_TEXT_MOBILE = EventScripts.init_bitmap_font(DH.lk("title",17), "center", 21, 22, null,"apple_white");
			static_shaderFilter = new ShaderFilter(static_shader);
			
			noScrollPt = new FlxPoint(0, 0);
			player_group = new FlxGroup();
			
			statefuls = new Array(); // The current statefuls being interacted with
			statelesses = new Array();
			anim_tiles_group = new FlxGroup();
			
			/* movable flat gadgets - dust basically */
			intra_bg_bg2_sprites = new FlxGroup();
			bg_sprites = new FlxGroup();
			fg_sprites = new FlxGroup(); //stuff from ceiling
			otherObjects = new Array(); //Holds sub-sprites, like a lser of wall laser
			oldObjects = new Array(); // A buffer that holds the next to be loaded..
			oldStateless = new Array();
			oldOthers = new Array();
			sortables = new FlxGroup();
			
			before_fg_overlay = new FlxSprite(0, 0);
			
            darkness = new FlxSprite(0, Registry.HEADER_HEIGHT);
			dec_over = new FlxSprite(0, 0);
			dec_over.scrollFactor = noScrollPt;
			player = new Player(Registry.ENTRANCE_PLAYER_X, Registry.ENTRANCE_PLAYER_Y, Registry.keywatch,darkness,this);

			bg = new FlxSprite(0, 0);
			map = new FlxTilemap();
			mapData = new Array();
			curMapBuf = new FlxTilemap(); 
			prevMapBuf = new FlxTilemap();
			map_bg_2 = new FlxTilemap(); 
			map_fg= new FlxTilemap(); 
			
			
			number_of_keys_text = EventScripts.init_bitmap_font("x" + Registry.get_nr_keys().toString(), "left", 37, 7, null, "apple_white");
			death_fadein = new FlxSprite(0, 0); 
			black_overlay = new FlxSprite(0, 0);
			death_text = EventScripts.init_bitmap_font("Continue?", "center", 50, 60, null, "apple_white");
			
			pause_state = new PauseState();
			
			dialogue_state = new DialogueState();
			debugText = new FlxText(0, 0, 160);
			downsample_fade = new ScreenFade(160, 180, this, ScreenFade.T_DS);
			upsample_fade = new ScreenFade(160, 180, this, ScreenFade.T_US);
			
			header_group = new FlxGroup();
			header = new FlxSprite(0, 0);
			mm_map = new Miniminimap();
			item_placeholder_1 = new FlxSprite(10, 2);
			item_placeholder_2 = new FlxSprite(37, 2);
			autosave_icon = EventScripts.init_autosave_icon(autosave_icon, autosave_icon_embed);
			
			FlxG.watch(Registry,"GRID_PUZZLES_DONE","puzct");
			FlxG.watch(Registry, "GRID_ENEMIES_DEAD", "enmct");
			
			Registry.PLAYSTATE = this;
			ran_constructors = true;
		}
		
		// Called once per area. 
		public function init():void {
			Registry.PLAYSTATE = this;
			
			dialogue_state.set_dialogue_box();
			// Determine the decorative overlay if any, sits on top of all graphic
			made_overlay = false;
			GFX_STATIC_ALWAYS_ON = false;
			if (Registry.CURRENT_MAP_NAME == "SUBURB") {
				if (Registry.E_NEXT_MAP_NO_STATIC == true) {
					GFX_STATIC_ALWAYS_ON = true;
					Registry.E_NEXT_MAP_NO_STATIC = false;
				} else {
					GFX_STATIC_ALWAYS_ON = true;
					player.broom.loadGraphic(Broom.Knife_Sprite, true, false, 16, 16);
				}
			} else if (Registry.CURRENT_MAP_NAME == "DRAWER") {
				if (false == in_death_room) {
					GFX_STATIC_ALWAYS_ON = true;
				} else {
					DH.disable_menu();
				}
			} else if (Registry.CURRENT_MAP_NAME == "TRAIN") {
				player.broom.loadGraphic(Broom.Cell_Sprite, true, false, 16, 16);
			} else {
				player.broom.loadGraphic(Broom.Broom_Sprite,true,false,16,16);
			}
			
			has_decor_overlay = false;
			dec_over.exists = false;
			dec_over.velocity.x = dec_over.velocity.y = 0;
			
			// overlay before the FG (for forest)
			
			set_before_fg();	
			state = S_JUST_ENTERED_MAP;
			SWITCH_MAPS = false;
			cleaned_up_before_exit = false;
			played_death_sound = false;
			start_death_fade_out = false;
			has_bg = false;
			fg_solid = false;
			Registry.GFX_WAVE_EFFECT_ON = false;
			number_of_keys_text.text = "x" + Registry.get_nr_keys().toString();
			
			/* Set some globals*/
			Registry.GAMESTATE = this;
			
			/* Flip some bools*/
			if (Registry.CURRENT_MAP_NAME == "BEDROOM") {
				Registry.GE_States[Registry.GE_Bedroom_Visited] = true;
			} else if (Registry.CURRENT_MAP_NAME == "STREET") {
				Registry.GE_States[Registry.GE_ent_str] = true;
			} else if (Registry.CURRENT_MAP_NAME == "REDCAVE") {
				
			} else if (Registry.CURRENT_MAP_NAME == "CROWD") {
			} else {
				if (Registry.GE_States[Registry.GE_Bedroom_Boss_Dead_Idx]) {
					Registry.GE_States[Registry.GE_Left_BDR_After_Boss_Dead] = true;
				} 
				
				if (Registry.GE_States[Registry.GE_Redcave_Boss_Dead_Idx]) {
					Registry.GE_States[Registry.GE_Left_RDC_After_Boss_Dead] = true;
					trace("GE: Left Redcave after boss!");
				}
				
				if (Registry.GE_States[Registry.GE_Crowd_Boss_Dead_Idx]) {
					trace("GE: Left Crowd after boss!");
					Registry.GE_States[Registry.GE_Left_CRD_After_Boss_Dead] = true;
				}
			} 
			
			if (Registry.CURRENT_MAP_NAME == "NEXUS") {
				Registry.GE_States[Registry.GE_ENTERED_NEXUS_ONCE] = true;
			}  else if (Registry.CURRENT_MAP_NAME == "BLUE") {
				Registry.GE_States[Registry.GE_ENTERED_BLUE_ONCE] = true;
			}
			if (Registry.nr_growths < 36 || Registry.GE_States[Registry.GE_ENTERED_BLUE_ONCE] == false) {
				Registry.Nexus_Door_State[13] = false;
			}
			
			
			set_do_dark_fill(Registry.CURRENT_MAP_NAME);
			set_darkness(Registry.CURRENT_MAP_NAME);
			
			/* set player data */
			trace("Instantiating player at (",Registry.CURRENT_MAP_NAME, Registry.ENTRANCE_PLAYER_X, Registry.ENTRANCE_PLAYER_Y, ")");
			player.x = Registry.ENTRANCE_PLAYER_X;
			player.y = Registry.ENTRANCE_PLAYER_Y;
			player.gridX  = Registry.CURRENT_GRID_X = int(player.x / 160);
			player.gridY =  Registry.CURRENT_GRID_Y = int((player.y - Registry.HEADER_HEIGHT) / 160);
			player.grid_entrance_x = player.x;
			player.grid_entrance_y = player.y;
			player.reset_anodyne();
			
			downsample_fade.reset();
			upsample_fade.reset();
			
			
			black_overlay.alpha = 0;
			start_death_fade_out = false;
			played_death_sound = false;
			death_text.visible = false;
			death_fadein.visible = false;
			death_fadein.alpha = 0;
			
			last_song_time = 0;
			header.scrollFactor = noScrollPt;
		}
		// Essentially the "reset" function. Resets all thingies.
		override public function create():void {
			run_constructors();
			init();
			noScrollPt.x = noScrollPt.y = 0;
			/* Add watcher for keypresses */
			keyWatch = Registry.keywatch;

			// New-s a CSV
			pause_state.minimap.init_minimap();
			pause_state.minimap.stuff_for_pause_state();
			pause_state.minimap.update_visited_array(Registry.CURRENT_MAP_NAME, Registry.CURRENT_GRID_X, Registry.CURRENT_GRID_Y);
			mm_map.switch_map();
			mm_map.switch_rooms(Registry.CURRENT_GRID_X, Registry.CURRENT_GRID_Y);
			
			/* Load initial map data */ // No reset needed
            TileData.setTileset(Registry.CURRENT_MAP_NAME); 
			// getMap new-s a CSV Object
			map.loadMap(CSV_Data.getMap(Registry.CURRENT_MAP_NAME), TileData.Tiles, 16, 16);
			mapData = map.getData();
			map_bg_2.null_buffer(0);
			map_fg.null_buffer(0);
			map_bg_2.loadMap(CSV_Data.getMap(Registry.CURRENT_MAP_NAME, 2), TileData.Tiles, 16, 16);
			map_bg_2.y = Registry.HEADER_HEIGHT;
			map_fg.loadMap(CSV_Data.getMap(Registry.CURRENT_MAP_NAME, 3), TileData.Tiles, 16, 16);
			map_fg.y = Registry.HEADER_HEIGHT;
			TileData.set_tile_properties(map_bg_2);
			if (Registry.CURRENT_MAP_NAME == "OVERWORLD") {
				TileData.set_tile_properties(map_fg);
				fg_solid = true;
			}
			
			/* Uses player, and left/right/etcborder  to set new borders */
			updateScreenBorders();
	
			/* UI stuff */
            header.loadGraphic(Header, false, false, 160, 20);
			header.scrollFactor = noScrollPt;
			number_of_keys_text.color = 0x7ca3b1;
			
			
			/* Init camera, player position */
			FlxG.camera.setBounds(0, 0, 160, 180, true);
            FlxG.camera.bounds.x = player.gridX * 160;
            FlxG.camera.bounds.y = player.gridY * 160;
			
            FlxG.worldBounds.copyFrom(FlxG.camera.bounds);
	
			/* Set debug text if necessary */
			debugText.text = "Foo."; debugText.scrollFactor = noScrollPt;
			
			FlxG.debug = true;

            /* Modifies the cur/left/etcmapBufs */
			fillMapBuffers(true); 
            
			/* Death screen entities */
			death_fadein.scrollFactor = noScrollPt;
			if (Registry.CURRENT_MAP_NAME == "TRAIN") {
				death_text.color = 0xffffff;
				death_fadein.makeGraphic(Registry.SCREEN_WIDTH_IN_PIXELS, Registry.SCREEN_HEIGHT_IN_PIXELS + Registry.HEADER_HEIGHT, 0xff000000);
			} else {
				death_text.color = 0x000000;
				death_fadein.makeGraphic(Registry.SCREEN_WIDTH_IN_PIXELS, Registry.SCREEN_HEIGHT_IN_PIXELS + Registry.HEADER_HEIGHT, 0xffffffff);
			}
			death_fadein.alpha = 0;
			
			
			death_text.visible = false;
			
            /* Draw order */
			/* BG1, anim-tiles, BG2, bg_sprites, sortables (depth sorting here), above draw group, FG */
			set_bg();
			
            initXML();
			reviveGridLocalSprites();
			Registry.reset_subgroups(); // In case some leftover from previous state
            loadStatelessSprites();
			loadStatefulSprites();
			
            
			//NEEDS TO STAY
            for (var id:int = 0; id < otherObjects.length; id++) {
				trace("otherObject constructor: ", otherObjects[id]);
                sortables.add(otherObjects[id]);
            }
			
			/* Add to player group */
			player.foot_overlay.map = map;
			player.foot_overlay.reset_anodyne();
			player.foot_overlay_bg_bg2.map = map;
			player.foot_overlay_bg_bg2.reset_anodyne();
			if (Registry.CURRENT_MAP_NAME == "WINDMILL") {
				player.foot_overlay.exists = false;
			} else {
				player.foot_overlay_bg_bg2.exists = false;
			}
			
			black_overlay.scrollFactor = noScrollPt;
			black_overlay.makeGraphic(Registry.SCREEN_HEIGHT_IN_PIXELS, Registry.HEADER_HEIGHT + Registry.SCREEN_WIDTH_IN_PIXELS, 0xff000000);
			black_overlay.alpha = 1;
			if (Registry.FUCK_IT_MODE_ON) {
				black_overlay.alpha = 0.02;
			}
			
			/* Graphical effects */
			
			Registry.EVENT_FADE_BEGUN = true;
			// Decorative overlay
			load_decoration_overlay_graphic();
			
			/* Maybe play special sounds and songs */
			has_ambient_sound = false;
			if (!dont_change_songs) {
				Registry.sound_data.start_song_from_title(Registry.CURRENT_MAP_NAME);
				if (Registry.CURRENT_MAP_NAME == "BEACH") {
					has_ambient_sound = true;
					ambience = Registry.sound_data.waves;
					Registry.sound_data.waves.play();
					
				} else if (Registry.CURRENT_MAP_NAME == "WINDMILL") {
					has_ambient_sound = true;
					ambience = Registry.sound_data.rain;
					Registry.sound_data.rain.play();
				} else {
					Registry.sound_data.rain.stop();
					Registry.sound_data.waves.stop();
					
				}
			} 
			dont_change_songs = false;
			
		  
		  
			if (Registry.EVENT_TELEPORT_DOWN_SOUND) {
				Registry.sound_data.teleport_down.play();
				Registry.EVENT_TELEPORT_DOWN_SOUND = false;
			}
			
			/* Check for debug mode */
			if (Registry.FUCK_IT_MODE_ON) {
				Scroll_Increment = 160;
				
			}
			
			// Misc.
			Eye_Boss.global_state = Eye_Boss.gs_new;
			
			if (!ran_Add) {
				init_add();
				ran_Add = true;
			} 
			
			if (Registry.CURRENT_MAP_NAME == "FIELDS") {
				if (Registry.playtime < 60 * 10) {
					Achievements.unlock(Achievements.Fast_fields);
				}
			}
			
		}
		
		// Do all of the adding, only once in the lifetime of the program.
		private function init_add():void {
			
			add(keyWatch); 
			
			header_group.add(header);
			header_group.add(number_of_keys_text);
			header_group.add(player.health_bar);
			header_group.add(autosave_icon);
			header_group.add(mm_map);
			
			add(bg);
			add(prevMapBuf);
			add(curMapBuf);
			
			add(anim_tiles_group);
			add(player.reflection);
			add(player.reflection_broom);
			add(intra_bg_bg2_sprites);
			add(map_bg_2);
			add(bg_sprites);
			
			player.init_player_group(player_group, player, map);
			sortables.add(player_group);
			add(sortables);
			
			add(before_fg_overlay);
			add(fg_sprites);
			add(map_fg);
			
			add(dec_over);
			add(darkness);
			add(header_group);
			add(death_fadein);
			add(death_text);
			add(black_overlay);
			
			//add(debugText);
			debugText.text = Achievements.DEBUG_TEXT;
			debugText.exists = true;
			
			BACK_TEXT_MOBILE.alpha = 0;
			add(BACK_TEXT_MOBILE);
		}
		
		private var t_mobile_back:Number = 0;
		override public function update():void {
			number_of_keys_text.x = 37;
			if (DH.isZH()) number_of_keys_text.x = 35;
			
			if (Registry.MOBILE_ASK_TO_EXIT_WITH_BACK && state != S_PAUSED && pause_timer < 0) {
				t_mobile_back = 2;
				Registry.MOBILE_ASK_TO_EXIT_WITH_BACK = false;
				Registry.MOBILE_OKAY_TO_EXIT_WITH_BACK = true;
			} else if (state == S_PAUSED) {
				Registry.MOBILE_OKAY_TO_EXIT_WITH_BACK = false;
				Registry.MOBILE_ASK_TO_EXIT_WITH_BACK = false;
			}
			if (t_mobile_back > 0 ) {
				BACK_TEXT_MOBILE.alpha = t_mobile_back / 2.0;
				t_mobile_back -= FlxG.elapsed;
				if (t_mobile_back < 0) {
					Registry.MOBILE_OKAY_TO_EXIT_WITH_BACK = false;
				}
			}
			
			playtime_timer += FlxG.elapsed;
			if (playtime_timer >= 1) {
				playtime_timer -= 1;
				Registry.playtime += 1;
			}
			// Sometimes there's an issue where a song gets stuck even if I put the samples correctly
			// So this checks every half second if the ms head has stopped moving, and if so, loops the song.
			t_last_song_pos_checked += FlxG.elapsed;
			if (t_last_song_pos_checked > 0.5) {
				if (Registry.sound_data.current_song != null && Registry.sound_data.current_song._channel != null) {
					if (last_song_time != 0 &&  Registry.sound_data.current_song._channel.position - last_song_time < 5) {
						Registry.sound_data.start_song_from_title(Registry.sound_data.current_song_name);
					}
					last_song_time = Registry.sound_data.current_song._channel.position;
				}
				t_last_song_pos_checked = 0;
			}
			
			// Test mode stuff
			if (Intra.is_test) {
				ugly_test_mode_functions();
			}
			
			
			// Change alpha value of darkness overlay, maybe.
			darkness_timer -= FlxG.elapsed;
			
			if (Registry.EVENT_CHANGE_DARKNESS_ALPHA) {
				if (darkness.alpha >= Registry.EVENT_CHANGE_DARKNESS_ALPHA_TARGET) {
					if (EventScripts.send_alpha_to(darkness, Registry.EVENT_CHANGE_DARKNESS_ALPHA_TARGET, -0.02)) {
						Registry.EVENT_CHANGE_DARKNESS_ALPHA = false;
					}
				} else {
					if (EventScripts.send_alpha_to(darkness, Registry.EVENT_CHANGE_DARKNESS_ALPHA_TARGET, 0.02)) {
						Registry.EVENT_CHANGE_DARKNESS_ALPHA = false;
					}
				}
				darkness.alpha = int(Math.round(darkness.alpha * 100)) / 100;
				//???
				
			}
			
			if (Registry.E_FADE_AND_SWITCH) {
				Registry.EVENT_CHANGE_VOLUME_SCALE = false;
				if (!Registry.E_FADED) {
					Registry.volume_scale -= 0.027;
					if (Registry.volume_scale <= 0) {
						Registry.volume_scale = 0;
						Registry.sound_data.start_song_from_title(Registry.E_FADE_AND_SWITCH_SONG);
						Registry.E_FADED = true;
					}
				} else {
					Registry.volume_scale += 0.027;
					if (Registry.volume_scale >= 1) {
						Registry.volume_scale = 1;
						Registry.E_FADE_AND_SWITCH = false;
						Registry.E_FADED = false;
					}
				}
			}
			
			
			// Makes the overlay, if it's a image tiled in a 2x2 pattern, 
			// repeat as it hits the edges, based on its width. should be larger than 160x160 to not appear awkward unless
			// it's not obvious how it repeats. 
			update_decoration_overlay();	
			
			// Scale ambience
			if (has_ambient_sound) {
				ambience.volume = FlxG.volume * Registry.volume_scale;
				if (Registry.CURRENT_MAP_NAME == "BEACH") {
					if (Registry.CURRENT_GRID_Y == 2) {
						ambience.volume *= 0.55;
					} else if (Registry.CURRENT_GRID_Y < 2) {
						ambience.volume *= 0.21;
					} 
				}
			}
			
			
			if (state ==  S_NORMAL) {
				stateNormal(); 
			} else if (state ==  S_TRANSITION) {
				Registry.sound_data.current_song.volume = FlxG.volume * Registry.volume_scale;
				stateTransition(); doCollisions();  super.update(); return; 
			} else if (state ==  S_PAUSED) {
				statePaused();
				Registry.sound_data.current_song.volume = FlxG.volume * Registry.volume_scale;
				return;
			} else if (state ==  S_PLAYER_DIED) {
				state_player_died();
				if (SWITCH_MAPS) {
					state = S_NORMAL;
				}
				super.update();
				return;
			} else if (state ==  S_JUST_ENTERED_MAP) {
				black_overlay.alpha -= 0.02;
				player.dontMove = true;
				if (Registry.FUCK_IT_MODE_ON) {
					
					Registry.EVENT_FADE_BEGUN = false;
					Registry.EVENT_FADE_BEGUN = true;
				}
				if (black_overlay.alpha <= 0 && Registry.EVENT_FADE_OVER) { 
					state = S_NORMAL; player.dontMove = false; 
					Registry.EVENT_FADE_BEGUN = Registry.EVENT_FADE_OVER = false;
				}
				super.update();
				return;
			} else if (state ==  S_DIRECT_CONTROLS) {
				stateControls();
				return;
			} else if (state ==  S_CUTSCENE) { //update cutscene event or whatever
				stateCutscene(); 
				return;
			} else if (state == S_DIALOGUE) {
				dialogue_state.update();
				if (dialogue_state.is_finished) {
					
					reset_dialogue_state_on_finish();
				}
			} 
			
			// Only actually transition once any dialogue is done
			if (SWITCH_MAPS && DH.a_chunk_is_playing() == false) {
				state = S_NORMAL;
				transition_out();
				return;
			}
            
			if (has_bg) {
				if (bg.x < -160) bg.x = 0;
				if (Registry.CURRENT_MAP_NAME == "BLANK") {
					if (Math.random() < 0.1) FlxG.shake(0.002, 0.1);
					if (Math.random() < 0.01) darkness.alpha = 0.2;
					darkness.alpha -= 0.05;
				}
				if (Registry.CURRENT_MAP_NAME == "GO") {
					if (bg.y > 20) {
						bg.y = -140;
					}
				}
				
				if (Registry.CURRENT_MAP_NAME == "NEXUS") {
					if (bg.y > 20) {
						bg.y = -140;
					}
				}
			}
			
            Registry.sound_data.current_song.volume = FlxG.volume * Registry.volume_scale;
			checkEvents();
			doCollisions();
			super.update();
			Registry.E_Dialogue_Just_Finished = false;
		}
		
		
		
		private function checkEvents():void {
			if (Registry.EVENT_OPEN_BROOM) {
				//Registry.sound_data.start_song_from_title("STREET_2");
				Registry.EVENT_OPEN_BROOM = false;
			}
			
			if (Registry.EVENT_OSCILLATE_DARKNESS_ALPHA) {
				if (darkness_timer > 0) {
					EventScripts.send_alpha_to(darkness, 0, -0.003);
				} else {
					EventScripts.send_alpha_to(darkness, 1, 0.003);	
					if (darkness_timer < -3) darkness_timer = 3;
				}
			}
			
			
			if (Registry.EVENT_EXTEND_HEALTH) {
				
				HealthBar.upgrade_health(player);
				//Add blocking event functionality here if you want...
				Registry.EVENT_EXTEND_HEALTH = false;
			}
			
			if (Registry.EVENT_CHANGE_VOLUME_SCALE) {
				if (EventScripts.send_property_to(Registry, "volume_scale", Registry.EVENT_CHANGE_VOLUME_SCALE_TARGET, 0.01))
					Registry.EVENT_CHANGE_VOLUME_SCALE = false;
			}
			
			/* If this is thrown, reset the current cutscene (if it exists),
			 * then initialize the next cutscene's views/objects etc
			 * */
			if (Registry.E_Load_Cutscene) { 
				state = S_CUTSCENE;
				Registry.E_Load_Cutscene = false;
				cutscene = new Cutscene(this);
				cutscene.push(this as FlxState);
				
			}
			
			
		}
		
		/** These obviously aren't really collisions but updating state and checking fo shit */
		private function doCollisions():void {
			
			FlxG.collide(curMapBuf, player);
			FlxG.collide(map_bg_2, player);
			if (fg_solid) {
				FlxG.collide(map_fg, player);
			}
			
		}
		
		
		/** Functions associated with NORMAL STATE **/
		private function stateNormal():void {
			checkForTransition();

            /* Only pause or enter controls if we're not in the middle of a transition */
            if (pause_timer < 0 && (Registry.keywatch.JUST_PRESSED_PAUSE || FlxG.keys.justPressed("ESCAPE")) && state != S_TRANSITION) {
								
				pause_timer = 0.2;
				if (FlxG.keys.justPressed("ESCAPE") && Registry.disable_menu == false) {
					if (false == in_death_room) {
						state = S_DIRECT_CONTROLS;
						pause_state.controls_state.change_text();
						pause_state.controls_state.push(this);
					}
				} else if (Registry.disable_menu == false) {
					state = S_PAUSED;
					pause_state.current_substate_visible = false;
					add(pause_state);
					//pause_state.push(this);
					Registry.sound_data.play_sound_group(Registry.sound_data.pause_sound_group);					
					//pause_state.set_inventory_icons(pause_state.inventory_icon_array);
					pause_timer = 0.2;
				}
            } else {
				pause_timer -= FlxG.elapsed;
			}
			
			/* Check for player death */
			if (player.health_bar.cur_health <= 0) {
				player.play("die");
				player.ANIM_STATE = player.ANIM_DEAD;
				player.alive = false;
				//player.unraftify_safely();
				var pt:FlxPoint = player.getScreenXY();
				player.scrollFactor.x = player.scrollFactor.y = 0;
				player.x = pt.x;
				player.y = pt.y;
				Registry.sound_data.stop_current_song();
				player.velocity.x = player.velocity.y = 0;
				player.framePixels_y_push = 0;
				
				remove(player, true);
				add(player);
				state = S_PLAYER_DIED;
			}
			
			
			if (dialogue_latency > 0) {
				dialogue_latency -= FlxG.elapsed;
			}
			if (load_dialogue) {
			   load_dialogue = false;
				if (dialogue_latency < 0) { //only load dialogue if latency over
					state = S_DIALOGUE;
					player.dontMove = true;
					player.state = player.S_INTERACT;
					dialogue_state.push(this as FlxState);
					
				}
			}
			
		}
		
		/*Check for a transition.
		 * If we need to transition, "bump" the player to the next part, change the grid
		 * coordinates, and switch state to S_TRANSITION, where camera movement/sprite spawning/map buffering 
		 * will be taken care of. */
		private function checkForTransition():void {
			if (player.x < leftBorder) {
				state = S_TRANSITION; player.gridX--; Registry.CURRENT_GRID_X--;
				player.x = leftBorder - 12;
			} else if (player.y < upperBorder) {
				state = S_TRANSITION; player.gridY--; Registry.CURRENT_GRID_Y--;
				
				player.y = upperBorder - 12;
			} else if (player.y > lowerBorder - 12) {
				state = S_TRANSITION; player.gridY++;  Registry.CURRENT_GRID_Y++;
				player.y = lowerBorder;
			} else if (player.x > rightBorder - 12) {
				state = S_TRANSITION; player.gridX++;Registry.CURRENT_GRID_X++;
				player.x = rightBorder;
			} else {
				
			}
			
			//debugText.text += " ub: " + upperBorder.toString() + "leb: " + leftBorder.toString() + "\n camx: " + FlxG.camera.bounds.x.toString() + "camy: " + FlxG.camera.bounds.y.toString() + 
			//"\n x: " + player.x.toFixed(2) + " y: " + player.y.toFixed(2);
		
			if (state == S_TRANSITION) {
				player.grid_entrance_x = player.x;
				player.grid_entrance_y = player.y;
				justTransitioned = true;
				player.dontMove = true;
			}
		}
		
		/* Move the camera's active viewport during a screen transition. */
		private function updateCamera():int {
			
			if (FlxG.camera.bounds.x < leftBorder) {
				FlxG.camera.bounds.x += Scroll_Increment; return 1;
			} else if (FlxG.camera.bounds.y < upperBorder - Registry.HEADER_HEIGHT) {
				FlxG.camera.bounds.y += Scroll_Increment; return 1;
			} else if (FlxG.camera.bounds.y > upperBorder - Registry.HEADER_HEIGHT) {
				FlxG.camera.bounds.y -= Scroll_Increment; return 1;
			} else if (FlxG.camera.bounds.x > leftBorder) {
				FlxG.camera.bounds.x -= Scroll_Increment; return 1;
			} else {
				FlxG.worldBounds.copyFrom(FlxG.camera.bounds); return 0;
			}
		}
		
		/** Functions associated with TRANSITION STATE **/
		/**
		 * Reset count of enemies killed and puzzles done on grid.
		 * Save the state of any stateful objects. Reset the state of stateless objects.
		 * Move the camera to the next screen, making sure to keep the draw order correct 
		 * 	scanlines > player assets > everything else
		 * Load in the new sprites.
		 */
		private function stateTransition():void {
			player.invincible = true;
			if (justTransitioned) {
				Registry.destroy_destroyems(); // Try not to put stuff in here
				// Keep in mind you have to manually remove things you add to sortables, since sortables
				// is stupidly a mix of things added through spritefactory, and inside of separate classes
				Registry.GRID_ENEMIES_DEAD = 0;
				Registry.GRID_PUZZLES_DONE = 0;
				updateScreenBorders();
				clearOthers(); //Move the fg/bg/sortables into the oldOthers array.
				fillMapBuffers(false);
                clearStateless();
				Registry.reset_subgroups(); 
                loadStatelessSprites();
                clearStateful(); // Update the XML as necessary
                loadStatefulSprites();
				for (var id:int = 0; id < otherObjects.length; id++) {
					sortables.add(otherObjects[id]);
				}
				//trace("Added ", id, " other objects to grid from XML");
				player.cleanup_on_grid_transition();
				fade_songs_screen_change();
				justTransitioned = false;
			}
            if (!updateCamera()) { // The order of these calls is very important.
				player.invincible = false;
                deleteOtherObjects(); // Stop everything in oldOthers from drawing, and call destroy on them.
				deletePrevStateless();
				deletePrevStateful();
				mm_map.switch_rooms(Registry.CURRENT_GRID_X, Registry.CURRENT_GRID_Y);
				player.broom.visible = false;
				player.broom.frame = 9;
				player.broom._curAnim = null;
				player.transformer.reset_next();
                player.dontMove = false; // Give player control
				// update the minimap
				pause_state.minimap.update_visited_array(Registry.CURRENT_MAP_NAME, Registry.CURRENT_GRID_X, Registry.CURRENT_GRID_Y);
                state = S_NORMAL;
            }
		}
		
		private function fade_songs_screen_change():void {
			switch (Registry.CURRENT_MAP_NAME) {
				case "HAPPY":
					var x:int = Registry.CURRENT_GRID_X;
					var y:int = Registry.CURRENT_GRID_Y;
					var b:Boolean = Registry.E_FADE_AND_SWITCH;
					if (x == 2 && y == 2 && ( b || Registry.sound_data.current_song_name == "HAPPY")
					
					) {
						Registry.E_FADE_AND_SWITCH = true;
						Registry.E_FADE_AND_SWITCH_SONG = "HAPPYINIT";
					} else if (x == 1 && y == 2 && ( b || Registry.sound_data.current_song_name == "HAPPYINIT") && Registry.GE_States[Registry.GE_Happy_Started]) {
						Registry.E_FADE_AND_SWITCH = true;
						Registry.E_FADE_AND_SWITCH_SONG = "HAPPY";
					} else if (x == 4 && y == 2 && ( b || Registry.sound_data.current_song_name == "HAPPY")) {
						Registry.E_FADE_AND_SWITCH = true;
						Registry.E_FADE_AND_SWITCH_SONG = "HAPPYINIT";
					} else if (x == 4 && y == 1 && ( b || Registry.sound_data.current_song_name == "HAPPYINIT") && Registry.GE_States[Registry.GE_Happy_Started]) {
						Registry.E_FADE_AND_SWITCH = true;
						Registry.E_FADE_AND_SWITCH_SONG = "HAPPY";
					}
					break;
				default:
			}
		}
		/** Various functions with map drawing **/
	
		private function fillMapBuffers(isInit:Boolean):void {
        /* Entity map array - enemies, switches, locked doors, doors, etc. When drawing through this, everything will have an ID:
             * 0 - no state - everything resets upon leaving/re-entering, or no state at all - Doors.
             * 1 - partial state - should be stored to the local area array upon first entry, or checked to reload. stores 
             * 						things like position, alive/dead, on/off. resets upon area entry/re-entry
             * 2 - global state - things like events, bosses, treasure boxes, NPCs. These should be serialized into a save file
             * upon saving, and stored in memory throughput a play session. These will need to be imported with XML and proper
             * IDs. When entering a room, always check to see if we need to load from the global state rather than what's stored
             * on the map/xml data struct or whatever. */
            
			 var nextMapData:Array = get_submap_from_map(player.gridX, player.gridY, true);
			 var prevMapData:Array = get_submap_from_map(curMapBuf.x / 160, (curMapBuf.y - Registry.HEADER_HEIGHT) / 160, false);
            if (isInit) {
                curMapBuf.loadMap(FlxTilemap.arrayToCSV(nextMapData, Registry.SCREEN_WIDTH_IN_TILES), TileData.Tiles, 16, 16);
                prevMapBuf.loadMap(FlxTilemap.arrayToCSV(nextMapData, Registry.SCREEN_WIDTH_IN_TILES), TileData.Tiles, 16, 16);
                curMapBuf.x = player.gridX * Registry.SCREEN_WIDTH_IN_PIXELS;
                curMapBuf.y = player.gridY * Registry.SCREEN_HEIGHT_IN_PIXELS + Registry.HEADER_HEIGHT;
                prevMapBuf.y = curMapBuf.y;
                
            } else {
                prevMapBuf.loadMap(FlxTilemap.arrayToCSV(prevMapData, Registry.SCREEN_WIDTH_IN_TILES), TileData.Tiles, 16, 16);
                prevMapBuf.x = curMapBuf.x;
                prevMapBuf.y = curMapBuf.y;
                curMapBuf.loadMap(FlxTilemap.arrayToCSV(nextMapData, Registry.SCREEN_WIDTH_IN_TILES), TileData.Tiles, 16, 16);
                curMapBuf.x = player.gridX * Registry.SCREEN_WIDTH_IN_PIXELS;
                curMapBuf.y = player.gridY * Registry.SCREEN_HEIGHT_IN_PIXELS + Registry.HEADER_HEIGHT;
            }
			nextMapData = null;
			prevMapData = null;
                
                //Set static tile properties
			TileData.set_tile_properties(curMapBuf);
        }
		
		public function ext_make_anims():void {
			get_submap_from_map(Registry.CURRENT_GRID_X, Registry.CURRENT_GRID_Y, true);
		}
		private function get_submap_from_map(gridX:int, gridY:int,make_anims:Boolean):Array {
			var submap:Array = new Array();
			var gridTileOffsetX:int = gridX * Registry.SCREEN_WIDTH_IN_TILES
            var gridTileOffsetY:int = gridY * Registry.SCREEN_HEIGHT_IN_TILES;
            var tileType:int;
			
            var i:int; var j:int;
            for (j = 0; j < Registry.SCREEN_HEIGHT_IN_TILES; j++) {
                for (i = 0; i < Registry.SCREEN_WIDTH_IN_TILES; i++) {
                    tileType = mapData[(gridTileOffsetY + j) * map.widthInTiles + gridTileOffsetX + i];
					if (make_anims) {
						TileData.make_anim_tile(anim_tiles_group, Registry.CURRENT_MAP_NAME, tileType, gridTileOffsetX * 16 + 16 * i, gridTileOffsetY * 16 + 16 * j + 20);
					}
                    submap.push(tileType);
                }
            }
			
			return submap;
		}
	
		
		private function updateScreenBorders():void {
			leftBorder = player.gridX * Registry.SCREEN_WIDTH_IN_PIXELS;
			rightBorder = (1 + player.gridX) * Registry.SCREEN_WIDTH_IN_PIXELS;
			upperBorder = player.gridY * Registry.SCREEN_HEIGHT_IN_PIXELS + Registry.HEADER_HEIGHT;
			lowerBorder = (1 + player.gridY) * Registry.SCREEN_HEIGHT_IN_PIXELS + Registry.HEADER_HEIGHT;
		}
		
    /* Functions associated with maintaining the state via XML */
	
		/**
		 * Sets the stateful_mapXML::XML and stateless_mapXML::XML to
		 * the current subtree for the area, so that sprites can be spawned.
		 */
        private function initXML():void {
            var map:XML;
			stateful_mapXML = null;
			stateless_mapXML = null;
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
        
		/**
		 * Loads sprites that generally do not have any state associated with them
		 * and places them into statelesses::Array . Then, adds them to
		 * sortables::FlxGroup .
		 */
        private function loadStatelessSprites():void {
            var grid:XML;
            if (stateless_mapXML == null) return;
            
            for each (grid in stateless_mapXML.grid) {
                if (grid.@grid_x == player.gridX.toString() && grid.@grid_y == player.gridY.toString()) {
                    stateless_gridXML = grid; break;
                }
            }
            if (stateless_gridXML == null) return;
            
            var i:int;
			var retval:int;
			var offset:int = 0;
			/** Terrible hack. Retval is how many extra *STATELESS* sprites were added. 
			 * So offset compensates to figure out where to add the "parent" sprite */
            for (i = 0; i < stateless_gridXML.child("*").length(); i++) {
                retval = SpriteFactory.makeSprite(stateless_gridXML.child("*")[i], i, statelesses, otherObjects, player, this, darkness);
				if (retval != -1) {
					sortables.add(statelesses[offset]);
					//trace(statelesses[offset]);
					offset += (retval + 1);
				}
            }
        }
        
        private function deletePrevStateless():void {
            var nrKilled:int = 0;
			var o:FlxBasic;
            while (oldStateless.length > 0) {
				o = oldStateless.pop();
				//trace(o);
                sortables.remove(o, true);
				if (o != null) o.destroy();
				o = null;
                nrKilled++;
            }
        }
        
		private function clearStateless():void {
			while (statelesses.length > 0) {
				oldStateless.push(statelesses.pop());
			}
            stateless_gridXML = null;
		}
  
		/**
		 * Load some sprites that generally have serialized state and 
		 * place them into statefuls::Array . Then, add them to sortables::FlxGroup .
		 */
        private function loadStatefulSprites():void {
            var grid:XML;
            if (stateful_mapXML == null) return;
            for each (grid in stateful_mapXML.grid) {
                if (grid.@grid_x == player.gridX.toString() && grid.@grid_y == player.gridY.toString()) {
                    stateful_gridXML = grid; break;
                }
            }
            if (stateful_gridXML == null) return; //No stateful sprites on this grid
            var id:int; //Stateful objects will have IDs set to index into the XML
            var nrStatefuls:int = 0;
            for (id = 0; id < stateful_gridXML.child("*").length(); id++) {
                if ( -1 != SpriteFactory.makeSprite(stateful_gridXML.child("*")[id], id, statefuls,otherObjects,player,this,darkness)) {
                    nrStatefuls++; //Number of stateful objects we made in DAME, not counting sprites that have subsprites (i.e., laser of wall laser)
				} else {
                    continue;
                }
            }
            // Now add these sprites in
            for (id = 0; id < statefuls.length; id++) {
                sortables.add(statefuls[id]);
            }
        }
        /**
         * Saves the references to the current stateful sprites so they can be removed when they are
		 * off-screen. Clears the stateful array so the new ones can be added.
         */
        private function clearStateful():void {
            var o:Object;
            while (statefuls.length > 0) {
                o = statefuls.pop();
                if (o != null) {
					oldObjects.push(o);
                }
            }
            stateful_gridXML = null;
        }
		
		/**
		 * Call destroy on all objects in oldObjects::Array and also removes them
		 * from sortables::FlxGroup .
		 */
		private function deletePrevStateful():void {
			var o:FlxBasic;
			var nr:int;
			while (oldObjects.length > 0) {
				o = oldObjects.pop() as FlxBasic;
				if (o != null) {
					nr++;
					sortables.remove(o, true);
					o.destroy();
				}
			}
		}

		/**
		 * Push some objects into the bag to be deleted later
		 */
		private function clearOthers():void {
			while (otherObjects.length > 0) {
				oldOthers.push(otherObjects.pop());
			}
			var o:*;
			for each (o in bg_sprites.members) {
				oldOthers.push(o);
			}
			
			for each (o in fg_sprites.members) {
				oldOthers.push(o);
			}
			
			for each (o in intra_bg_bg2_sprites.members) {
				//foot overlay in windmill goes here don't EVER fckign remov it fuck
				if (o != player.foot_overlay_bg_bg2) { 
					oldOthers.push(o);
				}
			}
			for each (o in anim_tiles_group.members) {
				if (o != null) oldOthers.push(o);
			}
		}
        private function deleteOtherObjects():void {
			//trace("Removing ", oldOthers.length, " other objects");
			var o:*;
            while (oldOthers.length > 0) {
				o = oldOthers.pop();
				if (o == null) continue;
                sortables.remove(o, true);
				bg_sprites.remove(o, true); //lol 
				fg_sprites.remove(o, true);
				intra_bg_bg2_sprites.remove(o, true);
				anim_tiles_group.remove(o, true);
				o.destroy();
            }
        }
        /* Revive sprites with permanence level 1 (MAP_LOCAL) when leaving a map */
        private function reviveGridLocalSprites():void {
            var grid:XML; 
            var id:int;
			if (stateful_mapXML != null) {
				for each (grid in stateful_mapXML.grid) {
					for (id = 0; id < grid.child("*").length(); id++) {
						if (grid.child("*")[id].@p == 1 && grid.child("*")[id].@alive == "false") {
							grid.child("*")[id].@alive = "true";
						}
					}
				}
			}
			
			if (stateless_mapXML != null) {
				for each (grid in stateless_mapXML.grid) {
					for (id = 0; id < grid.child("*").length(); id++) {
						if (grid.child("*")[id].@p == 1 && grid.child("*")[id].@alive == "false") {
							grid.child("*")[id].@alive = "true";
						}
					}
				}
			}
        }

		/* Direct access to controls state */
		private function stateControls():void {
			pause_state.controls_state.update();
			Registry.keywatch.update();
			if (!pause_state.controls_state.updating && Registry.keywatch.JUST_PRESSED_PAUSE) {
				state = S_NORMAL;
				pause_state.controls_state.pop(this);
			}
		}
        /** Functions associated with PAUSED STATE **/
        
        private function statePaused():void {
			pause_state.update();
			Registry.keywatch.update();
            if (pause_state.done == true) {
				pause_state.done = false;
                state = S_NORMAL;
				//pause_state.pop(this);
				remove(pause_state, true);
				if (Registry.GAMESTATE != null) {
					Registry.GAMESTATE.dialogue_state.set_dialogue_box();
				}
            }
        }
		
		
		// Based on the map name, load a graphic for the decorative overlay.
		// Then add anims, set its velocity if needed, etc
		// Add embedded graphics to src/data/Common_Sprites.as ! 
		private function load_decoration_overlay_graphic():void 
		{
			made_overlay = true;
			switch (Registry.CURRENT_MAP_NAME) {
				case "WINDMILL":
				//default:
				//	break;
					
					dec_over.loadGraphic(Common_Sprites.windmill_overlay, true, false, 320, 320);
					dec_over.addAnimation("blah", [0], 2);
					dec_over.play("blah");
					dec_over.exists = true;
					dec_over.velocity.y = 160;
					dec_over.velocity.x = -10;
					break;
				case "SUBURB":
				case "DRAWER":
					if (GFX_STATIC_ALWAYS_ON == false) return;
					//dec_over.loadGraphic(Common_Sprites.static_map as Class, true, false, 160, 160);
					dec_over.y = 20;
					dec_over.velocity.x = dec_over.velocity.y = 0;
					dec_over.pixels = Common_Sprites.static_map.bitmapData;
					dec_over.width = dec_over.height = 160;
					dec_over.frameHeight = dec_over.frameWidth = 160;
					dec_over.addAnimation("a", [0, 1, 2, 3], 8);
					dec_over.play("a");
					dec_over.exists = true;
					break;
				case "STREET":
					dec_over.blend = "overlay";
					dec_over.y = 20;
					dec_over.loadGraphic(Common_Sprites.street_blend, true, false, 160, 160);
					//dec_over.exists = true;
					dec_over.velocity.x = dec_over.velocity.y = 0;
					break;
					
			}
		}
		
		private function update_decoration_overlay():void 
		{
			if (dec_over.exists) {
				if (dec_over.x < -dec_over.width / 2) {
					dec_over.x += dec_over.width / 2;
				} else if (dec_over.x > 0) {
					dec_over.x -= dec_over.width / 2;
				}
				if (dec_over.y > Registry.HEADER_HEIGHT) {
					dec_over.y -= dec_over.height / 2;
				} else if (dec_over.y < -dec_over.height / 2 + Registry.HEADER_HEIGHT)  {
					dec_over.y += dec_over.height / 2;
				}
			}
		
		}
		
		/**
		 * Called if the game is in Test_mode. 
		 * Currently just lets you warp around the dungeons
		 */
		private function ugly_test_mode_functions():void 
		{
			if (FlxG.keys.D) {
				if (FlxG.keys.justPressed("ONE")) {
					SWITCH_MAPS = true;
					Registry.NEXT_MAP_NAME = "BEDROOM";
					Registry.inventory[Registry.IDX_JUMP] = false;
					header_group.remove(player.health_bar, true);
					player.health_bar = new HealthBar(155, 2, 6);
					header_group.add(player.health_bar);
					
					Registry.ENTRANCE_PLAYER_X = Registry.DUNGEON_ENTRANCES["BEDROOM"].x;
					Registry.ENTRANCE_PLAYER_Y = Registry.DUNGEON_ENTRANCES["BEDROOM"].y;
				} else if (FlxG.keys.justPressed("TWO")) {
					SWITCH_MAPS = true;
					Registry.NEXT_MAP_NAME = "REDCAVE";
					Registry.inventory[Registry.IDX_JUMP] = false;
					Registry.ENTRANCE_PLAYER_X = Registry.DUNGEON_ENTRANCES["REDCAVE"].x;
					Registry.ENTRANCE_PLAYER_Y = Registry.DUNGEON_ENTRANCES["REDCAVE"].y;
					header_group.remove(player.health_bar, true);
					player.health_bar = new HealthBar(155, 2, 7);
					header_group.add(player.health_bar);
				}else if (FlxG.keys.justPressed("THREE")) {
					SWITCH_MAPS = true;
					Registry.NEXT_MAP_NAME = "CROWD";
					Registry.inventory[Registry.IDX_JUMP] = false;
					Registry.ENTRANCE_PLAYER_X = Registry.DUNGEON_ENTRANCES["CROWD"].x;
					Registry.ENTRANCE_PLAYER_Y = Registry.DUNGEON_ENTRANCES["CROWD"].y;
					header_group.remove(player.health_bar, true);
					player.health_bar = new HealthBar(155, 2, 7);
					header_group.add(player.health_bar);
				}else if (FlxG.keys.justPressed("FOUR")) {
					SWITCH_MAPS = true;
					player.health_bar = new HealthBar(155, 2, 9);
					Registry.NEXT_MAP_NAME = "APARTMENT";
					Registry.inventory[Registry.IDX_JUMP] = true;
					Registry.ENTRANCE_PLAYER_X = Registry.DUNGEON_ENTRANCES["APARTMENT"].x;
					Registry.ENTRANCE_PLAYER_Y = Registry.DUNGEON_ENTRANCES["APARTMENT"].y;
					header_group.remove(player.health_bar, true);
					player.health_bar = new HealthBar(155, 2, 9);
					header_group.add(player.health_bar);
				}else if (FlxG.keys.justPressed("FIVE")) {
					SWITCH_MAPS = true;
					Registry.NEXT_MAP_NAME = "HOTEL";
					Registry.inventory[Registry.IDX_JUMP] = true;
					Registry.ENTRANCE_PLAYER_X = Registry.DUNGEON_ENTRANCES["HOTEL"].x;
					Registry.ENTRANCE_PLAYER_Y = Registry.DUNGEON_ENTRANCES["HOTEL"].y;
					header_group.remove(player.health_bar, true);
					player.health_bar = new HealthBar(155, 2, 9);
					header_group.add(player.health_bar);
				}else if (FlxG.keys.justPressed("SIX")) {
					SWITCH_MAPS = true;
					Registry.NEXT_MAP_NAME = "CIRCUS";
					Registry.inventory[Registry.IDX_JUMP] = true;
					Registry.ENTRANCE_PLAYER_X = Registry.DUNGEON_ENTRANCES["CIRCUS"].x;
					Registry.ENTRANCE_PLAYER_Y = Registry.DUNGEON_ENTRANCES["CIRCUS"].y;
					header_group.remove(player.health_bar, true);
					player.health_bar = new HealthBar(155, 2, 9);
					header_group.add(player.health_bar);
				} else if (FlxG.keys.justPressed("SEVEN")) {
					SWITCH_MAPS = true;
					Registry.NEXT_MAP_NAME = "STREET";
					Registry.inventory[Registry.IDX_BROOM] = false;
					Registry.inventory[Registry.IDX_JUMP] = false;
					Registry.ENTRANCE_PLAYER_X = Registry.DUNGEON_ENTRANCES["STREET"].x;
					Registry.ENTRANCE_PLAYER_Y = Registry.DUNGEON_ENTRANCES["STREET"].y;
					header_group.remove(player.health_bar, true);
					player.health_bar = new HealthBar(155, 2, 6);
					header_group.add(player.health_bar);
				} else if (FlxG.keys.justPressed("EIGHT")) {
					SWITCH_MAPS = true;
					Registry.NEXT_MAP_NAME = "DEBUG";
					Registry.ENTRANCE_PLAYER_X = 10;
					Registry.ENTRANCE_PLAYER_Y = 10;
				}
				
				Registry.inventory[Registry.IDX_BROOM] = true;
				Registry.bound_item_1 = "BROOM";
				Registry.inventory[Registry.IDX_WIDEN] = true;
				Registry.inventory[Registry.IDX_LENGTHEN] = true;
				
				if (Registry.inventory[Registry.IDX_JUMP]) {
					Registry.bound_item_2 = "JUMP";
				} else {
					Registry.bound_item_2 = "";
				}
			}
		}
		
		private function reset_dialogue_state_on_finish():void 
		{
			player.dontMove = false;
			player.state = player.S_GROUND;
			state = S_NORMAL;
			dialogue_latency =  0.3;	
			
			
			dialogue_state.reset();
			Registry.E_Dialogue_Just_Finished = true;
			dialogue_state.pop(this as FlxState);
		}
		
		private function set_bg():void 
		{
			has_bg = true;
			bg.visible = true;
			bg.scrollFactor = noScrollPt;
			bg.velocity.x = bg.velocity.y = 0;
			bg.x = 0;
			bg.y = 0;
			if (Registry.CURRENT_MAP_NAME == "BLANK") {
				bg.loadGraphic(BLANK_BG, false, false, 320, 160);
				bg.y = 20;
				bg.velocity.x = -20;
			} else if (Registry.CURRENT_MAP_NAME == "SPACE") {
				bg.loadGraphic(Common_Sprites.space_bg, false, false, 320, 160);
				bg.y = Registry.HEADER_HEIGHT;
				bg.velocity.x = -15;
			} else if (Registry.CURRENT_MAP_NAME == "GO") {
				bg.loadGraphic(Common_Sprites.briar_Bg, false, false, 160,320);
				bg.y = Registry.HEADER_HEIGHT;
				bg.velocity.y = 15;
			} else if (Registry.CURRENT_MAP_NAME == "NEXUS") {
				bg.loadGraphic(Common_Sprites.nexus_bg, false, false, 160, 320);
				bg.y = Registry.HEADER_HEIGHT - 160;
				bg.velocity.y = 15;
				bg.velocity.x = 0;
			} else {
				has_bg = false;
				bg.visible = false;
			}
		
		}
		
		private function set_before_fg():void 
		{
			before_fg_overlay.visible = true;
			before_fg_overlay.scrollFactor.x = before_fg_overlay.scrollFactor.y = 0;
			before_fg_overlay.y = 20;
			if (Registry.CURRENT_MAP_NAME == "FOREST") {
				before_fg_overlay.loadGraphic(Common_Sprites.forest_blend, false, false, 160, 160);
				before_fg_overlay.blend = "overlay";
			} else if (Registry.CURRENT_MAP_NAME == "HOTEL" && Registry.E_PLAY_ROOF) {
				before_fg_overlay.loadGraphic(Common_Sprites.roof_blend, false, false, 160, 160);
				before_fg_overlay.blend = "hardlight";
			} else if (Registry.CURRENT_MAP_NAME == "SUBURB") {
				before_fg_overlay.loadGraphic(Common_Sprites.suburbs_Blend, false, false, 160, 160);
				before_fg_overlay.blend = "overlay";
			} else {
				before_fg_overlay.visible = false;
			}
		
		}
		

		public function stateCutscene():void {
			cutscene.update();
			keyWatch.update();
			if (cutscene.state == cutscene.s_done) {
				cutscene.pop(this as FlxState);
				cutscene.destroy();
				cutscene = null;
				state = S_NORMAL;
			}
		}
		
		private var arrow:FlxSprite;
		private var arrow_state:int = 0;
		public var in_death_room:Boolean = false;
		
		public function state_player_died():void {
			Registry.keywatch.update();
			
			
			
			EventScripts.send_property_to(player, "x", 80, 0.5);
			EventScripts.send_property_to(player, "y", 100, 0.5);
			// Play the death noise (hit ground) and then show the death text. 
			// Also make the arrow show up.
			if (player.frame == player.DEATH_FRAME && !played_death_sound) {
				played_death_sound = true;
				Registry.sound_data.player_hit_1.play();
				Registry.sound_data.GameOver.play();
				death_text.visible = true;
				death_text.alpha = 1;
				death_text.setText("Continue?\n" + "Yes\nNo..", true, 0, 0, "center", true);
				
				if (arrow == null) {
					arrow = new FlxSprite;
					arrow.scrollFactor.x = arrow.scrollFactor.y = 0;
					arrow.loadGraphic(PauseState.arrows_sprite, true, false, 7, 7);
					arrow.addAnimation("flash", [2, 3], 8);
					add(arrow);
				}
				arrow.x = death_text.x + 4;
				arrow.y = death_text.y + 8;
				arrow.play("flash");
				arrow.visible = true;
				remove(arrow, true);
				add(arrow);
			}
			
			death_fadein.visible = true;
			if (death_fadein.alpha < 1) death_fadein.alpha += 0.03;
			if (death_fadein.alpha > 0.7) { 
				death_text.visible = true;
				
			}
			
			if (arrow != null) {
				if (arrow.visible == true) {
					if (arrow_state == 0) {
						if (Registry.keywatch.JP_DOWN) {
							arrow_state = 1;
							arrow.y += 8;
						}
					} else {
						if (Registry.keywatch.JP_UP) {
							arrow_state = 0;
							arrow.y -= 8;
						}
					}
				}
			}
			
			if (start_death_fade_out || (played_death_sound && Registry.keywatch.JP_ACTION_1 && death_text.visible )) {
				
				start_death_fade_out = true;
				black_overlay.alpha += 0.02;
				player.alpha -= 0.02;
				death_text.alpha -= 0.02;
				if (black_overlay.alpha == 1) {
					Registry.sound_data.GameOver.stop();
					Registry.sound_data.GameOver = null;
					Registry.sound_data.GameOver = new FlxSound();
					Registry.sound_data.GameOver.loadEmbedded(SoundData.GameOver_Song, false);
					Registry.ENTRANCE_PLAYER_X = Registry.checkpoint.x;
					Registry.ENTRANCE_PLAYER_Y = Registry.checkpoint.y;
					Registry.CURRENT_MAP_NAME = Registry.checkpoint.area;
					// When we die we want to make sure the song restarts 
					dont_change_songs = false;
					Registry.E_OVERRIDE_SAME_MAP_SONG = true;
					Registry.death_count++;
					Registry.BOI = false;
					Registry.CUR_HEALTH = Registry.MAX_HEALTH;
					player.health_bar.modify_health(Registry.MAX_HEALTH);
					if (arrow_state == 1) {
						Registry.CURRENT_MAP_NAME = Registry.NEXT_MAP_NAME = "DRAWER";
						Registry.ENTRANCE_PLAYER_X = 368;
						Registry.ENTRANCE_PLAYER_Y = 224 + 20;
						player.start_in_slump = true;
						in_death_room = true;
					} else {
						Registry.NEXT_MAP_NAME = Registry.checkpoint.area;
						trace("(death) Loading checkpoint: ", Registry.checkpoint.area, Registry.checkpoint.x, Registry.checkpoint.y);
					}
					header.scrollFactor = noScrollPt;
					SWITCH_MAPS = true;
					DH.enable_menu();
					remove(player, true);
					remove(arrow, true); 
					arrow.visible = false;
				}
				
			}
			
		}
		/*
		 * last things before leaving the map (transitions, changing global map name)
		 * */
		public function transition_out():void {
			/* Mark all sprites to be cleaned up, reset any events set,
			 * reset grid state, determine beginning state of the transition */
			if (!cleaned_up_before_exit) {
				cleaned_up_before_exit = true;
				Registry.destroy_destroyems();
				reviveGridLocalSprites();
				clearOthers();
				clearStateful();
				clearStateless();
				Registry.reset_events();
				Registry.GRID_ENEMIES_DEAD = 0;
				Registry.GRID_PUZZLES_DONE = 0;
				
				//trace(Registry.E_OVERRIDE_SAME_MAP_SONG, Registry.CURRENT_MAP_NAME, Registry.NEXT_MAP_NAME);
				if (Registry.E_OVERRIDE_SAME_MAP_SONG || Registry.CURRENT_MAP_NAME != Registry.NEXT_MAP_NAME) {
					Registry.pillar_switch_state = false;
					Registry.E_OVERRIDE_SAME_MAP_SONG = false;
				} else {
					dont_change_songs = true;
				}
				
				if (Registry.E_Enter_Whirlpool_Down) {
					
				} else {
					Registry.EVENT_FADE_BEGUN = true;
				}
						
				if (Registry.FUCK_IT_MODE_ON) {
					Registry.EVENT_FADE_OVER = true;
					Registry.EVENT_FADE_BEGUN = false;
					black_overlay.alpha = 1;
				}
			}
			/* Fade out the song and other sounds playing */
			
			if (!dont_change_songs) {
				Registry.sound_data.current_song.volume -= 0.03;
				if (Registry.sound_data.current_song.playing && Registry.sound_data.current_song.volume < 0.05) {
					Registry.sound_data.stop_current_song();
				}
				
					if (Registry.CURRENT_MAP_NAME == "BEACH") { 
						Registry.sound_data.waves.stop();
					} else if (Registry.CURRENT_MAP_NAME == "WINDMILL") {
						Registry.sound_data.rain.stop();
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
			if (black_overlay.alpha >= 0.99 && 
				(dont_change_songs || !Registry.sound_data.current_song.playing) &&
				Registry.EVENT_FADE_OVER) {
					
				DH.reset_scenes_on_map_change();
				Registry.EVENT_FADE_OVER = Registry.EVENT_FADE_BEGUN = false;
				
				Registry.CURRENT_MAP_NAME = Registry.NEXT_MAP_NAME;
				
				Registry.set_is_playstate(Registry.CURRENT_MAP_NAME);
				deleteOtherObjects();
				deletePrevStateful();
				deletePrevStateless();
				Registry.cleanup_on_map_change();
				create();
			}
		}
		
		public function set_darkness(map:String):void {
			
			var color:uint;	
				darkness.makeGraphic(Registry.SCREEN_WIDTH_IN_PIXELS, Registry.SCREEN_HEIGHT_IN_PIXELS, 0xff000000);
			darkness.blend = "overlay";
			darkness.visible = true;
			darkness.alpha = 1;
			darkness.y = 20;
			if (map == "DRAWER") {
				darkness.blend = "multiply";
				if (in_death_room == false) {
					darkness.alpha = 1;
				} else {
					darkness.alpha = 0.8;
				}
			} else if (map == "HAPPY") {
				darkness.loadGraphic(Common_Sprites.happy_blend, true, false, 160, 160);
				darkness.blend = "hardlight";
				if (Registry.GE_States[Registry.GE_Happy_Started]) {
					darkness.alpha = 1.0;
				} else {
					darkness.visible = false;
					darkness.alpha = 0;
				}
				// or "screen" or "lighten" etc 
			}  else if (map == "REDSEA") {
				darkness.loadGraphic(Common_Sprites.redsea_blend, true, false, 160, 160);
				darkness.blend = "hardlight";
			} else if (map == "GO") {
				darkness.loadGraphic(Common_Sprites.go_blend, true, false, 160, 160);
				darkness.blend = "hardlight";
			} else if (map == "CLIFF") {
				darkness.loadGraphic(Common_Sprites.cliff_blend, false, false, 160, 160);
			} else if (map == "APARTMENT") {
				darkness.loadGraphic(Common_Sprites.apartment_Blend, false, false, 160, 160);
			} else if (map == "SPACE") {
				darkness.loadGraphic(Common_Sprites.space_blend, false, false, 160, 160);
			} else if (map == "BEACH") {
				darkness.loadGraphic(Common_Sprites.beach_blend, false, false, 160, 160);
				darkness.blend = "hardlight";
			} else if (map == "HOTEL") {			
				darkness.loadGraphic(Common_Sprites.hotel_blend, false, false, 160, 160);
			} else if (map == "BLUE") {
				darkness.loadGraphic(Common_Sprites.blue_blend, false, false, 160, 160);
			} else if (map == "CROWD") {
				darkness.loadGraphic(Common_Sprites.crowd_blend, false, false, 160, 160);
			} else if (map == "GO") {
				darkness.loadGraphic(Common_Sprites.go_blend, false, false, 160, 160);
				darkness.blend = "hardlight";
			} else if (map == "REDCAVE") {
				darkness.loadGraphic(Common_Sprites.redcave_blend, false, false, 160, 160);
			} else if (map == "WINDMILL") {
				darkness.loadGraphic(Common_Sprites.windmill2_Blend, false, false, 160, 160);
			} else if (map == "NEXUS") {
				darkness.loadGraphic(Common_Sprites.nexus_Blend, false, false, 160, 160);
			} else if (map == "TERMINAL") {
				darkness.loadGraphic(Common_Sprites.terminal_blend, false, false, 160, 160);
			} else {
				darkness.alpha = 0;
				//darkness.visible = false;
				darkness.blend = "multiply";
			}
			
			if (Registry.E_NEXT_MAP_DARKNESS_8 == true) {
				Registry.E_NEXT_MAP_DARKNESS_8 = false;
				darkness.alpha = 0.91;
			}
			
			
			darkness.scrollFactor = noScrollPt;
			
		}
		
        override public function destroy():void {
			
			if (!Registry.E_DESTROY_PLAYSTATE) {
				trace("Not destryoing playstate");
				return;
			} 
			trace("destroying playstate");
			Registry.E_DESTROY_PLAYSTATE = false;
			
			remove(Registry.keywatch, true);
			
            for (var i:int = 0; i < members.length; i++) {
                if (members[i] != null) members[i] = null;
            }
            mapData = null;
			if (!dont_change_songs) {
				Registry.sound_data.current_song = null;
			
				}
			/* Need to null all of the non-added references and destroy their children*/
			statelesses = null;
			statefuls = null;
			pause_state.destroy();
			pause_state = null;
			if (cutscene != null) {
				cutscene.destroy();
				cutscene = null;
			}
			dialogue_state.destroy();
			dialogue_state = null;
			oldObjects = otherObjects = oldOthers = oldStateless = null;
			downsample_fade.destroy();
			upsample_fade.destroy();
			upsample_fade = downsample_fade = null;
			noScrollPt = null;
			dec_over = null;
			before_fg_overlay = null;
			number_of_keys_text = null;
			
			FlxG.clearBitmapCache();

            super.destroy();
        }
			
		public static var GFX_DISCO:int = 0;
		private static var GFX_DISCO_ON:Boolean = false;
		private static var GFX_DISCO_CTR:int = 0;
		private static var GFX_DISCO_A:int = 0;
		
		public static var GFX_STATIC_ALWAYS_ON:Boolean = false;
		private static var GFX_STATIC_ON:Boolean = false;
		public static var GFX_STATIC:int = 1;
		
		private static var GFX_GLITCH_ALWAYS_ON:Boolean = false;
		
		public static function turn_on_effect(effect:int):void {
			switch (effect) {
				case GFX_DISCO:
					GFX_DISCO_ON = true;
					break;
				case GFX_STATIC:
					GFX_STATIC_ON = true;
					break;
			}
		}
		
		// For static shader
		//private static var shades:Array = new Array(0x000000, 0x202020, 0x404040, 0x606060, 0x808080, 0xa0a0a0, 0xc0c0c0, 0xe0e0e0, 0xffffff);
		private static var shades:Array = new Array();
		
		private static var lookup:Array = new Array();
		private static var lookup_init:Boolean = false;
		private static var lookup1:Array = new Array();
		private static var lookup3:Array = new Array();
		private static var lookup5:Array = new Array();
		private static var lookup7:Array = new Array();
		private static var lookup_qe:Array = new Array();
		private static var poop:int = 0;
		private static var lookupa:Array;
		private static var nr_shades:int = 25;
		private static var bm:BitmapData = new BitmapData(160, 180, true);
		
		
		// For glitch shader
		
		private static var glitch_min:Point =  new Point(16, 16); // Min w, h of a part
		private static var glitch_max:Point = new Point(32, 32);	// max
		private static var glitch_r:Rectangle = new Rectangle;
		private static var glitch_dest:Point = new Point;
		private static var glitch_iters:int = 50; // How many transformations should happen.
		private static var glitch_f:Number = 0; // frame counter, +1 per draw call
		private static var glitch_fm:Number = 1; // glitch_f decremented by this when greater
		private static var glitch_rf:Number = 0; // 
		private static var glitch_rfm:Number = 10; // How often the glitched things change
		private static var glitch_data:Array = new Array(new Array(glitch_iters), new Array(glitch_iters), new Array(glitch_iters), new Array(glitch_iters), new Array(glitch_iters), new Array(glitch_iters)); // x, y, w, h
		
		
		private var redo_darknes:Boolean = false;
		private var do_dark_fill:Boolean = false;
		
		private function set_do_dark_fill(map:String):void {
			if (Registry.CURRENT_MAP_NAME != "BLANK" && Registry.CURRENT_MAP_NAME != "OVERWORLD" && Registry.CURRENT_MAP_NAME != "FIELDS" && Registry.CURRENT_MAP_NAME != "TRAIN" && Registry.CURRENT_MAP_NAME != "BEDROOM" && Registry.CURRENT_MAP_NAME != "SUBURB" && Registry.CURRENT_MAP_NAME != "DRAWER" && Registry.CURRENT_MAP_NAME != "CIRCUS") {
				do_dark_fill = false;
			} else {
				if (Registry.CURRENT_MAP_NAME == "CIRCUS") {
					darkness.alpha = 0;
				}
				do_dark_fill = true;
			}
		}
		override public function draw():void {
			
			
			 if (false == do_dark_fill) {
				if (redo_darknes) {
					redo_darknes = false;
					
					set_darkness(Registry.CURRENT_MAP_NAME);
				}
			} else {
					darkness.fill(0xff000000);
					redo_darknes = true;
			}
			
			
			
			/* Sort by y value */
			sortables.sort("y_bottom", ASCENDING);
			
			super.draw();
			
			if (true == GFX_DISCO_ON) {
				GFX_DISCO_CTR += 1;
				if (GFX_DISCO_CTR > 14) {
					GFX_DISCO_CTR = 0;
					GFX_DISCO_A = int(8 * Math.random());
				} 
			
				FlxG.camera.buffer.lock();
				for (var i:int = 0; i < 180; i++) {
					for (var j:int = 0; j < 160; j++) {
						//FlxG.camera.buffer.setPixel32(j, i, FlxG.camera.buffer.getPixel32(j, i) / GFX_DISCO_A);
					}
				}
				FlxG.camera.buffer.unlock();
				GFX_DISCO_ON = false;
			}
			
			//state for static effect
			
			if (!lookup_init) {
				//FlxG.camera.getContainerSprite().filters = [static_shaderFilter];
				lookup_init = true;
				var d:int = 0;
				for (i = 0; i < nr_shades; i++) {
					d = i * (255 / (nr_shades - 1));
					if (i == nr_shades - 1) {
						shades.push(0x00ffffff);
					} else {
						
						// UNCOMMENT FOR UFCKED UP GLOW
						//shades.push(d * 256 + d * 16 + d);
						shades.push(d * 256*256 + d * 256 + d);
					}
				}
				
				for (i = 0; i < 256; i++) {
					lookup.push(shades[int(i / (1 + (255/nr_shades)))]); // if we want 9 shades
					lookup1.push(int((10 / 16) * i) * 0x010101);
					lookup3.push(int((23 / 24) * i) * 0x010101); // Some fraction of the "error" that will be added to a pixel's value
					lookup5.push(int((22 / 24) * i) * 0x010101);
					lookup7.push(int((21 / 24) * i) * 0x010101);
					// Error value based on distance from nearest shade
					lookup_qe.push((Math.max(0,(i * 0x010101) - (shades[int(i / 27)]))) >> 16);
				}
			}
			
			if (Registry.CURRENT_GRID_X >= map.widthInTiles / 10 || Registry.CURRENT_GRID_X < 0 || Registry.CURRENT_GRID_Y < 0 || Registry.CURRENT_GRID_Y >= map.heightInTiles / 10) {
				GFX_GLITCH_ALWAYS_ON = true ;
			} else {
				GFX_GLITCH_ALWAYS_ON = false;
			}
			if (GFX_GLITCH_ALWAYS_ON) {
				glitch_rf += 1;
				FlxG.camera.buffer.lock();
				for (i = 0; i < glitch_iters; i++) {
					if (glitch_rf >= glitch_rfm) {
						glitch_data[2][i] = Math.max(glitch_min.x, int(Math.random() * glitch_max.x));
						glitch_data[3][i] = Math.max(glitch_min.y, int(Math.random() * glitch_max.y));
						glitch_data[0][i] = int(160 * Math.random());
						glitch_data[1][i] = int(180 * Math.random());
						glitch_data[4][i] = int(160 * Math.random());
						glitch_data[5][i] = int(180 * Math.random());
					}
					glitch_r.width =  glitch_data[2][i];
					glitch_r.height =  glitch_data[3][i];
					glitch_r.x =  glitch_data[0][i];
					glitch_r.y =  glitch_data[1][i];
					glitch_dest.x = glitch_data[4][i];
					glitch_dest.y = glitch_data[5][i];
					FlxG.camera.buffer.copyPixels(FlxG.camera.buffer, glitch_r, glitch_dest);
				}
				if (glitch_rf > glitch_rfm) {
					glitch_rf -= glitch_rfm;
				}
				FlxG.camera.buffer.unlock();
				
			}
			
	
			
			
			if (GFX_STATIC_ON || GFX_STATIC_ALWAYS_ON) {
					
				if (!Intra.is_mobile) {
				FlxG.camera.buffer.applyFilter(FlxG.camera.buffer, FlxG.camera.buffer.rect, FlxG.camera.buffer.rect.topLeft, static_shaderFilter);
				if (Registry.CURRENT_MAP_NAME == "SUBURB") {
					before_fg_overlay.draw();
					
				}
				}
				/*var gray:uint = 0;
				var r:uint = 0;
				var g:uint = 0;
				var b:uint = 0;
				var qe:uint = 0;
				var old:uint = 0;
			
				if (poop > 15) poop = 0;
				if (poop == 0) {
					lookupa = lookup7;
				} else if (poop == 5) {
					lookupa = lookup3;
				} else if (poop == 10){
					lookupa = lookup5;
				}
				poop += 1;
				
				// If it's mobile then the static effect is likely too slow, so just do grayscaling.
				if (Intra.is_mobile) {
					if (poop % 2 == 0) {
						FlxG.camera.buffer.lock();
						for (i = 0; i < 180; i++) { // dont want out of bounds?
							for (j = 0; j < 160; j++) {
								old = FlxG.camera.buffer.getPixel(j, i);
								r = (old & 0x00ff0000) >> 16;
								g = (old & 0x0000ff00) >> 8;
								b = (old & 0x000000ff);
								gray = (r + g + b) / 3;
								FlxG.camera.buffer.setPixel(j, i, lookup[gray]);
							}
						}
						FlxG.camera.buffer.unlock();
						bm.copyPixels(FlxG.camera.buffer, bm.rect, bm.rect.topLeft);
					} else {
						FlxG.camera.buffer.copyPixels(bm, bm.rect, bm.rect.topLeft);
					}
				} else {
					if (poop % 3 == 0) {
						FlxG.camera.buffer.lock();
						for (i = 0; i < 180; i++) { // dont want out of bounds?
							for (j = 0; j < 160; j++) {
								old = FlxG.camera.buffer.getPixel(j, i);
								r = (old & 0x00ff0000) >> 16;
								g = (old & 0x0000ff00) >> 8;
								b = (old & 0x000000ff);
								gray = (r + g + b) / 3;
								qe = lookup_qe[gray];
								FlxG.camera.buffer.setPixel(j, i, lookup[gray]);
								old = FlxG.camera.buffer.getPixel(j, i+1);
								FlxG.camera.buffer.setPixel(j , i + 1, old + lookupa[qe]);
							}
						}
						FlxG.camera.buffer.unlock();
						bm.copyPixels(FlxG.camera.buffer, bm.rect, bm.rect.topLeft);
					} else {
						FlxG.camera.buffer.copyPixels(bm, bm.rect, bm.rect.topLeft);
					}
				}
				if (state == S_DIALOGUE) {
					dialogue_state.dialogue.draw();
				}*/
			}
			GFX_STATIC_ON = false;
			// End static effect
			
			if (Registry.EVENT_FADE_BEGUN && state == S_NORMAL) {
				if (downsample_fade.do_effect() == ScreenFade.DONE) {
					Registry.EVENT_FADE_OVER = true;
				}
			}	else if (Registry.EVENT_FADE_BEGUN && state == S_JUST_ENTERED_MAP) {
				if (upsample_fade.do_effect() == ScreenFade.DONE) {
					Registry.EVENT_FADE_OVER = true;
					
				}
			}
			/** HOrizontal wavy effect **/
			if ( Registry.GFX_WAVE_EFFECT_ON) {
				if (last_time == 0) {
					last_time = getTimer();
				}
				if (getTimer() - last_time > 60) {
					Registry.GFX_WAVE_EFFECT_ON = false;
					last_time = 0;
				} else {
					last_time = getTimer();
				}
				Registry.GFX_WAVE_TABLE_INDEX = 0;
				Registry.GFX_WAVE_EFFECT_START = (Registry.GFX_WAVE_EFFECT_START + 3) % 180;
				Registry.GFX_BUFFER.copyPixels(FlxG.camera.buffer, FlxG.camera.buffer.rect, FlxG.camera.buffer.rect.topLeft);
				FlxG.camera.buffer.lock()
				for (i = 0; i < 180; i++) {
					for (j = 0; j < 160; j++) {
						
						FlxG.camera.buffer.setPixel32(j , Registry.GFX_WAVE_EFFECT_START, 
							Registry.GFX_BUFFER.getPixel32(Math.min(Math.max(j + Registry.GFX_WAVE_TABLE[Registry.GFX_WAVE_TABLE_INDEX],0),159),
							
							Registry.GFX_WAVE_EFFECT_START));
					}
					Registry.GFX_WAVE_TABLE_ROLLOVER = ( Registry.GFX_WAVE_TABLE_ROLLOVER + 1) % 15;
					if (Registry.GFX_WAVE_TABLE_ROLLOVER == 0) {
						Registry.GFX_WAVE_TABLE_INDEX++;
						if (Registry.GFX_WAVE_TABLE_INDEX + 1> Registry.GFX_WAVE_TABLE.length) Registry.GFX_WAVE_TABLE_INDEX = 0;
					}
					Registry.GFX_WAVE_EFFECT_START = (Registry.GFX_WAVE_EFFECT_START + 1) % 180;
				}
				FlxG.camera.buffer.unlock();
			}
			
		}
		
		private var last_time:int = 0;
	}
}