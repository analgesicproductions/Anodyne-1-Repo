	package entity.enemy.redcave 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.Cutscene;
	import helper.DH;
	import helper.EventScripts;
	import helper.Parabola_Thing;
	import mx.core.FlexSprite;
	import org.flixel.FlxBasic;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import states.PlayState;
	
	/**
	 * Red cave boss
	 */
	public class Red_Boss extends FlxSprite 
	{
		private var player:Player;
		private var parent:PlayState;
		private var xml:XML;
		private var timer:Number = 0;
		
		private var ripple:FlxSprite;
		
		private var added_to_parent:Boolean = false;
		public var cid:int = CLASS_ID.RED_BOSS;
		private var hit_timer_max:Number = 1.3;
		
		private var pushdown_angle:Number = 0;
		private var amp:int = 5;
		
		public var state:int = 0;
		private var s_intro:int = 0;
		private var intro_push_px:int = 32;
		private var boss_fight_started:Boolean = false;
		
		private var s_dead:int = 6;
		private var s_dying:int = 5;
		private var played_death_anim:Boolean = false;
		private var t_death_to_cutscene:Number = 0;
		private var t_death_push_tick:Number = 0;
		private var tm_death_to_cutscene:Number = 2;
		private var tm_death_push_tick:Number = 0.15;
		private var death_push_pixels:int = 0;
		private var final_alpha:Number = 1;
		
		private var ctr:int = 0;
		/* stun wave entitites */
		private var s_stun_wave:int = 2;
		private var small_wave:FlxSprite = new FlxSprite();
		private var big_wave:FlxSprite = new FlxSprite();
		private var player_hit_big_wave:Boolean = false;
		private var small_wave_risen:Boolean = false;
		private var small_wave_fallen:Boolean = false;
		private var big_wave_risen:Boolean = false;
		private var big_wave_fallen:Boolean = false;
		
		/* Dash entities */
		private var s_dash:int = 3;
		private var dash_timer:Number = 0;
		private var dash_timer_max:Number = 5.0;
		
		
		/* L-splash entities */
		private var s_l_splash:int = 1;
		public var too_close_count:int = 0;
		
		private var timer_l_splash_max:Number = 3.0;
		private var timer_l_splash:Number = 0;
		private var sig_l_splash:Boolean = false;
		private var on_l_splash:Boolean = false;
		private var group_l_splash:FlxGroup = new FlxGroup(8);
		private var group_l_splash_shadows:FlxGroup = new FlxGroup(8);
		private var l_splash_start_tile_coords:Array = new Array(new Point(1, 2), new Point(1, 3), new Point(1, 4), new Point(1, 5));
		private var l_splash_coeffs:Array = new Array(0,0,0,0,0,0,0,0);
		private var l_splash_periods:Array = new Array(0, 0, 0, 0, 0, 0, 0, 0);
		private var l_splash_timers:Array = new Array(0, 0, 0, 0, 0, 0, 0, 0);
		
		/* Tentacles */
		private var tentacles:FlxGroup = new FlxGroup(4);
		private var tentacle_warnings:FlxGroup = new FlxGroup(4);
		private var sig_tentacle_thrust:Boolean = false;
		private var on_tentacle_thrust:Boolean = false;
		private var timer_tentacle_thrust_max:Number = 3.0;
		private var timer_tentacle_thrust:Number = 3.0;
		private var tentacle_thrust_timers:Array = new Array(0, 0, 0, 0);
		private var tt_type:int = NONE;
		
		
		
		/**
		 * Top left walkable tile's world coordinates.
		 */
		private var pt_rm_tl:Point = new Point();
		
		private var bullet_pool:FlxGroup = new FlxGroup(10);
		private var bullet_shadows:FlxGroup = new FlxGroup(10);
		private var tl:FlxPoint;
		[Embed (source = "../../../res/sprites/enemies/red_boss.png")] public static var red_boss_sprite:Class;
		[Embed(source = "../../../res/sprites/redboss_alternate.png")] public var red_boss_alternate_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/redcave/red_boss_big_wave.png")] public var big_wave_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/redcave/red_boss_small_wave.png")] public var small_wave_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/redcave/red_boss_tentacle.png")] public var tentacle_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/redcave/red_boss_warning.png")] public var warning_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/redcave/red_boss_bullet.png")] public var bullet_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/redcave/red_boss_ripple.png")] public static var ripple_sprite:Class;
		
		public function Red_Boss(_xml:XML,_parent:PlayState,_player:Player ) 
		{
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			player = _player;
			parent = _parent;
			xml = _xml;
			
			if (Registry.FUCK_IT_MODE_ON) {
				state = s_dying;
				//state = s_stun_wave;
			}
			if (xml.@alive == "false") {
				Registry.GRID_ENEMIES_DEAD++;
				exists = false;
			}
			
			tl = new FlxPoint(Registry.CURRENT_GRID_X * 160, Registry.CURRENT_GRID_Y * 160 + 20);
			player.grid_entrance_x = tl.x + 23;
			player.grid_entrance_y = tl.y + 40;
			
			immovable = true;
			
			/* HEAD SPRITES */
			var stupid:Boolean = false;
			if (stupid) {
				loadGraphic(red_boss_alternate_sprite, true, false, 32, 32);
			} else {
				loadGraphic(red_boss_sprite, true, false, 32, 32);
			}
			addAnimation("bob", [0], 20, true);
			addAnimation("close_eyes", [1],10,false);
			addAnimation("warn", [2,2],24);
			addAnimation("die", [0, 1, 2], 3, false);
			addAnimation("last_death_frame", [1], 2);
			play("bob");
			height = 19;
			offset.y = 13;
			width = 26;
			offset.x = 3;
			framePixels_y_push = 32;
			
			ripple = new FlxSprite;
			ripple.loadGraphic(ripple_sprite, true, false, 48, 8);
			ripple.addAnimation("move", [0, 1], 12);
			ripple.play("move");
			
			pt_rm_tl.x = Registry.CURRENT_GRID_X * Registry.SCREEN_WIDTH_IN_PIXELS + Registry.TILE_WIDTH;
			pt_rm_tl.y = Registry.CURRENT_GRID_Y * Registry.SCREEN_HEIGHT_IN_PIXELS + Registry.HEADER_HEIGHT + Registry.TILE_WIDTH;
			
			/* BULLET + BULLET SHADOW SPRITES */
			for (var i:int = 0; i < bullet_pool.maxSize; i++) {
				
				var b:FlxSprite = new FlxSprite();
				b.loadGraphic(bullet_sprite, true, false, 8, 8);
				b.addAnimation("move", [0, 1], 12);
				b.addAnimation("explode", [2, 3, 4, 4], 14, false);
				/* load bulet shadow gfx */
				b.my_shadow =  EventScripts.make_shadow("8_small");
				b.parabola_thing = new Parabola_Thing(b, 48, 1.2 + Math.random(), "offset", "y");
				b.parabola_thing.set_shadow_fall_animation("get_big");
				b.visible = true;
				
				b.play("move");
				b.my_shadow.play("get_big");
				
				bullet_pool.add(b);
				bullet_shadows.add(b.my_shadow);
				
			}
			bullet_pool.setAll("exists", false);
			
			bullet_shadows.setAll("exists", false);
			
			var j:int;
			
			/* TENTACLE + WARNING SPRITES */
			for (j = 0; j < tentacles.maxSize; j++) {
				var tentacle:FlxSprite = new FlxSprite();
				tentacle.loadGraphic(tentacle_sprite, true, false, 10, 64);
				tentacle.addAnimation("move", [0, 1], 8);
				tentacle.play("move");
				tentacles.add(tentacle);
				
				var tentacle_warning:FlxSprite = new FlxSprite();
				tentacle_warning.loadGraphic(warning_sprite, true, false, 10, 10);
				tentacle_warning.addAnimation("move", [0, 1], 8);
				tentacle_warning.play("move");
				tentacle_warnings.add(tentacle_warning);
			}
			tentacles.setAll("exists", false);
			tentacle_warnings.setAll("exists", false);
			tentacles.setAll("immovable", true);
			tentacle_warnings.setAll("immovable", true);
			
			
			/* SMALL AND BIG WAVE SPRITES */
			small_wave = new FlxSprite(0, 0);
			small_wave.loadGraphic(small_wave_sprite, true, false, 16, 64);
			small_wave.addAnimation("move", [0, 1], 8);
			small_wave.addAnimation("rise", [2, 3], 8, true);
			small_wave.addAnimation("fall", [1, 2, 3, 4], 8, false);
			small_wave.play("move");
			
			big_wave = new FlxSprite(0, 0);
			big_wave.loadGraphic(big_wave_sprite, true, false, 32, 80);
			big_wave.addAnimation("move", [0, 1], 8);
			big_wave.addAnimation("rise", [2, 1, 0], 8, false);
			big_wave.addAnimation("fall", [1, 2, 3], 8, false);
			big_wave.play("move");
			
			big_wave.exists = small_wave.exists = false;
			
			
			/* SFX* */
			add_sfx("rise_from_water", Registry.sound_data.bubble_loop);
			add_sfx("bubble", Registry.sound_data.bubble_group);
			add_sfx("bubble_triple", Registry.sound_data.bubble_triple_group);
			add_sfx("moan", Registry.sound_data.redboss_moan);
			add_sfx("small_wave", Registry.sound_data.small_wave);
			add_sfx("big_wave", Registry.sound_data.big_wave);
			add_sfx("death", Registry.sound_data.redboss_death);
			
			health = 12;
		}
		
		override public function destroy():void 
		{
			player.AUTO_JUMP_HEIGHT = 22;
			parent.bg_sprites.remove(bullet_shadows,true);
			parent.fg_sprites.remove(bullet_pool,true);
			for each (var t:FlxSprite in tentacles.members) {
				if (t != null) parent.sortables.remove(t, true);
				t.destroy(); t = null;
			}
		
			for each (t in tentacle_warnings.members) {
				if (t != null) parent.sortables.remove(t,true);
				t.destroy(); t = null;
			}
			group_l_splash = null;
			group_l_splash_shadows = null;
			tentacles = null;
			parent.bg_sprites.remove(small_wave,true);
			parent.fg_sprites.remove(big_wave,true);
			ripple = null;
			tentacle_warnings = null; bullet_pool = null; bullet_shadows = null;
			
			super.destroy();
		}
		
		override public function update():void 
		{
			timer += FlxG.elapsed;
			
			ripple.x = x - 11;
			ripple.y = y + 17;
			
			/* Add children to parent draw group */
			if (!added_to_parent) {
				parent.bg_sprites.add(bullet_shadows);
				parent.fg_sprites.add(bullet_pool);
				for each (var t:FlxSprite in tentacles.members) {
					if (t != null) parent.sortables.add(t);
				}
				
				for each (t in tentacle_warnings.members) {
					if (t != null) parent.sortables.add(t);
				}
				added_to_parent = true;
				
				parent.bg_sprites.add(ripple);
				parent.bg_sprites.add(small_wave);
				parent.bg_sprites.add(big_wave);
			}
			
			/* Intro */
			if (state == s_intro) {
				play("close_eyes");
				if (!boss_fight_started) {
					Registry.sound_data.current_song.volume -= 0.05;
					if (Registry.sound_data.current_song.volume == 0) {
						Registry.sound_data.current_song.stop();
					}
					if (player.x >= pt_rm_tl.x + 32) {
						
						if (!DH.scene_is_dirty(DH.name_redboss, DH.scene_redboss_before_fight)) {
							DH.start_dialogue(DH.name_redboss, DH.scene_redboss_before_fight);
							play_sfx("rise_from_water");
							player.be_idle();
						}
						
						if (DH.scene_is_finished(DH.name_redboss, DH.scene_redboss_before_fight)) {
							boss_fight_started = true;
							state = s_l_splash;
							Registry.sound_data.start_song_from_title("BOSS");
							stop_sfx("rise_from_water");
							play("bob");
						}
					} else {
						return;
					}
				}
				framePixels_y_push = intro_push_px;
				t_death_push_tick += FlxG.elapsed;
				if (t_death_push_tick > tm_death_push_tick) {
					t_death_push_tick = 0;
					if (intro_push_px > 0) {
						FlxG.shake(0.021, 0.1);
						intro_push_px--;
					}
				}
				
				return;
			}
			
			// collisions for damage etc
			if (player.broom.overlaps(this) && player.broom.visible) {
				if (timer > hit_timer_max && health >= 0) {
					timer = 0;
					health--;	
					play_sfx("moan");
					flicker(0.5);
					if (health <= 0) {
						state = s_dying;
						stop_sfx("rise_from_water");
						velocity.x = velocity.y = 0;
						tentacles.exists = false;
						bullet_pool.exists = false;
						bullet_shadows.exists = false;
						tentacle_warnings.exists = false;
						tentacles.exists = false;
						big_wave.exists = small_wave.exists = false;
						player.angle = 0;
						player.angularVelocity = 0;
					}
				}
				
			}
			
			if (state == s_dying) {
				//die etc
				
				if (!DH.scene_is_dirty(DH.name_redboss, DH.scene_redboss_after_fight)) {
					Registry.sound_data.stop_current_song();
					DH.start_dialogue(DH.name_redboss, DH.scene_redboss_after_fight);
					player.be_idle();
					FlxG.shake(0.05, 0.1);
					FlxG.flash(0xffff0000, 1);
					super.update();
					return;
				}
				
				if (!DH.scene_is_finished(DH.name_redboss, DH.scene_redboss_after_fight)) {
					super.update();
					return;
				}
				
				tentacles.setAll("alpha", final_alpha);
				tentacle_warnings.setAll("alpha", final_alpha);
				bullet_shadows.setAll("alpha", final_alpha);
				bullet_pool.setAll("alpha", final_alpha);
				small_wave.alpha = final_alpha;
				big_wave.alpha = final_alpha;
				ripple.alpha -= 0.005;
				
				final_alpha -= 0.005;
				
				if (!played_death_anim) {
					Registry.GFX_WAVE_EFFECT_ON = true;
					played_death_anim = true;
					play_sfx("death");
					play("die");
				} else {
					if (_curAnim.name == "die" && _curAnim.frames.length - 1 == _curFrame) {
						play("last_death_frame");
					}
				}
				
				framePixels_y_push = death_push_pixels;
				if (framePixels_y_push >= 32) {
					framePixels_y_push = 32;
					if (t_death_to_cutscene  < tm_death_to_cutscene) {
						t_death_to_cutscene += FlxG.elapsed;
					} else {
						state = s_dead;
						Registry.GRID_ENEMIES_DEAD++;
						Registry.sound_data.start_song_from_title("REDCAVE");
						//if (!Registry.CUTSCENES_PLAYED[Cutscene.Terminal_Gate_Redcave]) {
							//Registry.E_Load_Cutscene = true;
							//Registry.CURRENT_CUTSCENE = Cutscene.Terminal_Gate_Redcave;
					//	}
						Registry.GE_States[Registry.GE_Redcave_Boss_Dead_Idx] = true;
						xml.@alive = "false";
					}
				}
				
				if (t_death_push_tick <= tm_death_push_tick) {
					t_death_push_tick += FlxG.elapsed;
					return;
				}
				t_death_push_tick = 0;
				death_push_pixels++;
				return;
			} else if (state == s_dead) {
				Registry.GFX_WAVE_EFFECT_ON = false;
				return;
			}
			
			if (FlxG.collide(this, player)) {
				player.touchDamage(1);
			}
			
			
			/* Check to send signals to attack patterns */
			if (state == s_l_splash) {
				
				pushdown_angle += 0.05;
				framePixels_y_push = 5 + Math.sin(pushdown_angle % 6.28) * 5;
				timer_l_splash -= FlxG.elapsed;
				if (timer_l_splash <= 0) {
					timer_l_splash = timer_l_splash_max;
					sig_l_splash = true;
				}
				
				timer_tentacle_thrust -= FlxG.elapsed;
				if (timer_tentacle_thrust <= 0) {
					timer_tentacle_thrust = timer_tentacle_thrust_max;
					sig_tentacle_thrust = true;
					tt_type = get_player_proximity_type();
					/* If player approaches too many times, then dive under */
					if (tt_type != NONE) too_close_count++;  
				}
				
				if (too_close_count == 2) {
					too_close_count = 0;
					state = s_stun_wave;
				}
			} else if (state == s_stun_wave) {
				do_stun_wave();
			} else if (state == s_dash) {
				
				
				dash_timer += FlxG.elapsed;
				if (dash_timer > dash_timer_max) {
					dash_timer = 0;
					state = s_stun_wave;
					velocity.x = velocity.y = 0;
					return;
				}
				timer_tentacle_thrust -= FlxG.elapsed;
				if (timer_tentacle_thrust <= 0) {
					timer_tentacle_thrust = timer_tentacle_thrust_max/2;
					sig_tentacle_thrust = true;
					tt_type = get_player_proximity_type();
					/* If player approaches too many times, then dive under */
					if (tt_type != NONE) too_close_count++;  
				}
				
				if (too_close_count == 2) {
					too_close_count = 0;
					state = s_l_splash;
					velocity.x = velocity.y = 0;
					return;
				}
				//Set xvel
				var vel:int = 60;
				if (velocity.x > 0) {
					if (x + width > pt_rm_tl.x + 7 * 16) {
						velocity.x = -vel;
						FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_HORIZONTAL_ONLY);
					}
				} else {
					if (x < pt_rm_tl.x + 16) {
						FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_HORIZONTAL_ONLY);
						velocity.x = vel;
					}
				}
				
				if (velocity.y > 0) {
					if (y + height > pt_rm_tl.y + 7 * 16) {
						FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_VERTICAL_ONLY);
						velocity.y = -vel;
					} 
				} else {
					if (y < pt_rm_tl.y + 16) {
						FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_VERTICAL_ONLY);
						velocity.y = vel;
					}
				}
			}
			
		
			
			/* Animation logic */
			
			
			sub_l_splash();
			sub_tentacle_thrust(tt_type);
			
			super.update();
		}
		
		private function get_player_proximity_type():uint {
			var close_u:FlxSprite = new FlxSprite(x , y - 21);
			close_u.makeGraphic(width, 8, 0xff000000);
			var close_l:FlxSprite = new FlxSprite(x - 18, y - 10);
			close_l.makeGraphic(12, height + 20, 0xf000000);
			
			var close_d:FlxSprite = new FlxSprite(x, y + height + 8);
			close_d.makeGraphic(width + 4, 12, 0xff000000);
			var close_r:FlxSprite = new FlxSprite(x + width  + 7, y - 8);
			close_r.makeGraphic(8, height + 16, 0xff000000);
			
			if (player.overlaps(close_u)) {
				return UP;
			} else if (player.overlaps(close_l)) {
				return LEFT;
			} else if (player.overlaps(close_r)) {
				return RIGHT;
			} else if (player.overlaps(close_d)) {
				return DOWN;
			}
			
			close_u.destroy();
			close_l.destroy();
			close_d.destroy();
			close_r.destroy();
			return NONE;
		}
		
		/*
		 * document...this isn't totally straightforward to re-read
		 * */
		private function sub_tentacle_thrust(tt_type:int):void {
			var t:FlxSprite;
			if (sig_tentacle_thrust && !on_tentacle_thrust) {
				sig_tentacle_thrust = false;
				on_tentacle_thrust = true;
				
				var t_ct:int = 0;
				for each (t in tentacles.members) {
					if (t != null) {
						t.exists = true;
						t.visible = false;
						t.framePixels_y_push = t.height;
						
						switch (tt_type) {
						case NONE:
							t.x = pt_rm_tl.x + 12 * (1 + t_ct) - 5 + int(10 * Math.random());
							t.y = pt_rm_tl.y + 16 * int(Math.random() * 3) - 5 + int(10 * Math.random());
							break;
						case LEFT:
							t.x = x - 14;
							t.y = y - 16 + t_ct * 16; break;
						case RIGHT:
							t.x = x + width + 2;
							t.y = y - 16 + t_ct * 16; break;
						case UP:
							t.x = x - 14 + 16 * t_ct;
							t.y = y - 13; break;
						case DOWN:
							t.x = x - 14 + 16 * t_ct;
							t.y = y + height + 2; break;
						}
						
						tentacle_thrust_timers[t_ct] = 2.0 + Math.random();
						if (tt_type != NONE) {
							t.y -= (t.height - 10);
						}
					}
					t_ct++;
				}
				
				var tw_ct:int = 0;
				for each (var tw:FlxSprite in tentacle_warnings.members) {
					if (tw != null) {
						
						tw.exists = true;
						tw.visible = true;
						tw.x = tentacles.members[tw_ct].x;
						tw.y = tentacles.members[tw_ct].y + tentacles.members[tw_ct].height - tw.height + 3;
						tw.flicker(1);
					}
					tw_ct++;
				}
			}
			
			if (on_tentacle_thrust) {
				var idx:int = 0;
				for each (t in tentacles.members) {
					
					if (t != null && t.visible) {
						if (!player.invincible && player.overlaps(tentacle_warnings.members[idx])) {
							player.touchDamage(1);
						}
						if (tentacle_thrust_timers[idx] < 0 && t.framePixels_y_push == t.height && !t.alive) {
							t.exists = false;
							t.alive = true;
							tentacle_warnings.members[idx].visible = false;
						}
					}
					tentacle_thrust_timers[idx] -= FlxG.elapsed;
					if (tentacle_thrust_timers[idx] < 1.3) {
						
						if (t.alive && t.framePixels_y_push > 0) {
							t.framePixels_y_push -= 2;
							if (t.framePixels_y_push <= 0) {
								t.alive = false;
							} 
						} else if (tentacle_thrust_timers[idx] < 0.3) {
							if (t.framePixels_y_push < t.height) {
								t.framePixels_y_push = Math.min(t.height, t.framePixels_y_push + 3);
							}
						}
						if (!t.visible) {
							play_sfx("bubble_triple");
						}
						t.visible = true;
					} 
					
					idx++;
				}
				if (tentacles.countExisting() == 0) {
					on_tentacle_thrust = false;
				}
			}
			return;
		}
		
		private function sub_l_splash():void {
			var b:FlxSprite;
			var shadow:FlxSprite;
			/* Do initialization. A signal to do the left splash
			 * attack will generate four bullet thingies */
			if (sig_l_splash) {
				sig_l_splash = false;
				on_l_splash = true;
				for (var i:int = 0; i < 4; i++) {
					b = bullet_pool.getFirstAvailable() as FlxSprite;
					if (b == null) continue;
					b.exists = b.my_shadow.exists = true;
					shadow = b.my_shadow;
					shadow.visible = true;
					b.visible = false;
					
					shadow.x = b.x = l_splash_start_tile_coords[i].x * 16 + pt_rm_tl.x + 3;
					shadow.y = b.y = l_splash_start_tile_coords[i].y * 16 + pt_rm_tl.y + 4;
					b.velocity.x = 0;
					l_splash_timers[bullet_pool.members.indexOf(b)] = 0;
				}
				
				return;
			}
			
			/* do something with "to be removed" so that removing is in sync */
			if (on_l_splash) {
				for each (b in bullet_pool.members) {
					
					if (b == null || !b.exists) continue;
					
					b.my_shadow.x = b.x;
					b.my_shadow.y = b.y;
					
					l_splash_timers[bullet_pool.members.indexOf(b)] += FlxG.elapsed;
					if (l_splash_timers[bullet_pool.members.indexOf(b)] > 0.5) {
						if (b.velocity.x == 0) { 
							b.visible = true;
							play_sfx("bubble", true);
							b.velocity.x = int(10 + 7 * Math.random());
							b.my_shadow.play("get_small");
						}
						
						if (b.offset.y < 10) {
							if (b.overlaps(player)) {
								player.touchDamage(1);
							}
						}
						
						if (b.parabola_thing.tick() && b.offset.y <= 4) {
							b.play("explode");
							if (b._curAnim.frames.length - 1 == b._curFrame) {
								b.my_shadow.exists = b.exists = false;
								b.parabola_thing.reset_time();
								b.play("move");
								play_sfx("bubble", true);
								b.parabola_thing.set_shadow_fall_animation("get_big");
							}
						}
					} else {
						b.my_shadow.flicker(0.05);
					}
				}
			}
		}
		
		private function do_stun_wave():void 
		{
			var sub_ctr:int = 0;
			
			/* Oscillation incrments */
			pushdown_angle += 0.05;
			framePixels_y_push = amp + Math.sin(pushdown_angle % 6.28) * amp;
			
			/* big 'n' small wave logic. */
			if (small_wave.exists) {
				if (small_wave.overlaps(player)) {
					EventScripts.send_property_to(player, "x", 0, -0.5);
				}
				if (small_wave.x < pt_rm_tl.x + 16) {
					if (!small_wave_fallen && small_wave.exists) {
						small_wave_fallen = true;
						small_wave.play("fall");
					}
					
					if (small_wave._curAnim.name == "fall" && (small_wave._curAnim.frames.length - 1 == small_wave._curFrame)) {
						small_wave.exists = false;
						small_wave_fallen = false;
					}
				}
			}
			
			if (player_hit_big_wave && player.state == player.S_AUTO_JUMP) {
				player.framePixels_y_push = 0;
				 
				EventScripts.send_property_to(player, "x", pt_rm_tl.x, -1.5);
				
				EventScripts.send_property_to(player, "y", pt_rm_tl.y + 60, -1.5);
			} else {
				player.angularVelocity = player.angle = 0;
			}
			
			if (big_wave.exists) {
				if (big_wave.overlaps(player) && (big_wave._curAnim.name == "move")) {
					if (!player_hit_big_wave) {
						Registry.sound_data.player_hit_1.play();
						player_hit_big_wave = true;
						player.angularVelocity = -500;
						player.framePixels_y_push = 0;
						player.auto_jump_base_y = y;
						player.AUTO_JUMP_HEIGHT = 50;
						player.auto_jump_distance = 50;
						player.auto_jump_period = 1;
						player.my_shadow.visible = true;
						player.state = player.S_AUTO_JUMP;
					}
				}
				if (big_wave.x < pt_rm_tl.x + 16) {
					
					big_wave.play("fall");
					if (big_wave._curAnim.frames.length - 1 == big_wave._curFrame) {
						big_wave.exists = false;
						player.angularVelocity = 0;
						player.angle = 0;
					}
				}
			}
			
			
			if (ctr == 0) { //move to the left.
				play("warn");
				if (EventScripts.send_property_to(this, "y", pt_rm_tl.y + 48, 0.5)) sub_ctr++;
				if (EventScripts.send_property_to(this, "x", pt_rm_tl.x + 16 * 5, 0.5)) sub_ctr++;
				if (framePixels_y_push == 0) sub_ctr++;
				
					if (!small_wave_risen) {
						small_wave_risen = true;
						small_wave.exists = true;
						small_wave.x = pt_rm_tl.x + 80;
						small_wave.y = pt_rm_tl.y + 32;
						small_wave.play("rise");
					}
				 
				if (sub_ctr == 3) {
					play_sfx("rise_from_water");
					small_wave_risen = false;
					ctr++;
					amp = 13;
				}
			} else if (ctr == 1) { //generate small wave when down
				if (framePixels_y_push > amp - 1) {
					FlxG.camera.shake(0.03, 1.0);
					ctr++;
					play_sfx("small_wave");
					small_wave.play("move");
					small_wave.velocity.x = -20;
				}
			} else if (ctr == 2) { //wait to be up to continue
				if (framePixels_y_push == 0) { 
					ctr++;
					amp = 20;
				}
			} else if (ctr == 3) { //when down generate big wave
				if (framePixels_y_push > 18) {
					if (!big_wave_risen) {
						big_wave.x = pt_rm_tl.x + 64;
						big_wave.y = pt_rm_tl.y + 32;
						big_wave.exists = true;
						big_wave_risen = true;
						big_wave.play("rise");
					} 
				}
				if (big_wave._curAnim.name == "rise" && (big_wave._curFrame == big_wave._curAnim.frames.length - 1)) {
					ctr++;
					big_wave_risen = false;
					big_wave.play("move");
					FlxG.camera.shake(0.05, 1.0);
					play_sfx("big_wave");
					big_wave.velocity.x = -40;
				}
				
			} else if (ctr == 4) { //wait to be up
				play("close_eyes");
				if (framePixels_y_push < 2) {
					ctr++;
					amp = 5;
				}
			} else if (ctr == 5) { //when waves gone, go back to dash satate
				if (!small_wave.exists && !big_wave.exists) {
					if (EventScripts.send_property_to(this, "y", pt_rm_tl.y + 48, 0.5)) sub_ctr++;
					if (EventScripts.send_property_to(this, "x", pt_rm_tl.x + 16 * 4, 0.5)) sub_ctr++;
					if (sub_ctr == 2) {
						small_wave.velocity.x = big_wave.velocity.x = 0;
						player_hit_big_wave = false;
						state = s_dash;
						play("bob");
						stop_sfx("rise_from_water");
						velocity.x = 30;
						velocity.y = 20;
						ctr = 0;
					}
				}
			}
		}
	}

}