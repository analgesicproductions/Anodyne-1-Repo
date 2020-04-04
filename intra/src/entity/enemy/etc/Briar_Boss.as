package entity.enemy.etc 
{
	import entity.decoration.Water_Anim;
	import entity.gadget.Dust;
	import entity.interactive.npc.Shadow_Briar;
	import flash.geom.Point;
	import global.Registry;
	import helper.Achievements;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.AnoSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import states.PlayState;
	
	/**
	 * TODO: 
		 * Up ice difficulty?
		 * Finish happy attack phase difficulties
		 * Bullets to main phase.
		 * outro scene.
		 * add briar sprite to intro/outro etc
	 * @author Melos Han-Tani
	 */
	public class Briar_Boss extends AnoSprite 
	{
		private var briar:FlxSprite;
		
		private var happy_thorn:FlxSprite;
		private var happy_health:int = 3;
		
		private var blue_thorn:FlxSprite;
		private var blue_health:int = 3;
		
		private var ice_crystal:FlxSprite;
		private var ice_exs:FlxGroup = new FlxGroup(5);
		
		private var body:FlxSprite;
		private var thorns:FlxGroup = new FlxGroup(10);
		private var bullet_thorns:FlxGroup = new FlxGroup(16);
		
		private var thorn_harmful_idx:int = 10; // Index into the ground thorn attack anim at which it becomes harmful
		private var thorn_harmless_idx:int = 19; // lah blah harmless
		
		private var is_staggered:Boolean = false; // Is one of the eyes staggered? Then attack in the normal state
		private var overhang:FlxSprite;
		private var core:FlxSprite;
		
		private const S_ATK_BLUE:int = 3;
		private const S_ATK_HAPPY:int = 2;
		private const S_ATK_BIG:int = 1;
		private const S_INTRO:int = 0;
		private const S_DYING:int = -1;
		private const S_DEAD:int = -2;
		private const S_PRE:int = -3; // happy/blue not done
		
		[Embed(source = "../../../res/sprites/enemies/etc/briar_arm_right.png")] public static const embed_blue_thorn:Class;
		[Embed(source = "../../../res/sprites/enemies/etc/briar_body.png")] public static const embed_body_thorn:Class;
		[Embed(source = "../../../res/sprites/enemies/etc/briar_arm_left.png")] public static const embed_happy_thorn:Class;
		[Embed(source = "../../../res/sprites/enemies/etc/briar_ground_thorn.png")] public static const embed_ground_thorn:Class;
		[Embed(source = "../../../res/sprites/enemies/etc/briar_ice_crystal.png")] public static const embed_ice_crystal:Class;
		[Embed(source = "../../../res/sprites/enemies/etc/briar_fire_eye.png")] public static const embed_fire_eye:Class;
		[Embed(source = "../../../res/sprites/enemies/etc/briar_dust_explosion.png")] public static const embed_dust_explosion:Class;
		[Embed(source = "../../../res/sprites/enemies/etc/briar_thorn_bullet.png")] public static const embed_thorn_bullet:Class;
		[Embed(source = "../../../res/sprites/enemies/etc/briar_mist.png")] public static const embed_mist:Class;
		[Embed(source = "../../../res/sprites/enemies/etc/briar_ice_explosion.png")] public static const embed_ice_explosion:Class;
		[Embed(source = "../../../res/sprites/enemies/etc/briar_overhang.png")] public static const embed_overhang:Class;
		[Embed(source = "../../../res/sprites/enemies/etc/briar_core.png")] public static const embed_briar_core:Class;
		
		
		public function Briar_Boss(args:Array)
		{
			super(args);
			
			overhang = new FlxSprite(tl.x, tl.y);
			overhang.loadGraphic(embed_overhang, true, false, 160, 48);
			
			// This is the "complete" (in flesh) briar
			briar = new FlxSprite();
			briar.loadGraphic(Shadow_Briar.embed_briar,true,false,16,16);
			briar.addAnimation("idle_d", [0]);
			briar.addAnimation("oh_no", [10], 2);
			briar.addAnimation("walk_u", [4,5], 4);
			briar.play("idle_d");
			briar.x = tl.x + 80 - briar.width / 2;
			briar.y = tl.y + 32;
			
			// Left thorn, "Happy"
			happy_thorn = new FlxSprite(tl.x + 16,tl.y + 16); 
			happy_thorn.loadGraphic(embed_happy_thorn, true, false, 64, 80);
			happy_thorn.immovable = true;
			happy_thorn.addAnimation("hit", [4, 6,4, 6,4, 6,4, 6,4, 6,4, 6], 15);
			happy_thorn.addAnimation("hurt", [7,8], 4); // When it's been it and is vulnerable
			happy_thorn.addAnimation("active", [4,5], 5); // When it is attacking. 
			happy_thorn.addAnimation("off", [0,1,2,3], 4); // When it's not doing anything.
			happy_thorn.play("off");
			happy_thorn.height = 63;
			happy_thorn.width = 24;
			
			// right thorn, "Blue:
			blue_thorn = new FlxSprite(tl.x + 5*16, tl.y + 16);
			blue_thorn.loadGraphic(embed_blue_thorn, true, false, 64, 80);
			blue_thorn.immovable = true;
			blue_thorn.addAnimation("hit", [4, 6,4, 6,4, 6,4, 6,4, 6,4, 6], 15);
			blue_thorn.addAnimation("hurt", [7,8], 4); // When it's been it and is vulnerable
			blue_thorn.addAnimation("active", [4,5], 5); // When it is attacking. 
			blue_thorn.addAnimation("off", [1,2,3,0], 4); // When it's not doing anything.
			blue_thorn.play("off");
			blue_thorn.height = 63;
			blue_thorn.width = 24;
			blue_thorn.offset.x = 40;
			blue_thorn.x += 40;
			
		
			
			// The main body of the boss.
			body = new FlxSprite(tl.x + 16, tl.y);
			body.loadGraphic(embed_body_thorn, true, false, 128, 80);
			body.addAnimation("active", [0], 10,false);
			body.addAnimation("idle", [0], 10);
			body.play("active");
			body.height = 60;
			
			core = new FlxSprite(tl.x + 64, tl.y + 32);
			core.loadGraphic(embed_briar_core, true, false, 32, 18);
			core.addAnimation("glow", [0, 1, 2, 1], 4);
			core.addAnimation("flash", [3, 4], 12);
			core.play("glow");
			
			// The Ice crystal the blue thorn shoots.
			// MARINA_ANIMS_ICE_CRYSTAL
			ice_crystal = new FlxSprite(0, 0);
			ice_crystal.loadGraphic(embed_ice_crystal, true, false, 16, 16);
			ice_crystal.addAnimation("move", [0, 1], 6, true);
			ice_crystal.play("move");
			
			
			// Initialize the little thorn barrier that is either
			// on the top or bottom of the screen
			init_pre_thorn(64,0);

			// The logical "sprite" doesn't actually have a sprite.
			visible = false;
			
			var iter:int = 0;
			
			// Create the thorns that rise from the ground.
			// MARINA_ANIMS_GROUND_THORN
			for (iter = 0; iter < thorns.maxSize; iter++) {
				var thorn:FlxSprite = new FlxSprite(0, 0);
				thorn.loadGraphic(embed_ground_thorn, true, false, 16, 16);
				thorn.width = 6;
				thorn.height = 6;
				thorn.offset.x = 5;
				thorn.offset.y = 4;
				// Thorn anim, sparkle, rise from the ground.
				thorn.addAnimation("attack", [0, 1, 2, 0, 3, 3, 3, 8, 9, 10, 11, 7, 11, 7,11,7, 10, 9, 8, 5], 8, false);
				thorns.add(thorn);
				thorn.exists = false;
			}
			
			// Create te thorn bullets that are fired in the main
			//body phase halfway through the fight AND BEYONODNDOD
			
			//			MARINA_ANIMS_BULLET_THORN

			for (iter = 0; iter < bullet_thorns.maxSize; iter++ ) {
				var bthorn:FlxSprite = new FlxSprite(0, 0);
				bthorn.loadGraphic(embed_thorn_bullet, true, false, 16, 16);
				bthorn.addAnimation("move", [0, 1], 10, true);
				bthorn.width = bthorn.height = 6;
				bthorn.offset.y = 5;
				bthorn.offset.x = 5;
				bthorn.play("move");
				bullet_thorns.add(bthorn);
				bthorn.exists = false;
			}
			
			// MARINA_ANIMS_ICE_EXPLOSIONS
			var ice_ex:FlxSprite;
			for (iter = 0; iter < ice_exs.maxSize; iter++) {
				ice_ex = new FlxSprite;
				ice_ex.loadGraphic(embed_ice_explosion, true, false, 24, 24);
				ice_ex.addAnimation("move", [0, 1, 2, 3], 15, false);
				ice_ex.exists = false;
				ice_exs.add(ice_ex);
			}
			parent.fg_sprites.add(ice_exs);
			
			// Check game states - if we haven't finishe
			// happy and blue, then don't start hte fight. DUH
			//Registry.GE_States[Registry.GE_Briar_Blue_Done] = true;
			//Registry.GE_States[Registry.GE_Briar_Happy_Done]  = true;
			
			if (Registry.GE_States[Registry.GE_Briar_Blue_Done] && Registry.GE_States[Registry.GE_Briar_Happy_Done])
			{
				state = S_INTRO;
				parent.sortables.add(briar);
			} else {
				state = S_PRE;
			}
			//if (xml.@alive == "false") {
				//state = S_DEAD;
				//exists = false;
				//update_parent_map(true);
				//briar.exists = false;
				//pre_thorn.exists = false;
			//} 
			
		}
		
		override public function destroy():void 
		{
			parent.map_bg_2.visible = true;
			parent.anim_tiles_group.setAll("visible", true);
			parent.sortables.remove(happy_thorn,true);
			parent.sortables.remove(blue_thorn, true);
			parent.sortables.remove(body, true);
			parent.sortables.remove(thorns, true);
			parent.sortables.remove(ice_crystal, true);
			parent.sortables.remove(fireballs, true);
			parent.sortables.remove(dust_explosions, true);
			parent.sortables.remove(pre_thorn, true);
			parent.sortables.remove(bullet_thorns, true);
			parent.sortables.remove(briar, true);
			parent.sortables.remove(overhang, true);
			
			super.destroy();
			// Need to be null-chcked since not allocate din the constructor
			if (dust_explosions != null) {
				dust_explosions.destroy();
				dust_explosions = null;
			}
			
			if (dusts != null) { // bg
				dusts.destroy();
				dusts = null;
			}
			if (fireballs != null) {
				fireballs.destroy();
				fireballs = null;
			}
			
			fire_eye = null;
			
			if (pre_thorn != null) {
				pre_thorn.destroy();
				pre_thorn = null;
			}
			ice_exs = null;
			
			briar.destroy();
			briar = null;
			
			overhang.destroy();
			overhang = null;
			bullet_thorns.destroy();
			bullet_thorns = null;
			happy_thorn.destroy();
			blue_thorn.destroy();
			body.destroy();
			thorns.destroy();
			ice_crystal.destroy();
			ice_crystal = null;
			happy_thorn = null;
			blue_thorn = null;
			body = null;
			mists = null;
			thorns = null;
			core = null;
		}
		
		
		override public function update():void 
		{
			
			if (FlxG.keys.FOUR && Intra.is_test) {
				state = S_DYING;
			}
			if (!did_init) {
				if (state != S_PRE && false == intro_add_lock) {
					did_init = true;
					parent.sortables.add(happy_thorn);
					parent.sortables.add(blue_thorn);
					parent.sortables.add(body);
					parent.sortables.add(thorns);
					parent.sortables.add(ice_crystal);
					parent.sortables.add(bullet_thorns);
					parent.sortables.add(overhang);
					parent.fg_sprites.add(core); // ???
					pre_thorn.y = tl.y + 16 * 9;
				}
			}
			
			switch (state) {
				case S_PRE:
					state_pre();
					super.update();
					return;
				case S_INTRO:
					state_intro();
					super.update();
					return;
				case S_ATK_BIG:
					state_atk_big();
					break;
				case S_ATK_BLUE:
					state_atk_blue();
					break;
				case S_ATK_HAPPY:
					state_atk_happy();
					break;
				case S_DYING:
					state_dying();
					super.update();
					return;
				case S_DEAD:
					state_dead();
					super.update();
					return;
			}
			
			
			// collision checks against the body and large thorns
			
			if (player.y < body.y + body.height) {
				player.y = body.y + body.height;
				player.touchDamage(1);
			}
			
			if (player.overlaps(happy_thorn)) {
				FlxG.collide(happy_thorn, player);
				player.touchDamage(1);
			}
			
			if (player.overlaps(blue_thorn)) {
				FlxG.collide(blue_thorn, player);
				player.touchDamage(1);
			}
			
			if (player.y + player.height > pre_thorn.y + 2) {
				player.y = pre_thorn.y - player.height;
				player.touchDamage(1);
			}
			super.update();
		}
		
		private var pre_thorn:FlxSprite;
		private var pre_ctr:int = 0;
		private function state_pre():void {
			switch (pre_ctr) {
				case 0:
					
					pre_ctr = 1;
					break;
				case 1:
					if (player.y < pre_thorn.y + 14 && player.x < pre_thorn.x + 40) {
						player.y = pre_thorn.y + 16;
						player.touchDamage(1);
					}
					break;
			}
		 
		}
		
		/**
		 * Update the parent's map. if done is true this means it's the "battle over",
		 * otherwise it's the during-battle
		 * @param	done
		 */
		
		private var saved_old:Boolean = false;
		private var old:Array = new Array(100);
		
		private function update_parent_map(done:Boolean):void { 
			var during:Array = new Array (
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
			0, 0, 0, 171, 172, 172, 173, 0, 0, 0,
			0, 171, 172, 181, 170, 170, 180, 172, 173, 0,
			0, 177, 170, 170, 170, 170, 170, 170,178, 0,
			0, 177, 170, 170, 170, 170, 170, 170, 178, 0,
			0, 174, 175, 175, 183, 182, 175, 175, 176, 0,
			0, 184, 185, 185, 177, 178, 185, 185, 186, 0
			);
			
			var t:FlxTilemap;
			t = parent.curMapBuf;
			
			if (saved_old == false) {
				saved_old = true;
				for (var j:int = 0; j < 100; j++) {
					old[j] = t.getTileByIndex(j);
				}
			}
			var p:PlayState = parent;
			if (done == false) {
				
				parent.map_bg_2.visible = false;
				p.anim_tiles_group.setAll("visible", false);
				for (var i:int = 0; i < 100; i++) {
					t.setTileByIndex(i, during[i], true);
				}
			} else {
				p.anim_tiles_group.setAll("visible", true);
				for (i = 0; i < 100; i++) {
					t.setTileByIndex(i, old[i], true);
				}
			}
		}
		private var intro_ctr:int = 0;
		private var intro_add_lock:Boolean = true;
		private function state_intro():void {
			switch (intro_ctr) {
				case 0:
					(Registry.volume_scale > 0) ? Registry.volume_scale -= 0.01 : 1;
					
					if (player.y < tl.y + 16 * 6) {
						player.be_idle();
						Registry.GAMESTATE.dialogue_latency = -1;
						DH.start_dialogue(DH.name_briar, DH.scene_briar_go_before_fight); // Hi!
						intro_ctr += 1;
					}
					break;
				case 1:
					(Registry.volume_scale > 0) ? Registry.volume_scale -= 0.01 : 1;
					if (false == DH.a_chunk_is_playing()) {
						Water_Anim.START_WATER_ANIMF();
						Registry.sound_data.stream_sound.play();
						intro_ctr += 1;
						FlxG.shake(0.01, 100);
						Registry.sound_data.stop_current_song();
					}
					break;
				case 2:
					// The water anim freezes the player till it's done.
					if (player.state != player.S_INTERACT) {
						FlxG.shake(0, 0);
						intro_ctr += 1;
					}
					break;
				case 3:
					player.be_idle();
					intro_ctr += 1;
					briar.play("oh_no");
					DH.start_dialogue(DH.name_briar, DH.scene_briar_go_before_fight);  // !!!
					break;
				case 4:
					if (DH.a_chunk_just_finished()) { 
						intro_add_lock = false;
						Registry.sound_data.start_song_from_title("BRIARFIGHT");
						Registry.volume_scale = 1;
						FlxG.flash(0xffffffff, 1);
						update_parent_map(false);
						parent.anim_tiles_group.setAll("visible", false);
						briar.visible = false;
						intro_ctr += 1;
						Registry.GAMESTATE.dialogue_latency = -1;
					}
					break;
				case 5:
					DH.start_dialogue(DH.name_briar, DH.scene_briar_go_before_fight); // Oh no
					player.be_idle();
					intro_ctr += 1;
					break;
				case 6:
					if (false == DH.a_chunk_is_playing()) {
						state = S_ATK_BIG;
						Water_Anim.UNALIVE = true;
					}
					break;
			}
		}
		
		private var ctr_atk_big:int = 0; // State counter
		private var ctr_atk_big_atks:int = 0; // How many attacks it's done
		private var thorn_ref:FlxSprite;
		private var t_atk_big:Number = 0;
		private var iter_atk_big:int = 0;
		private var atk_big_max_atks:Array = new Array(1, 1, 1, 2, 2, 3, 3);
		private var tm_atk_big:Array = new Array(0.18, 0.16, 0.14, 0.13, 0.11, 0.09,0.06);
		private var atk_big_fps:Array = new Array(12, 13, 14, 15, 16, 17, 17);
		private var t_shoot_bullets:Number = 0;
		private var tm_shoot_bullets:Array = new Array(1.4, 1.4,1.2,1.2,1,1,1);
	
		private function new_bul(group:FlxGroup,ref:Point,x:int, y:int, vx:int=0, vy:int=0, ax:int=0, ay:int=0,anim:String=""):void {
			var b:FlxSprite = group.getFirstAvailable() as FlxSprite;
			
			if (b != null) {
				b.velocity.x = vx;
				b.velocity.y = vy;
				b.acceleration.x = ax;
				b.acceleration.y = ay;
				if (ref == null) {
					b.x = x;
					b.y = y;
				} else {
					b.x = ref.x + x;
					b.y = ref.y + y;
				}
				
				if (anim != "") {
					b.play(anim);
				}
				b.exists = true;
			}
		}
		
		private function atk_big_shoot_bullets(type:int):void {
			var b:FlxSprite;
			if (type > 4) {
				new_bul(bullet_thorns, tl,36+16, 60, 0, 40, 0, 25);
				new_bul(bullet_thorns, tl, 52+16, 60, 0, 40, 0, 25);
				new_bul(bullet_thorns, tl, 69+16, 60, 0, 40, 0, 25);
				new_bul(bullet_thorns, tl, 84+16, 60, 0, 40, 0, 25);
			} else if (type > 2) {
				new_bul(bullet_thorns, tl, 16 + 20, 44, -10, 45, 5, 20);
				new_bul(bullet_thorns, tl, 16 + 101, 44, 10, 45, -5, 20);
				new_bul(bullet_thorns, tl,36+16, 60, 0, 40, 0, 25);
				new_bul(bullet_thorns, tl, 52+16, 60, 0, 40, 0, 25);
				new_bul(bullet_thorns, tl, 69+16, 60, 0, 40, 0, 25);
				new_bul(bullet_thorns, tl, 84+16, 60, 0, 40, 0, 25);
			} else {
				
				new_bul(bullet_thorns, tl, 16 + 4, 44, -10, 45, 5, 20);
				new_bul(bullet_thorns, tl, 16 + 116, 44, 10, 45, -5, 20);
				new_bul(bullet_thorns, tl, 16 + 20, 44, -10, 45, 5, 20);
				new_bul(bullet_thorns, tl, 16 + 101, 44, 10, 45, -5, 20);
				new_bul(bullet_thorns, tl,36+16, 60, 0, 40, 0, 25);
				new_bul(bullet_thorns, tl, 52+16, 60, 0, 40, 0, 25);
				new_bul(bullet_thorns, tl, 69+16, 60, 0, 40, 0, 25);
				new_bul(bullet_thorns, tl, 84+16, 60, 0, 40, 0, 25);
				
			}
		}
		private function state_atk_big():void {
			
			// Ground thorn attack - gives a warning then they sort of
			// poke out from the ground.
			for each (thorn_ref in thorns.members) {
				if (thorn_ref != null && thorn_ref._animations != null) {
					if (thorn_ref._curFrame >= thorn_harmful_idx && thorn_ref._curFrame < thorn_harmless_idx) {
						if (thorn_ref.overlaps(player) && player.state == player.S_GROUND) {
							player.touchDamage(1);
						}
					}
				}
			}
			
			t_shoot_bullets += FlxG.elapsed;
			if (t_shoot_bullets > tm_shoot_bullets[6 - (blue_health + happy_health)]) {
				t_shoot_bullets = 0;
				atk_big_shoot_bullets(blue_health + happy_health);
			}
	
			for each (thorn_ref in bullet_thorns.members) {
				if (thorn_ref != null && true == thorn_ref.exists) {
					if (player.state == player.S_GROUND && thorn_ref.overlaps(player)) {
						player.touchDamage(1);
					}
					
					if (thorn_ref.y + 6 > tl.y + 160) {
						thorn_ref.exists = false;
					}
				}
			}
			
			
			if (body._curAnim != null && body._curAnim.name == "active" && body._curAnim.frames.length -1 == body._curFrame) {
				body.play("idle");
			}
			// Also do an attack when less than 3 health.
			
			switch (ctr_atk_big) {
				// Make thorns follow the player across the screen and begin to pop up.
				case 0:
					t_atk_big += FlxG.elapsed;
					// Speed of the attack increases 
					if (t_atk_big > tm_atk_big[6 - (blue_health + happy_health)]) {
						t_atk_big = 0;
						body.play("active");
						if (iter_atk_big == 0) {
							Registry.sound_data.play_sound_group(Registry.sound_data.briar_shine_group);
						}
						thorn_ref = thorns.getFirstAvailable() as FlxSprite;
						if (thorn_ref != null) {
							
							thorn_ref.exists = true;
							thorn_ref.x = thorn_ref.offset.x + tl.x + 16 * (1 + iter_atk_big);
							if (player.y < tl.y + 6 * 16) {
								if (iter_atk_big > 1 && iter_atk_big <  6 && (player.y < tl.y + 5 * 16)) {
									thorn_ref.y = tl.y + 4 * 16;
								} else {
									thorn_ref.y = tl.y  + 5 * 16;
								}
							} else if (player.y < tl.y + 7 * 16) {
								thorn_ref.y = tl.y + 6 * 16;
							} else if (player.y < tl.y + 8 * 16) {
								thorn_ref.y = tl.y + 7 * 16;
							} else {
								thorn_ref.y = tl.y + 8 * 16;
							}
							// SFX
							thorn_ref.play("attack");
							thorn_ref._curAnim.delay = 1 / atk_big_fps[6 - (blue_health + happy_health)];
							iter_atk_big += 1;	
						}
					}
					if (iter_atk_big == 8) {
						iter_atk_big = 0;
						ctr_atk_big += 1;
					}
					break;
				case 1:
					// when all thorns are done, either do it again or transition
					for each (thorn_ref in thorns.members) {
						if (thorn_ref != null && thorn_ref.exists && thorn_ref.finished) {
							thorn_ref.exists = false;
							iter_atk_big += 1;
						}
					}
					// State change - either reset or go to blue or happy attack
					if (iter_atk_big == 8) {
						iter_atk_big = 0;
						ctr_atk_big = 0;
						ctr_atk_big_atks += 1;
						if (ctr_atk_big_atks > atk_big_max_atks[6 - (blue_health + happy_health)]) {
							ctr_atk_big_atks = 0;
						
							if (happy_health == 0) {
								state = S_ATK_HAPPY;
							} else if (blue_health == 0) {
								state = S_ATK_BLUE;
							} else {
								body.play("idle");
								if (Math.random() > 0.5) {
									state = S_ATK_HAPPY;
								} else {
									state = S_ATK_BLUE;
								}
							}
						}
					}
					
					break;
			}
			
			
		}
		
		private var atk_blue_ctr:int = 0;
		
		private var t_atk_blue:Number = 0;
		
		private var atk_blue_vels:Array = new Array(50, 70, 90);
		private var atk_blue_init:Boolean = false;
		private var atk_blue_pt:Point;
		private var atk_blue_init_pt:Point;
		private var atk_blue_vel_mul:Number = 1;
	
		
		private function state_atk_blue():void {
			
			if (!atk_blue_init) {
				atk_blue_init = true;
				atk_blue_pt = new Point(happy_thorn.x + 6, happy_thorn.y + 52);
				atk_blue_init_pt = new Point(blue_thorn.x, blue_thorn.y + 52);
			}
			
			var ex_ref:FlxSprite;
			for each (ex_ref in ice_exs.members) {
				if (ex_ref != null && ex_ref.exists == true) {
					if (ex_ref.finished) {
						ex_ref.exists = false;
					}
				}
			}
			switch (atk_blue_ctr) {
				case 0:
				
					
					blue_thorn.play("active");
					t_atk_blue += FlxG.elapsed;
					ice_crystal.x = blue_thorn.x;
					ice_crystal.y = blue_thorn.y + 52;
					ice_crystal.visible = true;
					ice_crystal.flicker(0.2);
					if (t_atk_blue < 1.5) {
						break;
						
					}
					
					new_bul(ice_exs, null, ice_crystal.x - 4, ice_crystal.y - 4,0,0,0,0,"move");
					Registry.sound_data.teleguy_down.play();
					EventScripts.scale_vector(atk_blue_init_pt, player, ice_crystal.velocity, atk_blue_vels[3 - happy_health]);
					atk_blue_ctr = 1;
					t_atk_blue = 0;
					break;
				case 1:
					if (player.overlaps(ice_crystal)) {
						FlxG.shake(0.01, 0.2);
						new_bul(ice_exs, null, ice_crystal.x - 4, ice_crystal.y - 4,0,0,0,0,"move");
						player.touchDamage(1);
						atk_blue_ctr = 3;
					}
					
					if (player.broom.visible && player.broom.overlaps(ice_crystal)) {
						FlxG.shake(0.01, 0.2);
						new_bul(ice_exs, null, ice_crystal.x - 4, ice_crystal.y - 4,0,0,0,0,"move");
						Registry.sound_data.broom_hit.play();
						atk_blue_vel_mul += 0.15;
						EventScripts.scale_vector(ice_crystal, atk_blue_pt, ice_crystal.velocity, atk_blue_vels[3 - happy_health]);
						ice_crystal.velocity.x *= atk_blue_vel_mul;
						ice_crystal.velocity.y *= atk_blue_vel_mul;
						atk_blue_ctr = 2;
					}
					
					if (ice_crystal.x > tl.x + 160 || ice_crystal.x < tl.x - 16 || ice_crystal.y < tl.y - 16 || ice_crystal.y > tl.y + 160) {
						atk_blue_ctr = 3;
					}
					break;
				case 2:
					if (EventScripts.distance(ice_crystal, atk_blue_pt) < 5) {
						FlxG.shake(0.01, 0.2);
						new_bul(ice_exs, null, ice_crystal.x - 4, ice_crystal.y - 4,0,0,0,0,"move");
						Registry.sound_data.play_sound_group(Registry.sound_data.sb_ball_appear);
						atk_blue_vel_mul += 0.15;
						EventScripts.scale_vector(ice_crystal, player, ice_crystal.velocity, atk_blue_vels[3 - happy_health]);
						ice_crystal.velocity.x *= atk_blue_vel_mul;
						ice_crystal.velocity.y *= atk_blue_vel_mul;
						
						if (happy_health == 3 && atk_blue_vel_mul >= 1.6) {
							atk_blue_ctr = 4;
						} else if (happy_health == 2 && atk_blue_vel_mul >= 1.9) {
							atk_blue_ctr = 4;
						} else if (happy_health == 1 && atk_blue_vel_mul > 2.05) {
							atk_blue_ctr = 4;
						} else {
							atk_blue_ctr = 1;
						}
					}
					
					if (EventScripts.distance(ice_crystal, atk_blue_pt) > 200) {
						atk_blue_ctr = 3;
					}
					break;
				case 3: // transition back to atk_big state, do some cleanup
					
					if (ice_exs.countExisting() == 0) {
						ice_crystal.visible = false;
						blue_thorn.play("off");
						
						if (happy_health == 0 && blue_health == 0) {
							state = S_DYING;
						} else {
							state = S_ATK_BIG;
						}
						atk_blue_vel_mul = 1;
						ice_crystal.velocity.x = ice_crystal.velocity.y = 0;
						atk_blue_ctr = 0;
					}
					break;
				case 4: // Staggered.
					ice_crystal.visible = false;
					
					happy_thorn.play("hurt");
					Registry.sound_data.wb_hit_ground.play();
					FlxG.flash(0xffff1111, 0.4);
					FlxG.shake(0.01, 0.2);
					new_bul(ice_exs, null, ice_crystal.x - 4, ice_crystal.y - 4,0,0,0,0,"move");
					atk_blue_ctr = 5;
					break;
				case 5: // Logic for hitting the thorn
					if (player.broom.overlaps(happy_thorn) && player.broom.visible)  {
						happy_health -= 1;
						core.play("flash");
						FlxG.flash(0xffff0000, 0.8);
						happy_thorn.play("hit");
						Registry.sound_data.wb_hit_ground.play();
						atk_blue_ctr = 6;
						FlxG.shake(0.03, 0.4);
					}
					break;
				case 6:
					if (happy_thorn.finished) {
						core.play("glow");
						happy_thorn.play("off");
						atk_blue_ctr = 3;
					}
					break;
			}
			
		/*
		 * Right side (Blue)
		 * 
		 * shoots out ice lazer thing, need to hit it back and forth with the red eye to hurt and open it
		 * Or a sharp one that explodes
		 * */
		}
		
		private var atk_happy_ctr:int = 0;
		
		private var fire_eye:FlxSprite;
		private var fireballs:FlxGroup;
		private var dusts:FlxGroup;
		private var dust_explosions:FlxGroup;
		private var did_atk_happy_init:Boolean = false;
		private var mists:FlxGroup;
		
		private var t_atk_happy:Number = 0;
		
		private function state_atk_happy():void {

			if (!did_atk_happy_init) {
				did_atk_happy_init = true;
				
				// Fire-eye init MARINA_ANIMS_FIRE_EYE
				fire_eye = new FlxSprite();
				fire_eye.loadGraphic(embed_fire_eye, true, false, 16, 16);
				fire_eye.addAnimation("shoot", [6, 7, 8, 9], 10, true);
				fire_eye.addAnimation("grow", [0, 1, 2, 3, 4, 5], 10, false);
				fire_eye.addAnimation("ungrow", [5, 4, 3, 2, 1, 0], 10, false);
				fire_eye.play("shoot");
				parent.bg_sprites.add(fire_eye);
				
				// Fireballs init MARINA_ANIMS_FIREBALLS
				fireballs = new FlxGroup(12);
				for (var i:int = 0; i < fireballs.maxSize; i++) {
					var fireball:FlxSprite = new FlxSprite;
					fireball.loadGraphic(embed_fire_eye, true, false, 16, 16);
					fireball.addAnimation("move", [12, 13], 12, true);
					fireball.play("move");
					fireball.exists = false;
					fireball.width = fireball.height = 6;
					fireball.offset.x = fireball.offset.y = 5;
					fireballs.add(fireball);
				}
				parent.sortables.add(fireballs);
				
				// Dusts init
				dusts = new FlxGroup(4);
				for (i = 0; i < dusts.maxSize; i++) {
					var dust:Dust = new Dust(0, 0, null, parent);
					dust.exists = false;
					dusts.add(dust);
					
				}
				parent.bg_sprites.add(dusts);
				
				// Explosions init MARINA_ANIMS_DUST_EXPLOSIONS
				dust_explosions = new FlxGroup(4);
				for (i = 0; i < dust_explosions.maxSize; i++) {
					var dust_explos:FlxSprite = new FlxSprite(0, 0);
					dust_explos.loadGraphic(embed_dust_explosion, true, false, 48, 48);
					dust_explos.addAnimation("explode", [0, 1, 2, 3, 4, 5], 12, false);
					dust_explosions.add(dust_explos);
					dust_explos.exists = false;
				}
				parent.sortables.add(dust_explosions);
				
				// Mists init MARINA_ANIMS_MIST
				mists = new FlxGroup(3);
				for (i = 0; i < mists.maxSize; i++) {
					var mist:FlxSprite = new FlxSprite();
					mist.loadGraphic(embed_mist, true, false, 24, 24);
					mist.addAnimation("a", [0, 1], 5);
					mist.play("a");
					mist.exists = false;
					mists.add(mist);
				}
				parent.fg_sprites.add(mists);
			}
			
			for each (fireball in fireballs.members) {
				if (fireball != null && fireball.exists) {
					if (fireball.x < tl.x || fireball.x > tl.x + 160 || fireball.y < tl.y || fireball.y > tl.y + 160) {
						fireball.exists = false;
					}
					
					for each (mist in mists.members) {
						if (mist.exists == true && fireball.overlaps(mist)) {
							fireball.exists = false;
						}
					}
					
					// Check for dust overlap, cause an explosion
					for each (dust in dusts.members) {
						if (dust != null && dust.exists && dust.frame == 0) {
							if (dust.overlaps(fireball)) {
								Registry.sound_data.play_sound_group(Registry.sound_data.dust_explode_group);
								fireball.exists = false;
								dust.exists = false;
								dust_explos = dust_explosions.getFirstAvailable() as FlxSprite;
								if (dust_explos != null) {
									dust_explos.x = dust.x - 16;
									dust_explos.y = dust.y - 16;
									dust_explos.exists = true;
									dust_explos.play("explode");
									
									// Make fireballs appear
									var fire_ref:FlxSprite = fireballs.getFirstAvailable() as FlxSprite;
									if (fire_ref != null) {
										
										fire_ref.velocity.y = 0;  fire_ref.velocity.x = -70;
										fire_ref.exists = true; fire_ref.x = dust_explos.x + 16; fire_ref.y = dust_explos.y + 16;
									}
									fire_ref = fireballs.getFirstAvailable() as FlxSprite;
									if (fire_ref != null) {
										fire_ref.velocity.y = 0; fire_ref.velocity.x = 70;
										fire_ref.exists = true; fire_ref.x = dust_explos.x + 16; fire_ref.y = dust_explos.y + 16;	
									}
									
									fire_ref = fireballs.getFirstAvailable() as FlxSprite;
									if (fire_ref != null) {
										fire_ref.velocity.x = 0;  fire_ref.velocity.y = 70;
										fire_ref.exists = true; fire_ref.x = dust_explos.x + 16; fire_ref.y = dust_explos.y + 16;	
									}
									
									fire_ref = fireballs.getFirstAvailable() as FlxSprite;
									if (fire_ref != null) {
										fire_ref.velocity.x = 0; fire_ref.velocity.y = -70;
										fire_ref.exists = true; fire_ref.x = dust_explos.x + 16; fire_ref.y = dust_explos.y + 16;	
									}
									
									if (dust_explos.overlaps(blue_thorn)) {
										atk_happy_ctr = 4;
															
										Registry.sound_data.wb_hit_ground.play();
										FlxG.flash(0xffff1111, 0.4);
										FlxG.shake(0.01, 0.2);
									}
								}
							}
						}
					}
					
					if (!player.invincible && player.state != player.S_AIR && player.overlaps(fireball)) {
						fireball.exists = false;
						player.touchDamage(1);
					}
					
				}
			}
			
			switch (atk_happy_ctr) {
				
				case -1:
					if (fire_eye.finished) {
						fire_eye.play("shoot");
						atk_happy_ctr = 1;
					}
					break;
				case 0:
					happy_thorn.play("active");
					t_atk_happy += FlxG.elapsed;
					if (t_atk_happy < 1.5) {
						break;
					}
					// Position of fire eye and dusts should vary by health
					
					fire_eye.exists = true;
					fire_eye.frame = 6;
					fire_eye.play("grow");
					
					if (blue_health == 3) {
						fire_eye.x = tl.x + 70;
						fire_eye.y = tl.y + 80;
					} else if (blue_health == 2) {
						fire_eye.x = tl.x + 50;
						fire_eye.y = tl.y + 100;
					} else {
						fire_eye.x = tl.x + 50;
						fire_eye.y = tl.y + 100;
					}
					
					var mist_ref:FlxSprite;
					if (blue_health == 3) {
						// No mists.
					} else if (blue_health == 2) { 
						mist_ref = mists.getFirstAvailable() as FlxSprite;
						mist_ref.exists = true; mist_ref.flicker(1); mist_ref.alpha = 0.7;
						mist_ref.x = tl.x + 6 * 16 - 7;
						mist_ref.y = tl.y + 5 * 16 - 12;
						mist_ref.exists = true; mist_ref.flicker(1); mist_ref.alpha = 0.7;
						mist_ref.x = tl.x + 6 * 16 - 7;
						mist_ref.y = tl.y + 7 * 16 - 12;
					} else {
						mist_ref = mists.getFirstAvailable() as FlxSprite;
						mist_ref.exists = true; mist_ref.flicker(1); mist_ref.alpha = 0.7;
						mist_ref.x = tl.x + 5 * 16 + 8;
						mist_ref.y = tl.y + 4 * 16 + 5;
						mist_ref = mists.getFirstAvailable() as FlxSprite;
						mist_ref.exists = true; mist_ref.flicker(1); mist_ref.alpha = 0.7;
						mist_ref.x = tl.x + 6 * 16;
						mist_ref.y = tl.y + 6 * 16 + 3;
					}
					
					var dust_ref:Dust;
					dust_ref = dusts.getFirstAvailable() as Dust;
					dust_ref.x =  tl.x + 16;
					dust_ref.exists = true;  dust_ref.y = tl.y + 16 * 7;
					
					dust_ref = dusts.getFirstAvailable() as Dust;
					dust_ref.x = tl.x + 8 * 16;
					dust_ref.exists = true; dust_ref.y = tl.y + 16 * 7;
					
					dust_ref = dusts.getFirstAvailable() as Dust;
					dust_ref.x = tl.x + 3 * 16;
					dust_ref.exists = true; dust_ref.y = tl.y + 16 * 5;
					
					dust_ref = dusts.getFirstAvailable() as Dust;
					dust_ref.x = tl.x + 16;
					dust_ref.exists = true; dust_ref.y = tl.y + 16 * 5;
					
					dusts.setAll("frame", Dust.EMPTY_FRAME);
					dusts.setAll("exists", true);
					
					for each (dust in dusts.members) {
						dust.play("unpoof");
					}
					t_atk_happy = 0;
					atk_happy_ctr = -1;

					break;
				case 1:
					// Shoot fireballs
					t_atk_happy += FlxG.elapsed;
					if (t_atk_happy > 0.4) {
						t_atk_happy = 0;
						Registry.sound_data.play_sound_group(Registry.sound_data.fireball_group);
						fireball = fireballs.getFirstAvailable() as FlxSprite;
						if (fireball != null) {
							fireball.x = fire_eye.x + 4;
							fireball.y = fire_eye.y + 4;
							fireball.exists = true;
							EventScripts.scale_vector(fireball, player, fireball.velocity, 45);
						}
					}
					
					for each (dust_explos in dust_explosions.members) {
						if (dust_explos.finished) {
							dust_explos.exists = false;
						}
					}
					// If all dusts gone then exit this state
					if (dusts.countExisting() == 0 && dust_explosions.countExisting() == 0) {
						atk_happy_ctr = 7;
					}
					break;
				
				case 3: // Transitioning back to big atk state
					fire_eye.exists = false;
					dust_explosions.setAll("exists", false);
					dusts.setAll("exists", false);
					fireballs.setAll("exists", false);
					mists.setAll("exists", false);
					happy_thorn.play("off");
					blue_thorn.play("off");
					atk_happy_ctr = 0;
					
					if (happy_health == 0 && blue_health == 0) {
						state = S_DYING;
					} else {
						state = S_ATK_BIG;
					}
					break;
				case 4: // Just got hit
					blue_thorn.play("hurt");
					atk_happy_ctr = 5;
					break;
				case 5:
					if (player.broom.visible && player.broom.overlaps(blue_thorn)) {
						blue_health -= 1;
						FlxG.flash(0xffff1111, 0.6);
						Registry.sound_data.wb_hit_ground.play();
						FlxG.shake(0.03, 0.4);
						blue_thorn.play("hit");
						core.play("flash");
						atk_happy_ctr = 6;
					}
					break;
				case 6:
					// wait for hurt anim to finish, if we add a new one
					if (blue_thorn.finished) {
						core.play("glow");
						blue_thorn.play("off");
						atk_happy_ctr = 7;
					}
					break;
				case 7:
					for each (dust in dusts.members) {
						if (dust.exists) dust.play("poof");
					}
					fire_eye.play("ungrow");
					for each (mist in mists.members) {
						mist.flicker(1);
					}
					atk_happy_ctr = 8;
					break;
				case 8:
					t_atk_happy += FlxG.elapsed;
					if (t_atk_happy > 1.3) {
						t_atk_happy = 0;
						atk_happy_ctr = 3;
					}
					break;
			}
		}
	
		private var dying_ctr:int = 0;
		private var explode_ctr:int = 0;
		private function state_dying():void {
			switch (dying_ctr) {
				case 0:
					DH.disable_menu();	
					Registry.sound_data.stop_current_song();
					player.be_idle();
					dying_ctr = -1;
					t_atk_blue = 0;
					break;
				case -1:
						t_atk_blue += FlxG.elapsed;
						player.be_idle();
						player.state = player.S_INTERACT;
						
						happy_thorn.play("hit");
						if (t_atk_blue > 0.2) {
							t_atk_blue = 0;
							EventScripts.make_explosion_and_sound(happy_thorn, 1);
							explode_ctr ++;
							if (explode_ctr > 10) {
								FlxG.flash(0xffff1111, 1.5);
								Registry.sound_data.sun_guy_death_s.play();
								dying_ctr = -2;
								happy_thorn.visible = false;
								explode_ctr = 0;
							}
						}
					break;
				case -2:
					t_atk_blue += FlxG.elapsed;
					if (t_atk_blue > 0.2) {
						t_atk_blue = 0;
						blue_thorn.play("hit");
						EventScripts.make_explosion_and_sound(blue_thorn, 2);
						explode_ctr ++;
						if (explode_ctr > 10) {
							dying_ctr = -30;
							blue_thorn.visible = false;
							explode_ctr = 0;
							FlxG.flash(0xff1111ff, 1.5);
							Registry.sound_data.sun_guy_death_s.play();
						}
					}
					break;
				case -30:
					t_atk_blue += FlxG.elapsed;
					if (t_atk_blue > 1.5) {
						dying_ctr = -3;
					}
					break;
				case -3:
					t_atk_blue += FlxG.elapsed;
					if (t_atk_blue > 0.15) { 
						t_atk_blue = 0;
						core.play("flash");
						EventScripts.make_explosion_and_sound(body, 3);
						explode_ctr ++;
						if (explode_ctr > 15) {
							FlxG.flash(0xffffffff, 5);
							Registry.sound_data.sun_guy_death_l.play();
							dying_ctr = -40;
							body.visible = false;
							core.visible = false;
							update_parent_map(true);
							overhang.visible = false;
							parent.map_bg_2.visible = true;
							briar.exists = true; briar.visible = true;
						}
					}
					break;
				case -40:
					t_atk_blue += FlxG.elapsed;
					if (t_atk_blue > 1.5) {
						dying_ctr = 1;
					}
					break;
				case 1:
						dying_ctr = 2;
						player.state = player.S_INTERACT;
						if (ice_crystal != null && ice_exs != null) ice_crystal.exists = ice_exs.exists = false;
						if (dusts != null && fire_eye != null && fireballs != null && dust_explosions != null) dusts.exists = fire_eye.exists = fireballs.exists = dust_explosions.exists = false;
						bullet_thorns.exists = thorns.exists = false;
						body.exists = blue_thorn.exists = happy_thorn.exists = pre_thorn.exists = core.exists = false;
						t_atk_big = 0;
						Registry.GAMESTATE.dialogue_latency = -1;
						DH.start_dialogue(DH.name_briar, DH.scene_briar_go_after_fight);
					break;
				case 2:
					
					if (player.y > tl.y + 120) {
						player.y = tl.y + 120;
					}
					if (false == DH.a_chunk_is_playing()) {
						t_atk_big += FlxG.elapsed;
						if (t_atk_big > 1.0) {
							dying_ctr = 3;
							briar.velocity.y = -20;
							Achievements.unlock(Achievements.A_DEFEAT_BRIAR);
							Achievements.is_100_percent();
							Registry.sound_data.start_song_from_title("GO");
							Registry.sound_data.current_song.volume = 1;
							briar.play("walk_u");
						}
					}
					break;
				case 3:
					if (player.y > tl.y + 120) {
						player.y = tl.y + 120;
					}
					if (briar.y < tl.y - 16) {
						briar.exists = false;
						dying_ctr = 4;
						player.state = player.S_GROUND;
					}
					break;
				case 4:
					if (player.y > tl.y + 120) {
						player.y = tl.y + 120;
					}
					xml.@alive = "false";
					Registry.GE_States[Registry.GE_BRIAR_BOSS_DEAD] = true;
					state = S_DEAD;
					break;
			}
		}
		
		private function state_dead():void {
			// Ain't no thang.
					if (player.y > tl.y + 120) {
						player.y = tl.y + 120;
					}
		}
		private function init_pre_thorn(x:int,y:int):void 
		{
			pre_thorn = new FlxSprite();
			pre_thorn.loadGraphic(embed_ground_thorn, false, false, 32, 16);
			pre_thorn.addAnimation("move", [6,7,8], 6);
			pre_thorn.play("move");
			pre_thorn.x = tl.x + x;
			pre_thorn.y = tl.y + y;
			parent.sortables.add(pre_thorn);
			pre_thorn.immovable = true;
		}
		
		
	
	}

}