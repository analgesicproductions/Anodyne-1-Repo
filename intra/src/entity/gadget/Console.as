package entity.gadget 
{
	import data.CLASS_ID;
	import data.SoundData;
	import entity.player.Player;
	import global.Registry;
	import helper.Cutscene;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	import states.PauseState;
	import states.PlayState;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Console extends FlxSprite 
	{
		
		public var xml:XML;
		public var cid:int = CLASS_ID.CONSOLE;
		public var active_region:FlxSprite;
		public var is_active:Boolean = true;
		public var INCREMENTED_REGISTRY:Boolean = false;
		public var did_init:Boolean = false;
		public var do_sound_test:Boolean = false;
		
		[Embed (source = "../../res/sprites/gadgets/console.png")] public var sprite_console:Class;
		[Embed(source = "../../res/sprites/gadgets/windmill_inside.png")] public static var embed_windmill_inside:Class;
		
		private var p:Player;
		
		
		public function Console(x:int,y:int,_xml:XML,_p:Player) 
		{
			super(x, y);
			xml = _xml;
			if (Registry.CURRENT_MAP_NAME == "WINDMILL") {
				loadGraphic(embed_windmill_inside, true, false, 48, 48);
				addAnimation("active", [0, 1], 5, true);
				addAnimation("green", [1], 3, true);
				active_region = new FlxSprite(x + 16, y + 16);
				active_region.makeGraphic(24, 20, 0x00ffffff);
			} else if (Registry.CURRENT_MAP_NAME == "BLANK" && Registry.CURRENT_GRID_Y >= 7) {
				loadGraphic(sprite_console, true, false, 16, 16);
				addAnimation("spaz", [0, 1, 2], 20);
				play("spaz");
				active_region = new FlxSprite(x, y + 16);
				active_region.makeGraphic(16, 4, 0x00ffffff);
			} else if (Registry.CURRENT_MAP_NAME == "DEBUG" && Registry.CURRENT_GRID_Y < 3) {
				loadGraphic(sprite_console, true, false, 16, 16);
				addAnimation("spaz", [0, 1, 2], 20);
				play("spaz");
				active_region = new FlxSprite(x, y + 16);
				active_region.makeGraphic(x, y + 16);
				do_sound_test = true;
			} else {
				loadGraphic(sprite_console, true, false, 16, 16);
				addAnimation("active", [0, 1], 5, true);
				addAnimation("green", [2], 3, true);
			active_region = new FlxSprite(x, y + 16);
			active_region.makeGraphic(16, 4, 0x00ffffff);
			}
			play("active"); 
			immovable = true;
			active_region.solid = false;
				
			p = _p;
			xml.@p = "2";
			
			if (xml.@alive == "false") {
				play("green");
				is_active = false;
			}
			//visible = false;
			
			Registry.subgroup_interactives.push(this);
		}
		
		override public function update():void 
		{
			
			if (state == S_SOUND) {
				sound_test();
				super.update();
				return;
			}
			if (!is_active && !INCREMENTED_REGISTRY) {
				INCREMENTED_REGISTRY = true;
				Registry.GRID_PUZZLES_DONE++;
				play("green");
				
			}
			
			if (Registry.CURRENT_MAP_NAME == "WINDMILL" && !did_init) {
				did_init = true;
				Registry.GAMESTATE.sortables.remove(this, true);
				Registry.GAMESTATE.bg_sprites.add(this);
			} 
			if (Registry.CURRENT_MAP_NAME != "WINDMILL") {
				FlxG.collide(this, p);
			}
			if (p.overlaps(active_region) && p.facing == UP && (Registry.keywatch.JP_ACTION_1 || Registry.keywatch.JP_ACTION_2)) {
				if (!Registry.CUTSCENES_PLAYED[Cutscene.Windmill_Opening] && Registry.CURRENT_MAP_NAME == "WINDMILL") {
					Registry.E_Load_Cutscene = true;
					Registry.CURRENT_CUTSCENE = Cutscene.Windmill_Opening;
					is_active = false;
					xml.@alive = "false";
					Registry.sound_data.get_small_health.play();
				} else if (Registry.CURRENT_MAP_NAME == "BLANK" && Registry.CURRENT_GRID_Y >= 7) {
					DH.start_dialogue(DH.name_rock, DH.scene_rock_five, "NEXUS");
				} else if (do_sound_test) {
					state = S_SOUND;
					Registry.GAMESTATE.player.be_idle();
				} else {
					is_active = false;
					xml.@alive = "false";	
					Registry.sound_data.get_small_health.play();
					
				}
				
			}
			
			super.update();
		}
		private var state:int = 0;
		private const S_SOUND:int = 1;
		private var soundtest_init:Boolean = false;
		private var sound_bg:FlxSprite;
		private var sound_text:FlxBitmapFont;
		private var sound_select_1:FlxSprite;
		private var sound_select_2:FlxSprite;
		private var snd_ctr:int = 0;
		private const snd_text:String = "Jukebox!\nMuzak\nSFX";
		private function sound_test():void {
			if (soundtest_init == false) {
				
				sound_bg = new FlxSprite;
				sound_bg.loadGraphic(Checkpoint.checkpoint_save_box_sprite, true, false, 80, 29);
				sound_bg.scrollFactor.x = sound_bg.scrollFactor.y = 0;
				sound_bg.x = (160 - sound_bg.width) / 2;
				sound_bg.y = 20 + (160 - sound_bg.height) / 2;
				
				sound_text= EventScripts.init_bitmap_font(snd_text, "center", sound_bg.x + 5, sound_bg.y + 3, null, "apple_black");
				sound_select_1 = new FlxSprite;
				sound_select_1.loadGraphic(PauseState.arrows_sprite, true, false, 7, 7);
				sound_select_1.scrollFactor = new FlxPoint(0, 0);
				sound_select_1.addAnimation("flash", [0, 1], 12);
				sound_select_1.play("flash");
				sound_select_1.scale.x = -1;
				
				sound_select_1.x = sound_text.x + 4;
				sound_select_1.y = sound_text.y + 8;
				
				var p:PlayState;
				p = Registry.GAMESTATE;
				p.fg_sprites.add(sound_bg);
				p.fg_sprites.add(sound_text);
				p.fg_sprites.add(sound_select_1);
				soundtest_init = true;
			}
			
			if (Registry.keywatch.JP_ACTION_2 && ((snd_ctr == 1) || (snd_ctr == 2))) {
				sound_bg.visible = sound_text.visible = sound_select_1.visible = false;
				Registry.GAMESTATE.player.state = Registry.GAMESTATE.player.S_GROUND;
				state = 0;
				snd_ctr = 0;
				return;
			}
			if (snd_ctr == 0) {
				sound_bg.visible = sound_text.visible = sound_select_1.visible = true;
				Registry.GAMESTATE.player.state = Registry.GAMESTATE.player.S_INTERACT;
				snd_ctr = 1;
			} else if (snd_ctr == 1) {
				if (Registry.keywatch.JP_DOWN) {
					sound_select_1.y += 8;
					snd_ctr = 2;
				}
				if (Registry.keywatch.JP_ACTION_1) {
					snd_ctr = 3; 
					sound_select_1.visible = false;
					sound_text.text = "MUSIC\n" + music_idx.toString();
				}
			} else if (snd_ctr == 2) {
				if (Registry.keywatch.JP_UP) {
					sound_select_1.y -= 8;
					snd_ctr = 1;
				}
				if (Registry.keywatch.JP_ACTION_1) {
					sound_text.text = "SFX\n\n" + snd_idx.toString();
					snd_ctr = 4;
					sound_select_1.visible = false;
				}
			} else if (snd_ctr == 3) {
				do_music();
			} else if (snd_ctr == 4) {
				do_sfx();
			}
		}
		
		
		private static var sfxs:Array;
		private var snd_idx:int = 0;
		private function do_sfx():void {
			if (sfxs == null) {
				var s:SoundData = Registry.sound_data;
				sfxs = new Array(s.unlock, s.open, s.fall_in_hole, s.push_block, s.button_up, s.button_down, s.floor_crack, s.get_treasure, s.get_key, s.dash_pad_1, s.dash_pad_2, s.spring_bounce, s.puddle_up, s.puddle_down, s.puddle_step, s.ladder_step, s.sun_guy_death_l, s.sun_guy_death_s, s.sun_guy_scream, s.sun_guy_charge, s.player_jump_down, s.player_jump_up, s.enter_door, s.player_hit_1, s.broom_hit, s.teleport_up, s.teleport_down, s.shieldy_hit, s.shieldy_ineffective, s.red_cave_rise, s.redboss_moan, s.small_wave, s.big_wave, s.redboss_death, s.dog_dash, s.talk_group, s.wb_tap_ground, s.wb_hit_ground, s.wb_shoot, s.wb_moan, s.wb_moan_2, s.talk_death, s.teleguy_up, s.teleguy_down, s.gasguy_shoot, s.gasguy_move, s.rat_move, s.sb_split, s.sb_hurt, s.sb_dash, s.sb_ball_appear, s.sf_move, s.dustmaid_alert, s.elevator_open, s.elevator_close, s.flame_pillar_group, s.fireball_group, s.get_small_health, s.big_door_locked, s.hitground1, s.fall1, s.slasher_atk, s.on_off_laser_shoot, s.dialogue_bloop, s.cicada_chirp, s.briar_shine_group, s.stream_sound, s.dust_explode_group, s.mushroom_sound_group, s.slime_walk_group, s.slime_splash_group, s.slime_shoot_group, s.four_shooter_pop_group, s.four_shooter_shoot_group, s.mover_move_group, s.mover_die_group, s.bubble_group, s.bubble_triple_group, s.laser_pew_group, s.menu_move_group, s.menu_select_group, s.pause_sound_group, s.enemy_explode_1_group, s.swing_broom_group, s.water_step_group, s.dialogue_blip_group, s.sparkle_group, s.dog_bark_group, Dust.dust_sound);
				// Init array
			}
			if (Registry.keywatch.JP_ACTION_2) {
				snd_ctr = 2;
				sound_text.text = snd_text;
				sound_select_1.visible = true;
			}
			
			if (Registry.keywatch.JP_RIGHT && snd_idx < sfxs.length - 1) {
				snd_idx += 1;
				sound_text.text = "SFX\n\n" + snd_idx.toString();
			} 
			
			if (Registry.keywatch.JP_LEFT && snd_idx > 0) {
				snd_idx -= 1;
				sound_text.text = "SFX\n\n" + snd_idx.toString();
			}
			
			if (Registry.keywatch.JP_ACTION_1) {
				if (sfxs[snd_idx]) {
					if ("FlxSound" == FlxU.getClassName(sfxs[snd_idx], true)) {
						sfxs[snd_idx].play();
					} else {
						Registry.sound_data.play_sound_group(sfxs[snd_idx]);
					}
				}
			}
		}
		
		private static var musicks:Array;
		private var music_idx:int = 0;
		
		private function do_music():void {
			if (musicks == null) {
				musicks = new Array("TITLE", "BLANK", "NEXUS", "STREET", "OVERWORLD", "BEDROOM", "BEDROOMBOSS", "MITRA", "FIELDS", "BEACH", "REDSEA", "FOREST", "CLIFF", "REDCAVE", "REDCAVEBOSS", "CROWD", "CROWDBOSS", "WINDMILL", "SUBURB", "SPACE", "APARTMENT", "APARTMENTBOSS", "ROOF", "HOTEL", "HOTELBOSS", "CELL", "CIRCUS", "CIRCUSBOSS", "PRETERMINAL", "SAGEFIGHT", "TERMINAL", "GO", "HAPPYINIT", "HAPPY", "BLUE", "BRIARFIGHT", "ENDING");
			}
			
			if (Registry.keywatch.JP_ACTION_2) {
				snd_ctr = 1;
				sound_select_1.visible = true;
				sound_text.text = snd_text;
			}
			
			if (Registry.keywatch.JP_RIGHT && music_idx < musicks.length - 1) {
				music_idx ++;
				sound_text.text = "MUSIC\n" + music_idx.toString();
			}
			
			if (Registry.keywatch.JP_LEFT && music_idx > 0) {
				music_idx--;
				sound_text.text = "MUSIC\n" + music_idx.toString();
			}
			
			
			if (Registry.keywatch.JP_ACTION_1) {
				Registry.sound_data.start_song_from_title(musicks[music_idx]);
			}
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
		
	}

}