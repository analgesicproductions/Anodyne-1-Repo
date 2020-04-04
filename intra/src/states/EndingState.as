package states 
{
	import entity.enemy.*;
	import entity.enemy.bedroom.*;
	import entity.enemy.etc.Chaser;
	import entity.enemy.etc.Follower_Bro;
	import entity.enemy.etc.Red_Walker;
	import entity.enemy.etc.Sadbro;
	import entity.enemy.etc.Space_Face;
	import entity.enemy.redcave.*;
	import entity.enemy.crowd.*;
	import entity.enemy.apartment.*;
	import entity.enemy.hotel.*;
	import entity.enemy.circus.*;
	import entity.enemy.suburb.Suburb_Killer;
	import entity.enemy.suburb.Suburb_Walker;
	import entity.gadget.Checkpoint;
	import entity.interactive.Fisherman;
	import entity.interactive.NPC;
	import entity.interactive.npc.Forest_NPC;
	import entity.interactive.npc.Mitra;
	import entity.interactive.npc.Sage;
	import entity.interactive.npc.Shadow_Briar;
	import entity.interactive.npc.Space_NPC;
	import entity.interactive.npc.Trade_NPC;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Keys;
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	
	public class EndingState extends FlxState 
	{
		public function EndingState () {
			
		}
		[Embed(source = "../res/sprites/npcs/easter/dev_npcs.png")] public static const embed_dev_npcs:Class;
		private var state:int = 1;
		private const S_DONE:int = 2;
		private const S_DIALOGUE_DONE:int = 3;
		public var text:FlxBitmapFont;
		public var text2:FlxBitmapFont;
		
		private var sprites_1:FlxGroup = new FlxGroup(12);
		private var sprites_2:FlxGroup = new FlxGroup(12);
		
		private var init_sprites:Array = new Array(30);
		
		private var positions_1:Array = new Array(new Point, new Point, new Point, new Point, new Point, new Point, new Point, new Point, new Point, new Point, new Point, new Point, new Point, new Point);
		private var positions_2:Array = new Array(new Point, new Point, new Point, new Point, new Point, new Point, new Point, new Point, new Point, new Point, new Point, new Point, new Point, new Point);
		
		public var save_dialog_bg:FlxSprite;
		public var save_dialog_text:FlxBitmapFont;
		public var save_dialog_selector:FlxSprite;
		public var s_ctr:int = 0;
		public var ctr:int = 0;
		
		public var timer:Number = 0;
		public var timer_text:FlxText = new FlxText(0, 0, 200);
		
		private var filler:String = "\n                      \n";
		
		private var overlay:FlxSprite = new FlxSprite();
		private var bg:FlxSprite = new FlxSprite();
		private var stop_text:FlxBitmapFont;
		
		private var dimoverlay:FlxSprite;
		
		private var PG_SPRITES_START:int = 12; 
		// Array of the dialogue. These should be almsot as screen height, so that when
		// They
		private var text_ctr:int = 0;
		private var dialogue:Array = new Array();
		
		private var bg_ctr:int = 0;
		
		[Embed(source = "../res/sprites/ending/go.png")] public static const embed_go:Class;
		[Embed(source = "../res/sprites/ending/screenies.png")] public static const embed_screenies:Class;
		
		
		
		override public function destroy():void 
		{
			
			super.destroy();
			save_dialog_bg = save_dialog_selector = save_dialog_text = null;
			overlay = null;
			timer_text = null;
			bg = null;
			text = text2 = null;
			
		}
		override public function create():void 
		{
			// debug
			//ctr = 8;
			dialogue = new Array();
			for (var i:int = 0; i < 24; i++) {
				dialogue.push(DH.lk("ending", i));
			}
			// REMOVE ABOVE LATER
			text = EventScripts.init_bitmap_font(Registry.C_FONT_APPLE_WHITE_STRING, "center", 1, 180, null, "apple_white");
			text2 = EventScripts.init_bitmap_font(Registry.C_FONT_APPLE_WHITE_STRING, "center", 1, 360, null, "apple_white");
			if (DH.isZH()) {
				filler = "\n             \n";
			}
			//text.text = "thanks for playing lol";
			text.text = dialogue[ctr] + filler;
			ctr++;
			text2.text = dialogue[ctr] + filler;
			ctr++;
			text.velocity.y = text2.velocity.y = -15; // -15 is good
			text.drop_shadow = text2.drop_shadow = true;
			
			
			dimoverlay = new FlxSprite(0, 0);
			dimoverlay.makeGraphic(160, 180, 0xff000000);
			dimoverlay.alpha = 0.2;
			
			bg.loadGraphic(embed_go, false, false, 160, 480);
			bg.x = 0; bg.y = -bg.height + 180;
			overlay.makeGraphic(160, 160, 0xff171717);
			add(bg);
			add(overlay);
			
			add(dimoverlay);
			add(text);
			add(text2)
			//add(timer_text);
			
	
			poopy_save_stuff();
			
			
			
			add(save_dialog_bg);
			add(save_dialog_text);
			add(save_dialog_selector);
			save_dialog_bg.visible = save_dialog_selector.visible = save_dialog_text.visible = false;
			
			for (i=0; i < sprites_1.maxSize; i++) {
				var s1:FlxSprite = new FlxSprite;
				var s2:FlxSprite = new FlxSprite;
				s1.exists = s2.exists = false;
				sprites_1.add(s1);
				sprites_2.add(s2);
			}
			add(sprites_1);
			add(sprites_2);
			
			for (i = 0; i < 30; i++) {
				init_sprites[i] = false;
			}
			
			//ctr--;
			// REMOVE LATER
			//make_sprites(ctr-1, text);
			//make_sprites(ctr, text2);
			
			
			if (Registry.keywatch == null) {
				Registry.keywatch = new Keys();
			}
			add(Registry.keywatch);
			Registry.sound_data.stop_current_song();
			Registry.sound_data.start_song_from_title("ENDING");
		}
		
		private var fade_out:Boolean = false;
		
		private var depth:int = 0;
		override public function update():void 
		{
			if (Registry.keywatch.ACTION_1 && depth < 8 && ctr < 24) {
				depth++;
				update();
				depth--;
			}
			
			timer += FlxG.elapsed;
			timer_text.text = timer.toFixed(2);
			if (state == S_DONE) {
				if (ctr == 0) {
					if (Registry.keywatch.JP_DOWN) {
						save_dialog_selector.y += 8;
						ctr = 1;
					}
					if (Registry.keywatch.JP_ACTION_1) {
						Registry.GE_States[Registry.GE_Finished_Game] = true;
						Save.save();
						Registry.sound_data.stop_current_song();
						FlxG.switchState(new TitleState());
					}
				} else {
					if (Registry.keywatch.JP_UP) {
						ctr = 0;
						save_dialog_selector.y -= 8;
					}
					if (Registry.keywatch.JP_ACTION_1) {
						Registry.sound_data.stop_current_song();
						FlxG.switchState(new TitleState());
					}
				}
				super.update();
				return;
			} else if (state == S_DIALOGUE_DONE) {
				//stop_text.color  = 0xebf600;
				
				if (Registry.keywatch.JP_ACTION_1 || Registry.keywatch.JP_ACTION_2 || Registry.keywatch.JUST_PRESSED_PAUSE) {
					fade_out = true;
				}
				if (fade_out) {
					dimoverlay.alpha += 0.02;
					stop_text.alpha -= 0.014;
				}
				if (stop_text.alpha <= 0) {
					stop_text.y = 0;
					stop_text.alpha = 1;
					//stop_text.text = filler + "Now you have\nthe ability\nto explore Young's\nworld with (almost) no\nlimitations, via \nthe swap.\n";
					stop_text.text = filler + DH.lk("ending", 25);
					state = S_DONE;
					ctr = 0;
					save_dialog_bg.visible = save_dialog_selector.visible = save_dialog_text.visible = true;
					return;
				}
			}
			
			if (text.y < -165 && ctr < dialogue.length - 1) {
				text.y = 180;
				ctr++;
				text.text = dialogue[ctr]  + filler;
				if (ctr == dialogue.length - 1) {
					stop_text = text;
				} else if (ctr >= PG_SPRITES_START) {
					make_sprites(ctr, text);
				}
				
			} else if (text2.y < -165 && ctr < dialogue.length - 1) {
				text2.y = 180;
				ctr++;
				text2.text = dialogue[ctr]  + filler;
				if (ctr == dialogue.length - 1) {
					stop_text = text2;
				} else if (ctr >= PG_SPRITES_START) {
					make_sprites(ctr, text2);
				}
			}
			
			if (stop_text != null) {
				if (stop_text.y <= 0) {
					stop_text.y = 0;
					stop_text.velocity.y = 0;
					state = S_DIALOGUE_DONE;
				}
			}
			
			// woot!
			if (ctr >= PG_SPRITES_START) {
				for (var i:int = 0; i < sprites_1.maxSize; i++) {
					if (sprites_1.members[i] == null) continue;
					sprites_1.members[i].x = positions_1[i].x + text.x;
					sprites_1.members[i].y = positions_1[i].y + text.y;
				}
				for (i = 0; i < sprites_2.maxSize; i++) {
					if (sprites_2.members[i] == null) continue;
					sprites_2.members[i].x = positions_2[i].x + text2.x;
					sprites_2.members[i].y = positions_2[i].y + text2.y;
				}
			}
			
			// set velocity thingies here etc
			switch (ctr) {
				case 0: case 1: case 2: case 3: case 4: case 5:
					overlay.alpha = 0;
					bg.alpha = 1;
					if (bg.y >= 0){
						bg.velocity.y = 0;
						bg.y = 0;
					} else {
						bg.velocity.y = 10;
					}
					break;
				case 6:
					text.color = 0x000000;
					text2.color = 0x000000;
					text.drop_shadow = text2.drop_shadow = false;
					bg.x = overlay.x = 0;
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						overlay.loadGraphic(embed_screenies, true, false, 160, 160);
						overlay.y = 10;
						overlay.alpha = 0;
						overlay.frame = 0;
						bg.velocity.y = 0;
					}
					bg.alpha -= fade_rate;
					overlay.alpha += fade_rate;
					
					break;
				case 7:
					text.color = 0xffffff;
					text2.color = 0xffffff;
					text.drop_shadow = text2.drop_shadow = true;
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						bg.loadGraphic(embed_screenies, true, false, 160, 160);
						bg.frame = 1;
						bg.y = 10;
						
					}
					bg.alpha += fade_rate;
					overlay.alpha -= fade_rate;
					break;
				case 8:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						overlay.frame = 2;
					}
					overlay.alpha += fade_rate;
					bg.alpha -= fade_rate;
					break;
				case 9:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						bg.frame = 3;
					}
					bg.alpha += fade_rate;
					overlay.alpha -= fade_rate;
					break;
				case 10:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						overlay.frame = 4;
					}
					overlay.alpha += fade_rate;
					bg.alpha -= fade_rate;
					break;
				case 11:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						bg.frame = 5;
					}
					bg.alpha += fade_rate;
					overlay.alpha -= fade_rate;
					break;
				case 12:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						overlay.frame = 6;
					}
					overlay.alpha += fade_rate;
					bg.alpha -= fade_rate;
					break;
				case 13:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						bg.frame = 7;
					}
					bg.alpha += fade_rate;
					overlay.alpha -= fade_rate;
					break;
				case 14:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						overlay.frame = 8;
					}
					overlay.alpha += fade_rate;
					bg.alpha -= fade_rate;
					break;
				case 15:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						bg.frame = 9;
					}
					bg.alpha += fade_rate;
					overlay.alpha -= fade_rate;
					break;
				case 16:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						overlay.frame = 10;
					}
					overlay.alpha += fade_rate;
					bg.alpha -= fade_rate;
					break;
				case 17:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						bg.frame = 11;
					}
					bg.alpha += fade_rate;
					overlay.alpha -= fade_rate;
					break;
				case 18:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						overlay.frame = 12;
					}
					overlay.alpha += fade_rate;
					bg.alpha -= fade_rate;
					break;
				case 19:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						bg.frame = 13;
					}
					bg.alpha += fade_rate;
					overlay.alpha -= fade_rate;
					break;
				case 20:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						overlay.frame = 14;
					}
					overlay.alpha += fade_rate;
					bg.alpha -= fade_rate;
					break;
				case 21:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						bg.frame = 15;
					}
					bg.alpha += fade_rate;
					overlay.alpha -= fade_rate;
					break;
				case 22:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						overlay.frame = 16;
					}
					overlay.alpha += fade_rate;
					bg.alpha -= fade_rate;
					break;
				case 23:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						bg.frame = 17;
					}
					bg.alpha += fade_rate;
					overlay.alpha -= fade_rate;
					dimoverlay.alpha -= 0.001;
					break;
				case 24:
					if (!init_sprites[ctr-2]) {
						init_sprites[ctr - 2] = true;
						overlay.frame = 18;
						if (stop_text == text2) {
							make_sprites(ctr, text2);
						} else {
							make_sprites(ctr, text);
						}
					}
					init_sprites[ctr - 2] = true;
					overlay.alpha += fade_rate;
					bg.alpha -= fade_rate;
					
					if (overlay.alpha >= 1) {
						stop_text.y = -100;
					}
					break;
			}
			
			super.update();
		}
		
		private var fade_rate:Number = 0.009;
		private var new_ctr:int = 0;
		private var bg_timer:Number = 0;
		private static var cur_m:Array;
		private static var cur_p:Array;
		private static var pos_ctr:int;
		private function make_sprites(pg:int, _text:FlxBitmapFont):void {
			if (text == _text) {
				cur_m = sprites_1.members;
				sprites_1.setAll("exists", false);
				cur_p = positions_1;
			} else {
				cur_m = sprites_2.members;
				sprites_2.setAll("exists", false);
				cur_p= positions_2;
			}
			
			
			pos_ctr = 0;
			if (pg == PG_SPRITES_START) {
				mk(Slime.Slime_Sprite, 16, 16, [0, 1],5,  4, 20);
				mk(Annoyer.S_ANNOYER_SPRITE, 16, 16, [0, 1, 2, 3, 4, 5], 8,  130, 46);
				mk( Pew_Laser.PEW_LASER, 16, 16, [0], 2,  5, 66);
				mk(Shieldy.SPRITE_SHIELDY, 16, 16, [1, 2, 1, 0, 1, 2, 1, 0, 16, 17, 18], 5,  130, 92);
				mk( Pew_Laser.PEW_LASER_BULLET, 16, 8, [0, 1], 8,  5, 84);
				mk(Sun_Guy.C_SUN_GUY, 16, 24, [0, 1, 2, 3, 4], 3,  11, 110);
				mk(Sun_Guy.C_LIGHT_ORB, 16, 16, [0, 1, 2, 3, 4, 3, 2, 1], 6,  125, 120);
				mk( Sun_Guy.C_SUN_GUY_WAVE, 128, 8, [3, 4, 5], 8,  8, 144);
			} else if (pg == PG_SPRITES_START + 1) {
				mk(Mover.mover_sprite, 16, 16, [0, 1], 4,  35, -4);
				mk(On_Off_Laser.on_off_shooter_sprite, 16, 16, [0, 1, 2, 2, 1, 0], 2,  108, 30);
				mk(Four_Shooter.four_shooter_sprite, 16, 16, [0, 1, 2, 2, 1, 0], 3,  4, 20);
				mk(Slasher.slasher_sprite, 24, 24, [0, 1, 0, 1, 0, 1], 3,  115, 68);
				mk(Red_Boss.red_boss_sprite, 32, 32, [0, 0, 1, 0, 0, 2], 3,  12, 110);
				mk(Red_Boss.ripple_sprite, 48, 8, [0, 1], 12, 4, 138);
			} else if (pg == PG_SPRITES_START + 2) {
				mk(Dog.dog_sprite, 16, 16, [2, 3, 2, 3, 4, 5, 4, 5, 6, 7, 6, 7, 2, 3], 4, 22, -3);
				mk(Frog.frog_sprite, 16, 16, [0, 1, 0, 1, 3, 3], 2, 118, 20);
				mk(Rotator.rotator_sprite, 16, 16, [0, 1], 10, 20, 42);
				mk(Person.person_sprite, 16, 16, [0, 1, 0, 1, 2, 3, 2, 3, 4, 5, 4, 5, 2, 3, 2, 3], 5, 120, 68);
				mk(WallBoss.wall_sprite, 160, 32, [0, 1], 4, -1, 120);
				mk(WallBoss.face_sprite, 64, 32, [0, 2, 0, 2,0,2, 1,1, 4,4], 5, -1 + 48, 120);
				mk(WallBoss.r_hand_sprite, 32, 32, [0, 1, 2, 3], 1, 8, 150);
				mk(WallBoss.l_hand_sprite, 32, 32, [0, 1, 2, 3], 1, 128, 150);
				cur_m[7].scale.x = -1;
			} else if (pg == PG_SPRITES_START + 3) {
				mk(Rat.rat_sprite, 16, 16, [0, 1], 5, 16, 3);
				mk(Gasguy.gas_guy_sprite, 16, 24, [0, 1],4, 122, 20);
				mk(Gasguy.gas_guy_cloud_sprite, 24, 24, [0, 1], 3, 137, 34);
				mk(Silverfish.silverfish_sprite, 16, 16, [4, 5], 6, 5, 46);
				mk(Dash_Trap.dash_trap_sprite, 16, 16, [4, 5], 12, 137, 66);
				mk(Spike_Roller.Spike_Roller_Sprite_H, 128, 16, [0, 1], 5, 5, 78);
				mk(Splitboss.splitboss_sprite, 24, 32, [0, 1, 2, 1], 5, 70, 120);
			} else if (pg == PG_SPRITES_START + 4) {
				mk(Dustmaid.dustmaid_sprite, 16, 24, [0, 0, 0, 1, 2, 1, 2, 3, 4,3,4], 7, 5, -3);
				mk(Burst_Plant.burst_plant_sprite, 16, 16, [0, 0, 1, 0, 1, 3, 3, 3,3,0], 8, 140, 25);
				mk(Eye_Boss.eye_boss_water_sprite, 24, 24, [0, 1, 2, 3, 2, 1], 10, 5, 70);
				mk(Eye_Boss.eye_boss_water_sprite, 24, 24, [4, 5, 4, 5, 6, 7, 6], 6, 120, 70);
			} else if (pg == PG_SPRITES_START + 5) {
				mk(Lion.lion_sprite, 32, 32, [10, 11, 10, 11, 10, 11, 12, 12], 4, 10, -5);
				mk(Contort.contort_big_sprite, 16, 32, [0, 1, 2, 1], 9, 140, 20);
				mk(Contort.contort_small_sprite, 16, 16, [0, 1], 9, 140, 50);
				mk(Contort.contort_small_sprite, 16, 16, [2,3], 9, 118, 50);
				mk(Contort.contort_small_sprite, 16, 16, [4, 5], 9, 126, 65);
				mk(Fire_Pillar.fire_pillar_base_sprite, 16, 16, [0, 1], 8, 5, 54 + 32 - 4 - 12);
				mk(Fire_Pillar.fire_pillar_sprite, 16, 32, [0, 0, 0, 0, 1, 2, 3, 4, 3, 4, 5, 6, 0], 9, 5, 54);
				mk(Circus_Folks.both_sprite, 16, 32, [0, 1], 8, 65, 94);
			} else if (pg == PG_SPRITES_START + 6) {
				//follower
				mk(Follower_Bro.sprite_follower, 16, 24, [1, 2, 1, 0], 4, 14, -5);
				//edward
				mk(Sadbro.sadman_sprite, 16, 16, [0, 1], 2, 120, 20);
				//fisherman
				mk(NPC.embed_beach_npcs, 16, 16, [10,11], 3, 6, 52);
				//walker
				mk(Red_Walker.sprite_redwalker, 32, 48, [0, 1, 2, 3, 4], 6, 130, 50);
				// lobster
				mk(NPC.embed_beach_npcs, 16, 16, [0], 2, 6, 80);
				//hairs
				//bombs
				
			}else if (pg == PG_SPRITES_START + 7) {
				// Miao, Icky, Goldman, Shopguy, Rank
				mk(Trade_NPC.embed_dame_trade_npc, 16, 16, [0,1], 4,140, 49);
				mk(Trade_NPC.embed_dame_trade_npc, 16, 16, [10,11], 4,2, 15);
				mk(Trade_NPC.embed_dame_trade_npc, 16, 16, [20,21], 4,124, 91);
				mk(Trade_NPC.embed_dame_trade_npc, 16, 16, [50, 51], 4, 2, 45);
				mk(Forest_NPC.embed_forest_npcs, 16, 16, [30,31], 4, 129, 15);
				mk(Trade_NPC.embed_dame_trade_npc, 32, 32, [15, 15, 15, 15, 15, 15, 15, 15, 16, 17, 17, 18, 18], 18, 2, 80);
			}else if (pg == PG_SPRITES_START + 8) {
				// James, Thorax, Rabbit, Golem
				mk(Forest_NPC.embed_forest_npcs, 16, 16, [0, 1], 4, 4, 0);
				mk(Forest_NPC.embed_forest_npcs, 16, 16, [10,10,11,10,10,12], 4, 130, 0);
				mk(Forest_NPC.embed_forest_npcs, 16, 16, [20,21,20,22], 4, 4, 20);
				mk(Forest_NPC.embed_forest_npcs, 16, 16, [30,31], 4, 130, 20);
				mk(NPC.embed_cliff_npcs, 16, 16, [1,3,1,5,1,1,1,0,2,0,4,0,0,1,1], 4, 4, 40); // More ? 
				//folks
				mk(Suburb_Walker.embed_suburb_folk, 16, 16, [0,1],4, 3, 83);
				mk(Suburb_Walker.embed_suburb_folk, 16, 16, [9,10],4, 140, 80);
				mk(Suburb_Walker.embed_suburb_folk, 16, 16, [18,19],4, 3, 103);
				mk(Suburb_Walker.embed_suburb_folk, 16, 16, [27,28],4, 140, 103);
				mk(Suburb_Walker.embed_suburb_folk, 16, 16, [36,37],4, 3, 123);
				mk(Suburb_Walker.embed_suburb_folk, 16, 16, [45,46],4, 140, 123);
			}else if (pg == PG_SPRITES_START + 9) {
				mk(Chaser.embed_chaser_sprite, 16, 32, [8,9], 4, 2, 4);
				mk(Space_NPC.embed_space_npc, 32, 32, [10,11], 4, 120, 106);
				mk(Space_NPC.embed_space_npc, 32, 32, [12,13], 4, 3, 106);
				mk(Space_NPC.embed_space_npc, 16,16,[0,1], 4, 20, 40);
				mk(Space_NPC.embed_space_npc, 16,16,[20,21], 4, 20, 70);
				mk(Space_NPC.embed_space_npc, 16,16,[22,23], 4, 20, 70);
				mk(Space_NPC.embed_space_npc, 16,16,[10,11], 4, 120, 40);
				
				//entities
			} else if (pg == PG_SPRITES_START + 10) {
				mk(Player.Player_Sprite, 16, 16, [1, 0, 1, 0], 6, 39, -5);
				mk(Mitra.mitra_sprite, 16, 16, [0, 1, 0, 1], 6, 110, 17);
				mk(Sage.sage_sprite, 16, 16, [0, 1], 6, 20, 44);
				mk(Shadow_Briar.embed_briar, 16, 16, [0, 1], 6, 125, 67);
			} else if (pg == PG_SPRITES_START + 11) {
				//us???
				
				mk(embed_dev_npcs, 16, 16, [0], 1, 6, 28);
				mk(embed_dev_npcs, 16, 16, [10], 1, 140, 28);
				
			} 
		}
		
		// Set sprite ref at a[idx] to graphic, with width w, height h.
		// Play the anim FRAMES at frame rate FR.
		// Set its position relative to its accompanying text to posx,posy.
		private function mk(graphic:Class, w:int, h:int, frames:Array, fr:int,posx:int,posy:int):void {
			cur_m[pos_ctr].loadGraphic(graphic, true, false, w, h);
			cur_m[pos_ctr].scale.x = 1;
			cur_m[pos_ctr].addAnimation("anim"+ctr.toString(), frames, fr, true);
			cur_m[pos_ctr].play("anim"+ctr.toString());
			cur_m[pos_ctr].exists = true;
			cur_p[pos_ctr].x = posx;
			cur_p[pos_ctr].y = posy;
			pos_ctr ++;
		}
		private function poopy_save_stuff():void {
			
			save_dialog_bg = new FlxSprite;
			save_dialog_bg.loadGraphic(Checkpoint.checkpoint_save_box_sprite, true, false, 80, 29);
			save_dialog_bg.x = (160 - save_dialog_bg.width) / 2;
			save_dialog_bg.y = 20 + (160 - save_dialog_bg.height) / 2;
			save_dialog_bg.scrollFactor = new FlxPoint(0, 0);
			save_dialog_text = EventScripts.init_bitmap_font(DH.lk("checkpoint",0), "left", save_dialog_bg.x + 5, save_dialog_bg.y + 2, null, "apple_white");
			save_dialog_text.drop_shadow = true;
			save_dialog_selector = new FlxSprite;
			save_dialog_selector.loadGraphic(PauseState.arrows_sprite, true, false, 7, 7);
			save_dialog_selector.scrollFactor = new FlxPoint(0, 0);
			save_dialog_selector.addAnimation("flash", [0, 1], 8);
			save_dialog_selector.play("flash");
			save_dialog_selector.scale.x = -1;
			
			
			save_dialog_selector.x = save_dialog_text.x + 4;
			save_dialog_selector.y = save_dialog_text.y + 8;
			if (DH.isZH()) save_dialog_selector.y = save_dialog_text.y + 16;
		}
	}

}