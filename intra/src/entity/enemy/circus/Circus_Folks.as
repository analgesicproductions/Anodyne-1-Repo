package entity.enemy.circus 
{
	import data.Common_Sprites;
	import entity.decoration.Light;
	import entity.gadget.Dust;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import helper.Parabola_Thing;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * "Arthur and Javiera" - acrobat and juggler NPC/enemy that you meet in circus
	 * Eitehr appear alone throughout dungeon, or together at end in boss room
	 */
	//Story: both are these circus workers, very scared of their jobs but have no choice, so in
	// a way a representation of the fear of harm of the player. this fear attacks the player at the end, even though
	// the player helps them, tying a bit into paranoia
	
	 
	public class Circus_Folks extends FlxSprite 
	{
		[Embed (source = "../../../res/sprites/enemies/circus/shockwave.png")] public static var shockwave_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/circus/javiera.png")] public static var javiera_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/circus/javiera_juggle.png")] public static var javiera_juggle_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/circus/arthur.png")] public static var arthur_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/circus/arthur_javiera.png")] public static var both_sprite:Class;
		
		public const T_ARTHUR:int = 0;
		public const T_JAVIERA:int = 1;
		public const T_BOTH:int = 2;
		public var TYPE:int = 0;
		
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		public var added_to_parent:Boolean = false;
		
		public var ctr:int = 0;
		private var tl:Point = new Point;
		
		/* Only Arthur */
		public var ARTHUR_timer:Number = 0;
		public var ARTHUR_timer_max:Number = 1;
		public var ARTHUR_INIT_PT:Point = new Point();
		public var dust_pillow:Dust;
		public var light:Light;
		
		/* Only Javiera*/
		public var JAVIERA_timer:Number = 0;
		public var JAVIERA_timer_max:Number = 1;
		public var JAVIERA_INIT_PT:Point = new Point();
		
		/* Both (boss) */
		private var MAX_HEALTH:int = 2;
		private var state:int;
		private var s_walk:int = 0;
		private var s_jump:int = 1;
		private var s_throw:int = 2;
		private var s_intro:int = -1;
		private var s_dying:int = -2;
		private var s_dead:int = -3;
		private const s_really_dead:int = -4;
		
		private var skip_intro:Boolean = false;
		private var test_throw:Boolean = false;
		
		private var walk_vel:int = 90;
		private var t_walk:Number = 0;
		private var tm_walk:Number = 3.0;
		
		private var jump_vel:Number = 100;
		private var t_jump:Number = 0;
		private var tm_jump:Number = 2.0;
		private var ty:int; // Target y, x
		private var tx:int;
		
		private var throw_vel:int = 120;
		
		public var javiera:FlxSprite = new FlxSprite;
		public var arthur:FlxSprite = new FlxSprite;
		
		public var shockwaves:FlxGroup = new FlxGroup(8);
		private var sw_vel:int = 70;
		
		private var t_hurt:Number = 0;
		private var tm_hurt:Number = 1;
		
		public function Circus_Folks(_xml:XML, _player:Player, _parent:*) 
		{
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			TYPE = parseInt(xml.@frame);
			tl.x = Registry.CURRENT_GRID_X * 160 + 16;
			tl.y = Registry.CURRENT_GRID_Y * 160 + Registry.HEADER_HEIGHT + 16;
			
			if (xml.@alive == "false") {
				exists = false;
				Registry.GRID_ENEMIES_DEAD++;
			} else {
				if (TYPE == T_ARTHUR) {
					// Load anims
					DH.set_scene_to_pos(DH.name_arthur, DH.scene_arthur_circus_alone, 0);
					load_arthur(this);
					ARTHUR_INIT_PT.x = x;
					ARTHUR_INIT_PT.y = y + Registry.HEADER_HEIGHT - 2 * 16;
					y -= 2 * 16;
					offset.y = 5 * 16;
					my_shadow.x = x + 4;
					my_shadow.y = y + 4 + Registry.HEADER_HEIGHT;
					if (Registry.CURRENT_GRID_X == 8 && Registry.CURRENT_GRID_Y == 1) {
						state = s_really_dead;
						offset.y = 0;
						y += 32;
						my_shadow.visible = false;
						frame = 18;
						light = new Light(x-10, y-10, parent.darkness, Light.T_GLOW_LIGHT, false);
					}
				} else if (TYPE == T_JAVIERA) {
					//load j anims
					DH.set_scene_to_pos(DH.name_arthur, DH.scene_arthur_circus_alone, 0);
					load_javiera(this);
					loadGraphic(javiera_juggle_sprite, true, false, 16, 24);
					JAVIERA_INIT_PT.x = x;
					JAVIERA_INIT_PT.y = y + Registry.HEADER_HEIGHT;
					if (Registry.CURRENT_GRID_X == 8 && Registry.CURRENT_GRID_Y == 1) {
						loadGraphic(javiera_sprite, true, false, 16, 16);
						state = s_really_dead;
						frame = 12;
					}
				} else if (TYPE == T_BOTH) {
					player.grid_entrance_x = tl.x + 75;
					player.grid_entrance_y = tl.y + 16 * 7 + 4;
			
					// Load A anims
					load_arthur(arthur);
					arthur.exists = true;
					arthur.x = tl.x + 64 - 8 - width;
					arthur.y = tl.y ;
					
					// Load J anims
					load_javiera(javiera);
					javiera.exists = true;
					javiera.x = tl.x + 64 + 8;
					javiera.y = tl.y;
					
					// Load a+j sprite and anims.
					loadGraphic(both_sprite, true, false, 16, 32);
					height = 16;
					offset.y = 16;
					addAnimation("walk_d", [0, 1], 8);
					addAnimation("walk_u", [2, 3], 12);
					addAnimation("walk_r", [4, 5], 12);
					addAnimation("walk_l", [4, 5], 12);
					addAnimation("switch", [6, 7], 6,false);
					addAnimation("throw_d", [8, 8], 1,false); // The length of all frames minus last is how long the warning lasts.
					addAnimation("throw_r", [10, 8], 1,false);
					addAnimation("throw_u", [9, 8], 1,false);
					addAnimation("throw_l", [10, 8], 1, false);
					addAnimation("dying", [10,10,10], 1, false);
					play("walk_l");
					visible = false;
					
					
					// Init shadow and parabola.
					my_shadow = EventScripts.make_shadow("8_small", true);
					parabola_thing = new Parabola_Thing(this, 48, 1.0, "offset", "y");
					parabola_thing.set_shadow_fall_animation("get_big");
					parabola_thing.OFFSET = 16;
					my_shadow.play("get_small");
					
					// Create shockwaves.
					for (var i:int = 0; i < shockwaves.maxSize; i++) {
						var shockwave:FlxSprite = new FlxSprite;
						shockwave.loadGraphic(shockwave_sprite, true, false, 16, 16);
						shockwave.addAnimation("move", [0, 1, 2, 1], 8); // Remove if we make directional moving shockwaves
						shockwave.addAnimation("move_d", [0, 1, 2, 1], 8);
						shockwave.addAnimation("evaporate", [3, 4, 5, 6, 6], 8, false);
						shockwave.play("move_d");
						
						shockwaves.add(shockwave);
					}
					shockwaves.setAll("exists", false);
					
					MAX_HEALTH = 7;
					health = MAX_HEALTH;
					skip_intro = false;
					//test_throw = true;
					state = s_intro;
					
					add_sfx("jump_up", Registry.sound_data.player_jump_up);
					add_sfx("jump_down", Registry.sound_data.player_jump_down);
				}
					addAnimationCallback(on_anim_change);
			}
		}
		
		
		override public function update():void 
		{
			trace(health);
			if (TYPE == T_ARTHUR) {
				arthur_logic();
			} else if (TYPE == T_JAVIERA) {
				javiera_logic();
			} else if (TYPE == T_BOTH) {
				both_logic();
				shockwave_logic();
			}
			super.update();
		}
		
		private function arthur_logic():void {
			
			if (!added_to_parent) {
				added_to_parent = true;
				my_shadow.visible = true;
				my_shadow.frame = 0;
				dust_pillow = new Dust(tl.x + 30, tl.y, null, Registry.GAMESTATE);
				if (state != s_really_dead) {
					parent.bg_sprites.add(dust_pillow);	
				} else {
					parent.sortables.add(light);
				}
				parent.bg_sprites.add(my_shadow);
				
			}
			
			if (state == s_really_dead) {
				super.update();
				return;
			}
			
			if (parent.state == parent.S_TRANSITION) return;
			
			if (ctr == 0) { // Say description of situation
				DH.start_dialogue(DH.name_arthur, DH.scene_arthur_circus_alone);
				ctr++;
			} else if (ctr == 1) { 
				if (Registry.cur_dialogue == "") {
					ctr++;
					tm_hurt = 1.3;
					t_hurt = 0;
				}
			} else if (ctr == 2) { // wobble left and right until dust under arthur
					t_hurt += FlxG.elapsed;
					
					offset.x = my_shadow.offset.x = -3 * Math.sin((t_hurt /tm_hurt) * 6.28);
					if (dust_pillow.overlaps(this) && offset.x <= 0.5) {
						ctr++;
						offset.x = my_shadow.offset.x = 0;
						play("fall_1");
						Registry.sound_data.fall1.play();
						my_shadow.play("get_big");
					}
			} else if (ctr == 3) { //  Poof the dust, play sounds/anims, open gate
				offset.y -= FlxG.elapsed * 30 * (1 + 3*((80 - offset.y)/80));
				if (offset.y < 0) {
					offset.y = 0;
					dust_pillow.play("poof");
					Dust.dust_sound.play();
					play("stunned");
					Registry.GRID_PUZZLES_DONE++;
					FlxG.shake(0.01, 0.2);
					my_shadow.visible = false;
					ctr++;
				}
			} else if (ctr == 4) { //Wait a bit then say something? Or say nothing (...)
					ARTHUR_timer += FlxG.elapsed;
					if (ARTHUR_timer > ARTHUR_timer_max) {
						ctr++;
						DH.start_dialogue(DH.name_arthur, DH.scene_arthur_circus_alone);
					}
			} else if (ctr == 5) {
				if (Registry.cur_dialogue == "") {
					ctr++;
					play("walk_d");
				}
			} else if (ctr == 6) { // Move off 
				var sub_ctr:int = 0;
				if (EventScripts.send_property_to(this, "y", ARTHUR_INIT_PT.y + 32, 1)) {
					play("walk_l");
					if (parabola_thing.tick()) {
						my_shadow.visible = false;
						if (EventScripts.send_property_to(this, "x", ARTHUR_INIT_PT.x - 40, 1)) {
							sub_ctr++;
						}
					} else {
						if (!my_shadow.visible) {
							my_shadow.visible = true;
							my_shadow.play("get_small");
						}
						my_shadow.x = x + 4; my_shadow.y = y + 4;
					}
					
				}
				if (sub_ctr == 1) {
					exists = false;
					xml.@alive = "false";
					ctr++;
				}
			}
		}
		
		private function javiera_logic():void {
			if (parent.state == parent.S_TRANSITION) return;
			
			
			if (state == s_really_dead) {
				super.update();
				return;
			}
			
			if (ctr == 0) {
				DH.start_dialogue(DH.name_javiera, DH.scene_javiera_circus_alone);
				ctr++;
			} else if (ctr == 1) {
				if (Registry.cur_dialogue == "") {
					ctr++;
					loadGraphic(javiera_sprite, true, false, 16, 16);
				}
			} else if (ctr == 2) {
				if (Registry.GRID_ENEMIES_DEAD == 2) {
					play("walk_d");
					JAVIERA_timer += FlxG.elapsed;
					if (JAVIERA_timer > JAVIERA_timer_max) {
						ctr++;
					DH.start_dialogue(DH.name_javiera, DH.scene_javiera_circus_alone);
					}
				}
			} else if (ctr == 3) {
				if (Registry.cur_dialogue == "") {
					ctr++;
				}
			} else if (ctr == 4) {
				var sub_ctr:int = 0;
				if (EventScripts.send_property_to(this, "y", JAVIERA_INIT_PT.y, 1)) {
					play("walk_l");
					if (EventScripts.send_property_to(this, "x", JAVIERA_INIT_PT.x - 66, 1)) {
						sub_ctr++;
					}
				}
				if (sub_ctr == 1) {
					exists = false;
					xml.@alive = "false";
					ctr++;
					Registry.GRID_PUZZLES_DONE++;
					
				}
			}
		}
		
		
		private function both_logic():void {
			if (!added_to_parent) {
				added_to_parent = true;
				if (javiera != null) parent.sortables.add(javiera);
				if (arthur != null) parent.sortables.add(arthur);
				parent.sortables.add(shockwaves);
				parent.sortables.add(my_shadow);
			}
			
			if (state == s_walk) {
				walk_state();
			} else if (state == s_jump) {
				jump_state();
			} else if (state == s_throw) {
				throw_state();
			} else if (state == s_intro) {
				intro_state();
			} else if (state == s_dying) {
				dying_logic();
			} else if (state == s_dead) {
				dead_logic();
			}
			
			if (state != s_dying && state != s_dead && t_hurt < 0){
				hurt_logic();
			} else {
				t_hurt -= FlxG.elapsed;
			}
			
			
			if (player.overlaps(this) && visible && state != s_dying) {
				player.touchDamage(1);
			}
			
		}
		
		/* Stand, talk, walk into eachother, flash, load a+j sprite, go to walk. */
		private function intro_state():void {
			if (skip_intro) {
				ctr = 3;
			}
			
			switch (ctr) {
				// Talk.
				case 0:
					
					if (player.y > tl.y + 7 * 16 - 5) return; 
					
					if (!DH.scene_is_dirty(DH.name_circus_folks, DH.scene_circus_folks_before_fight)) {
						DH.start_dialogue(DH.name_circus_folks, DH.scene_circus_folks_before_fight);
						player.be_idle();
					}
					Registry.volume_scale -= 0.01;
					if (Registry.volume_scale < 0.05) {
						
						if (DH.scene_is_finished(DH.name_circus_folks, DH.scene_circus_folks_before_fight)) {
							ctr++;	
						}
					}
					break;
				// Walk.
				case 1:
					Registry.volume_scale = 1;
					Registry.sound_data.start_song_from_title("BOSS");
					arthur.play("walk_r");
					javiera.play("walk_l");
					javiera.scale.x = -1;
					arthur.velocity.x = 20;
					javiera.velocity.x = -20;
					ctr++;
					break;
				// Stop when touching.
				case 2:
					if (arthur.x > tl.x + 64) {
						arthur.velocity.x = javiera.velocity.x = 0;
						ctr++;
					}
					break;
				// Load joint sprite.
				case 3:
					javiera.exists = arthur.exists = false;
					facing = LEFT;
					play("walk_l");
					visible = true;
					if (test_throw) {
						state = s_throw;
					} else {
						state = s_walk;
					}
					velocity.x = -walk_vel;
					x = tl.x + 56;
					y = tl.y;
					ctr = 0;
					break;
			}
		}
		/* Walk ccw */
		private function walk_state():void {
			walk_about_perimeter(this,walk_vel);
			
			t_walk += FlxG.elapsed;
			if (t_walk > tm_walk) {
				t_walk = 0;
				ctr = 0;
				if (Math.random() > 0.6) {
					state = s_jump;
				} else {
					state = s_throw;
				}
			}
		}
		
		private function jump_state():void {
			// Set target coords. for jump, switch facing for animation, reset parabola and shadow.
			if (ctr == 0) {
				tx = (player.x > tl.x + 60) ? tl.x : tl.x + 112;
				ty = (player.y > tl.y + 60) ? tl.y: tl.y + 112;
				if (tx == tl.x && ty == tl.y) {
					facing = DOWN;
				} else if (tx == tl.x + 112 && ty == tl.y) {
					facing = LEFT;
				} else if (tx == tl.x + 112 && ty == tl.y + 112) {
					facing = UP;
				} else {
					facing = RIGHT;
				}
				
				var d:Number = EventScripts.distance(this, new Point(tx, ty));
				parabola_thing.period = d / jump_vel;
				parabola_thing.reset_time();
				EventScripts.scale_vector(this, new Point(tx, ty), velocity, jump_vel);
				
				my_shadow.play("get_small", true);
				my_shadow.visible = true;
				my_shadow.x = x + 4;
				my_shadow.y = y + 8;
				parabola_thing.set_shadow_fall_animation("get_big");
				play_sfx("jump_up");
				ctr++;
			// Move and then generate shockwaves.
			} else if (ctr == 1) {
				my_shadow.x = x;
				my_shadow.y = y;
				if (parabola_thing.tick()) {
					play_sfx("jump_down");
					Registry.sound_data.wb_tap_ground.play();
					my_shadow.visible = false;
					velocity.x = velocity.y = 0;
					offset.y = 16;
					x = tx;
					y = ty;
					
					// Cap the max shockwaves generated from this attack.
					if (shockwaves.countExisting() > 5) {
						ctr++; 
						return;
					}
					
					var sw1:FlxSprite = shockwaves.getFirstAvailable() as FlxSprite;
					if (sw1 == null) {
						ctr++;
						return;
					}
					sw1.exists = true;
					var sw2:FlxSprite = shockwaves.getFirstAvailable() as FlxSprite; 
					if (sw2 == null) {
						ctr++;
						return;
					}
					sw2.exists = true;
					
					sw2.x = sw1.x = x; 
					sw1.y = sw2.y = y;
					
					
					switch (facing) {
						case UP:
							sw1.velocity.x = -sw_vel;
							sw2.velocity.y = -sw_vel;
							break;
						case DOWN:
							sw1.velocity.x = sw_vel;
							sw2.velocity.y = sw_vel;
							break;
						case RIGHT:
							sw1.velocity.x = sw_vel;
							sw2.velocity.y = -sw_vel;
							break;
						case LEFT:
							sw1.velocity.x = -sw_vel;
							sw2.velocity.y = sw_vel;
							break;
					}
					
					ctr++;
					
				}
			// Wait a bit and then walk.
			} else if (ctr == 2) {
				t_jump += FlxG.elapsed;
				if (t_jump > tm_jump) {
					t_jump = 0;
					ctr = 0;
					state = s_walk;
					if (x < tl.x + 16) {
						facing = DOWN;
						play("walk_d");
					} else if (x > tl.x +105) {
						facing = UP;
						play("walk_u");
					} else if (y > tl.y +106) {
						facing = RIGHT;
						play("walk_r");
					} else {
						facing = LEFT;
						play("walk_l");
					}
				}
			}
		}
		
		private function throw_state(): void {
			// Switch places
			if (ctr == 0) {
				velocity.x = velocity.y = 0;
				play("switch");
				ctr++;
			// Wait for switch to be done.
			} else if (ctr == 1) {
				if (_curAnim.frames.length - 1 == _curFrame) {
					FlxG.flash(0xffffffff, 0.2);
					
					ctr++;
				}
			// Face the player and throw.
			} else if (ctr == 2) {
				var e2e:uint =  EventScripts.get_entity_to_entity_dir(x, y, player.x, player.y);
				arthur.facing = e2e;
				switch (e2e) {
					case UP:
						play("throw_u");
						break;
					case DOWN:
						play("throw_d");
						break
					case RIGHT:
						play("throw_r");
						break;
					case LEFT:
						play("throw_l");
						break;
				}
				ctr++;
			// Wait for throw anim to finish, then separate a+j into separate sprites.
			// Move arthur at the player.
			} else if (ctr == 3) {
				if (_curAnim.frames.length - 1 == _curFrame) {
					EventScripts.scale_vector(this, player, arthur.velocity, throw_vel);
					visible = false;
					arthur.exists = javiera.exists = true;
					arthur.play("roll");
					javiera.x = x; javiera.y = y;
					arthur.x = x; arthur.y = y - 16;
					ctr++;
					Registry.sound_data.slasher_atk.play();
				}
			// If arthur touches a wall that he didn't come from,
			// spawn 2 shockwaves, stop arthur, and play arthur's stun animation.
			} else if (ctr == 4) {
				
				if (arthur.x < tl.x && arthur.velocity.x < 0)  {
					arthur.x = tl.x; arthur.velocity.x = arthur.velocity.y = 0; arthur.facing = NONE;
				} else if (arthur.x > tl.x + 112 && arthur.velocity.x > 0) {
					arthur.x = tl.x + 112; arthur.velocity.x = arthur.velocity.y = 0; arthur.facing = NONE; 
				} else if (arthur.y > tl.y + 112 && arthur.velocity.y > 0) {
					arthur.y = tl.y + 112; arthur.velocity.x = arthur.velocity.y = 0; arthur.facing = NONE;
				} else if (arthur.y < tl.y && arthur.velocity.y < 0) {
					arthur.y = tl.y; arthur.velocity.x = arthur.velocity.y = 0; arthur.facing = NONE;
				}
				
				
				if (arthur.facing == NONE) {
					var s1:FlxSprite = shockwaves.getFirstAvailable() as FlxSprite;
					if (s1 != null) s1.exists = true;
					var s2:FlxSprite = shockwaves.getFirstAvailable() as FlxSprite;
					if (s2 != null) s2.exists = true;
					
					
					if (s1 == null || s2 == null) {
						ctr++;
						return;
					}
					
					s1.x = s2.x = arthur.x;
					s1.y = s2.y = arthur.y;
					if (arthur.x == tl.x || arthur.x == tl.x + 112) {
						s1.velocity.y = sw_vel;
						s2.velocity.y = -sw_vel;
					}  else {
						s1.velocity.x = sw_vel;
						s2.velocity.x = -sw_vel;
					}
					ctr++;
				}
			// Arthu stunned for a bit, shake screen, javiera faces in same dir as a+j
			} else if (ctr == 5) {
				if ( arthur.x < tl.x) {
					arthur.x = tl.x;
				} else if (arthur.x > tl.x + 112) {
					arthur.x = tl.x + 112;
				} else if (arthur.y > tl.y + 112) {
					arthur.y = tl.y + 112;
				} else if (arthur.y < tl.y) {
					arthur.y = tl.y;
				}
				Registry.sound_data.hitground1.play();
				arthur.play("stunned");
				FlxG.shake(0.03, 0.1);
				javiera.facing = facing;
				EventScripts.play_based_on_facing(javiera, "walk");
				ctr++;
			// Walk about until touching arthur and then freeze
			} else if (ctr == 6) {
				if (player.broom.visible) {
					if (!arthur.flickering && player.broom.overlaps(arthur)) {
						arthur.flicker(3);
					play_sfx(HURT_SOUND_NAME);
						health--;
					}
					if (!javiera.flickering && player.broom.overlaps(javiera)) {
						javiera.flicker(3);
					play_sfx(HURT_SOUND_NAME);
						health--;
					}
				}
				walk_about_perimeter(javiera, walk_vel * 1.3);
				if (player.state == player.S_GROUND) {
					if (player.overlaps(javiera) || player.overlaps(arthur)) {
						player.touchDamage(1);
					}
				}
				if (EventScripts.distance(javiera, arthur) < 12) {
					ctr++;
					javiera.velocity.x = javiera.velocity.y = 0;
					arthur.play("walk_d");
				}
			// Flash and then go to walk
			} else if (ctr == 7) {
				FlxG.flash(0xffffffff, 0.4);
				//flash
				x = javiera.x;
				y = javiera.y;
				javiera.exists = arthur.exists = false;
				visible = true;
				
				if (x < tl.x + 16) {
					facing = DOWN;
					play("walk_d");
				} else if (x > tl.x +105) {
					facing = UP;
					play("walk_u");
				} else if (y > tl.y +106) {
					facing = RIGHT;
					play("walk_r");
				} else {
					facing = LEFT;
					play("walk_l");
				}
				state = s_walk;
				ctr = 0;
				
			} 
			
		}
		
		
		private function dying_logic():void {
			
			if (ctr == 0) {
				Registry.volume_scale = 0;
				Registry.sound_data.stop_current_song();
				velocity.x = velocity.y = 0;
				play("dying");
				Registry.sound_data.sun_guy_death_s.play();
				FlxG.shake(0.04, 1.0);
				player.be_idle();
				
				DH.start_dialogue(DH.name_circus_folks, DH.scene_circus_folks_after_fight);
				ctr++;
			} else if (ctr == 1) {
				if (DH.scene_is_finished(DH.name_circus_folks,DH.scene_circus_folks_after_fight) && _curAnim.frames.length - 1 == _curFrame) {
					ctr++;
					visible = false;
					javiera.exists = arthur.exists = true;
					arthur.x = x; arthur.y = y;
					javiera.x = x; javiera.y = y - 16;
					
					arthur.parabola_thing = new Parabola_Thing(arthur, 24, 1.0, "offset", "y");
					javiera.parabola_thing = new Parabola_Thing(javiera, 18, 0.8, "offset", "y");
					arthur.frame = 1;
					javiera.frame = 1;
					tm_jump = 2;
					t_jump = 0;
					
				}
			} else if (ctr == 2) {
				// do something?
				var n:Number = Math.sin(t_jump * 6.28);
				arthur.offset.x = -3 * n;
				javiera.offset.x = 3 * n;
				t_jump += FlxG.elapsed;
				if (t_jump > tm_jump) {
					t_jump = 0;
					Registry.sound_data.floor_crack.play();
					ctr++;
					EventScripts.scale_vector(arthur, new Point(tl.x + 64, tl.y + 40), arthur.velocity, 40);
					EventScripts.scale_vector(javiera, new Point(tl.x + 36, tl.y + 50), javiera.velocity, 70);
				}
				
			} else if (ctr == 3) {
				if (arthur.parabola_thing.tick()) {
					arthur.velocity.x = arthur.velocity.y = 0;
					arthur.alpha -= 0.005;
					if (arthur._curAnim == null || arthur._curAnim.name != "fall") {
						arthur.play("fall");
					}
				}
				if (javiera.parabola_thing.tick()) {
					javiera.velocity.x = javiera.velocity.y = 0;
					javiera.alpha -= 0.005;
					if (javiera._curAnim == null || javiera._curAnim.name != "fall") {
						javiera.play("fall");
					}
				}
				if (javiera.alpha == 0 && arthur.alpha == 0) {
					ctr++; 	
					Registry.sound_data.wb_hit_ground.play();
					FlxG.flash(0xffff0000, 1);
				}
			} else if (ctr == 4) {
				t_jump += FlxG.elapsed;
				if (t_jump > 1.3) {
					ctr++;
				}
			} else {
					state = s_dead;
					Registry.volume_scale = 1;
					Registry.sound_data.start_song_from_title("CIRCUS");
					Registry.GRID_ENEMIES_DEAD++;
					Registry.GE_States[Registry.GE_Circus_Boss_Dead_Idx] = true;
					xml.@alive = "false";
					javiera.exists = arthur.exists = false;
			}
			 
			
		}
		
		private function dead_logic():void {
			exists = false;
		}
		
		private function hurt_logic():void {
			if (offset.y < 18) {
				if (!flickering && player.broom.visible && player.broom.overlaps(this)) {
					t_hurt = tm_hurt;
					play_sfx(HURT_SOUND_NAME);
					health--;
					if (health < 0 && state == s_throw) {
						health = 0;
					}
					flicker(1);
				}
			}
			
			/* Only go to dying when in the joint state */
			if (health <= 0 && visible) {
				ctr = 0;
				health = -1;
				state = s_dying;
			}
			
		}
		private function on_anim_change(name:String, _frame:int, _index:int):void {
			if (name == "walk_l" || name == "throw_l") {
				scale.x = -1;
			} else {
				scale.x = 1;
			}
			
		}
		
		// A shockwave travels around the perimeter until it hits another shockwave, or the player.
		private function shockwave_logic():void {
			
			if (state == s_dying || state == s_dead) {
				for each (var shockwave:FlxSprite in shockwaves.members) {
					if (shockwave._curAnim.name != "evaporate") {
						shockwave.play("evaporate");
						shockwave.velocity.x = shockwave.velocity.y = 0;
					} else {
						shockwave.alpha -= 0.1;
					}
				}
				return;
			}
			for each (var sw:FlxSprite in shockwaves.members) {
				if (sw == null || !sw.exists) continue;
				if (!sw.alive) {
					if (sw._curAnim.frames.length - 1 == sw._curFrame) {
						sw.exists = false;
						sw.alive = true;
						sw.play("move");
					}
					continue;
				}
				if (sw.x > tl.x + 114) {
					
					sw.x = tl.x + 112;
					sw.velocity.x = 0;
					sw.velocity.y = (sw.y > tl.y + 60) ?  -sw_vel : sw_vel;
				} else if (sw.x < tl.x) {
					sw.x = tl.x;
					sw.velocity.x = 0;
					sw.velocity.y = (sw.y > tl.y + 60) ? -sw_vel : sw_vel;
				} else if (sw.y > tl.y + 114) {
					sw.y = tl.y + 112;
					sw.velocity.y = 0;
					sw.velocity.x = (sw.x > tl.x + 60) ? -sw_vel : sw_vel;
				} else if (sw.y < tl.y) {
					sw.y = tl.y;
					sw.velocity.y = 0;
					sw.velocity.x = (sw.x > tl.x + 60) ? -sw_vel: sw_vel;
				}
				if (player.state != player.S_AIR && sw.overlaps(player)) {
					player.touchDamage(1);
					sw.alive = false;
					sw.play("evaporate");
					sw.velocity.x = sw.velocity.y = 0;
					
				}
				if (player.broom.visible && player.broom.overlaps(sw)) {
					sw.alive = false;
					sw.play("evaporate");
					sw.velocity.x = sw.velocity.y = 0;
				}
			}
		}
		
		private function load_javiera(javiera_ref:FlxSprite):void 
		{
			javiera_ref.loadGraphic(javiera_sprite, true, false, 16, 16);
			javiera_ref.addAnimation("walk_d", [0, 1], 8);
			javiera_ref.addAnimation("walk_l", [4, 5], 8);
			javiera_ref.addAnimation("walk_u", [2, 3], 8);
			javiera_ref.addAnimation("walk_r", [4, 5], 8);
			javiera_ref.addAnimation("juggle", [0, 1], 8);
			javiera_ref.addAnimation("fall", [6, 7, 8, 9, 10, 11, 12], 2, false); // Should end on an empty frame
			javiera_ref.play("juggle");
		}
		
		private function load_arthur(arthur_ref:FlxSprite):void 
		{
			arthur_ref.loadGraphic(arthur_sprite, true, false, 16, 16);
			arthur_ref.addAnimation("walk_d", [0, 1], 8);
			arthur_ref.addAnimation("walk_l", [4, 5], 8);
			arthur_ref.addAnimation("walk_u", [2, 3], 8);
			arthur_ref.addAnimation("walk_r", [4, 5], 8);
			arthur_ref.addAnimation("roll", [6], 6); // For flying through the air
			arthur_ref.addAnimation("stunned", [8, 9], 6);
			arthur_ref.addAnimation("wobble", [16,17], 8);
			arthur_ref.addAnimation("fall_1", [10], 8);
			arthur_ref.addAnimation("fall", [10, 11, 12, 13, 14, 15, 6], 2, false); // Should end on an empty frame
			arthur_ref.parabola_thing = new Parabola_Thing(this, 32, 1, "offset", "y");
			arthur_ref.parabola_thing.set_shadow_fall_animation("get_big");
			arthur_ref.my_shadow = EventScripts.make_shadow("8_small");
			arthur_ref.play("wobble");
		}
		
		private function walk_about_perimeter(s:FlxSprite,speed:int):void 
		{
			s.scale.x = 1;
			if (s.facing & LEFT) {
					s.scale.x = -1;
				s.velocity.x = -speed;
				if (s.x < tl.x) {
					s.x = tl.x;
					s.velocity.x = 0;
					s.velocity.y = speed;
					s.play("walk_d");
					s.facing = DOWN;
				}
			} else if (s.facing & RIGHT) {
				s.velocity.x = speed;
				if (s.x > tl.x + 112) {
					s.x = tl.x + 112;
					s.velocity.x = 0;
					s.velocity.y = -speed;
					s.play("walk_u");
					s.facing = UP;
				}
			} else if (s.facing & UP) {
				s.velocity.y = -speed;
				if (s.y < tl.y) {
					s.y = tl.y;
					s.velocity.y = 0;
					s.velocity.x = -speed;
					s.play("walk_l");
					s.facing = LEFT;
				}
			} else if (s.facing & DOWN) {
				s.velocity.y = speed;
				if (s.y > tl.y + 112) {
					s.y = tl.y + 112;
					s.velocity.y = 0;
					s.velocity.x = speed;
					s.play("walk_r");
					s.facing = RIGHT;
				}
			}
		}
		
		override public function destroy():void 
		{
			ARTHUR_INIT_PT = JAVIERA_INIT_PT = null;
			tl = null;
			if (light != null) {
				parent.sortables.remove(light, true);
			}
			if (TYPE == T_BOTH) {
				parent.sortables.remove(arthur, true);
				parent.sortables.remove(javiera, true);
				parent.sortables.remove(shockwaves, true);
				parent.sortables.remove(my_shadow, true);
				arthur.destroy(); javiera.destroy(); shockwaves.destroy();
				arthur = javiera = null;
				shockwaves = null;
			}
			super.destroy();
		}
	}
	

}