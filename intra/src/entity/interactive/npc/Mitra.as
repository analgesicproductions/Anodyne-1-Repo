package entity.interactive.npc 
{
	import data.CLASS_ID;
	import entity.enemy.etc.Sage_Boss;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Keys;
	import global.Registry;
	import helper.Cutscene;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	
	public class Mitra extends FlxSprite 
	{
		
		
		private var player:Player;
		private var parent:*;
		private var xml:XML;
		private var dame_frame:int;
		public var active_region:FlxObject;
		public var sage_active_region:FlxObject;
		
		public var bike:FlxSprite;
		public var cid:int = CLASS_ID.MITRA;
		public var sage:FlxSprite;
		
		
		private var logic:Function;
		private var fields_state:int = 0;
		private const FS_cards:int = 1;
		private const FS_init:int = 2;
		// whehter an in
		private var gave_initial_hint:Boolean = false;
		private var state_counter:int = 0;
		// Generic flags
		private var b1:Boolean = false;
		private var b2:Boolean = false;
		private var tl:Point = new Point();
		private var ctr:int = 0;
		private var bullet:FlxSprite;
		
		[Embed (source = "../../../res/sprites/npcs/bike.png")] public static var bike_sprite:Class;
		[Embed (source = "../../../res/sprites/npcs/mitra.png")] public static var mitra_sprite:Class;
		[Embed (source = "../../../res/sprites/npcs/mitra_bike.png")] public static var mitra_on_bike_sprite:Class;
		public function Mitra(_player:Player,_parent:*,_xml:XML) 
		{
			player = _player;
			parent = _parent;
			xml = _xml;
			dame_frame = parseInt(xml.@frame);
			
			tl.x = Registry.CURRENT_GRID_X * 160;
			tl.y = 20 + Registry.CURRENT_GRID_Y * 160;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			addAnimation("bike_d", [0,1], 8);
			addAnimation("bike_u", [4,5], 8);
			addAnimation("bike_idle_u", [4], 8);
			addAnimation("bike_r", [2,3], 8);
			addAnimation("bike_l", [2,3], 8);
			
			addAnimation("walk_d", [0,1], 8);
			addAnimation("walk_u", [4,5], 8);
			addAnimation("walk_r", [2,3], 8);
			addAnimation("walk_l", [2,3], 8);
			
			addAnimation("idle_d", [6], 8);
			addAnimation("idle_u", [8], 8);
			addAnimation("idle_r", [7], 8);
			addAnimation("idle_l", [7], 8);
			
			addAnimationCallback(on_anim_change);
			
			play("idle_d");
			
			bike = new FlxSprite; 
			bike.loadGraphic(bike_sprite, true, false, 20, 20)
			bike.addAnimation("r", [1], 2);
			bike.addAnimation("d", [0], 2);
			bike.addAnimation("u", [2], 2);
			bike.visible = false;
			bike.play("r");
			bike.width = 16;
			bike.height = 10;
			bike.offset.x = 2;
			bike.offset.y = 11;
			parent.sortables.add(bike);
			
			active_region = new FlxObject(x, y, 20, 20);
			sage_active_region = new FlxObject(x, y, 20, 20);
		
			Registry.subgroup_interactives.push(this);
			
			switch (Registry.CURRENT_MAP_NAME) {
				case "OVERWORLD":
					to_bike();
					
					if (dame_frame == 0) {
						Registry.EVENT_CHANGE_VOLUME_SCALE = true;
						Registry.EVENT_CHANGE_VOLUME_SCALE_TARGET = 0.3;
						logic = overworld_logic;
						visible = false;
						if (DH.scene_is_dirty(DH.name_mitra, DH.scene_mitra_overworld_initial_overworld)) {
							exists = false;
						}
					}
					break;
				case "FIELDS":
							
					bike.visible = true;
					bike.x = x - 20;
					bike.y = y + 20;
					if (Registry.all_bosses_dead() && Registry.nr_growths < 36) {
						trace("Mitra.as : All bosses dead!");
						fields_state = FS_cards;
					}
					
					if (DH.scene_is_dirty(DH.name_mitra, DH.scene_mitra_fields_init, "FIELDS") == false) {
						fields_state = FS_init;
					}
					logic = fields_logic;
					
					loadGraphic(mitra_sprite, true, false, 16, 16);
					break;
				case "CLIFF":
					logic = cliff_logic;
					x = tl.x - 20;
					y = tl.y + 70;
					to_bike();
					if (Registry.inventory[Registry.IDX_JUMP]) exists = false;
					break;
				case "GO":
					// Make a sage sprite
					if (Registry.GE_States[Registry.GE_Briar_Blue_Done] == false) {
						exists = false;
						break;
					}
					loadGraphic(mitra_on_bike_sprite, true, false, 20,20);
					visible = false;
					sage = new FlxSprite(0, 0);
					
					sage.loadGraphic(Sage.sage_sprite, true, false, 16, 16);
					
					sage.addAnimation("walk_d", [0, 1], 6, true);
					sage.addAnimation("walk_r", [2,3], 6, true);
					sage.addAnimation("walk_l", [2,3],6, true);
					sage.addAnimation("walk_u", [4,5], 6, true);
					sage.addAnimation("idle_d",[6]);
					sage.addAnimation("idle_r", [7]);
					sage.addAnimation("idle_l", [7]);
					sage.addAnimation("idle_u", [8]);
					sage.visible = false;
					parent.sortables.add(sage);
					
					bullet = new FlxSprite(0, 0);
					bullet.loadGraphic(Sage_Boss.embed_sage_attacks, true, false, 16, 16);
					bullet.addAnimation("a", [0, 1], 8);
					bullet.play("a");
					parent.sortables.add(bullet);
					
					logic = go_logic;
					
					if (Registry.GE_States[Registry.GE_go_mitra] == true) {
						GO_STATE = GO_STATE_AFTER;
						loadGraphic(mitra_sprite, true, false, 16, 16);	
						sage.x = tl.x + 32 + 8;
						sage.y = tl.y + 7 * 16 + 2;
						sage.visible = true;
						bike.visible = true;
						visible = true;
						bike.x = tl.x + 6 * 16 + 2;
						bike.y = tl.y  + 7 * 16;
						x = tl.x + 6 * 16 + 2;
						y = tl.y + 8 * 16 - 20;
					}
					
					break;
			}
		}
		
		override public function preUpdate():void 
		{
			if (solid) {
				FlxG.collide(this, parent.curMapBuf);
			}
			super.preUpdate();
		}
		override public function update():void 
		{
			if (parent.state == parent.S_NORMAL) {
				logic();
			}
			super.update();
		}

		private const GO_STATE_AFTER:int = 2;
		private const GO_STATE_DURING:int = 1;
		private const GO_STATE_BEFORE:int = 0;
		private var GO_STATE:int = 0;
		private function go_logic():void {
			if (GO_STATE == GO_STATE_BEFORE) {
				if (ctr == 0 && player.x < tl.x + 7 * 16 && player.y < tl.y + 7 * 16) {
					// Move into place.
					ctr = 1;
				}
			
				if (ctr == 1) {
					player.state = player.S_INTERACT;
					player.x += 1;
					player.play("walk_r");
					if (player.x > tl.x + 7 * 16) {
						player.x = tl.x + 7 * 16;
						ctr++;
					}
				} else if (ctr == 2) {
					if (player.y > tl.y + 7 * 16) {
						player.y -= 1;
						player.play("walk_u");
					} else if (player.y < tl.y + 7 * 16 - 3) {
						player.y += 1;
						player.play("walk_d");
					} else {
						player.play("idle_r");
						player.y = tl.y + 7 * 16;
						
						visible = true;
						play("bike_l");
						velocity.x = -45;
						x = tl.x + 160;
						y = tl.y + 5 * 16;
						ctr ++;
					}
				} else if (ctr == 3) {
					if (x < player.x - 24) {
						velocity.y = 45;
						velocity.x = 0;
						play("bike_d");
						if (y > player.y - 4) {
							loadGraphic(mitra_sprite, true, false, 16, 16);
							velocity.y = 20;
							play("walk_d");
							
							bike.visible = true;
							bike.x = player.x - 18;
							bike.y = player.y + 10;
							
							ctr++;
						}
					}
				} else if (ctr == 4) {
					if (y > player.y + player.height) {
						velocity.y = 0;
						velocity.x = 20;
						play("walk_r");
						if (x > player.x) {
							player.play("idle_d");
							play("idle_u");
							velocity.x = 0;
							
							sage.x = tl.x + 4 * 16;
							sage.y = tl.y + 160;
							sage.velocity.y = -20;
							sage.visible = true;
							sage.play("walk_u");
							
							ctr++;
						}
					}
				} else if (ctr == 5) {
					if (sage.y < tl.y + 8 * 16 - 8) {
						sage.velocity.y = 0;
						sage.velocity.x = -20;
						sage.scale.x = -1;
						sage.play("walk_l");
						if (sage.x < tl.x + 2 * 16 + 8) {
							sage.velocity.x = 0;
							sage.scale.x = 1;
							sage.play("idle_r");
							GO_STATE = GO_STATE_DURING;
							ctr = 0;
							DH.set_scene_to_pos(DH.name_sage, "one", 0);
						}
					}
				}
			} else if (GO_STATE == GO_STATE_DURING) {
				if (player.x > tl.x + 9 * 16) {
					player.x = tl.x + 9 * 16;
				}
				
				if (player.x < tl.x + 16) {
					player.x = tl.x + 16;
				}
				if (player.y > tl.y + 9 * 16) {
					player.y = tl.y + 9 * 16;
				}
				if (player.y < tl.y +16) {
					player.y = tl.y + 16;
				}
				if (ctr == 0) {
					DH.start_dialogue(DH.name_sage, "one");
					ctr++;
					player.play("idle_l");
					play("idle_l");
					scale.x = -1;
				} else if (ctr == 1) {
					player.play("idle_l");
					if (DH.a_chunk_is_playing() == false) {
						parent.dialogue_latency = -1;
						DH.start_dialogue(DH.name_sage, "one");
						repeats++;
						if (repeats == 6) { 
							ctr++;
							Registry.sound_data.sun_guy_charge.play();
						}
					} 
				} else if (ctr == 2) {
					bullet.x = sage.x + sage.width;
					bullet.y = sage.y;
					bullet.flicker(0.1);
					t += FlxG.elapsed;
					if (t > tm) {
						t = 0;
						bullet.velocity.x = 10;
						ctr++;
						Registry.sound_data.play_sound_group(Registry.sound_data.laser_pew_group);
					}
					
					// Fire bullet
				} else if (ctr == 3) {
					if (bullet.x > bike.x - 3) {
						bullet.visible = false;
						FlxG.flash(0xffff0000, 1);
						EventScripts.make_explosion_and_sound(bullet);
						ctr = 6;
					}
					if (bullet.overlaps(player)) {
						FlxG.flash(0xffff0000, 1);
						EventScripts.make_explosion_and_sound(bullet);
						player.state = player.S_INTERACT;
						bullet.visible = false;
						player.play("slumped");
						ctr = 4;
					}
					if (player.broom.visible && player.broom.overlaps(bullet)) {
						FlxG.flash(0xffffffff, 1);
						EventScripts.make_explosion_and_sound(bullet);
						ctr = 4;
						bullet.visible = false;
					}
				} else if (ctr == 4) {
					// Wares doesnt gets hit
					DH.start_dialogue(DH.name_sage, "hit", "", 0);
					ctr = 5;
				} else if (ctr == 5) {
					if (DH.a_chunk_is_playing() == false) {
						Registry.GAMESTATE.dialogue_latency = -1;
						ctr = 9;
						DH.start_dialogue(DH.name_sage, "hit", "", 1);
					}
				} else if (ctr == 6) {
					//wares gets hit
					DH.start_dialogue(DH.name_sage, "hit", "", 2);
					ctr ++;
				} else if (ctr == 7) {
					velocity.x = -20;
					scale.x = -1;
					play("walk_l");
					if (x < bike.x) {
						play("idle_u");
						velocity.x = 0;
						scale.x = 1;
						Registry.GAMESTATE.dialogue_latency = -1;
						DH.start_dialogue(DH.name_sage, "hit", "", 3);
						ctr++;
					}
				} else if (ctr == 8) {
					if (DH.a_chunk_is_playing() == false) {
						play("idle_l");
						scale.x = -1;
						Registry.GAMESTATE.dialogue_latency = -1;
						DH.start_dialogue(DH.name_sage, "hit", "", 4);
						ctr++;
					}
				} else if (ctr == 9) {
					if (DH.a_chunk_is_playing() == false) {
						Registry.GAMESTATE.dialogue_latency = -1;
						DH.start_dialogue(DH.name_sage, "hit", "", 5);
						ctr = 10;
						GO_STATE = GO_STATE_AFTER;
						Registry.GE_States[Registry.GE_go_mitra] = true;
					}
				} 
			} else if (GO_STATE == GO_STATE_AFTER) {
				
				active_region.x = x - 2;
				active_region.y = y - 2;
				sage_active_region.x = sage.x - 2;
				sage_active_region.y = sage.y - 2;
				EventScripts.face_and_play(sage, player, "idle");
				EventScripts.face_and_play(this, player, "idle");
				
				immovable = true;
				sage.immovable = bike.immovable = true;
				FlxG.collide(sage, player);
				FlxG.collide(this, player);
				FlxG.collide(bike, player);
				if (DH.nc(player, active_region)) {
					//mitra
					if (Registry.GE_States[Registry.GE_Briar_Happy_Done]) {
						DH.start_dialogue(DH.name_sage, DH.scene_sage_happy_posthappy_mitra);
					} else {
						DH.start_dialogue(DH.name_sage, "hit", "", 7);
					}
				}
				if (player.overlaps(sage_active_region)) {
					player.actions_disabled = true;
				}
				if (DH.nc(player, sage_active_region)) {
					if (Registry.GE_States[Registry.GE_Briar_Happy_Done]) {
						DH.start_dialogue(DH.name_sage, DH.scene_sage_happy_posthappy_sage);
					} else {
						DH.start_dialogue(DH.name_sage, "hit", "", 6);
					}
				}
			}
		}
		private var t:Number = 0;
		private var tm:Number = 2.5;
		private var repeats:int = 0;
		
		private function cliff_logic():void {
			if (state_counter == 0) {
				if (player.y > tl.y + 50 && player.state != player.S_LADDER) {
					Registry.sound_data.stop_current_song();
					Registry.sound_data.start_song_from_title("MITRA");
					player.be_idle();
					player.state = player.S_INTERACT;
					DH.disable_menu();
					//DH.dialogue_popup("Hey, Young!");
					DH.dialogue_popup(DH.lk("mitra",0));
					state_counter = 1;
					x = tl.x + 160 + 20;
					y = tl.y + 80;
				}
			} else if (state_counter == 1) {					
				player.be_idle();
				player.state = player.S_INTERACT;
				if (DH.a_chunk_is_playing() == false) {
					play("bike_l");
					velocity.x = -37;
					state_counter = 2;
				}
			} else if (state_counter == 2) {
				if (x <= player.x) {
					velocity.x = 0;
					bike.x = x - 1;
					bike.y = y - 1;
					bike.visible = true;
					if (Registry.inventory[Registry.IDX_BIKE_SHOES]) {
						//DH.dialogue_popup("Are those bike shoes for me?  Wow!  Thanks, Young!  I’ve been thinking about getting these, since Wares has those pedals where you can clip in bike shoes.  Here, Young, take my boots in exchange!  They have these cool springs that let you jump really high! You press " + Registry.controls[Keys.IDX_ACTION_2] + " to jump with them on!");
						DH.dialogue_popup(DH.lk("mitra",1) + " "+Registry.controls[Keys.IDX_ACTION_2] + " "+DH.lk("mitra",2));
					
					} else {
						//DH.dialogue_popup("Hi Young!  Notice anything new? ^... ^... Oh, well, I got new biking shoes, see!  They clip into Wares' pedals.  Since I’ll no longer be needing my old boots, I want you to have them, Young!  They have these cool springs that let you jump really high! You press " + Registry.controls[Keys.IDX_ACTION_2] + " to jump with them on!");
						DH.dialogue_popup(DH.lk("mitra",3) + " "+Registry.controls[Keys.IDX_ACTION_2] + " "+DH.lk("mitra",4));
					}
					
					Registry.inventory[Registry.IDX_JUMP] = true;
					Registry.bound_item_2 = "JUMP";
					Registry.inventory[Registry.IDX_BIKE_SHOES] = false;
					state_counter = 6;
					loadGraphic(mitra_sprite, true, false, 16, 16);
					play("idle_u");
					offset.x  = offset.y = 0;
					
				}
			} else if (state_counter == 3) {
				if (!DH.a_chunk_is_playing()) {
					player.state = player.S_INTERACT;
					player.be_idle();
					//DH.dialogue_popup("Alright, take care!");
					DH.dialogue_popup(DH.lk("mitra",5));
					state_counter  = 4;
				}
			}  else if (state_counter == 4) {
				
				if (!DH.a_chunk_is_playing()) {
					velocity.x = 37;
					bike.visible = false;
					to_bike();
					play("bike_r");
					player.state = player.S_INTERACT;
					state_counter = 5;
				}
			} else if (state_counter == 5) {
				
				if (x > tl.x + 160) {
					exists = false;
					player.state = player.S_GROUND;
					Registry.E_FADE_AND_SWITCH = true;
					Registry.E_FADE_AND_SWITCH_SONG = "CLIFF";
					DH.enable_menu();
				}
			} else if (state_counter == 6) {
				EventScripts.face_and_play(this, player, "idle");
				
				immovable = true;
				active_region.x = x - 2;
				active_region.y = y - 2;
				
				
				FlxG.collide(this, player);
				if (player.state == player.S_AIR) {
					jumpedonce = true;
				}
				if (player.overlaps(active_region) && DH.a_chunk_is_playing() == false && player.state == player.S_GROUND && Registry.keywatch.JP_ACTION_1) {
					player.be_idle();
					if (DH.get_int_property(DH.name_mitra, "smells") == -1) {
						DH.increment_property(DH.name_mitra, "smells");
						//DH.dialogue_popup("Go on, try them out!  ^...They’re not THAT smelly.");
						DH.dialogue_popup(DH.lk("mitra",6));
					} else {
						if (jumpedonce) {
							//DH.dialogue_popup("Cool, huh?");	
							DH.dialogue_popup(DH.lk("mitra",7));	
						}
					}
				}
				
				if (player.y < tl.y + 49) {
					state_counter = 3;
				}
				
				if (player.x > tl.x + 135) {
					if (player.state == player.S_GROUND) {
						state_counter = 3;
					}
					player.x = tl.x + 135;
				}
			}
		}
		private var jumpedonce:Boolean = false;
		//hints and shit
		private function fields_logic():void {
			bike.immovable = true;
			FlxG.collide(bike, player);
			if (fields_state == FS_cards) {
				// Find next card thing to help with
				idle_card();
			} else if (fields_state == FS_init) {
				idle_fields_init();
			} else {
				idle_fields();
				// Give hints about game, maybe
				// Orj ust talk in general
			}
		}
		
		private function idle_fields_init():void {
			
			EventScripts.face_and_play(this, player, "idle");
			immovable = true;
			active_region.x = x - 2;
			active_region.y = y - 2;
			FlxG.collide(this, player);
			if (DH.nc(player,active_region)) {
				if (DH.get_scene_position(DH.name_mitra, DH.scene_mitra_fields_init) < 2) {
					if (DH.get_int_property(DH.name_mitra, "wares") != -1) {
						DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_init, "", 0);
						DH.set_scene_to_pos(DH.name_mitra, DH.scene_mitra_fields_init, 2);
					} else {
						DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_init, "", 1);
						DH.set_scene_to_pos(DH.name_mitra, DH.scene_mitra_fields_init, 2);
					}
				} else {
					DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_init);
				}
			}
			
		}
		
		private function overworld_logic():void {
			switch(state_counter) {
				case 0:
					DH.disable_menu();
					if (DH.a_chunk_just_finished()) {
						state_counter++;
						EventScripts.scale_vector(this, player, velocity, 80);
						visible = true;
						
					} else {
						if (Math.abs(player.y -y) < 48) {
							if (!Registry.EVENT_CHANGE_VOLUME_SCALE && !DH.a_chunk_is_playing()) {
								Registry.sound_data.start_song_from_title("MITRA");
								Registry.volume_scale = 1;
								x -= 20; // Keep mitra off screen
								player.state = player.S_INTERACT;
								player.play("idle_l");
								play("bike_r");
								DH.start_dialogue(DH.name_mitra, DH.scene_mitra_overworld_initial_overworld);
							} else {
								
							}
						}
					}
					break;
				case 1: // Move down 
					player.state = player.S_INTERACT;
					if (player.x - x < 24 && (x > Registry.CURRENT_GRID_X * 160 + 40)) {
						state_counter++;
						velocity.x = 0;
						velocity.y = 80;
						play("bike_d");
					}
					break;
				case 2 : // move right
					if (y - player.y > 24) {
						state_counter++;
						velocity.y = 0;
						velocity.x = 80;
						player.play("idle_d");
						play("bike_r");
					}
					break;
				case 3: //Hit the wall, flash, shake, cahnge graphic
					if (touching != NONE) {
						FlxG.shake(0.02, 0.3);
						Registry.sound_data.sun_guy_death_s.play();
						loadGraphic(mitra_sprite, true, false, 16, 16);
						width = height = 10;
						offset.x = 3;
						offset.y = 3;
						velocity.x = velocity.y = 0;
						play("idle_r");
						
						//Bike stuff
						bike.visible = true;
						bike.x = x - 4; bike.y = y;
						
						// After flash, move left
						FlxG.flash(0xffffffff, 1.0, function():void {
							state_counter++;
							velocity.x = -20;
							velocity.y = 0;
							play("walk_l");
							player.play("idle_r");
						});
					}
					break;
				case 4:
					// walk up to player
					if (x < player.x + 3) {
						x = player.x;
						velocity.x = 0;
						velocity.y = -20;
						player.play("idle_d");
						play("walk_u");
						state_counter++;
					}
					break;
				case 5:
					// Face player, talk
					if (y < player.y + 26) {
						velocity.y = 0;
						play("idle_u");
						state_counter++;
						DH.start_dialogue(DH.name_mitra, DH.scene_mitra_overworld_initial_overworld);
					}
					break;
				case 6:
					// wait to be done
					if (DH.a_chunk_just_finished()) {
						state_counter++;
					} 
					break;
				case 7:
					
					// If player is below mitra, have mitra walk left/rght first before biking
					//nvm dont need it anymore
					if (DH.scene_is_finished(DH.name_mitra, DH.scene_mitra_overworld_initial_overworld)) {
						var dx:int = x - player.x;
						if (velocity.x != 20 && Math.abs(dx) < 20 && y < player.y) {
							if (dx < 20 && dx > -4) {
								velocity.x = 20;
								play("walk_r");
 							} else if (dx > -20 && dx < -4) {
								velocity.x = 20;
								play("walk_r");
							}
						} else {
							player.be_idle();
							// Touch the bike first
							play("walk_r");
							touching = NONE;
							velocity.x = 20;
							player.state = player.S_INTERACT;
							
							if (EventScripts.distance(this,bike) < 8) {
								state_counter++;
								to_bike();
								bike.visible = false;
								play("bike_d");
								velocity.y = 50;
								velocity.x = 0;
							}
						}
					} else {
						if (false == DH.a_chunk_is_playing() && EventScripts.distance(this, player) > 48) {
							player.be_idle();
							DH.set_scene_to_end(DH.name_mitra, DH.scene_mitra_overworld_initial_overworld);
							DH.start_dialogue(DH.name_mitra, DH.scene_mitra_overworld_initial_overworld);
						// otherwise wait for interaction
						} else {
							idle(DH.scene_mitra_overworld_initial_overworld);
						}
					}
					break;
				case 8:
					// When off map, change song back
					if (y > 160 * (Registry.CURRENT_GRID_Y + 1) + 30) {
						Registry.volume_scale -= 0.02;
						if (Registry.volume_scale < 0.2) {
							DH.enable_menu();
							DH.dont_need_recently_finished();
							player.state = player.S_GROUND;
							player.ANIM_STATE = 7;
							Registry.sound_data.start_song_from_title("OVERWORLD");
							Registry.volume_scale = 1;
							exists = false;
						}
					}
					break;
					
			}
		}
		
		
		private function idle(scene:String):void 
		{
			immovable = true;
			active_region.x = x - 2;
			active_region.y = y - 2;
			FlxG.collide(this, player);
			EventScripts.face_and_play(this, player, "idle");
			if (Registry.keywatch.JP_ACTION_1 && player.overlaps(active_region) && EventScripts.are_facing_opposite(this, player)) {
				EventScripts.face_and_play(player, this, "idle");
				DH.start_dialogue(DH.name_mitra, scene);
				
				if (scene == DH.scene_mitra_overworld_initial_overworld) {
					// If we heard the "wares" line then set a flag which
					// affects the init FIELDS scene for mitra
					DH.increment_property(DH.name_mitra, "wares");
				}
			}
		}
		
		private function idle_card():void {
			immovable = true;
			active_region.x = x - 2;
			active_region.y = y - 2;
			FlxG.collide(this, player);
			EventScripts.face_and_play(this, player, "idle");
			if (Registry.keywatch.JP_ACTION_1 && player.overlaps(active_region) && EventScripts.are_facing_opposite(this, player)) {
				
				EventScripts.face_and_play(player, this, "idle");
				
				// Give quest hint first till they go to cliff?
				if (!gave_quest_hint) {
					gave_quest_hint = true;
					if (Registry.GE_States[Registry.GE_QUEST_CLIFF] == false) {
						DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_quest_event);
						Registry.GE_States[Registry.GE_QUEST_MITRA] = true;
						return;
					}
				} 
				
				
				var i:int = int(36 * Math.random());
				
				for (var j:int = 0; j < 36; j++) {
					if (!Registry.card_states[(i + j) % 36]) {
						DH.set_scene_to_pos(DH.name_mitra, DH.scene_mitra_fields_card_hints, (i + j ) % 36);
						break;
					}
				}
				if (Registry.nr_growths == 0) {
					DH.set_scene_to_pos(DH.name_mitra, DH.scene_mitra_fields_card_hints, 36);
				}
				DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_card_hints);
			}
		}
		
		private var gave_quest_hint:Boolean = false;
		private function idle_fields():void {
			immovable = true;
			active_region.x = x - 2;
			active_region.y = y - 2;
			FlxG.collide(this, player);
			EventScripts.face_and_play(this, player, "idle");
			if (Registry.keywatch.JP_ACTION_1 && player.overlaps(active_region) && EventScripts.are_facing_opposite(this, player)) {
				EventScripts.face_and_play(player, this, "idle");
				
				if (Registry.inventory[Registry.IDX_BIKE_SHOES]) {
					Registry.inventory[Registry.IDX_BIKE_SHOES] = false;
					Registry.inventory[Registry.IDX_JUMP] = true;
					Registry.bound_item_2 = "JUMP";
					
					//DH.dialogue_popup("Wow, are those the biking shoes from Finty's shop?  You're giving them to me?  Thanks, Young, I really appreciate it!  Here, try out my old shoes in return--I think you'll find them really useful!  There's an engraving on the shoes that says \"Press " + Registry.controls[Keys.IDX_ACTION_2] + " to jump\".  I've never understood that, though, because there's no \"" + Registry.controls[Keys.IDX_ACTION_2] + "\" anywhere on the shoes...");
					DH.dialogue_popup(DH.lk("mitra", 8) + " " + Registry.controls[Keys.IDX_ACTION_2]  + " " + DH.lk("mitra", 9) + Registry.controls[Keys.IDX_ACTION_2]  + DH.lk("mitra", 10));
					
				} else if (!gave_initial_hint) {
					
					gave_initial_hint = true;
					// Before widmill event.
					if (0 == Registry.CUTSCENES_PLAYED[Cutscene.Windmill_Opening]) {
						// hint to go to beach (or forest)
						if (!Registry.GE_States[Registry.GE_Redcave_Boss_Dead_Idx] && !Registry.GE_States[Registry.GE_Crowd_Boss_Dead_Idx]) {
							if (Math.random() < 0.5) {
								DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_game_hints, "FIELDS", 1);
							} else {
								DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_game_hints, "FIELDS", 2);
							}
						} else if (Registry.GE_States[Registry.GE_Redcave_Boss_Dead_Idx] && !Registry.GE_States[Registry.GE_Crowd_Boss_Dead_Idx]) {
							DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_game_hints, "FIELDS", 8);
							
						} else if (!Registry.GE_States[Registry.GE_Redcave_Boss_Dead_Idx] && Registry.GE_States[Registry.GE_Crowd_Boss_Dead_Idx]) {
							DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_game_hints, "FIELDS", 7);
						// hint to go to windmill
						} else {
							DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_game_hints, "FIELDS", 3);
						}
					} else {
						// If the bosses aren't all dead, hint to go past dungeon statues
						if (!Registry.all_bosses_dead()) {
							DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_game_hints, "FIELDS", 4);
						// If don't have the transformer, hint to go to terminal
						} else if (!Registry.inventory[Registry.IDX_TRANSFORMER]) { // No GO yet
							DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_game_hints, "FIELDS", 5);
						// Otheriwse a hint for hte puzzle?
						} else { // got swap
							DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_game_hints, "FIELDS", 6);
						}
					}
				} else if (!gave_quest_hint) {
				// Give quest hint first till they go to cliff?
					if (Registry.GE_States[Registry.GE_QUEST_CLIFF] == false) {
						if (true == DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_quest_event)) {
							gave_quest_hint = true;
							Registry.GE_States[Registry.GE_QUEST_MITRA] = true;
						}
						return;
					}
				} else {
					DH.start_dialogue(DH.name_mitra, DH.scene_mitra_fields_general_banter);
				}
			}
		}
		
		private function to_bike():void 
		{
			loadGraphic(mitra_on_bike_sprite, true, false, 20, 20);
			width = height = 10;
			centerOffsets(true);
		}
		
		public function on_anim_change(name:String, frame:int, index:int):void {
			if (name == "walk_l" || name == "bike_l" || name == "idle_l") {
				scale.x = -1;
			
			} else {
				scale.x = 1;
			}
		}
		
		override public function destroy():void 
		{
			parent.sortables.remove(bike, true);
			bike.destroy();
			bike = null;
			
			if (sage != null ) {
				parent.sortables.remove(sage, true);
				sage.destroy();
				sage = null;
			}
			
			if (bullet != null) {
				parent.sortables.remove(bullet, true);
				bullet.destroy();
				bullet = null;
			}
			
			active_region.destroy();
			active_region = null;
			
			sage_active_region.destroy();
			sage_active_region = null;
			
			DH.a_chunk_just_finished();
			DH.enable_menu();
			super.destroy();
		}
		
		
	}

}