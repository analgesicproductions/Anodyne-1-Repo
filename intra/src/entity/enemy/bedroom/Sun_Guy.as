package entity.enemy.bedroom 
{
	import data.CLASS_ID;
	import data.SoundData;
	import entity.decoration.Light;
	import entity.gadget.Dust;
	import entity.player.Player;
	import helper.Achievements;
	import helper.Cutscene;
	import helper.DH;
	import org.flixel.*;
	import global.Registry;
	import helper.EventScripts;
	import flash.geom.Point;
	import states.PlayState;
	
	
	public class Sun_Guy extends FlxSprite
	{
		
		/*intro: statue, darkened room, rays of light rotate out of eyes
		 * then whole room gets lit?
		 * 
		 * floats, moves horizontally, usually has a force field
		 * shoots lasers across the screen, you must push dust to block them
		 * these comes from two orbs
		 * can only hit him when the orbs are not circling
		 * can attack the orbs too
		 * */
		public var xml:XML;
		
		/* state vars */
		protected var times_hurt_player:int = 0;
		protected var S_INTRO_1:int = 0;
		protected var S_INTRO_2:int = 6;
		protected var S_INTRO_0:int = 7;
		protected var S_HORIZONTAL_FLOAT:int = 1;
		private var HF_1:Boolean = false;
		private var VF_1:Boolean = false;
		protected var S_CHARGE:int = 2;
		protected var S_CHARGE_CTR:int = 0;
		protected var S_FIRE_LASER:int = 3;
		protected var S_DYING:int = 4;
		protected var S_DYING_CTR:int = 0;
		protected var S_DEAD:int  = 5;
		protected var S_VERTIFLOAT:int = 8;
		protected var S_VERTIFLOAT_CTR:int = 0;
	
		protected var STATE:int;
		private var INCREMENTED_REGISTRY:Boolean = false;
		
		public var just_got_hurt:Boolean = false;
		public var hit_timer:Number = 1;
		public var HIT_TIMER_MAX:Number = 1.5;
		
		/* other stuff */
		public var dusts:FlxGroup = new FlxGroup(3);
		private var dusts_poofed:Boolean = false;
		/* Lighting for intro */
		private var light_cone_1:Light;
		private var light_cone_2:Light;
		
		/* entities for dying outr o */
		private var white_overlay:FlxSprite = new FlxSprite(0, 0);
		/* Circular protective orbs */
		private var light_orb_1:FlxSprite;
		private var light_orb_2:FlxSprite;
		private var orb_illum_1:Light;
		private var orb_illum_2:Light;
		private var sun_guy_wave:FlxSprite;
		private var sun_wave_evaporating:Boolean = false;
		
		/* Radii of circulation, rotation velocity (degrees/tick), angle about boss */
		public var lr_1:Number = 16;
		public var lr_2:Number = 32;
		public var rv_1:Number = 0.05;
		public var rv_2:Number = 0.04;
		private var a_1:Number = 0;
		private var a_2:Number = 0;
		
		private var MAX_HEALTH:int = 7; //health of boss
		private var center_pt:FlxPoint = new FlxPoint(0, 0); //used for rotations
		
		/* References we need for events/lighting */
		private var player:Player;
		private var darkness:FlxSprite;
		private var parent:PlayState;
		
		private var y_timer:Number = 0; //For y-oscillations
		private var stopped_song:Boolean = false; 
		private var started_song:Boolean = false;
		private var base_pt:Point; //Spawn point of the boss
		
		[Embed (source = "../../../res/sprites/enemies/sun_guy.png")] public static var C_SUN_GUY:Class;
		[Embed (source = "../../../res/sprites/enemies/light_orb.png")] public static var C_LIGHT_ORB:Class;
		[Embed (source = "../../../res/sprites/enemies/sun_guy_wave.png")] public static var C_SUN_GUY_WAVE:Class;
		
		
		private var DEAD_FRAME:int = 4;
		public var cid:int = CLASS_ID.SUN_GUY;
		
		public function Sun_Guy(_x:int,_y:int,_darkness:FlxSprite,_parent:PlayState,_xml:XML,_player:Player)
		{
			super(_x, _y);
			base_pt = new Point(_x, _y);
			xml = _xml;
			health = MAX_HEALTH;
			player = _player;
			darkness = _darkness;
			immovable = true;
			parent = _parent;
			if (Registry.FUCK_IT_MODE_ON) {
				MAX_HEALTH = 1;
				xml.@alive = "false";
			}
			if (xml.@alive == "false") {
				STATE = S_DEAD;
			} else {
				STATE = S_INTRO_0;
			}
			
			/* Animations for boss */
			loadGraphic(C_SUN_GUY, true, false, 16, 24);
			addAnimation("foo", [0, 1, 2, 3, 4], 3);
			addAnimation("death_fade", [12, 13, 14, 15, 16, 17, 18,19], 6,false);
			play("foo");
			if (STATE == S_DEAD) frame = DEAD_FRAME;
			
			
			light_cone_1 = new Light(x - 12, y- 32, darkness, Light.T_CONE_LIGHT, false);
			light_cone_2 = new Light(x - 6, y - 32, darkness, Light.T_CONE_LIGHT, false);
			
			/* ANIMS FOR ORBS */
			light_orb_1 = new FlxSprite(x -  16, y);
			light_orb_2 = new FlxSprite(x +  32, y);
			
			light_orb_1.addAnimation("glow", [0, 1, 2, 3, 4/*, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12*/], 10, true);
			light_orb_2.addAnimation("glow", [2, 3, 4, 0, 1/*6, 7, 8, 9, 10, 11, 12, 0, 1, 2, 3, 4, 5*/], 10, true);
			light_orb_1.play("glow");
			light_orb_2.play("glow");
			
			light_orb_1.loadGraphic(C_LIGHT_ORB, true, false, 16, 16);
			light_orb_2.loadGraphic(C_LIGHT_ORB, true, false, 16, 16);
			light_orb_1.width = light_orb_1.height = light_orb_2.height = light_orb_2.width = 12;
			light_orb_1.offset.x = light_orb_1.offset.y = 2;
			light_orb_2.offset.x = light_orb_2.offset.y = 2;
			orb_illum_1 = new Light(x, y, darkness, Light.T_FIVE_FRAME_GLOW, true, light_orb_1, 5, Light.L_SUN_GUY_ORBS);
			orb_illum_2 = new Light(x, y, darkness, Light.T_FIVE_FRAME_GLOW, true, light_orb_2, 5, Light.L_SUN_GUY_ORBS);
			orb_illum_1.base_x_scale = orb_illum_1.base_y_scale = orb_illum_2.base_y_scale = orb_illum_2.base_x_scale = 0.8;
			orb_illum_1.addAnimation("flicker", [0, 1, 2, 3, 4,3,2,1], 6, true);
			orb_illum_2.addAnimation("flicker", [0, 1, 2, 3, 4,3,2,1], 6, true);
			orb_illum_1.play("flicker");
			orb_illum_2.play("flicker");
			
			/* BIG WAVE ANIMS */
			sun_guy_wave = new FlxSprite(base_pt.x - 50, base_pt.y +8);
			
			sun_guy_wave.loadGraphic(C_SUN_GUY_WAVE, true, false, 128, 8);
			sun_guy_wave.addAnimation("play", [3, 4, 5], 8, true);
			sun_guy_wave.addAnimation("evaporate", [2, 1, 0], 8, false);
			sun_guy_wave.play("play");
			parent.add(sun_guy_wave);
			sun_guy_wave.visible = false;
			
			for (var i:int = 0; i < 3; i++) {
				var dust:Dust = new Dust(0, 0, null,parent);
				dust.exists = false;
				dusts.add(dust);
				parent.bg_sprites.add(dusts);
				
			}
			
			light_orb_1.visible = light_orb_2.visible = false;
			orb_illum_1.visible = orb_illum_2.visible = false;
			parent.add(light_cone_1);
			parent.add(light_cone_2);
			parent.add(light_orb_1);
			parent.add(light_orb_2);
			parent.add(orb_illum_1);
			parent.add(orb_illum_2);
			alpha = light_cone_1.alpha = light_cone_2.alpha = 0;
			
			/* White overlay */
			white_overlay.makeGraphic(160, 180, 0xffffffff);
			white_overlay.scrollFactor = new FlxPoint(0, 0);
			parent.add(white_overlay);
			white_overlay.visible = false;
			
		
			Registry.EVENT_CHANGE_DARKNESS_ALPHA = false;
		}
		
		override public function update():void {
			
			if (player.health_bar.cur_health <= 0) {
				light_orb_1.alpha -= 0.05;
				light_orb_2.alpha = sun_guy_wave.alpha = light_orb_1.alpha;
				dusts.setAll("visible", false);
			}
			
			if (player.broom.overlaps(this)) {
				 if (player.broom.visible)  {
					hit("broom", player.broom.root.facing);
				 }
			}
			
			
			if (just_got_hurt) {
				hit_timer -= FlxG.elapsed;
				if (hit_timer < 0) { 
					hit_timer = HIT_TIMER_MAX;
					just_got_hurt = false;
				}
				if (health == 0) {
					STATE = S_DYING;
					light_cone_2.base_x_scale = light_cone_2.base_y_scale = 1;
					light_cone_2.x = x -8; 
					light_cone_2.y = y - 24;
					parent.remove(white_overlay, true);
					parent.add(white_overlay);
					play("death_fade");
					health = -1;
					Registry.sound_data.stop_current_song();
					Registry.sound_data.sun_guy_death_s.play();
					FlxG.shake(0.01,1);
				}
			}
			switch (STATE) {
				case S_INTRO_0:
					intro_state_0();
					break;
				case S_INTRO_1:
					intro_state_1();
					break;
				case S_INTRO_2:
					intro_state_2();
					break;
				case S_HORIZONTAL_FLOAT:
					horizontal_float_state();
					break;
				case S_VERTIFLOAT:
					vertifloat_state();
					break;
				case S_DYING:
					dying_state();
					break;
				case S_DEAD:
					dead_state();
					break;
				case S_CHARGE:
					charge_state();
					break;
			}
			super.update();
		}
		
		private function intro_state_0():void {
			
			if (Registry.sound_data.sun_guy_scream.playing) {
				Registry.sound_data.sun_guy_scream = new FlxSound();
				Registry.sound_data.sun_guy_scream.loadEmbedded(SoundData.S_SUN_GUY_SCREAM);
				
			}
			if (!stopped_song) {
				stopped_song = true;
				Registry.sound_data.stop_current_song();
			}
			EventScripts.send_alpha_to(darkness, 0.9, 0.006);
			
			EventScripts.send_property_to(player.light, "base_x_scale", 1.7, -0.02);
			EventScripts.send_property_to(player.light, "base_y_scale", 1.7, -0.02);
			if ((player.y - y) < 48) {
				
				if (!started_song) {
					started_song = true;
					DH.start_dialogue(DH.name_sun_guy, DH.scene_sun_guy_before_fight);
				}
				player.dontMove = true;
				EventScripts.send_alpha_to(light_cone_1, 1.0, 0.01);
				EventScripts.send_alpha_to(light_cone_2, 1.0, 0.01);
				EventScripts.send_alpha_to(this, 1.0, 0.007);
				if (DH.a_chunk_just_finished()) {
					Registry.sound_data.start_song_from_title("BOSS");
					STATE = S_INTRO_1;
					player.dontMove = false;
				}
			}
		}
		
		private function intro_state_1():void {
			EventScripts.send_alpha_to(darkness, 0.1, -0.02);
			EventScripts.send_property_to(light_cone_1, "base_x_scale", 3, 0.01);
			EventScripts.send_property_to(light_cone_2, "base_x_scale", 3, 0.01);
			if (EventScripts.send_property_to(light_cone_1, "base_y_scale", 3, 0.02) || 
			EventScripts.send_property_to(light_cone_2, "base_y_scale", 3, 0.02)) {
				STATE = S_INTRO_2;
			}
			FlxG.shake(0.01,1);
			EventScripts.send_property_to(player.light, "base_x_scale", 1.0, -0.02);
			EventScripts.send_property_to(player.light, "base_y_scale", 1.0, -0.02);
			
			FlxG.collide(player, this);
		}
		
		private function intro_state_2():void {
			if (EventScripts.send_property_to(light_cone_1, "angle", 180, 5)) {
				if (EventScripts.send_property_to(light_cone_1, "base_x_scale", 5, 0.3)) {
					STATE = S_HORIZONTAL_FLOAT;
					light_orb_1.visible = light_orb_2.visible = true;
					orb_illum_1.visible = orb_illum_2.visible = true;
				}
			}
			FlxG.collide(player, this);
		}
		private function horizontal_float_state():void {
			/* Oscillate boss */
			y_timer += FlxG.elapsed;
			y = base_pt.y + 10 * Math.sin(y_timer);
			/* Move left and right */
			
			move_horizontally();
			
			/* Rotate orbs around boss */
			
			rotate_orbs_about_sun_guy();
			
			
			
			
			/* Touch damage with player */
			if (FlxG.collide(player, this) || FlxG.overlap(player, light_orb_1) || FlxG.overlap(player, light_orb_2)) {
				player.touchDamage(1);
				times_hurt_player++;
			}
			
			if (health <= 6) {
				STATE = S_VERTIFLOAT;
			}
		}
		
		private function dying_state():void {
			velocity.x = velocity.y = 0;
			alpha -= 0.05;
			switch (S_DYING_CTR) {
				case 0:
					// Get dark, then show dialogue
					if (times_hurt_player == 0) {
						times_hurt_player = 1;
						Achievements.unlock(Achievements.No_damage_sunguy);
					}
					if (EventScripts.send_alpha_to(darkness, 1, 0.01)) {
						if (!DH.scene_is_dirty(DH.name_sun_guy,DH.scene_sun_guy_after_fight)) {
							DH.start_dialogue(DH.name_sun_guy, DH.scene_sun_guy_after_fight);
						}
					}
					
					// Fade out other objects
					EventScripts.send_alpha_to(orb_illum_1, 0, -0.01);
					EventScripts.send_alpha_to(orb_illum_2, 0, -0.01);
					EventScripts.send_alpha_to(light_orb_1, 0, -0.01);
					EventScripts.send_alpha_to(light_orb_2, 0, -0.01);
					EventScripts.send_alpha_to(light_cone_1, 0, -0.02);
					EventScripts.send_alpha_to(sun_guy_wave, 0, -0.03);
					
					// When dialogue's finihsed, do the flashes etc.
					if (DH.scene_is_finished(DH.name_sun_guy,DH.scene_sun_guy_after_fight)) {
			
						if (!white_overlay.visible) {
							FlxG.shake(0.01,1);
							Registry.sound_data.sun_guy_death_s.play();
							white_overlay.visible = true;
						}
						if (EventScripts.send_alpha_to(white_overlay, 0, -0.007)) {
								FlxG.shake(0.01,1);
								Registry.sound_data.sun_guy_death_s.play();
								white_overlay.alpha = 1;
								frame++;
								S_DYING_CTR++;
						}
					}
					break;
				case 1:
					if (EventScripts.send_alpha_to(white_overlay, 0, -0.007)) {
						S_DYING_CTR++;
						frame++; 
						FlxG.shake(0.01,1);
						Registry.sound_data.sun_guy_death_s.play();
						white_overlay.alpha = 1;
					}
					break;
				case 2:
					if (EventScripts.send_alpha_to(white_overlay, 0, -0.007)) {
						S_DYING_CTR++;
						frame++;
						FlxG.shake(0.02,2);
						Registry.sound_data.sun_guy_death_l.play();
						white_overlay.alpha = 1;
					}
					break;
				case 3:
					if (EventScripts.send_alpha_to(white_overlay, 0, -0.005)) {
						frame++;
						S_DYING_CTR++;
					}
					break;
				case 4:
					EventScripts.send_alpha_to(darkness, 0.75, -0.005);
					if (EventScripts.send_property_to(player.light, "base_x_scale", 4, 0.06)) S_DYING_CTR++;
					EventScripts.send_property_to(player.light, "base_y_scale", 4, 0.06);
					break;
				default:
					STATE = S_DEAD;
					
					break;
			}
		}
		
		/* Change the XML, global state, so forth...cleanup etc */
		private function dead_state():void {
			//One-off
			if (!INCREMENTED_REGISTRY) {
			/*	if (!Registry.CUTSCENES_PLAYED[Cutscene.Terminal_Gate_Bedroom]) {
					Registry.E_Load_Cutscene = true;
					Registry.CURRENT_CUTSCENE = Cutscene.Terminal_Gate_Bedroom;
				}*/
				darkness.alpha = 0.5;
				Registry.GE_States[Registry.GE_Bedroom_Boss_Dead_Idx] = true;
				for (var i:int = 0; i < 3; i++) {
					dusts.members[i].x = -5000; //HEHHEH
				}
				xml.@alive = "false";
				trace("boss dead");
				Registry.GRID_ENEMIES_DEAD++;
				trace("grid enemies dead",Registry.GRID_ENEMIES_DEAD);
				INCREMENTED_REGISTRY = true;
			//EventScripts.boss_drop_health_up(x, y);
				Registry.sound_data.start_song_from_title(Registry.CURRENT_MAP_NAME);
				exists = false;
				
				
			}
		}
		
		private function vertifloat_state():void {
			var res:Boolean;
			switch (S_VERTIFLOAT_CTR) {
				case 0:
					if (x > base_pt.x) {
						res = EventScripts.send_property_to(this, "x", base_pt.x, -3);
					} else {
						res = EventScripts.send_property_to(this, "x", base_pt.x, 3);
					}
					if (res && EventScripts.send_property_to(this, "y", base_pt.y - 30, -0.2)) S_VERTIFLOAT_CTR++;
				break;
				case 1:
					EventScripts.send_property_to(this, "lr_1", 8, -0.5);
					EventScripts.send_property_to(this, "lr_2", 8, -0.5);
					EventScripts.send_property_to(this, "rv_1", 0.4, 0.001);
					EventScripts.send_property_to(this, "rv_2", 0.4, 0.001);
					move_horizontally();
					move_vertically();
					if (FlxG.overlap(player, this) || FlxG.overlap(player, light_orb_1) || FlxG.overlap(player, light_orb_2)) {
						player.touchDamage(1);
						times_hurt_player++;
					}
					break;
			}
			
			rotate_orbs_about_sun_guy();
		}
		private function charge_state():void {
			//move orbs to guy
			if (FlxG.overlap(player, this) || FlxG.overlap(player, light_orb_1) || FlxG.overlap(player, light_orb_2)) {
				player.touchDamage(1);
				times_hurt_player++;
			}
			var res:Boolean;
			var i:int;
			switch (S_CHARGE_CTR) {
				case 0:
					EventScripts.send_property_to(light_orb_1, "x", x+4, 2);
					EventScripts.send_property_to(light_orb_1, "y", y+10, 2);
					EventScripts.send_property_to(this, "x", base_pt.x + 30, 1);
					EventScripts.send_property_to(light_orb_2, "x", x-4, 2);
					EventScripts.send_property_to(light_orb_2, "y", y + 10, 2);
					if (EventScripts.send_property_to(this, "y", base_pt.y - 20, 1)) {
						S_CHARGE_CTR++;
						sun_guy_wave.play("play");
						Registry.sound_data.sun_guy_charge.play();
					}
					break;
				case 1:
					sun_guy_wave.visible = true;
					sun_guy_wave.flicker(3);
					FlxG.shake(0.02, 0.1);
					sun_guy_wave.x = base_pt.x - 50;
					sun_guy_wave.y = base_pt.y - 10;
					sun_guy_wave.velocity.y = 0;
					velocity.x = velocity.y = 0;
					if (FlxG.overlap(sun_guy_wave, player)) { sun_guy_wave.visible = false; player.touchDamage(1); S_CHARGE_CTR = 3; 
				times_hurt_player++; }
					EventScripts.send_property_to(light_orb_1, "x", base_pt.x - 50, 0.3);
					if (EventScripts.send_property_to(light_orb_2, "x", base_pt.x + 75, 0.3)) {
						S_CHARGE_CTR++;
						Registry.sound_data.sun_guy_death_s.play();
					}
					break;
				case 2:
					sun_guy_wave.velocity.y = 30;
					if (!sun_wave_evaporating) {
						for (i = 0; i < dusts.length; i++) {
							if (sun_guy_wave.overlaps(dusts.members[i]) && dusts.members[i].exists) {
								sun_guy_wave.play("evaporate");
								sun_wave_evaporating = true;
								//sun_guy_wave.visible = false;
							}
						}
						move_horizontally();
						if (sun_guy_wave.visible && FlxG.overlap(sun_guy_wave, player)) { 
								sun_guy_wave.play("evaporate");
								sun_wave_evaporating = true;
								player.touchDamage(1); 
								times_hurt_player++;
							}
					} else {
						if (sun_guy_wave._curFrame == sun_guy_wave._curAnim.frames.length -1) {
							sun_guy_wave.visible = false;
							sun_wave_evaporating = false;
							S_CHARGE_CTR = 3;
							velocity.x =  0;
						}
					}
					
					if (sun_guy_wave.y > 180) {
						S_CHARGE_CTR = 3;
						sun_wave_evaporating = false;
						sun_guy_wave.play("evaporate");
					}
					break;
				case 3:
					if (!dusts_poofed) {
						for (i = 0; i < dusts.length; i++) {
							dusts.members[i].play("poof");
						}
						dusts_poofed = true;
					} else {
						if (dusts.members[0]._curFrame == dusts.members[0]._curAnim.frames.length - 1) {
							STATE = S_VERTIFLOAT;
							S_CHARGE_CTR = 0;		
							dusts_poofed = false;
							dusts.setAll("exists", false);
						}
					}
					break;
			}
			return;
			
		}
		private function rotate_orbs_about_sun_guy():void {
			center_pt.x = x + 8;
			center_pt.y = y + 13;
			
			light_orb_1.x = Math.cos(a_1) * (lr_1) + center_pt.x - 8;
			light_orb_1.y = Math.sin(a_1) * (lr_1) + center_pt.y;
			a_1 = (a_1 + rv_1) % 6.28;
			light_orb_2.x = Math.cos(a_2) * (lr_2) + center_pt.x - 8;
			light_orb_2.y = Math.sin(a_2) * (lr_2) + center_pt.y;
			a_2 = (a_2 + rv_2) % 6.28;
		}
		
		private function move_horizontally():void {
			if (HF_1) {
				
				if (EventScripts.move_to_x(this, 50, base_pt.x + 60)) {
					HF_1 = false;
				}
			} else {
				if (EventScripts.move_to_x(this, -50, base_pt.x - 50))
					HF_1 = true;
			}
		}
		
		private function move_vertically():void {
			if (VF_1) {
				if (EventScripts.send_property_to(this, "y", base_pt.y + 80, 1.5)) {
					VF_1 = false;
					FlxG.shake(0.05, 0.3);
					var dust:Dust = dusts.getFirstAvailable() as Dust;
				if (dust == null) { STATE = S_CHARGE; S_VERTIFLOAT_CTR = 0;  return; }
					dust.exists = true;
					dust.x = x;
					dust.y = y;
					Dust.dust_sound.play();
					Registry.sound_data.play_sound_group(Registry.sound_data.enemy_explode_1_group);
					dust.play("unpoof");
					parent.bg_sprites.add(dust);
					
				}
			} else {
				if (EventScripts.send_property_to(this, "y", base_pt.y - 32, -2)) {
					VF_1 = true;
				}
			}
			return;
		}
		
		public function hit(type:String, dir:int):int {
			
			if (just_got_hurt) return -1;
			if (health <= 0) return -1;
			//if (STATE == S_VERTIFLOAT) return -1;
			if (flickering) return -1;
			just_got_hurt = true;
			Registry.sound_data.sun_guy_scream.play();
			flicker(1);
			
			health--;
			return -1;
		}
		
		override public function destroy():void {
			DH.a_chunk_just_finished();
			parent.remove(light_cone_1, true);
			parent.remove(light_cone_2, true);
			parent.remove(light_orb_1, true);
			parent.remove(light_orb_2, true);
			parent.remove(orb_illum_1, true);
			parent.remove(sun_guy_wave, true);
			parent.remove(orb_illum_2, true);
			light_cone_1 = light_cone_2 =  orb_illum_1 = orb_illum_2 = null;
			light_orb_1 = light_orb_2 = sun_guy_wave = null;
			
			super.destroy();
		}
	}

}