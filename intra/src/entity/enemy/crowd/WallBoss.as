package entity.enemy.crowd 
{
	import data.CLASS_ID;
	import data.Common_Sprites;
	import data.TileData;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.Cutscene;
	import helper.DH;
	import helper.EventScripts;
	import helper.Parabola_Thing;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	
	/**
	 * The 3rd boss. Face on a wall, and two fists.
	 * Basically.
	 * @author Seagaia
	 */
	public class WallBoss extends FlxSprite 
	{
		
		/* Generic properties */
		public var tl:Point = new Point();
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		public var cid:int = CLASS_ID.WALLBOSS;
		private var max_health:int = 12;
		public var cur_phase:int = 0;
		private var phase_2_health:int = 10;
		private var phase_3_health:int = 5;
		private var fade_in_alpha_rate:Number = 0.04;
		private var fade_out_alpha_rate:Number = 0.003;
		private var broke_ground:Boolean = false;
		
		private var talk_timer:Number = 0;
		
		
		
		
		/* wall properties */
		public var wall:FlxSprite;
		private var death_explosions:FlxGroup = new FlxGroup(4);
		private var death_explosion_timer:Number = 0.25;
		private var tm_de:Number = 0.20;
		
		/* Face properties */
		public var face:FlxSprite;
		private var s_face:int = -1;
		private var s_face_intro:int = -1;
		private var s_face_normal:int = 0;
		private var s_face_charge:int = 1;
		private var s_face_hit:int = 2;
		private var s_face_dying:int = 3;
		private var s_face_dead:int = 4;
		private var s_face_shoot:int = 5;
		public var hurt_t:Number = 0;
		public var hurt_tm:Number = 1.0;
		public var charge_t:Number = 0;
		public var charge_tm:Number = 3.0;
		public var finish_charge_tm:Number = 1.0;
		public var face_bullets:FlxGroup = new FlxGroup(8);
		public var nr_bullets:Array = new Array(5, 6, 8);
		
		/* Hand properties */
		public var lhand:FlxSprite;
		public var rhand:FlxSprite;
		private var lhand_init_pt:Point = new Point();
		private var rhand_init_pt:Point = new Point();
		
		private var lhand_poof:FlxSprite = new FlxSprite;
		private var rhand_poof:FlxSprite = new FlxSprite;
		
		
		private var s_hand:int = 0;
		private var s_hand_intro:int = 0;
		
		private var s_hand_float:int = 1;
		private var t_float:Number = 0;
		private var tm_float:Number = 2.0;
		 
		private var s_hand_push:int = 2;
		private var max_nr_pushes:Array = new Array(2,3, 3);
		private var nr_pushes:int = 0;
		private var push_y_vel:Array = new Array(60, 90, 120);
		private var p_double_push:Array = new Array(0.5, 0.7, 0.8);
		
		
		/**
		 * Lhand only = 0, rhand = 1, both = 2
		 */
		private var push_type:int = 0; 
		private var ctr_hand_push:int = 0;
		
		
		private var s_hand_stomp:int = 3;
		private var s_hand_stomp_rhand:int = LEFT;
		private var max_nr_falls:Array = new Array(2, 3, 4);
		private var nr_falls:int = 0; //counter
		private var period_lhand_stomp:Number = 2.0; 
		private var ctr_hand_stomp:int = 0; //sub-state ctr
		private var rhand_stomp_vel:Number = 30; 
		private var t_lhand_stomp:Number = 0; 
		private var tm_lhand_stomp:Number = 0.7
		private var played_sound:Boolean = false;
		
		/* laser states*/
		
		private var s_hand_h_laser:int = 4;
		private var s_hand_h_laser_ctr:int = 0;
		public var h_laser:FlxSprite = new FlxSprite();
		
		private var s_hand_dying:int = 5;
		private var t_dying:Number = 0;
		private var tm_dying:Number = 3;
		
		private var s_hand_dead:int = 6;
		
		private var do_intro:Boolean = true;
		private var intro_ctr:int = 0;
		
		
		/* Assets */
		[Embed (source = "../../../res/sprites/enemies/crowd/wallboss_wall.png")] public static var wall_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/crowd/wallboss_laser.png")] public var laser_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/crowd/wallboss_bullet.png")] public var bullet_sprite:Class;
		[Embed(source = "../../../res/sprites/enemies/crowd/f_wallboss_face.png")] public static var face_sprite:Class;
		[Embed(source = "../../../res/sprites/enemies/crowd/f_wallboss_l_hand.png")] public static var l_hand_sprite:Class;
		[Embed(source = "../../../res/sprites/enemies/crowd/f_wallboss_l_hand.png")] public static var r_hand_sprite:Class;
		
		/* N.B. all interactive entities added and removed directly in this code */
		public function WallBoss(_x:XML,_p:Player,_s:*) 
		{
			/* boilerplate */
			xml = _x;
			player = _p;
			parent = _s;
			
			super(parseInt(_x.@x), parseInt(_x.@y));
			tl.x  = Registry.CURRENT_GRID_X * 160 + 16;
			tl.y = Registry.CURRENT_GRID_Y * 160 + Registry.HEADER_HEIGHT + 16;
			var ctr:int;
			
			health = max_health;
			visible = false;
			
			
			wall = new FlxSprite(tl.x - 16, tl.y - 16);
			face = new FlxSprite(tl.x + (128 - 64) / 2, tl.y - 16);
			lhand = new FlxSprite(tl.x, tl.y + 16);
			rhand = new FlxSprite(tl.x + 16 * 6, tl.y + 16);
			
			/* init wall entities */
			wall.loadGraphic(wall_sprite, true, false, 160, 32);
			wall.addAnimation("move", [0, 1], 4);
			wall.play("move");
			wall.immovable = true;
			
			// Death explosions
			for (ctr = 0; ctr < death_explosions.maxSize; ctr++) {
				var de:FlxSprite = new FlxSprite;
				de.loadGraphic(EventScripts.small_explosion_sprite, true, false, 24,24);
				de.addAnimation("explode", [0, 1, 2, 3, 4,4], 14, false); 
				de.visible = false;
				death_explosions.add(de);
			}
			death_explosions.exists = false;
			tm_de = 0.15;
			
			
			/* init face entities */
			face.loadGraphic(face_sprite, true, false, 64, 32);
			face.immovable = true;
			face.addAnimation("normal", [0,2],5);
			face.addAnimation("hurt", [3, 5],14,true); 
			face.addAnimation("charge", [1], 5, true);
			face.addAnimation("shoot", [4], 10, true);
			face.play("normal");
			
			for (ctr = 0; ctr < face_bullets.maxSize; ctr++) {
				var b:FlxSprite = new FlxSprite(0, 0);
				b.loadGraphic(bullet_sprite, true, false, 8, 8);
				b.addAnimation("move", [0, 1], 12, true);
				b.addAnimation("explode", [2, 3, 4], 10, false);
				b.play("move");
				
				b.my_shadow = EventScripts.make_shadow("8_small");
				b.my_shadow.visible = true;
				b.my_shadow.exists = false;
				b.addAnimation("get_small", [4, 3, 2, 1, 0], 12, false);
				b.addAnimation("get_big", [0,1,2,3,4], 12, false);
				b.my_shadow.play("get_small");
				parent.bg_sprites.add(b.my_shadow);
				face_bullets.add(b);
			}
			face_bullets.setAll("exists", false);
			
			/* Init hand stuff */
			/* Hand ANIMS */
			lhand.loadGraphic(l_hand_sprite, true, false, 32, 32);
			rhand.loadGraphic(r_hand_sprite, true, false, 32, 32);
			rhand.scale.x = -1;
			lhand.addAnimation("idle", [0]);
			lhand.addAnimation("stomp", [1]);
			lhand.addAnimation("push", [3]);
			lhand.addAnimation("shoot", [2]);
			lhand.play("idle");
			rhand.addAnimation("idle", [0]);
			rhand.addAnimation("stomp", [1]);
			rhand.addAnimation("push", [3]);
			rhand.addAnimation("shoot", [2]);
			rhand.play("idle");
			
			
			lhand_init_pt.y = lhand.y;
			lhand_init_pt.x = lhand.x;
			rhand_init_pt.y = rhand.y;
			rhand_init_pt.x = rhand.x;
			rhand.immovable = lhand.immovable = true; 
			lhand.parabola_thing = new Parabola_Thing(lhand, 64, period_lhand_stomp, "offset", "y");
			rhand.parabola_thing = new Parabola_Thing(rhand, 32, 1.0, "offset", "y");
			lhand.my_shadow = new FlxSprite(0, 0);
			rhand.my_shadow = new FlxSprite(0, 0);
			/* Load shadow anims */
			/* This shadow has 5 frames, and its frame is determined by the fist's y-offset 
			 * (or height) */
			lhand.my_shadow.loadGraphic(Common_Sprites.shadow_sprite_28_10, true, false, 28, 10);
			rhand.my_shadow.loadGraphic(Common_Sprites.shadow_sprite_28_10, true, false, 28, 10);
			
			/* Hand poofs */
			lhand_poof.loadGraphic(EventScripts.small_explosion_sprite, true, false, 24,24);
			rhand_poof.loadGraphic(EventScripts.small_explosion_sprite, true, false, 24,24);
			lhand_poof.addAnimation("poof", [0, 1, 2, 3,4,4], 12, false); // Last frame should be empty
			rhand_poof.addAnimation("poof", [0, 1, 2, 3,4,4], 12, false); 
			lhand_poof.exists = false;
			rhand_poof.exists = false;
			
			/* Load laser anims */
			h_laser.loadGraphic(laser_sprite, true, false, 64, 10);
			h_laser.addAnimation("charge", [0], 12);
			h_laser.addAnimation("move", [1,2], 12);
			h_laser.play("charge");
			h_laser.visible = false;
			
			
			/* Add to parent draw group */
			if (xml.@alive == "false") {
				Registry.GRID_ENEMIES_DEAD++;
				exists = false;
			} else {
				parent.bg_sprites.add(lhand.my_shadow);
				parent.bg_sprites.add(rhand.my_shadow);
				parent.bg_sprites.add(wall);
				parent.bg_sprites.add(h_laser);
				parent.sortables.add(face);
				parent.fg_sprites.add(face_bullets);
				parent.fg_sprites.add(death_explosions);
				parent.sortables.add(lhand);
				parent.sortables.add(rhand);
				parent.sortables.add(rhand_poof);
				parent.sortables.add(lhand_poof);
			}
			
			
			if (Registry.FUCK_IT_MODE_ON) {
				s_face = s_face_dying;
			}
			
			lhand.alpha = rhand.alpha = 0;
			
			/* Change player respawn point */
			player.grid_entrance_x = tl.x + 70;
			player.grid_entrance_y = tl.y + 65;
			
			
			FlxG.watch(this, "cur_phase", "phase");
			face.alpha = wall.alpha = lhand.alpha = rhand.alpha = 0;
			
			
			add_sfx("hit_ground", Registry.sound_data.wb_hit_ground);
			add_sfx("tap_ground", Registry.sound_data.wb_tap_ground);
			add_sfx("fall", Registry.sound_data.fall1);
			add_sfx("charge", Registry.sound_data.sun_guy_charge);
			add_sfx("shoot", Registry.sound_data.wb_shoot);
			add_sfx("pop", Registry.sound_data.four_shooter_pop_group);
			add_sfx("push", Registry.sound_data.slasher_atk);
			add_sfx("hurt", Registry.sound_data.wb_moan);
			add_sfx("hurt_2", Registry.sound_data.wb_moan_2);
			add_sfx("death", Registry.sound_data.talk_death);
		}
		
		override public function update():void 
		{
			
			if (do_intro) {
				if (intro_ctr == 0) {
					Registry.volume_scale -= 0.005;
					if (player.y < tl.y + 80 ) {
						DH.start_dialogue(DH.name_wallboss, DH.scene_wallboss_before_fight);
						intro_ctr++;
						player.be_idle();
					}
					super.update();
					return;
				} else if (intro_ctr == 1) {
					if (DH.a_chunk_just_finished()) {
						
						intro_ctr++;
						Registry.sound_data.stop_current_song();
						Registry.sound_data.start_song_from_title("BOSS");
						Registry.volume_scale = 1;
					}
					super.update();
					return;
				} else if (intro_ctr == 2) {
					face.alpha += 0.003;
					wall.alpha = lhand.alpha = rhand.alpha = face.alpha;
					if (face.alpha == 1) {
						do_intro = false;
					}
				}
			}
			
			/* Act solid */
			FlxG.collide(face, player);
			FlxG.collide(wall, player);
			
			var s:FlxSprite;
			var ctr:int;
			
			
			/* Hurting the boss logic */
			//in normal state, boss can be hurt. also set current attack phase.
			if (s_face == s_face_normal) {
			
				charge_t += FlxG.elapsed;
				if (charge_t > charge_tm) {
					s_face = s_face_charge;
					charge_t = 0;
				}
				if (hurt_t > hurt_tm) {
					if (player.broom.visible && player.broom.overlaps(face)) {
						health--;
						if (health == phase_2_health) cur_phase = 1;
						if (health == phase_3_health) cur_phase = 2;
						if (health == 0) {
							s_face = s_face_dying;
							s_hand = s_hand_dying;
							play_sfx("hurt_2");
						} else {
							
							play_sfx("hurt");
						}
						hurt_t = 0;
						face.play("hurt");
					} else {
						face.play("normal");
					}
				} else {
					hurt_t += FlxG.elapsed;
				}
			//charge up, and then set all teh bullet properties
			} else if (s_face == s_face_charge) {
				face.play("charge");
				charge_t += FlxG.elapsed;
				if (charge_t > finish_charge_tm) {
					charge_t = 0;
					s_face = s_face_shoot;
					face.play("shoot");
					play_sfx("shoot");
					face_bullets.setAll("exists", true);
					
					for each (s in face_bullets.members) { //BARF
						if (s == null) continue;
						s.x = face.x + 32;
						s.y = face.y + 16;
						s.parabola_thing = null;
						s.parabola_thing = new Parabola_Thing(s, 16 + int(8 * Math.random()), 1 + 0.5 * Math.random(), "offset", "y");
						s.parabola_thing.set_shadow_fall_animation("get_big");
						s.velocity.x = -30 + int(60 * Math.random());
						s.velocity.y = 30;
						
						s.my_shadow.exists = true;
						s.my_shadow.play("get_small");
						s.my_shadow.x = s.x;
						s.my_shadow.y = s.y;
					}
				}
			//release bullets and chek for collisions. return to normal state
			// when all bullets have hit the ground.
			} else if (s_face == s_face_shoot) {
				for each (s  in face_bullets.members) {
					s.my_shadow.x = s.x; //pin shadow to bullet
					s.my_shadow.y = s.y;
					if (!player.invincible && s.overlaps(player) && s.alive && s.exists) { //check overlap only if player vulnerable
						player.touchDamage(1);
					}
					
					if (s.parabola_thing.tick()) {
						if (s.alive && s.exists) {
							s.alive = false;
							s.play("explode");
							play_sfx("pop");
							s.my_shadow.exists = false;
							s.velocity.x = s.velocity.y = 0;
						
						} else {
							if (s._curAnim.frames.length - 1 == s._curFrame) {
								if (s.exists) { 
									s.alive = true;
									s.exists = false;
									s.play("move");
								}	
							}
						}
						
					}
					
					if (!s.exists) {
						ctr++;
					}
				}
				if (ctr >= face_bullets.maxSize) {
					s_face = s_face_normal;
				}
			} else if (s_face == s_face_intro) {
				//play some sort of animation
				//wait for hands to appear
				if (s_hand != s_hand_intro) {
					s_face = s_face_normal;
				}
				
			} else if (s_face == s_face_dying) {
				
				if (t_dying < 0) {
					if (!played_sound) {
						DH.start_dialogue(DH.name_wallboss, DH.scene_wallboss_after_fight);
						player.be_idle();
						played_sound = true;
						play_sfx("death");
					}
					
					if (!DH.scene_is_finished(DH.name_wallboss, DH.scene_wallboss_after_fight)) {
						super.update();
						return;
					}
					
					face.alpha -= fade_out_alpha_rate;
					wall.alpha -= fade_out_alpha_rate;
					if (face.alpha == 0 && wall.alpha == 0) {
						s_face = s_face_dead;
						t_dying = 1;
					}
				} else if (s_hand == s_hand_dead) {
					t_dying -= FlxG.elapsed;
				}
				
			} else if (s_face == s_face_dead) {
				if (t_dying < 0) {
					Registry.sound_data.start_song_from_title("CROWD");
					Registry.GRID_ENEMIES_DEAD++;
					//if (!Registry.CUTSCENES_PLAYED[Cutscene.Terminal_Gate_Crowd]) {
					//	Registry.CURRENT_CUTSCENE = Cutscene.Terminal_Gate_Crowd;
					//	Registry.E_Load_Cutscene = true;
					//}
					Registry.GE_States[Registry.GE_Crowd_Boss_Dead_Idx] = true;
					xml.@alive = "false";
					exists = false;
				} else {
					t_dying -= FlxG.elapsed;
				}
			}
			
			/**************/
			/* Hand logic */
			//only collide if not in stomp state
			
			set_shadow_size(lhand);
			set_shadow_size(rhand);
			
			if (s_hand != s_hand_stomp) {
				FlxG.collide(player, lhand);
				FlxG.collide(player, rhand);
			}
			if (s_hand == s_hand_intro) {
				rhand.alpha += fade_in_alpha_rate;
				lhand.alpha += fade_in_alpha_rate;
				if (lhand.alpha == 1 && rhand.alpha == 1) {
					s_hand = s_hand_float;
				}
			/* Floating logic */
			} else if (s_hand == s_hand_float) {
				t_float += FlxG.elapsed;
				if (t_float > tm_float) {
					t_float = 0;
					
					choose_attack();
					if (s_hand == s_hand_push) {
						nr_pushes = max_nr_pushes[cur_phase];
					}
					
				}
				lhand.y  = lhand_init_pt.y + 4 + Math.sin(t_float * 6.28) * 8;
				rhand.y  = rhand_init_pt.y + 4 - Math.sin(t_float * 6.28) * 8;
			/* Logic for pushing */
			} else if (s_hand == s_hand_push) {
				var sub_ctr:int = 0;
				//move hands to correct place then depending on the type of 
				//attack, set velocities
				if (ctr_hand_push == 0) {
					if (push_type != 0) {
						if (EventScripts.send_property_to(lhand, "y", tl.y, 0.5)) sub_ctr++;
						if (EventScripts.send_property_to(lhand, "x", tl.x, 0.5)) sub_ctr++;
					} else {
						sub_ctr += 2;
					}
					if (push_type != 1) {
						if (EventScripts.send_property_to(rhand, "y", tl.y, 0.5)) sub_ctr++;
						if (EventScripts.send_property_to(rhand, "x", tl.x + 16*6, 0.5)) sub_ctr++;
					} else {
						sub_ctr += 2;
					}
					
					if (sub_ctr == 4) {
						if (push_type != 1) {
							rhand.play("push");
							play_sfx("push");
							rhand.velocity.y = push_y_vel[cur_phase];
							rhand.velocity.x = -20 - 40 * Math.random();
						}
						if (push_type != 0) {
							lhand.play("push");
							play_sfx("push");
							lhand.velocity.y = push_y_vel[cur_phase];
							lhand.velocity.x = 20 + 40 * Math.random();
						}
						
						ctr_hand_push++;
					}
				//if the hand goes far enough, then change states
				} else if (ctr_hand_push == 1) {
					if (lhand.y > tl.y + 5 * 16 || rhand.y > tl.y + 5*16) {
						ctr_hand_push++;
					}
				//reset hand push script if more pushes, otherwise go back to float
				} else if (ctr_hand_push == 2) {
					if (EventScripts.send_property_to(lhand, "y", lhand_init_pt.y, 3)) sub_ctr++;
					if (EventScripts.send_property_to(lhand, "x", lhand_init_pt.x, 3)) sub_ctr++;
					if (EventScripts.send_property_to(rhand, "y", rhand_init_pt.y, 3)) sub_ctr++;
					if (EventScripts.send_property_to(rhand, "x", rhand_init_pt.x, 3)) sub_ctr++;
					
					if (sub_ctr == 4) {
						ctr_hand_push = 0;
						lhand.play("idle");
						rhand.play("idle");
						lhand.velocity.y = lhand.velocity.x = 0;
						rhand.velocity.y = rhand.velocity.x = 0;
						set_next_push();
						nr_pushes--;
						if (nr_pushes == 0) {
							s_hand = s_hand_float;
						}
					}
				} 
			/* Logic for stomping */
			} else if (s_hand == s_hand_stomp) {
				sub_ctr = 0;
				// Pin shadows to hands
				lhand.my_shadow.x = lhand.x;
				lhand.my_shadow.y = lhand.y + 20;
				rhand.my_shadow.x = rhand.x;
				rhand.my_shadow.y = rhand.y + 20;
				// Init nuumber of falls and other things
				if (ctr_hand_stomp == 0) {
					lhand.play("stomp");
					rhand.play("stomp");
					if (EventScripts.send_property_to(rhand, "y", tl.y + 16, 0.5)) {
						ctr_hand_stomp++;
						nr_falls = max_nr_falls[cur_phase];
						lhand.my_shadow.visible = rhand.my_shadow.visible = true;
					}
				//Stomp the rhand back and forth, have the lhand sort of follow the player
				//state change when lhand stomps enough times
				} else if (ctr_hand_stomp == 1) {
					if (rhand.parabola_thing.tick()) {
						play_sfx("tap_ground");
						rhand_poof.exists = true;
						rhand_poof.play("poof");
						rhand_poof.x = rhand.x;
						rhand_poof.y = rhand.y;
						rhand.parabola_thing.reset_time();
					}
					if (rhand.offset.y <= 8 && rhand.my_shadow.overlaps(player)) {
						player.touchDamage(1);
					}
					if (s_hand_stomp_rhand == LEFT) {
						rhand.velocity.x = -rhand_stomp_vel;
						if (rhand.x < tl.x) {
							s_hand_stomp_rhand = RIGHT;
						}
					} else {
						rhand.velocity.x = rhand_stomp_vel;
						if (rhand.x > (tl.x + 16 * 8 - rhand.width)) {
							s_hand_stomp_rhand = LEFT;
						}
					}
					//rise and fall for lhand
					if (lhand.parabola_thing.t > (lhand.parabola_thing.period / 2)) {
						if (!played_sound) {
							play_sfx("fall");
							played_sound = true;
						}
						if (t_lhand_stomp > tm_lhand_stomp) {
							if (lhand.parabola_thing.tick()) {
								lhand_poof.exists = true;
								lhand_poof.play("poof");
								play_sfx("hit_ground");
								lhand_poof.x = lhand.x;
								lhand_poof.y = lhand.y;
								lhand.parabola_thing.reset_time();
								nr_falls--;
								played_sound = false;
								FlxG.shake(0.01, 0.2);
								//break the ground if damaged a bit
								if (!broke_ground && cur_phase >= 1) {
									FlxG.shake(0.02, 0.5);
									Registry.sound_data.floor_crack.play();
									if (break_ground()) {
										broke_ground = true;
									}
								}
								if (nr_falls == 0) {
									ctr_hand_stomp = 2;
									rhand.velocity.x = 0;
									rhand.my_shadow.visible = lhand.my_shadow.visible = false;
								}
							}
							if (lhand.offset.y < 8 && lhand.my_shadow.overlaps(player)) {
								player.touchDamage(1);
							}
						} else {
							t_lhand_stomp += FlxG.elapsed;
						}
					} else {
						EventScripts.send_property_to(lhand, "x", player.x, 1);
						EventScripts.send_property_to(lhand, "y", player.y - 16, 1);
						lhand.parabola_thing.tick();
					}
				//reset then return to float state
				} else if (ctr_hand_stomp == 2) {
					if (EventScripts.send_property_to(lhand, "y", lhand_init_pt.y, 3)) sub_ctr++;
					if (EventScripts.send_property_to(lhand, "x", lhand_init_pt.x, 3)) sub_ctr++;
					if (EventScripts.send_property_to(rhand, "y", rhand_init_pt.y, 3)) sub_ctr++;
					if (EventScripts.send_property_to(rhand, "x", rhand_init_pt.x, 3)) sub_ctr++;
					if (EventScripts.send_property_to(rhand.offset, "y", 0, 2)) sub_ctr++;
					
					if (sub_ctr == 5) {
						
						lhand.play("idle");
						rhand.play("idle");
						s_hand = s_hand_float;
						ctr_hand_stomp = 0;
						
					}
				} 
			} else if (s_hand == s_hand_h_laser) {
				if (player.y < tl.y + 16) {
					player.y = tl.y + 16;
				}
				sub_ctr = 0;
				h_laser.x = lhand.x + 32;
				h_laser.y = lhand.y + 11;
				
				if (h_laser.visible && !h_laser.flickering && (player.state != player.S_AIR) && h_laser.overlaps(player)) {
					player.touchDamage(1);
				}
				//Play shooting animation for hands, move them into position, flicker the laser, and then begin moving.
				if (s_hand_h_laser_ctr == 0) {
					h_laser.play("charge");
					rhand.play("shoot");
					lhand.play("shoot");
					if (EventScripts.send_property_to(lhand, "x", tl.x, 3)) sub_ctr++;
					if (EventScripts.send_property_to(rhand, "x", tl.x + 96, 3)) sub_ctr++;
					if (EventScripts.send_property_to(lhand, "y", lhand_init_pt.y, 3)) sub_ctr++;
					if (EventScripts.send_property_to(rhand, "y", rhand_init_pt.y, 3)) sub_ctr++;
					if (sub_ctr == 4 && !h_laser.visible) {
						h_laser.visible = true;
						play_sfx("charge");
						h_laser.flicker(1.3);
					} 
					
					if (h_laser.visible && !h_laser.flickering) {
						s_hand_h_laser_ctr++;
						h_laser.play("move");
						lhand.velocity.y = rhand.velocity.y = 50;
					}
				} else if (s_hand_h_laser_ctr == 1) {
					if (lhand.y > tl.y + 16 * 5) {
						lhand.velocity.y = rhand.velocity.y = -65;
						s_hand_h_laser_ctr++;
					}
				} else if (s_hand_h_laser_ctr == 2) {
					if (lhand.y < tl.y + 18) {
						lhand.velocity.y = rhand.velocity.y = 80;
						s_hand_h_laser_ctr++;
					}
				} else if (s_hand_h_laser_ctr == 3) {
					if (lhand.y > tl.y + 16 * 5) {
						s_hand_h_laser_ctr++;
						lhand.velocity.y = rhand.velocity.y = -20;
					}
				} else {
					if (EventScripts.send_property_to(lhand, "y", lhand_init_pt.y, 1.5)) sub_ctr++;
					if (EventScripts.send_property_to(lhand, "x", lhand_init_pt.x, 1.5)) sub_ctr++;
					if (EventScripts.send_property_to(rhand, "y", rhand_init_pt.y, 1.5)) sub_ctr++;
					if (EventScripts.send_property_to(rhand, "x", rhand_init_pt.x, 1.5)) sub_ctr++;
					if (sub_ctr == 4) {
						h_laser.visible = false;
						lhand.velocity.y = rhand.velocity.y = 0;
						s_hand = s_hand_float;
						lhand.play("idle");
						rhand.play("idle");
						s_hand_h_laser_ctr = 0;
					}
				}
				
			} else if (s_hand == s_hand_dying) {
				
				if (Registry.sound_data.current_song.playing) {
					rhand.velocity.x = rhand.velocity.y = lhand.velocity.x = lhand.velocity.y  = 0;
					Registry.sound_data.stop_current_song();
					Registry.sound_data.sun_guy_death_s.play();
					FlxG.flash(0xffffffff, 3);
					t_dying = tm_dying;
				}
				if (t_dying > 0) {
					t_dying -= FlxG.elapsed;
					death_explosions.exists = true;
					super.update();
					return;
				} 
				FlxG.shake(0.02, 0.1, null, true);
				
				
				rhand.alpha -= fade_out_alpha_rate;
				lhand.alpha -= fade_out_alpha_rate;
				rhand.my_shadow.alpha -= fade_out_alpha_rate;
				lhand.my_shadow.alpha -= fade_out_alpha_rate;
				
				if (death_explosion_timer < 0) {
					death_explosion_timer = tm_de;
					for each (var de:FlxSprite in death_explosions.members) {
						if (!de.visible) {
							de.visible = true;
							de.play("explode");
							de.x = wall.x + (160 - de.width) * Math.random();
							de.y = wall.y + 32 * Math.random();
							Registry.sound_data.play_sound_group(Registry.sound_data.enemy_explode_1_group);
							break;
						} else {
							if (de._curAnim.frames.length - 1 == de._curFrame) {
								de.visible = false;
							}
						}
					}
				} else {
					death_explosion_timer -= FlxG.elapsed;
				}
				if (rhand.alpha <= 0.03 && lhand.alpha <= 0.03) {
					s_hand = s_hand_dead;
					h_laser.visible = false;
					rhand.my_shadow.visible = false;
					lhand.my_shadow.visible = false;
				}
			} else if (s_hand == s_hand_dead) {
				lhand.velocity.x = rhand.velocity.x = lhand.velocity.y = rhand.velocity.y = 0;
				
			}
			
				//laser attacks
		
			super.update();
		}
		
		private function choose_attack():void {
			var r:Number = Math.random();
			switch (cur_phase) {
				case 0:
					if (r <= 0.7) {
						s_hand = s_hand_stomp;
					} else {
						s_hand = s_hand_push;
					}
					break;
				case 1:
					if (r <= 0.35) {
						s_hand = s_hand_h_laser;
					} else if (r <= 0.7) {
						s_hand = s_hand_stomp;
					} else {
						s_hand = s_hand_push;
					}
					break;
				case 2:
					if (r <= 0.5) {
						s_hand = s_hand_h_laser;
					} else if (r <= 0.75) {
						s_hand = s_hand_stomp;
					} else {
						s_hand = s_hand_push;
					}
					break;
			}
		}
		
		private function set_shadow_size(fist:FlxSprite):void {
			var y_off:int = fist.offset.y;
			
			if (y_off >= 29) {
				fist.my_shadow.frame = 0;
			} else if (y_off >= 24) {
				fist.my_shadow.frame = 1;
			} else if (y_off >= 16) {
				fist.my_shadow.frame = 2;
			} else if (y_off >= 8) {
				fist.my_shadow.frame = 3;
			} else {
				fist.my_shadow.frame = 4;
			}
		}
		/**
		 * Breaks the ground in the 6th row of the play area
		 */
		private function break_ground():int {
			var tile_indices:Array = new Array(62, 63, 64, 65, 66, 67);
			var cracked_index:int = 71;
			var is_broken:Boolean = false;
			for each (var index:int in tile_indices) {
				var tm:FlxTilemap = parent.curMapBuf;
				if (tm.getTileByIndex(index) != cracked_index) {
					tm.setTileByIndex(index, cracked_index, true);
				} else {
					tm.setTileByIndex(index, 81, true);
					is_broken = true;
				}
			}
			
			return is_broken ? 1 : 0;
		}
		 
		/**
		 * Helper function, sets the some of the next push properties
		 */
		private function set_next_push():void  {
			
			if (Math.random() < p_double_push[cur_phase]) {
				push_type = 2; //Both hands
			} else {
				if (Math.random() <= 0.5) {
					push_type = 0;
				} else {
					push_type = 1;
				}
			}
		}
		override public function destroy():void 
		{
			parent.sortables.remove(face, true);
			parent.sortables.remove(lhand, true);
			parent.sortables.remove(rhand, true);
			
			max_nr_falls = null;
			p_double_push = null; 
			push_y_vel  = null;
			max_nr_pushes = null;
			
			tl = null;
			
			wall = null;
			death_explosions = null;
			face = null;
			lhand_init_pt = rhand_init_pt = null;
			rhand = lhand = null;
			lhand_poof = rhand_poof = null;
			face_bullets = null;
			
			
			super.destroy();
		}
		
	}

}