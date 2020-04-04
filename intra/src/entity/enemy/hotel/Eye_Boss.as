package entity.enemy.hotel 
{
	import data.Common_Sprites;
	import entity.gadget.Dust;
	import entity.player.HealthBar;
	import entity.player.Player;
	import flash.geom.Point;
	import flash.text.engine.BreakOpportunity;
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import helper.Parabola_Thing;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	
	public class Eye_Boss extends FlxSprite 
	{
		
		public var xml:XML;
		private var parent:*;
		private var player:Player;
		private var tl:Point = new Point();
		
		private var hitbox:FlxSprite;
		
		[Embed (source = "../../../res/sprites/enemies/hotel/eye_boss_water.png")] public static var eye_boss_water_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/hotel/eye_boss_bullet.png")] public static var eye_boss_bullet_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/hotel/eye_boss_splash.png")] public static var eye_boss_splash_sprite:Class;
		
		
		private var did_init:Boolean = false;
		
		public static var global_state:int = 0;
		public static var gs_new:int = 0;
		public var gs_land:int = 1;
		public var gs_water:int = 2;
		public var gs_dead:int = 3;
		public var gs_transition_to_land:int = 4;
		
		
		public static var cur_health:int;
		private var max_health:int = 12;
		private var phase_2_health:int = 6;
		private var ctr:int = 0;
		public var state:int = 0;
		
		/* Land state var s*/
		
		private var s_land_pace:int = 0;
		private var s_land_shoot:int = 1;
		private var s_land_charge:int = 2;
		private var s_land_dying:int = 3;
		private var s_land_dead:int = 4;
		
		private var t_pace:Number = 0;
		private var tm_pace:Number = 1;
		
		private var t_shoot:Number = 0;
		private var tm_shoot:Array = new Array(1, 1, 0.9, 0.8, 0.7, 0.65);
	
		private var grp_land_splashes:FlxGroup = new FlxGroup(18);
		
		private var base_pt:Point = new Point();
		private var rel_coords:Point = new Point(1, 1);
		
		private var land_hitbox:FlxSprite = new FlxSprite;
		
		/* Water state vars */
		private var intro_ctr:int = 0;
		private var s_water_intro:int = -1;
		private var s_water_waiting:int = 0;
		private var s_water_moving:int = 3;
		private var s_water_dying:int = 1;
		private var s_water_dead:int = 2;
		private var s_water_blinded:int = 4;
		private var s_water_leaving:int = 5;
		
		
		private var grp_water_bullets:FlxGroup = new FlxGroup(8);
		private var vel_water_bullet:int = 70;
		private var t_blink:Number = 0;
		private var tm_blink:Array = new Array(1.1, 0.95, 0.9, 0.8, 0.7, 0.65);
		
		private var move_vel:Number = 100;
		private var t_move:Number = 0;
		private var tm_move:Number = 0.8;
		
		
		public function Eye_Boss(_xml:XML, _player:Player, _parent:*)
		{
			xml = _xml;
			parent = _parent;
			player = _player;
			tl.x = Registry.CURRENT_GRID_X*160  + 16;
			tl.y = Registry.CURRENT_GRID_Y * 160 + Registry.HEADER_HEIGHT + 16;
			
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			// Set hitboxes/sprites
			if (global_state == gs_water || global_state == gs_new) {
				hitbox = this;
			} else {
				land_hitbox.makeGraphic(24, 11, 0xff123123);
				hitbox = land_hitbox;
			}
			
			loadGraphic(eye_boss_water_sprite, true, false, 24, 24);
			parabola_thing = new Parabola_Thing(this, 16, 0.6, "offset", "y");
			my_shadow = new FlxSprite;
			my_shadow.loadGraphic(Common_Sprites.shadow_sprite_28_10, true, false, 28, 10);
			
			/* Water anims for Eye */
			addAnimation("blink", [0, 1, 2, 3, 2, 1, 0], 10, false);
			addAnimation("blink_fast", [0, 1, 2, 3, 2, 1], 20, true);
			addAnimation("idle", [0]);
			addAnimation("closed", [3]);
			addAnimation("open", [3, 2, 1, 0],5);
			/* Land anims for Eye (same spritesheet a water anims ) */
			addAnimation("walk", [4, 5], 6);
			addAnimation("blink_land", [5, 6, 7, 6, 5,5], 6,false);
			
			for (var i:int = 0; i < grp_water_bullets.maxSize; i++) {
				var b:FlxSprite = new FlxSprite;
				/* Bullet and bullet shadow anims */
				b.loadGraphic(eye_boss_bullet_sprite, true, false, 16, 16);
				b.addAnimation("move", [0, 1], 12);
				b.addAnimation("pop", [2, 3, 4, 5], 12, false);
				b.addAnimation("move_land", [6, 7], 12);
				b.addAnimation("pop_land", [2, 3, 4, 5], 24, false);
				
				b.play("move");
				b.width = b.height = 8;
				b.centerOffsets(true);
				
				b.my_shadow = EventScripts.make_shadow("8_small",true);
				b.my_shadow.exists = false;
				b.my_shadow.visible = true;
				b.my_shadow.play("get_big");
				
				b.parabola_thing = new Parabola_Thing(b, 45, 1.5, "offset", "y");
				b.parabola_thing.set_shadow_fall_animation("get_big");
				grp_water_bullets.add(b);
			}
			grp_water_bullets.setAll("exists", false);
			grp_water_bullets.setAll("alive", false);
			
			
			for (i = 0; i < grp_land_splashes.maxSize; i++) {
				/* Small splash and small splash shadow ANIMS */
				var splash:FlxSprite = new FlxSprite;
				splash.makeGraphic(8, 8, 0xff123412);
				splash.loadGraphic(eye_boss_splash_sprite, true, false, 8, 8);
				splash.addAnimation("move", [0, 1], 10);
				splash.addAnimation("explode", [2, 3, 3], 12, false);
				splash.play("move");
				
				splash.my_shadow = EventScripts.make_shadow("8_small",true);
				splash.my_shadow.play("get_big");
				splash.my_shadow.exists = false;
				
				splash.parabola_thing = new Parabola_Thing(splash, 36, 1 + 0.4 * Math.random(), "offset", "y");
				splash.parabola_thing.set_shadow_fall_animation("get_big");
				
				grp_land_splashes.add(splash);
				
			}
			grp_land_splashes.setAll("exists", false);
			grp_land_splashes.setAll("alive", false);
			
			

			//if land room
			/* NOTE TO MARINA: flip TEST_LAND to get straight to hte land phase for testing its anims */
			var TEST_LAND:Boolean = false;
			if (TEST_LAND) {
				global_state = gs_transition_to_land;
				cur_health = phase_2_health;
			}
			

			if (Registry.GE_States[Registry.GE_Hotel_Boss_Dead_Idx] == true) {
				exists = false;
				Registry.GRID_PUZZLES_DONE ++;
				Registry.GRID_ENEMIES_DEAD++;
			}

			if (Registry.CURRENT_GRID_X == 8 && Registry.CURRENT_GRID_Y == 10) { // If land room
				if (global_state == gs_dead) {
					exists = false;
					Registry.GRID_ENEMIES_DEAD++;
					Registry.GE_States[Registry.GE_Hotel_Boss_Dead_Idx] = true;
				} else if (global_state == gs_water) {
					
					exists = false;
					/*health = cur_health = 6;
					global_state = gs_transition_to_land;
					Registry.GRID_PUZZLES_DONE++;*/
					
				} else {
					state = s_land_pace;
					Registry.GRID_PUZZLES_DONE++; //open the door for land fight
					y = tl.y + 75;
					x = tl.x +  16;
					base_pt.x = x - 16;
					base_pt.y = y - 16;
					play("walk");
				}
			} else { //if water room
				play("closed");
				if (xml.@alive == "false" || global_state == gs_dead) { // Already killed: open north and south door
					exists = false;
					Registry.GRID_PUZZLES_DONE ++;
					Registry.GRID_ENEMIES_DEAD++;
					global_state = gs_dead;
				} else if (global_state == gs_land) { // In land state: open the door
					Registry.GRID_PUZZLES_DONE ++;
					exists = false;
				} else if (global_state == gs_transition_to_land) { // 
					Registry.GRID_PUZZLES_DONE++;
					exists = false;
				} else {
					state = s_water_intro;
					global_state = gs_new;
				}
			}
			
			// Set health
			if (global_state == gs_new) {
				health = max_health;
			} else {
				health = cur_health;
			}
			FlxG.watch(this, "health", "health");
			FlxG.watch(this, "state", "state");
			
			
			// Set position, maybe.
			if (global_state == gs_transition_to_land) {
				x = tl.x + 44;
				y = tl.y - 32;
				alpha = 0;
			}
			
			add_sfx("shoot", Registry.sound_data.gasguy_shoot);
			add_sfx("poof", Dust.dust_sound);
			add_sfx("bounce", Registry.sound_data.wb_tap_ground);
			add_sfx("hit_ground", Registry.sound_data.hitground1);
			add_sfx("pop", Registry.sound_data.four_shooter_pop_group);
			add_sfx("unpop", Registry.sound_data.four_shooter_shoot_group);
			add_sfx("land_shoot", Registry.sound_data.slasher_atk);
			
		} 
		
		
		override public function update():void 
		{
			if (parent.state == parent.S_TRANSITION) {
				return;
			}
			if (global_state == gs_land ) {
				do_land();
			} else if (global_state == gs_water) {
				do_water();
			} else if (global_state == gs_new) {
				do_new();
			} else if (global_state == gs_transition_to_land) {
				do_transition_to_land();
			}
			
			if (!did_init) {
				if (global_state == gs_water) {
					player.grid_entrance_x = tl.x + 80;
					player.grid_entrance_y = tl.y + 20;
				} else {
					player.grid_entrance_x = tl.x + 70;
					player.grid_entrance_y = tl.y + 50;
				}
				did_init  = true;
				parent.fg_sprites.add(grp_water_bullets);
				for each (var b:FlxSprite in grp_water_bullets.members) {
					parent.bg_sprites.add(b.my_shadow);
				}
				parent.fg_sprites.add(grp_land_splashes);
				for each (b in grp_land_splashes.members) {
					parent.bg_sprites.add(b.my_shadow);
				}
				parent.bg_sprites.add(my_shadow);
			}
			
			
			super.update();
		}
		
		
		private function do_transition_to_land():void {
			my_shadow.x = x;
			my_shadow.y = y + 21;
			
		
			if (offset.y <= 20) {
				my_shadow.frame = 4;
			} else if (offset.y <= 40) {
				my_shadow.frame = 3;
				
			} else {
				my_shadow.frame =  2;
			}
			
			if (ctr == 0) {
				my_shadow.visible = false;
				play("closed");
				if (framePixels_y_push < 22) {
					framePixels_y_push++;
				}
				velocity.y = 6;
				alpha += 0.03;
				if (y > tl.y && alpha == 1 && framePixels_y_push == 22) {
					velocity.y = 0;
					play("walk");
					framePixels_y_push = 0;
					my_shadow.visible = true;
					Registry.sound_data.play_sound_group(Registry.sound_data.bubble_triple_group);
					ctr++;
				}
			} else if (ctr == 1) {
				offset.y += 1.5;
				if (offset.y > 90) {
					ctr++;
					y = tl.y + 75;
					x = tl.x +  16;
					Registry.sound_data.fall1.play();
					
				}
			} else if (ctr == 2) {
				offset.y -= 3;
				if (offset.y <= 0) {
					offset.y = 0;
					FlxG.shake(0.03, 0.5);
					global_state = gs_land;
					state = s_land_pace;
					my_shadow.visible  = false;
					
					base_pt.x = x - 16;
					base_pt.y = y - 16;
				}
				
			}
			
		}
		
		private var land_ctr:int = 0;
		
		private function do_land():void {
			hitbox.x = x;
			hitbox.y = y + (height - hitbox.height);
			
			var b:FlxSprite;
			if (state == s_land_pace) {
				
				// Occasionally shoot a big bullet.
				t_shoot += FlxG.elapsed;
				if (t_shoot > tm_shoot[phase_2_health - health]) {
					t_shoot = 0;
					play("blink_land");
					play_sfx("land_shoot");
					shoot_big_bullet();
				}
				
				if (_curAnim.name == "blink_land" && _curAnim.frames.length - 1 == _curFrame) {
					play("walk");
				}
				
				// Pace about a small 3x3 grid of points
				t_pace += FlxG.elapsed;
				
				if (t_pace  > tm_pace) {
					t_pace = 0;
					var r:Number = Math.random();
					if (r <  0.7) {
						rel_coords.x = int(3 * Math.random());
						rel_coords.y = int(3 * Math.random()); 
					} else {
						
					}
				}
				EventScripts.send_property_to(this, "x", base_pt.x + rel_coords.x * 16, 1);
				EventScripts.send_property_to(this, "y", base_pt.y + rel_coords.y * 16, 1);
				
				// Get hurt by the player maybe
				if (!flickering && player.broom.visible && player.broom.overlaps(hitbox)) {
					ctr = 0;
					get_hurt();
					play_sfx(HURT_SOUND_NAME);
					if (player.x > x) {
						ctr = 1;
						velocity.x = -20;
						my_shadow.exists = true;
						my_shadow.x = x;
						my_shadow.y = y + (height - my_shadow.height);
					}
					state = s_land_charge;
				}
				
			}  else if (state == s_land_charge) {
				if (ctr == 0) { // Charge to the right side
					var sub_ctr:int = 0;
					if (EventScripts.send_property_to(this, "x", tl.x + 16 * 8 - width, 1.7)) sub_ctr++;
					if (EventScripts.send_property_to(this, "y", tl.y + 57, 1)) sub_ctr++;
					if (sub_ctr == 2) { //Shoot some bullets when hitting the wall
						FlxG.shake(0.05, 0.3);
						play_sfx("hit_ground");
						for (var j:int = 0; j < 3; j++) {
							shoot_big_bullet();
						}
						state = s_land_pace;
					}
				} else if (ctr == 1) { // If hit from the front hop back a bit
					my_shadow.visible = true;
					my_shadow.x = x;
					my_shadow.y = y + (height - my_shadow.height);
					if (offset.y >= 10) {
						my_shadow.frame = 2;
					} else if (offset.y >= 6) {
						my_shadow.frame = 3;
					} else {
						my_shadow.frame = 4;
					}
					if (parabola_thing.tick()) {
						offset.y = 0;
						ctr = 0;
						play_sfx("bounce");
						parabola_thing.reset_time();
						my_shadow.visible = false;
						
					}
				}
			} else if (state == s_land_dying) {
				player.invincible_timer = 0.3;
				if (DH.scene_is_finished(DH.name_eyeboss, DH.scene_eyeboss_after_fight)) {
					
					if (land_ctr == 0) {
						ctr = 0;
						land_ctr = 1;
						offset.x = 5;
						offset.y = 5;
					} else if (land_ctr == 1) {
						t_blink += FlxG.elapsed;
						if (t_blink > 0.3) {
							x += ( -4 + 8 * Math.random());
							y += ( -4 + 8 * Math.random());
							EventScripts.make_explosion_and_sound(this);
							t_blink = 0;
							ctr += 1;
							if (ctr >= 10) {
								land_ctr = 2;
								FlxG.flash(0xffffffff, 2);
								Registry.sound_data.sun_guy_death_l.play();
								visible = false;
							}
						}
					} else {
						my_shadow.exists = false;
						if (grp_land_splashes.countLiving() == 0) {
							if (grp_water_bullets.countLiving() == 0) {
								state = s_land_dead;
								exists = false;
								Registry.GRID_ENEMIES_DEAD++;
								Registry.GE_States[Registry.GE_Hotel_Boss_Dead_Idx] = true;
								Registry.sound_data.start_song_from_title("HOTEL");
								global_state = gs_dead;
								xml.@alive = "false";
							}
						}
					}
					
				} else {
					if (!DH.scene_is_dirty(DH.name_eyeboss, DH.scene_eyeboss_after_fight)) {
						DH.start_dialogue(DH.name_eyeboss, DH.scene_eyeboss_after_fight);
						Registry.sound_data.stop_current_song();
						FlxG.flash(0xffffffff, 1);
						velocity.x = velocity.y = 0;
						Registry.sound_data.sun_guy_death_l.play();
					}
				}
			}
			
		
			// Update "bombs"
			for each (b in grp_water_bullets.members) {
				if (b.exists) {
					b.my_shadow.x = b.x;
					b.my_shadow.y = b.y;
					
					if (b.offset.y < 7 && !player.invincible && player.overlaps(b)) {
						player.touchDamage(1);
					}
					

					if (b.parabola_thing.tick()) {
						b.play("pop_land");
						
						if (b._curAnim.frames.length - 1 == b._curFrame) {
							b.parabola_thing.reset_time();
							b.parabola_thing.set_shadow_fall_animation("get_big");
							b.exists = b.alive = b.my_shadow.exists = false;
							b.velocity.x = b.velocity.y = 0;
							play_sfx("unpop");
							// Make little splash sprites and move them sort of randomly
							for (var i:int = 0; i < 4; i ++) {
								var splash:FlxSprite = grp_land_splashes.getFirstDead() as FlxSprite;
								if (splash == null) break;
								splash.play("move");
								splash.my_shadow.play("get_small");
								splash.x = b.x;
								splash.y = b.y;
								splash.alive = splash.exists = splash.my_shadow.exists = true;
								splash.velocity.x = -20 + 40 * Math.random();
								splash.velocity.y = Math.sqrt(20 * 20 - Math.pow(splash.velocity.x, 2));
								Math.random() > 0.5 ? splash.velocity.y *= -1 : 1;
							}
						}
					}
				}
			}
			
			// Update slow-you-down-splashes - mostly boilerplate
		
			for each (b in grp_land_splashes.members) {
				if (b.exists) {
					if (b.offset.y < 9 && !player.invincible && player.overlaps(b)) {
						//player.touchDamage(1);
						Registry.sound_data.play_sound_group(Registry.sound_data.bubble_group);
						b.my_shadow.exists = false;
						player.slow_mul = 0.3;
						player.slow_ticks = 100;
					} 
 					b.my_shadow.x = b.x;
					b.my_shadow.y = b.y;
					if (b.parabola_thing.tick()) {
						b.play("explode");
						if (b._curAnim.frames.length - 1 == b._curFrame) {
							b.parabola_thing.reset_time();
							b.parabola_thing.set_shadow_fall_animation("get_big");
							b.alive = b.exists = b.my_shadow.exists = false;
							b.velocity.x = b.velocity.y = 0;
							play_sfx("pop");
						}
					}
				}
			}
			
			// Hit the player
			
			if (state != s_land_dying && !player.invincible && player.overlaps(hitbox) && state != s_land_dead) {
				player.touchDamage(1);
			}
			
			if (health <= 0) {
				
				state = s_land_dying;
			}
			
			/* Occasionally charge */
		}
		
		private function do_water():void {
			var bullet:FlxSprite;
			
			switch (state) {
				case s_water_intro:
					if (intro_ctr == 0) {
						Registry.volume_scale -= 0.007;
						if (player.y > tl.y + 24 && player.state != player.S_AIR) {
							if (!DH.scene_is_dirty(DH.name_eyeboss, DH.scene_eyeboss_before_fight)) {
								DH.start_dialogue(DH.name_eyeboss, DH.scene_eyeboss_before_fight);
								player.be_idle();
							}
							
							if (!DH.scene_is_finished(DH.name_eyeboss, DH.scene_eyeboss_before_fight)) {
								super.update();
								return;
							}
							play("open");
							Registry.volume_scale = 1;
							Registry.sound_data.start_song_from_title("BOSS");
							state = s_water_moving;
						}
					} 
					break;
				case s_water_waiting:
					if (EventScripts.bounce_in_box(hitbox, tl.x + 16 * 7 + 4, tl.x + 12, tl.y + 16 * 8, tl.y + 16) != 0) {
						play_sfx("bounce");
					}
					// Timeout for launching a bullet
					t_blink += FlxG.elapsed;
					if (t_blink > tm_blink[max_health - health]) {
						
						t_blink = 0;
						bullet = grp_water_bullets.getFirstDead() as FlxSprite;
						if (bullet == null) break;
						bullet.exists = true;
						bullet.alive = true;
						bullet.play("move");
						play("blink");
						
						play_sfx("shoot");
						bullet.velocity.x = bullet.velocity.y = 50;
						bullet.x = x; bullet.y = y;
					}
					
					// If harmed, bounce about the room, initially away from player
					// Or if at low enough health, move to land
					if (!flickering && player.broom.visible && player.broom.overlaps(hitbox)) {
						play_sfx(HURT_SOUND_NAME);
						get_hurt();
						if (health <= phase_2_health) {
							water_death_logic();
						} else { 
							state = s_water_moving;
						}
						play("closed", true);
						velocity.x = Math.min(20, move_vel * Math.random());
						velocity.y = Math.sqrt(move_vel * move_vel - velocity.x * velocity.x);
						
						player.facing == UP ? velocity.y *= -1 : 1;
						player.facing == LEFT ? velocity.x  *= -1: 1;
					}
					
					break;
				case s_water_moving:
					// Bounce in a box.
					if (EventScripts.bounce_in_box(hitbox, tl.x + 16 * 7 + 4, tl.x + 12, tl.y + 16 * 8, tl.y + 16) != 0) {
						play_sfx("bounce");
					}
					if (!player.invincible && hitbox.overlaps(player)) {
						player.touchDamage(1);
					}
					// After a timeout, return back to drifting state,
					// speed based on current health
					t_move += FlxG.elapsed;
					if (t_move > tm_move) {
						t_move = 0;
						velocity.x = velocity.y = (max_health - health) * 15;
						play("blink");
						state = s_water_waiting;
					}
					if (!flickering && player.broom.visible && player.broom.overlaps(hitbox)) {
						get_hurt();
						play_sfx(HURT_SOUND_NAME);
						if (health <= phase_2_health) {
							water_death_logic();
						} else {
							t_move = 0;
							velocity.x *= 1.5;
							velocity.y *= 1.5;
						}
					}
					
					// If hit, reset the timeout and bounce even faster.
					
					break;
				case s_water_leaving:
					velocity.x = 0;
					//play smoe harmed animation
					velocity.y = 40;
					if (y > tl.y + 16 * 6) {
						framePixels_y_push++;
						alpha -= 0.05;
						if (alpha == 0) {
							Registry.GRID_PUZZLES_DONE++;
							global_state = gs_transition_to_land;
							exists = false;
						}
					}
					break;
			}
			
			for each (bullet in grp_water_bullets.members) {
				if (bullet == null || !bullet.alive) continue;
				if (!player.invincible && bullet.overlaps(player) && player.state != player.S_AIR) {
					player.touchDamage(1);
					bullet.play("pop");
					bullet.alive = false;
					bullet.velocity.x = bullet.velocity.y = 0;
					play_sfx("poof");
				}
				
				if (player.broom.visible && player.broom.overlaps(bullet)) {
					bullet.play("pop");
					bullet.alive = false;
					bullet.velocity.x = bullet.velocity.y = 0;
					play_sfx("poof");
				}
				
				EventScripts.bounce_in_box(bullet, tl.x + 16 * 8, tl.x, tl.y + 16 * 9, tl.y);
			}
		}
		
		//intro stuff, transitions to water
		private function do_new():void {
			global_state = gs_water;
		}
		
		private function water_death_logic():void 
		{
			velocity.x = 0;
			state = s_water_leaving;
			EventScripts.drop_big_health(x, y, 1);
			cur_health = health;
			for each (var bullet:FlxSprite in grp_water_bullets.members) {
				bullet.play("pop");
				bullet.alive = false;
			}
		}
		
		private function get_hurt():void 
		{
			health--;
			if (global_state == gs_land) {
				flicker(1.0);
			} else {
				flicker(2.3);
			}
			
		}
		
		private function shoot_big_bullet():void 
		{
			var b:FlxSprite = grp_water_bullets.getFirstDead() as FlxSprite;
			if (b == null) return;
			b.play("move_land");
			b.my_shadow.play("get_small");
			b.alive = b.exists = b.my_shadow.exists = true;
			b.x = x + width;
			b.y = y + 2;
			EventScripts.scale_vector(new Point(x + width, y + 4), new Point(player.x, player.y), b.velocity, (EventScripts.distance(player, this) - width) / b.parabola_thing.period);
			b.velocity.y += 5 * Math.random();
			b.velocity.x += 5 * Math.random();
			
		}
		
		override public function destroy():void 
		{
			cur_health = health;
			super.destroy();
		}
		
	}

}