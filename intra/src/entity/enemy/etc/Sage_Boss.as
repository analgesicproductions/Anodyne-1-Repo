package entity.enemy.etc 
{
	import entity.gadget.Dust;
	import entity.interactive.npc.Sage;
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.AnoSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class Sage_Boss extends AnoSprite 
	{
		
		private const S_RESET:int = -1; //  going betwen substates of ACTIVE state
		private const S_WAITING:int = 0; // intro
		private const S_ACTIVE:int = 1; // fighting
		private const S_DYING:int = 2;
		private const S_DEAD:int = 3; 
		
		private var active_substate:int = 0;
		private var substate_ctr:int = 0;
		
		private var gt:Number = 0; // generic timer
		
		private var s_bullets:FlxGroup = new FlxGroup(6);
		private var l_bullets:FlxGroup = new FlxGroup(6);
		private var dusts:FlxGroup = new FlxGroup(2);
		
		private var do_s1_debug:Boolean = false;
		private var do_s2_debug:Boolean = false;
		private var do_s3_debug:Boolean = false;
		private var do_s4_debug:Boolean = false;
		
		[Embed(source = "../../../res/sprites/enemies/etc/sage_fight_long_dust.png")] public static var embed_long_dust:Class;
		[Embed(source = "../../../res/sprites/enemies/etc/sage_attacks.png")] public static var embed_sage_attacks:Class;
		[Embed(source="../../../res/sprites/enemies/etc/sage_fight_long_dust.png")] public static var embed_sage_long_attacks:Class;
		[Embed(source = "../../../res/sprites/enemies/etc/sage_boss.png")] public static var embed_sage_boss:Class;
		
		public function Sage_Boss(args:Array)
		{
			super(args);
			
			// MARINA_ANIMS
			loadGraphic(embed_sage_boss, true, false, 16, 24);
			addAnimation("a", [0, 4], 10, true);
			addAnimation("idle", [4]);
			addAnimation("idle_d", [0, 1, 2, 3], 5, true);
			addAnimation("dash_d",[0, 1, 2, 3], 5, true); 
			addAnimation("dash_u", [0, 1, 2, 3], 5, true);
			addAnimation("walk_u", [0, 1, 2, 3], 5, true);
			play("idle");
			width = height = 10;
			offset.x = offset.y = 3;
			offset.y = 8;
			
			x = tl.x + 72;
			x += 3; y += 3;
			
			// 16x16 dust-razors
			for (var i:int = 0; i < s_bullets.maxSize; i++) {
				var b:FlxSprite = new FlxSprite(0, 0);
				b.loadGraphic(embed_sage_attacks, true, false, 16, 16);
				b.addAnimation("spin", [0, 1], 24, true);
				b.addAnimation("poof", [0,1,2], 12, false);
				b.addAnimation("shoot", [4,5], 12);
				b.play("spin");
				b.width = b.height = 8;
				b.offset.x = b.offset.y = 4;
				
				s_bullets.add(b);
			}
			s_bullets.setAll("exists", false);
			parent.sortables.add(s_bullets);
			
			// 64x16 dust razors
			for (i = 0; i < l_bullets.maxSize; i++) {
				b = new FlxSprite(0, 0);
				b.loadGraphic(embed_sage_long_attacks, true, false, 64, 16);
				b.addAnimation("spin", [0,1], 24, true);
				b.addAnimation("poof", [0,1,2], 12, false);
				b.play("spin");
				b.width = 56; b.height = 10;
				b.offset.x = 4; b.offset.y = 3;
				
				l_bullets.add(b);
			}
			l_bullets.setAll("exists", false);
			parent.sortables.add(l_bullets);
			
			// Dusts
			for (i = 0; i < dusts.maxSize; i++) {
				var d:Dust = new Dust(0, 0, null, parent);
				dusts.add(d)
				d.y = tl.y + 8 * 16;
				if (i == 0) {
					d.x = tl.x + 48;
				} else {
					d.x = tl.x + 48 + 48;
				}
				
			}
			//parent.bg_sprites.add(dusts);
			
			//sfx
			add_sfx("warp_out", Registry.sound_data.teleguy_up);
			add_sfx("warp_in", Registry.sound_data.teleguy_down);
			add_sfx("hurt", Registry.sound_data.broom_hit);
			
			xml.@p = "2";
			// If we don't have all cards or are already dead don't show up.
			if (xml.@alive == "false") {
				exists = false;
			} else {
				state = S_WAITING;
			}
			
			
			if (Registry.FUCK_IT_MODE_ON) {
				exists = true;
			}
			
			
			// Debug flags, for skipping to certain stages of the fight
			//do_s2_debug = true;
			//do_s1_debug = true;
			//do_s3_debug = true;
			//do_s4_debug = true;
			if (do_s1_debug) {
				state = S_ACTIVE;
				substate_ctr = 0;
				active_substate = 1;
			} else if (do_s2_debug) {
				state = S_RESET;
				active_substate = 1;
				substate_ctr = 0;
			} else if (do_s3_debug) {
				state = S_RESET;
				active_substate = 2;
				substate_ctr = 0;
			} else if (do_s4_debug) {
				state = S_RESET;
				active_substate = 3;
				substate_ctr = 0;
			}
			
		}
		
		override public function destroy():void 
		{
			parent.sortables.remove(s_bullets,true);
			if (s_bullets != null) s_bullets.destroy();
			s_bullets = null;
			
			parent.sortables.remove(l_bullets,true);
			if (l_bullets != null) l_bullets.destroy();
			l_bullets = null;
			
			super.destroy();
		}
		override public function update():void 
		{
			if (state == S_WAITING) {
				// Idle around
				wait_state();
			} else if (state == S_ACTIVE) {
				active_state(); 
			} else if (state == S_DYING) {
				dying_state();
				// Exit speech, etc
			} else if (state == S_DEAD) {
				// Cleanup and modify global state.
				Registry.GE_States[Registry.GE_Sage_Dead_Idx] = true;
				xml.@alive = "false";
				exists = false;
				Registry.sound_data.start_song_from_title("TERMINAL");
				Registry.GRID_ENEMIES_DEAD++;
			} else if (state == S_RESET) {
				reset_state();
			}
			super.update();
		}
		
		// Logic for fight
		private function active_state():void {
			
			switch (active_substate) {
				case 1:
					stage_1();
					break;
				case 2:
					stage_2();
					break;
				case 3:
					stage_3();
					break;
				case 4:
					stage_4();
					break;
			}
			dust_routine(1);
		}
		
		
		// Intro stuff.
		private function wait_state():void {
			if (substate_ctr == 0) {
				facing = DOWN;
				play("idle");
				substate_ctr++;
				
				
			} else if (substate_ctr == 1) {
				Registry.volume_scale = (Registry.volume_scale > 0) ? Registry.volume_scale -= 0.01 : 0;
				if (Registry.volume_scale != 0) return;
				
				if (EventScripts.distance(this, player) < 32 && player.state == player.S_GROUND) {
					player.be_idle();
					player.state = player.S_INTERACT;
					
					DH.start_dialogue(DH.name_sage, DH.scene_sage_terminal_before_fight, Registry.CURRENT_MAP_NAME);
					
					Registry.sound_data.stop_current_song();
					
					substate_ctr++;
				}
			} else if (substate_ctr == 2) {
				if (DH.a_chunk_just_finished()) {
					substate_ctr++;
					play("idle_d");
					play_sfx("warp_out");
					alpha = 0;
					visible = false;
					x = tl.x + 80 - width / 2;
					y = tl.y + 24;
				}
			} else if (substate_ctr == 3) {
				// relaly bad timing hacks
				alpha += 0.008;
				if (alpha >= 0.4) {
					visible = true;
					if (alpha <= 0.43) {
						play_sfx("warp_in");
					}
					
					if (alpha == 1) {
						substate_ctr++;
						Registry.sound_data.start_song_from_title("SAGEFIGHT");
						Registry.volume_scale = 1;
						FlxG.flash(0xff000000, 2.18);
						FlxG.shake(0.02, 1.5);
					}
				}
			} else if (substate_ctr == 4) {
				alpha += 0.07;
				if (alpha >= 1) {
					
					substate_ctr++;
				}
			} else if (substate_ctr == 5) {
				
				gt += FlxG.elapsed;
				
				if (gt > 2.18) {
					gt = 0;
					FlxG.flash(0xff000000, 2.15);
					FlxG.shake(0.025, 1.5);
					substate_ctr++;
				}
			} else if (substate_ctr == 6) {
				gt += FlxG.elapsed;
				
				x = tl.x + 40 + 60 * Math.random();
				y = tl.y + 70 - 40 * Math.random();
				
				if (gt > 2.16) {
					gt = 0;
					FlxG.flash(0xff000000, 2.15);
					FlxG.shake(0.03, 1.5);
					x = player.x - 2;
					y = player.y - 16;
					substate_ctr++;
				}
				
			} else if (substate_ctr == 7) {
				gt += FlxG.elapsed;
				if (gt > 2.15) {
					gt = 0;
					
					x = tl.x + 80 - width / 2;
					y = tl.y + 25;
					
					FlxG.flash(0xff000000, 6);
					FlxG.shake(0.035, 1.7);
					substate_ctr++;
					alpha = 0;
				}
			} else if (substate_ctr == 8) {
				alpha += 0.005;
				if (alpha == 1) {
					substate_ctr++;
				}
			} else {
				state = S_ACTIVE;
				substate_ctr = 0;
				active_substate = 1;
			}
		}
		
		private const s1_vel:int = 50;
		private var t_s1:Number = 0;
		private var tm_s1:Array = new Array(1.6, 1.4, 1.2);
		private const s1_max_health:int = 3;
		private var s1_health:int = 3;
		
		/**
		 * Stage 1: Razors become large razors, sweep vertically, must jump forward to reach and hit sage
		 */
		private function stage_1():void {
			
			var b:FlxSprite;
			// Periodically shoot
			t_s1 += FlxG.elapsed;
			if (t_s1 > tm_s1[s1_max_health - s1_health]) {
				b = l_bullets.getFirstAvailable() as FlxSprite;
				if (b != null) {
					b.play("spin");
					b.exists = true;
					b.x = tl.x + 48 + (64 - b.width) / 2;
					b.y = tl.y + 20;
					b.velocity.y = s1_vel;
				}
				
				t_s1 = 0;
				
			}
			
			// Check to destroy some bullets
			// Dust or wall
			for each (b in l_bullets.members) {
				if (b != null && b.exists) {
					if (b.y > tl.y + 16 * 9) {
						if (b._curAnim.name != "poof") {
							b.play("poof");
						} else {
							if (b.finished) {
								b.exists = false;
								b.velocity.y = 0;
							}
						}
					}
				}
			}
			
			
			// Check to hurt player
			
			for each (b in l_bullets.members) {
				if (b != null && b.exists) {
					if (player.state == player.S_GROUND) {
						if (b.overlaps(player) && b._curAnim.name != "poof") {
							player.touchDamage(1);
						}
					}
					
					/*if (b.overlaps(dusts.members[0]) || b.overlaps(dusts.members[1])) {
						b.play("poof");
						b.exists = false;
						b.velocity.y = 0;
					}*/
				}
			}
			
			// Check if boss hurt
			if (!flickering && player.broom.visible && player.broom.overlaps(this)) {
				flicker(1);
				play_sfx("hurt");
				s1_health--;
			}
			
			
			if (s1_health <= 0) {
				l_bullets.setAll("x", -1000);
				state = S_RESET;
			}
		}
		
		
		/**
		 * Stage 2: Razors go to ends of bridge, sage dashes up and down with razors in front and back
		 */
		private const s2_max_health:int = 3;
		private var s2_health:int = 3;
		private var s2_dash_vel:Array = new Array(50, 70, 90);
		
		private var s2_d1:FlxSprite;
		private var s2_d2:FlxSprite;
		private var s2_set_vel:Boolean = false;
		
		private function stage_2():void {
			// Wait for sage to stop flickering
			if (substate_ctr == 0) {
				if (!flickering) {
					substate_ctr++;
				}
				return;
			// Make long dusts appear flicker for a bit
			} else if (substate_ctr == 1) {
				for (var i:int = 0; i < 2; i++) {
					var ld:FlxSprite = l_bullets.getFirstAvailable() as FlxSprite;
					ld.velocity.x = ld.velocity.y = 0;
					ld.exists = true;
					ld.play("spin");
					ld.x = tl.x + 48 + (64 - ld.width) / 2;
					if (i == 0) {
						ld.y = tl.y + 16 + (16 - ld.height) / 2;
					} else {
						ld.y = tl.y + 8 * 16 + (16 - ld.height) / 2;
					}
					ld.flicker(1);
				}
				substate_ctr ++ ;
				return;
			// Start fight when lds stop flickering
			} else if (substate_ctr == 2) {
				ld = l_bullets.getFirstExtant() as FlxSprite;
				if (!ld.flickering) {
					substate_ctr++;
					s2_d1 = s_bullets.getFirstAvailable() as FlxSprite;
					s2_d1.exists = true;
					s2_d2 = s_bullets.getFirstAvailable() as FlxSprite;
					s2_d2.exists = true;
				}
				velocity.x = 40;
				
				return;
			}
			
			// Snap dusts to sage
			s2_d1.x = x + (width - s2_d1.width) / 2;
			s2_d2.x = x + (width - s2_d2.width) / 2;
			
			s2_d1.y = y - 10;
			s2_d2.y = y + 12;
			
			// Dash up and down
			if (substate_ctr == 3) { // Down
				if (!s2_set_vel) {
					velocity.y = s2_dash_vel[s2_max_health - s2_health];
					s2_set_vel = true;
					play("dash_d");
				}
				if (y > tl.y + 16 * 8) {
					substate_ctr = 4;
					s2_set_vel = false;
				}
			} else if (substate_ctr == 4) {
				if (!s2_set_vel) {
					play("dash_u");
					velocity.y = -s2_dash_vel[s2_max_health - s2_health];
					s2_set_vel = true;
				}
				if (y < tl.y + 16) {
					substate_ctr = 3;
					s2_set_vel = false;
				}
			}
			
			if (velocity.x > 0) {
				if (x > tl.x + 16 * 7 - 4) {
					velocity.x = -40;
				}
			} else {
				if (x < tl.x + 48) {
					velocity.x = 40;
				}
			}
			
			hit_hurt_logic();
			
			// Check for phase change
			if (s2_health <= 0) {
				state = S_RESET;
				substate_ctr = 0;
				s2_d1 = null;
				s2_d2 = null;
			}
		}
		
		/**
		 * Stage 3: Stage 2 but with 4 things on sage (can still hit but harder!)
		 */
		
		private var s3_t:Number = 0;
		private var s3_dust_osc_t:Number = 0;
		
		private var s3_nr_dusts_made:int = 0;
		
		private var s3_d1:FlxSprite;
		private var s3_d2:FlxSprite;
		private var s3_d3:FlxSprite;
		private var s3_d4:FlxSprite;
		
		private var s3_health:int = 4;
		private var s3_set_vel:Boolean = false;
		private var s3_max_health:int = 4;
		
		private var s3_dash_vel:Array = new Array(80, 90, 100, 115);
		
		private function stage_3():void {
			
			// Move to top
			// Poof the 4 dusts in order
			// Start movin'
			switch (substate_ctr) {
				case 0:
					x = tl.x + 80 - width / 2;
					y = tl.y + 25;
					substate_ctr++;
					
					return;
				case 1:
					s3_t += FlxG.elapsed;
					if (s3_t > 1) {
						s3_t = 0;
						substate_ctr++;
						s_bullets.setAll("exists", false);
					}
					return;
				// Make the small bullets appear around sage slowly
				case 2:
					s3_t += FlxG.elapsed;
					if (s3_t > 0.8) {
						s3_t = 0;
						var d:FlxSprite = s_bullets.getFirstAvailable() as FlxSprite;
						d.exists = true;
						d.play("spin");
						Dust.dust_sound.play();
						switch (s3_nr_dusts_made) {
							case 0:
								s3_d1 = d;
								s3_d1.y = y - 10 - off;
								s3_d1.x = x + (width - s3_d1.width) / 2;
								break;
							case 1:
								s3_d2 = d;
								s3_d2.y = y + 12 + off;
								s3_d2.x = x + (width - s3_d2.width) / 2;
								break;
							case 2:
								s3_d3 = d;
								s3_d3.x = x - 12;
								s3_d3.y = y;
								break;
							case 3:
								s3_d4 = d;
								s3_d4.x = x + 14;
								s3_d4.y = y;
								break;
						}
						s3_nr_dusts_made++;
						if (s3_nr_dusts_made == 4) {
							substate_ctr++;
							velocity.x = 20;
						}
					}
					return;
			}
			
			if (substate_ctr == 3) { // Down
				if (!s3_set_vel) {
					velocity.y = s3_dash_vel[s3_max_health - s3_health];
					s3_set_vel = true;
					play("dash_d");
				}
				if (y > tl.y + 16 * 8) {
					substate_ctr = 4;
					s3_set_vel = false;
				}
			} else if (substate_ctr == 4) {
				if (!s3_set_vel) {
					play("dash_u");
					velocity.y = -s3_dash_vel[s3_max_health - s3_health];
					s3_set_vel = true;
				}
				if (y < tl.y + 16) {
					substate_ctr = 3;
					s3_set_vel = false;
				}
			}
			
			if (velocity.x > 0) {
				if (x > tl.x + 16 * 7 - 4) {
					velocity.x = -20;
				}
			} else {
				if (x < tl.x + 48) {
					velocity.x = 20;
				}
			}
			
			// Snap dusts to sage, but vary their distance with time
			s3_dust_osc_t += FlxG.elapsed;
			var r:Number;
			
			if (s3_dust_osc_t > 2) {
				s3_dust_osc_t = 0;
			}
			if (s3_dust_osc_t < 1) {
				r = s3_dust_osc_t;
			} else {
				r = 2 - s3_dust_osc_t;
			}
			var off:int = int(r * 34);
			s3_d1.x = x + (width - s3_d1.width) / 2;
			s3_d2.x = x + (width - s3_d2.width) / 2;
			s3_d3.x = x - 12 - off;
			s3_d4.x = x + 14 + off;
			
			s3_d1.y = y - 10 - off;
			s3_d2.y = y + 12 + off;
			s3_d3.y = y;
			s3_d4.y = y;
			
			hit_hurt_logic();
			
			if (s3_health <= 0) {
				state = S_RESET;
				substate_ctr = 0;
			}
			
		}
		
		/**
		 * Stage 4: Lots of small dusts thrown at you.
		 */
		private var s4_t:Number = 0;
		private var s4_tm:Number = 0.55;
		
		private var s4_health:int = 3;
		private var s4_health_max:int = 3;
		private var s4_vel:Array = new Array(50, 60, 70);
		
		private function stage_4():void {
			if (substate_ctr == 0) {
				play_sfx("warp_out");
				x = tl.x + 80 - width / 2;
				y = tl.y + 38;
				velocity.x = velocity.y = 0;
				substate_ctr++;
				return;
			} 
			
			var d:FlxSprite;
			
			s4_t += FlxG.elapsed;
			if (s4_t > s4_tm) {
				s4_t = 0;
				d = s_bullets.getFirstDead() as FlxSprite;
				if (d != null) {
					d.exists = d.alive = true;
					d.x = tl.x + 4 + 48 + 16 * (int (4 * Math.random()));
					d.y = tl.y + 16;
					d.velocity.y = s4_vel[s4_health_max - s4_health];
					d.play("shoot");
				}
			}
			
			for each (d in s_bullets.members) {
				var undo:Boolean = false;
				if (d != null && d.alive) {
					if (d.overlaps(player) && player.state != player.S_AIR) {
						undo = true;
						player.touchDamage(1);
					}
				//	if (d.overlaps(dusts)) {
					//	undo = true;
				//	}
					
					if (d.y > tl.y + 16 * 9) {
						undo = true;
					}
					
					if (undo) {
						d.play("poof");
						d.alive = false;
						d.velocity.x = d.velocity.y = 0;
						undo = false;
					}
				}
			}
			
			if (player.overlaps(this)) {
				player.touchDamage(1);
				
			}
			
			if (!flickering && player.broom.visible && player.broom.overlaps(this)) {
				flicker(2.5);
				play_sfx("hurt");
				s4_health--;
			
				
				/*dusts.members[0].x = tl.x + 48;
				dusts.members[1].x = tl.x + 48;
				dusts.members[0].y = tl.y + 16 * 7;
				dusts.members[1].y = tl.y + 16 * 7;
			*/
			}
			
			if (s4_health <= 0) {
				state = S_RESET;
				substate_ctr = 0;
			}
			
			
		}
		
		
		private function dying_state():void {
			switch (substate_ctr) {
				case 0:
					Registry.sound_data.stop_current_song();
					play("idle_d");
					DH.start_dialogue(DH.name_sage, DH.scene_sage_terminal_after_fight);
					substate_ctr++;
					break;
				case 1:
					if (DH.a_chunk_just_finished()) {
						DH.dont_need_recently_finished();
						substate_ctr = 2;
					}
					break;
				case 2:
					play("walk_u");
					player.state = player.S_INTERACT;
					velocity.y = -20;
					substate_ctr = 3;
					break;
				case 3:
					if (y + 16 < tl.y) {
						visible = false;
						substate_ctr = 4;
						player.state = player.S_GROUND;
					}
					break;
				case 4:
					state = S_DEAD;
					break;
			}
		}
		private function reset_state():void {
			var d:FlxSprite;
			switch (active_substate) {
				case 1:
					FlxG.flash(0xff000000, 1.0);
					play_sfx("warp_out");
					flicker(1.5);
					poof_big();
					state = S_ACTIVE;
					active_substate++;
					break;
				case 2:
					play_sfx("warp_out");
					flicker(1.5);
					state = S_ACTIVE;
					active_substate++;
					velocity.x = velocity.y = 0;
					poof_small();
					break;
				case 3:
					flicker(1.5);
					state = S_ACTIVE;
					active_substate++;
					velocity.x = velocity.y;
					poof_big();
					
					poof_small();
					break;
				case 4:
					poof_big();
					poof_small();
					state = S_DYING;
					break;
			}
		}
		/**
		 * Revives the dust every LATENCY seconds
		 * @param	latency 	When the dusts should revive when poofed.
		 */
		private var t_dust:Number = 0;
		private function dust_routine(latency:Number):void {
			
		/*	t_dust += FlxG.elapsed;
			if (t_dust > latency) {
				t_dust = 0;
				var d:Dust;
				for each (d in dusts.members) {
					if (d.fell_in_hole) {
						d.exists = true;
						d.fell_in_hole = false;
						d.play("unpoof");
						d.flicker(0.5);
						var idx:int = dusts.members.indexOf(d);
						d.y = tl.y + 8 * 16;
						if (idx == 0) {
							d.x = tl.x + 48;
						} else {
							d.x = tl.x + 48 + 48;
						}
					}
				}
			}*/
		}
		
		private function hit_hurt_logic():void 
		{
			//Check for player hitting sage
			if (!flickering && player.broom.visible && player.broom.overlaps(this)) {
				flicker(1);
				play_sfx("hurt");
				FlxG.flash(0xff000000, 0.4);
				if (active_substate == 2) {
					s2_health--;
				} else if (active_substate == 3) {
					s3_health--;
				}
			}
			
			
			// check for player getting hurt (Sage, sage dusts, long dusts)
			if (player.overlaps(this)) {
				player.touchDamage(1);
			}
			
			var s:FlxSprite;
			
			if (player.state == player.S_AIR) return;
			
			for each (s in s_bullets.members) {
				if (s != null && s.exists && s.visible) {
					if (s.overlaps(player)) {
						player.touchDamage(1);
					}
				}
			}
			
			for each (s in l_bullets.members) {
				if (s != null && s.exists) {
					if (s.overlaps(player) && s.visible) {
						player.touchDamage(1);
					}
				}
			}
		}
		
		private function poof_small():void 
		{
			var d:FlxSprite;
			for each (d in s_bullets.members) {
				if (d != null) {
					d.play("poof");
					d.alive = false;
				}
			}
		}
		
		private function poof_big():void 
		{
			var d:FlxSprite;
			for each (d in l_bullets.members) {
				if (d != null) {
					d.play("poof");
					d.alive = false;
				}
			}
		}
	}

}