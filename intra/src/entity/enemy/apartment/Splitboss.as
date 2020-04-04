package entity.enemy.apartment 
{
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class Splitboss extends FlxSprite
	{
		
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		private var added_to_parent:Boolean = false;
		private var white_overlay:FlxSprite;
		
		
		private var DETHBALLZ:FlxGroup = new FlxGroup(12);
		private var copies:FlxGroup = new FlxGroup(2);
		private var copy_1:FlxSprite;
		private var copy_2:FlxSprite;
		
		private var is_damaged:Boolean = false;
		private var t_damaged:Number = 0;
		private var tm_damaged:Number = 0.8;
		
		
		public var state:int = 0;
		private var s_dead:int = -2;
		private var s_dying:int = -1;
		private var s_intro:int = 0;
		
		private var s_dethballz:int = 1;
		private var s_dethballz_times_shot:int = 0;
		private var h_dethballz_counts:Array = new Array(2, 1, 4);
		private var h_dethballz_shots:Array = new Array(4, 10, 7);
		private var h_dethballz_timeouts:Array = new Array(0.7, 0.2, 0.8);
		private var t_dethballz:Number = 0;
		private var dethball_queue:Array = new Array();

		private var s_h_dash:int = 2;
		private var Y_OFF_R_DASH:int = 6;
		private var h_dash_vel:Array = new Array(80, 100, 120);
		private var h_dash_ball_vel:Array = new Array(80, 100, 120);
		private var h_dashes_done:int = 0;
		private var nr_dashes:Array = new Array(2, 3, 4);
		private var h_dash_ball_pos:Array = new Array(1, 4);
		private var t_h_dash:Number = 0;
		private var tm_h_dash:Number = 0.5;
		private var nr_dropped:int = 0;
		private var nr_to_drop:Array = new Array(2, 3, 4);
		private var next_drop:Number = 0;
		
		private var s_split:int = 3;
		private var t_split:Number = 0;
		private var split_vels:Array = new Array(40, 50, 60);
		
		
		public var phase:int = 0;
		
		
		private var MAX_HEALTH:int = 12;
		private var PHASE_2_HEALTH:int = 8;
		private var PHASE_3_HEALTH:int = 4;
		private var AREA_TILE_W:int = 6;
		private var AREA_TILE_H:int = 5;
		
		
		private var tl:Point = new Point(); //top left of movable area (2,2) in this case, relative to rooom
		public var ctr:int = 0;
		
		
		[Embed(source = "../../../res/sprites/enemies/apartment/splitboss.png")] public static var splitboss_sprite:Class;
		[Embed(source = "../../../res/sprites/enemies/apartment/splitboss_fireball.png")] public static var splitboss_fireball_sprite:Class;
		
		public function Splitboss(_xml:XML,_player:Player,_parent:*) 
		{
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			solid = false;
			solid = false;
			immovable = true;
			
			tl.x = 160 * Registry.CURRENT_GRID_X + 32;
			tl.y = 160 * Registry.CURRENT_GRID_Y + Registry.HEADER_HEIGHT + 48;
			
			health =  MAX_HEALTH + 1;
			
			/* Make bullets (shuriken)*/
			for (var i:int = 0; i < DETHBALLZ.maxSize; i++) {
				var DETHBALL:FlxSprite = new FlxSprite;
				DETHBALL.loadGraphic(splitboss_fireball_sprite, true, false, 16, 16);
				DETHBALL.height = DETHBALL.width = 6;
				DETHBALL.centerOffsets(true);
				DETHBALLZ.add(DETHBALL);
				DETHBALL.addAnimation("pulsate", [0, 1, 2, 3], 12); // IDLE
				DETHBALL.addAnimation("shoot", [0, 1, 2, 3], 12,true); // MOVING
				DETHBALL.addAnimation("fizzle", [4, 5, 6, 7], 12, false); //DISAPEPARING
			}
			DETHBALLZ.setAll("exists", false);
			
			/* Make sprite and copies */
			loadGraphic(splitboss_sprite, true, false, 24, 32);
			width -= 8;
			height -= 12;
			centerOffsets(true);
			
			addAnimation("float", [0, 1, 2, 1], 5); //facing downwards, idle
			addAnimation("idle_r", [4, 5, 6, 5], 5);
			addAnimation("dash_r", [10, 11], 8);
			addAnimation("dash_d", [8, 9], 8);
			addAnimation("die", [0, 3], 14);
			play("float");
			
			for (i = 0; i < copies.maxSize; i++) {
				var copy:FlxSprite = new FlxSprite(0, 0);
				copy.loadGraphic(splitboss_sprite, true, false, 24, 32);
				copy.width -= 8;
				copy.height -= 12;
				copy.centerOffsets(true);
					
				copy.addAnimation("float", [0, 1, 2, 1], 5);
				//copy.addAnimation("hurt", [0, 3], 14);
				copy.addAnimation("idle_r", [4, 5, 6, 5], 5);
				copy.addAnimation("dash_r", [10, 11], 8);
				copy.addAnimation("dash_d", [8, 9], 8);
				copy.play("float");
				copy.alpha = 0.5;
				copy.visible = false;
				copy.solid = false;
				copies.add(copy);
			}
			copy_1 = copies.members[0];

			copy_2 = copies.members[1];
			
			
			if (xml.@alive == "false") {
				Registry.GRID_ENEMIES_DEAD++;
				exists = false;
			} else {
				state = s_intro;
			}
			
			player.grid_entrance_x = tl.x + 42;
			player.grid_entrance_y = tl.y + 40;
			
			parent.bg_sprites.add(DETHBALLZ);
			
			FlxG.watch(this,"state", "state");
			FlxG.watch(this, "phase", "phase");
			FlxG.watch(this, "ctr", "ctr");
			
			add_sfx("split", Registry.sound_data.sb_split);
			add_sfx("hurt", Registry.sound_data.sb_hurt);
			add_sfx("dash", Registry.sound_data.sb_dash);
			add_sfx("shoot", Registry.sound_data.sb_ball_appear);
		}
		
		
		override public function update():void 
		{
			if (!added_to_parent) {
				added_to_parent = true;
				parent.sortables.add(copies);
				white_overlay = new FlxSprite(0, 0);
				white_overlay.scrollFactor = new FlxPoint(0, 0);
				white_overlay.makeGraphic(160, 160 + Registry.HEADER_HEIGHT, 0xffffffff);
				white_overlay.alpha = 0;
				white_overlay.x = white_overlay.y = 0;
				parent.fg_sprites.add(white_overlay);
			}
			
			if (!player.invincible && player.overlaps(this)) {
				if (state != s_dead && state != s_dying && state != s_intro && !(state == s_split && ctr == 0)) {
					player.touchDamage(1);
				}
			}
			
			/* Handle health and phase chanages */
			if (!is_damaged && player.broom.visible && player.broom.overlaps(this)) {
				if ((state == s_intro || state == s_split) && ctr < 5 ) {
					
				} else {
				health--;
				play_sfx("hurt");
				play_sfx(HURT_SOUND_NAME);
				is_damaged = true;
				t_damaged = 0;
				flicker(tm_damaged);
				if (health <= PHASE_2_HEALTH) {
					phase = 1;
				}
				if (health <= PHASE_3_HEALTH) {
					phase = 2;
				}
				if (state != s_dying && state != s_dead) {
					if (health <= 0) {
						state = s_dying;
						ctr = 0;
						t_split = 5.0;
					}
				}
				}
				
			} else {
				t_damaged += FlxG.elapsed;
				if (t_damaged > tm_damaged) {
					is_damaged = false;
				}
			}
			
			/* Determine behavior */
			if (state == s_dethballz) {
				do_h_dethballz();
			} else if (state == s_h_dash) {
				do_h_dash();
			} else if (state == s_split) {
				do_split();
			} else if (state == s_intro) {
				do_intro();
			} else if (state == s_dying) {
				
				if (ctr == 0) {
					DH.start_dialogue(DH.name_splitboss, DH.scene_splitboss_after_fight, "APARTMENT");
					ctr++;
					
				} else if (ctr == 1) {
					if (DH.a_chunk_just_finished()) {
						ctr++;
						Registry.sound_data.big_door_locked.play();
					}
				} else {
					Registry.volume_scale -= 0.005;
					flicker(0.1);
					play("die");
					var tm_split:Number = 5;
					t_split -= FlxG.elapsed;
					x = tl.x + 40;
					y = tl.y + 40;
					var r:Number = -65 * (1 - (t_split /tm_split));
					x += (r + Math.random() * -2 * r);
					y += (r + Math.random() * -2 * r);
					
					white_overlay.alpha = (1 - (t_split / tm_split));
					for each (var dethball:FlxSprite in DETHBALLZ.members) {
						if (dethball == null) continue;
						dethball.alpha -= 0.05;
					}
					copy_1.alpha -= 0.1;
					copy_2.alpha -= 0.1;
					
					if (t_split < 0) {
						state = s_dead;
						Registry.sound_data.stop_current_song();
						Registry.volume_scale = 1;
						
						//
						Registry.sound_data.start_song_from_title("APARTMENT");
						Registry.GRID_ENEMIES_DEAD++;
						Registry.GE_States[Registry.GE_Apartment_Boss_Dead_Idx] = true;
						visible = false;
						xml.@alive = "false";
						
					}
				}
			} else if (state == s_dead) {
				white_overlay.alpha -= 0.05;
				if (white_overlay.alpha == 0) {
					exists = false;
				}
			}
			
			super.update();
		}
		
		private function do_h_dash():void {
		
			var DETHBALL:FlxSprite;
			if (ctr == 0) {
				play("idle_r");
				offset.y = Y_OFF_R_DASH;
				alpha -= 0.1;
				if (alpha == 0) {
					x = tl.x - 32;
					y = player.y;
					velocity.x = 0;
					ctr = 1;
				}
			} else if (ctr == 1) {
				alpha += 0.15;
				y = player.y;
				if (alpha == 1) {
					t_h_dash += FlxG.elapsed; // y-track the player as  a warning
					if (t_h_dash > tm_h_dash) {
						t_h_dash = 0;
						ctr = 2;
						play("dash_r");
						play_sfx("dash");
						velocity.x = h_dash_vel[phase];
						next_drop = tl.x + 16 * Math.random();
					}
				}
			} else if (ctr == 2) {
				
				offset.y = player.offset.y - player.DEFAULT_Y_OFFSET + Y_OFF_R_DASH;
				if (nr_dropped < nr_to_drop[phase]) { //drop a ball when needed.
					if (x > next_drop && (x > tl.x && x < tl.x + 96)) {
						DETHBALL = DETHBALLZ.getFirstAvailable() as FlxSprite;
						if (DETHBALL != null) { //set next drop point.
							next_drop = x + 16 + 16 * Math.random();
							DETHBALL.exists = true;
							play_sfx("shoot");
							DETHBALL.play("pulsate");
							DETHBALL.x = x;
							DETHBALL.y = y;
							nr_dropped ++;
						}
					}
				}
				
				if (x > tl.x + 16*8) { //when far enough, dash aagain, or state change
					alpha -= 0.1;
					if (alpha == 0) {
						nr_dropped = 0;
						h_dashes_done++;
						if (h_dashes_done >= nr_dashes[phase]) {
							ctr = 3;
							h_dashes_done = 0;
							for each (DETHBALL in DETHBALLZ.members) {
								if (DETHBALL.exists) {
									DETHBALL.play("shoot");
								}
							}
						} else {
							ctr = 0;
						}
					}
				}
				for each (DETHBALL in DETHBALLZ.members) {
					DETHBALL.flicker(0.05);
				}

			} else if (ctr == 3) {
				t_h_dash += FlxG.elapsed;
				if (t_h_dash < tm_h_dash) return; //wait a bit as a warning for the balls
				
				var pt:Point = new Point;
				var p_pt:Point = new Point;
				for each (DETHBALL in DETHBALLZ.members) { //set destinations for the balls
					if (DETHBALL != null && DETHBALL.exists) {
						pt.x = DETHBALL.x;
						pt.y = DETHBALL.y;
						p_pt.x = player.x - 10 + 20 * Math.random();
						p_pt.y = player.y - 10 + 20 * Math.random();
						EventScripts.scale_vector(pt, p_pt, DETHBALL.velocity, h_dash_ball_vel[phase]);
					}
					
				}
				play_sfx("split");
				ctr = 4;
			} else if (ctr == 4) {
				for each (DETHBALL in DETHBALLZ.members) { //balls acan now daamage player on the ground
					if (DETHBALL != null && DETHBALL.exists) {
						if (!player.invincible && player.state == player.S_GROUND && player.overlaps(DETHBALL)) {
							player.touchDamage(1);
							DETHBALL.exists = false;
						}
						DETHBALL.alpha -= 0.005;
						if (DETHBALL.alpha == 0) {
							for each (DETHBALL in DETHBALLZ.members) {
								DETHBALL.exists = false;
								DETHBALL.alpha = 1;
								DETHBALL.velocity.x = DETHBALL.velocity.y = 0;
							}
							alpha = 1;
							ctr = 5;
						}
					} 
				}
			} else if (ctr == 5) {
				velocity.x = 0;
				centerOffsets(true);
				var r:Number = Math.random();
				if (r > 0.6) {
					state = s_dethballz;
				} else if (r > 0.3) {
					state = s_split;
				} else {
					state = s_h_dash;
				}
				ctr = 0;
			}
		}
		private function do_h_dethballz():void {
			var iter:int = 0;
			var len:int = 0;
			var DETHBALL:FlxSprite;
			
			/***********/
			/*H_DETHBALLZ*/
			/***********/
			if (ctr == 0) {
				play("float");
				velocity.x = 0;
				x = tl.x + 40;
				y = tl.y - 32;
				/* Set number of balls to appear, and their positions.*/
				var tx:int = int(6 * Math.random());
				play_sfx("shoot");
				for (iter = 0; iter < h_dethballz_counts[phase]; iter++) {
					DETHBALL = DETHBALLZ.getFirstAvailable() as FlxSprite;
					if (DETHBALL == null) break;
					DETHBALL.exists = true;
					DETHBALL.play("pulsate");
					DETHBALL.y = tl.y - DETHBALL.height;
					DETHBALL.x = tl.x + ((16 - DETHBALL.width) / 2) + ((tx + 1 * iter) % 6) * 16;
					dethball_queue.push(DETHBALL);
				}
				ctr = 1;
			/* After a charge period, move the balls. */
			} else if (ctr == 1) {
				t_dethballz += FlxG.elapsed;
				if (t_dethballz > h_dethballz_timeouts[phase]) {
					//sfx pew pew
					len = dethball_queue.length;
					for (iter = 0; iter < len; iter++) {
						DETHBALL = dethball_queue.pop();
						DETHBALL.velocity.y = 40;
						DETHBALL.play("shoot", true);
					}
					/* Loop back to ball-spawn unless we've shot enough times. */
					ctr = 0;
					t_dethballz = 0;
					s_dethballz_times_shot++;
					if (s_dethballz_times_shot >= h_dethballz_shots[phase]) {
						ctr = 2;
						s_dethballz_times_shot = 0;
					}
				}
			} else if (ctr == 2) {
				if (DETHBALLZ.countExisting() == 0) {
					ctr = 0;
					var r:Number = Math.random();
					if (r > 0.63) {
						state = s_h_dash;
					} else if (r > 0.38) {
						state = s_dethballz; 
					} else {
						state = s_split;
					}
				}
			}
			
			/* Boilerplate overlap with player code. */
			if (!player.invincible && player.state != player.S_AIR) {
				for each (DETHBALL in DETHBALLZ.members) {
					if (DETHBALL != null && DETHBALL.exists) {
						if (DETHBALL._curAnim.name == "fizzle" && (DETHBALL._curFrame == DETHBALL._curAnim.frames.length - 1)) {
							DETHBALL.exists = false;
							DETHBALL.velocity.y = 0;
						}
						if (!player.invincible && player.overlaps(DETHBALL) ) {
							player.touchDamage(1);
							//sfx fizzle
							DETHBALL.play("fizzle");
						}
						if (DETHBALL.y > tl.y + AREA_TILE_H * 16) {
							Registry.sound_data.play_sound_group(Registry.sound_data.fireball_group);
							DETHBALL.play("fizzle");
						}
					}
				}
			}
		}
		
		private function do_split():void {
			if (ctr == 0) { // move to top of playing area and flicker
				centerOffsets(true);
				play("float");
				x = tl.x + 40;
				y = tl.y - 16;
				ctr++;
				flicker(1.5);
				visible = true;
				
			} else if (ctr == 1) { //when hit, split into three
				if (player.broom.visible && player.broom.overlaps(this)) {
					play_sfx("split");
					alpha = copy_1.alpha = copy_2.alpha = 1;
					copy_1.x = copy_2.x = x;
					copy_1.y = copy_2.y = y;
					velocity.y = -40;
					copy_1.visible = copy_2.visible = true;
					copy_1.velocity.x = -40; // copy 1 faces left
					copy_2.velocity.x = 40; // copy 2 faces right
					copy_1.play("idle_r"); copy_1.scale.x = -1;
					copy_2.play("idle_r"); 
					copy_1.offset.y = copy_2.offset.y = Y_OFF_R_DASH;
					ctr++;
				}
			} else if (ctr == 2) { //fade out while moving
				alpha -= 0.02;
				copy_1.alpha = copy_2.alpha = alpha;
				if (alpha == 0) {
					copy_1.velocity.x = copy_2.velocity.x = velocity.x = 0;
					copy_1.velocity.y = copy_2.velocity.y = velocity.y = 0;
					ctr++;
					alpha = copy_1.alpha = copy_2.alpha = 0.7;
					t_split = 1.0;
				}
			} else if (ctr == 3) { //pin to the player and successively dash
				x = player.x; y = player.y - 24;
				t_split -= FlxG.elapsed;
				if (t_split < 0) { //flicker for a bit before dashing
					copy_1.flicker(0.2);
					copy_2.flicker(0.2);
					if (t_split < -0.7) {
						ctr++;
						copy_1.play("dash_r");
						copy_2.play("dash_r");
					}
				} else {
					copy_1.x = player.x + 25; copy_1.y = player.y;
					copy_2.x = player.x - 25; copy_2.y = player.y;
				}
			} else if (ctr == 4) { //dash the copies horizontally
				copy_1.velocity.x = -split_vels[phase];
				copy_2.velocity.x = split_vels[phase];
				play_sfx("dash");
				if (player.overlaps(copy_1) || player.overlaps(copy_2)) {
					player.touchDamage(1);
				}
				x = player.x; y = player.y - 24;
				copy_1.alpha -= 0.02;
				copy_2.alpha = copy_1.alpha;
				if (copy_1.alpha == 0) { // give a warning for the boss
					ctr++;
					copy_1.velocity.x = copy_2.velocity.x = 0;
					flicker(1);
				}
				
			} else if (ctr == 5) { // when warning done, dash
				if (!flickering) {
					play_sfx("dash");
					play("dash_d");
					velocity.y = split_vels[phase];
					alpha -= 0.02;
					if (alpha == 0) {
						alpha = 1;
						ctr++;
						velocity.y = 0;
					}
				}
			} else if (ctr == 6) { //determine next attack
				play("float");
				var r:Number = Math.random();
				ctr = 0;
				if (phase <= 1) {
					if (r <= 0.3) {
						state = s_h_dash;
					} else if (r <= 0.7) {
						state = s_dethballz;
					} else {
						state = s_split;
					}
				} else {
					if (r <= 0.5) {
						state = s_h_dash;
					} else if (r <= 0.75) {
						state = s_dethballz;
					} else {
						state = s_split;
					}
				}
			}
			return;
		}
		
		
		private function do_intro():void {
			var sub_ctr:int = 0;
			if (ctr == 0) {
				x = tl.x + 48 - (width / 2);
				y = tl.y + 32;
				Registry.volume_scale -= 0.005;
				if (player.broom.visible && player.broom.overlaps(this)) {
					ctr = 1;
					DH.start_dialogue(DH.name_splitboss, DH.scene_splitboss_before_fight, "APARTMENT");
				}
			} else if (ctr == 1) {
			
				if (DH.a_chunk_just_finished()) {
					play_sfx("split");
					Registry.volume_scale = 1;
					Registry.sound_data.start_song_from_title("BOSS");
					visible = false;
					copy_1.visible = true;
					copy_2.visible = true;
					copy_1.x = copy_2.x = x;
					copy_1.y = copy_2.y = y;
					copy_1.velocity.x = -50;
					copy_2.velocity.x = 50;
					ctr = 2;
				} 
			} else if (ctr == 2) {
				copy_1.alpha -= 0.01;
				copy_2.alpha -= 0.01;
				if (copy_1.alpha == 0 && copy_2.alpha == 0) {
					ctr = 3;
					alpha = 0;
					copy_1.y = y = copy_2.y = tl.y - 32;
					copy_1.x = x - 40;
					copy_2.x = x + 40;
					copy_1.velocity.x = copy_2.velocity.x = 0;
					visible = true;
				}
			} else if (ctr == 3) {
				alpha += 0.01;
				copy_1.alpha = copy_2.alpha = alpha;
				if (alpha == 1) {
					ctr = 4;
				}
			} else if (ctr == 4) {
				copy_1.flicker(0.5); copy_2.flicker(0.5); flicker(0.5);
				if (EventScripts.send_property_to(copy_1, "x", x, 0.5)) sub_ctr++;
				if (EventScripts.send_property_to(copy_2, "x", x, 0.5)) sub_ctr++;
				if (sub_ctr == 2) {
					ctr = 5;
					copy_1.visible = copy_2.visible = false;
				}
			} else {
				ctr = 0;
				visible = true;
				state = s_dethballz;
			}
		}
		
		override public function destroy():void 
		{	
			DH.dont_need_recently_finished();
			parent.sortables.remove(copies, true);
			super.destroy();
		}
		
		}

}