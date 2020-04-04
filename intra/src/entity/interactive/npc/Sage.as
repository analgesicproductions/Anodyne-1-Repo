package entity.interactive.npc 
{
	import data.Common_Sprites;
	import entity.gadget.KeyBlock;
	import flash.geom.Point;
	import flash.utils.Endian;
	import global.Keys;
	import global.Registry;
	import helper.Achievements;
	import helper.Cutscene;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import entity.player.Player;
	import states.EndingState;
	import states.PlayState;
	public class Sage extends FlxSprite
	{
		
		private var player:Player;
		private var parent:*;
		private var xml:XML;
		
		// The logic function specific to a map/area.
		private var logic:Function;
		
		private var dame_frame:int;
		
		private var state_counter:int = 0;
		
		private var briar_ref:FlxSprite;
		private var whitelayer:FlxSprite;
		// Generic flags
		private var b1:Boolean = false;
		private var b2:Boolean = false;
		public var active_region:FlxObject;
		
		private var tl:Point = new Point();
		
		
		[Embed (source = "../../../res/sprites/npcs/sage.png")] public static var sage_sprite:Class;
		public function Sage(_player:Player,_parent:*,_xml:XML)
		{
			
			player = _player;
			parent = _parent;
			xml = _xml;
			dame_frame = parseInt(xml.@frame);
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			loadGraphic(sage_sprite, true, false, 16, 16);
			addAnimation("walk_d", [0, 1], 6, true);
			addAnimation("walk_r", [2,3], 6, true);
			addAnimation("walk_l", [2,3],6, true);
			addAnimation("walk_u", [4,5], 6, true);
			addAnimation("idle_d",[6]);
			addAnimation("idle_r", [7]);
			addAnimation("idle_l", [7]);
			addAnimation("idle_u", [8]);
			addAnimationCallback(on_anim_change);
			
			width = height = 10;
			offset.x = 3;
			offset.y = 3;
			x += 3;
			y += 3;
			
			tl.x = Registry.CURRENT_GRID_X * 160;
			tl.y = Registry.CURRENT_GRID_Y * 160 + 20;
			
			play("idle_d");
			
			
			// Pick the function that will be called (for map-specific events, etc)
			switch (Registry.CURRENT_MAP_NAME) {
				case "BLANK":
					visible = false;
					logic = blank_logic;
					Registry.subgroup_interactives.push(this); 
					break;
				case "BEDROOM":
					// Do not show up after being talked to once and having left bedroom
					if (Registry.GE_States[Registry.GE_Left_BDR_After_Boss_Dead]) {
						exists = false;
					}
					logic = bedroom_logic;
					Registry.subgroup_interactives.push(this); 
					break;
				case "REDCAVE":
					if (Registry.GE_States[Registry.GE_Left_RDC_After_Boss_Dead] && Registry.inventory[Registry.IDX_RED_KEY]) {
						exists = false;
					}
					play("idle_u");
					logic = redcave_logic;
					Registry.subgroup_interactives.push(this);
					break;
				case "OVERWORLD":
					// Do not show up after sunboss dead
					if (Registry.GE_States[Registry.GE_Bedroom_Boss_Dead_Idx]) {
						exists = false;
					}
					logic = overworld_logic;
					break;
				case "NEXUS":
					if ( Registry.GE_States[Registry.GE_Sage_Dead_Idx]) {
						exists = false;
					}
					logic = nexus_logic;
					Registry.subgroup_interactives.push(this); 
					break;
				case "TERMINAL":
					// If all cards, sage should appear on the bridge for the fight, otherwise at terminal etrance.
					xml.@p = "2";
					if (xml.@alive == "false" || Registry.GE_States[Registry.GE_Sage_Dead_Idx] == true) {
						exists = false;
					} else {
						logic = terminal_logic;
						Registry.subgroup_interactives.push(this);
					}
					break;
				case "CROWD":
					if (Registry.GE_States[Registry.GE_Left_CRD_After_Boss_Dead]) {
						exists = false;
					}
					logic = crowd_logic;
					Registry.subgroup_interactives.push(this);
					break;
				case "GO":
					
					if (Registry.playtime < 15 * 60) {
						Achievements.unlock(Achievements.A_ENDING_SUB_15_M);
					}
					player.grid_entrance_x = tl.x + 75;
					player.grid_entrance_y = tl.y + 140;
					briar_ref = new FlxSprite;
					briar_ref.loadGraphic(Shadow_Briar.embed_briar, true, false, 16, 16);
					briar_ref.addAnimation("walk_d", [0, 1], 4);
					briar_ref.addAnimation("walk_r", [2, 3], 4);
					briar_ref.addAnimation("walk_u", [4, 5], 4);
					briar_ref.addAnimation("walk_l", [6, 7], 4);
					briar_ref.play("walk_d");
					briar_ref.x = tl.x + 16 * 4;
					briar_ref.y = tl.y + 60;
					briar_ref.framePixels_y_push = 8;
					
					whitelayer = new FlxSprite(tl.x, tl.y);
					whitelayer.makeGraphic(160, 160, 0xffffffff);
					whitelayer.alpha = 0;
					whitelayer.height = 2;
					parent.sortables.add(whitelayer);
					
					parent.sortables.add(briar_ref);
					
					visible = false;
					exists = true;
					logic = gof_logic;
					
				parent.darkness.loadGraphic(Common_Sprites.ending_blend, true, false, 160, 160);
					Registry.EVENT_CHANGE_DARKNESS_ALPHA_TARGET = 1;
					Registry.EVENT_CHANGE_DARKNESS_ALPHA = true;
					break;
			}
			
			
			immovable = true;
			// Where the player can talk to sage
			active_region = new FlxObject(x, y, 20, 20);
			
			
		}
		
		override public function update():void 
		{
			active_region.x = x - 2;
			active_region.y = y - 2;
			if (parent.state == parent.S_NORMAL) {
				logic();
				super.update();
			}
		}
		
		
		
//The player controls Young again.  Jumps into water and swims up to the next screen.  Sees Briar swimming up off the top of the screen.  Young struggles up through the water, sinking, the sides of the canal are steep, so Young sinks all the way into the water>
//<Briar, from offscreen>
 //Dude, Young.  
//<briar swims over to where young sank, goes underwater and comes back up, with Young>
//Kick your feet.  Move your arms.  Jeez, you wouldn’t last a minute without me!
		private function gof_logic():void {
			if (player.y > tl.y + 144) {
				player.y = tl.y + 144;
			}
			DH.disable_menu();
			switch (state_counter) {
				case 0:
					if (player.y < tl.y + 16 * 6) {
						player.y = tl.y + 16 * 6;
					}
					if (player.x < tl.x + 64) {
						player.x = tl.x + 64;
					}
					if (player.x > tl.x + 88) {
						player.x = tl.x + 88;
					}
					briar_ref.framePixels_y_push = 8;
					briar_ref.velocity.y = -20;
					briar_ref.play("walk_u");
					if (player.y < tl.y + 140 && player.framePixels_y_push > 14) {
						player.state = player.S_INTERACT;
						state_counter = 1;
					}
					break;
				case 1:
					DH.start_dialogue(DH.name_briar, "final");
					player.framePixels_y_push = 14;
					state_counter = 2;
					break;
				case 2:
					
					player.framePixels_y_push = 14;
					if (DH.a_chunk_is_playing() == false) {
						player.state = player.S_INTERACT;
						briar_ref.y = tl.y - 16;
						briar_ref.play("walk_d");
						player.play("idle_u");
						briar_ref.framePixels_y_push = 14;
						briar_ref.velocity.y = 25;
						state_counter = 3;
						
					}
					break;
				case 3:
					player.framePixels_y_push = 14;
					EventScripts.move_to_x_and_stop(briar_ref, 10, player.x);
					t_pushdown += FlxG.elapsed;
					if (t_pushdown > 0.4 && briar_ref.framePixels_y_push < 14) {
						briar_ref.framePixels_y_push++;
						t_pushdown = 0;
					}
					if (EventScripts.distance(briar_ref, player) < 7) {
						briar_ref.play("idle_d");
						briar_ref.velocity.y = briar_ref.velocity.x = 0;
						state_counter = 4;
					}
					break;
				case 4:
					t_pushdown += FlxG.elapsed;
					
					player.framePixels_y_push = briar_ref.framePixels_y_push;
					if (t_pushdown > 0.3 && briar_ref.framePixels_y_push > 0) {
						t_pushdown = 0;
						briar_ref.framePixels_y_push--;
						player.framePixels_y_push = briar_ref.framePixels_y_push;
					}
					// after rising from water play dialogue
					if (briar_ref.framePixels_y_push == 6) {
						state_counter = 5;
						DH.start_dialogue(DH.name_briar, "final");
						
					}
					break;
					
  //<Young starts treading water>  
//Well, come on, let’s go get a sandwich or something. 
//<briar swims up>
//SAGE: <walks up from the right side after briar leaves>
 //You... you did adequately.  Until we meet again.  
//<you regain control of young and can swim upwards off the screen (I think we shld just make it so that you can’t go down without really explaining it).  
//Once you do that, Sage stands there for a second.  
//All the tiles waver (like gas guy effect) and fade to white, with sage just standing in a white screen. 
 //Sage then walks back off to the right. 
 //Fade to credits.
				case 5:
					player.state = player.S_INTERACT;
					player.framePixels_y_push = 6;
					if (false == DH.a_chunk_is_playing()) {
						state_counter = 6;
						player.play("walk_r");
					}
					break;
				case 6:
					player.state = player.S_INTERACT;
					player.framePixels_y_push = 6;
					if (EventScripts.send_property_to(player, "x", tl.x + 85, 0.25)) {
						state_counter = 7;
						player.play("walk_l");
					}
					break;
				case 7:
					player.state = player.S_INTERACT;
					player.framePixels_y_push = 6;
					if (EventScripts.send_property_to(player, "x", tl.x + 65, 0.25)) {
						state_counter = 8;
						DH.start_dialogue(DH.name_briar, "final");
						player.play("idle_u");
					}
					break;
				case 8:
					player.state = player.S_INTERACT;
					player.framePixels_y_push = 6;
					if (false == DH.a_chunk_is_playing()) {
						briar_ref.play("walk_u");
						briar_ref.velocity.y = -25;
						state_counter = 9;
					}
					break;
				case 9:
					if (briar_ref.y < tl.y - 16) {
						x = tl.x + 160;
						y = player.y;
						play("walk_l");
						visible = true;
						velocity.x = -24;
						state_counter = 10;
					}
					break;
				case 10:
					if (x < tl.x + 128) {
						player.play("idle_r");
						play("idle_l");
						velocity.x = 0;
						DH.start_dialogue(DH.name_briar, "final");
						state_counter = 11;
					}
					break;
				case 11:
					player.framePixels_y_push = 6;
					if (player.y > tl.y + 150) {
						player.y = tl.y + 150;
					}
					if (player.x > tl.x + 92) {
						player.x = tl.x + 92;
					}
					if (player.x < tl.x + 68) {
						player.x = tl.x + 68;
					}
					if (player.y < tl.y + 80) {
						player.alpha -= 0.005;
					}
					if (player.y < tl.y + 8) {
						state_counter = 12;
						play("idle_u");
						t_pushdown = 0;
					}
					break;
					
				case 12:
					if (player.y < tl.y + 8) {
						player.y = tl.y + 8;
					}
					player.state = player.S_INTERACT;
					player.alpha -= 0.005;
					if (player.alpha < 0.005) {
						state_counter = 13;
					}
					break;
				case 13: 
					t_pushdown  += FlxG.elapsed;
					if (t_pushdown > 1) {
						state_counter = 14;
						t_pushdown = 0;
						Registry.GFX_WAVE_EFFECT_ON = true;
					}
					break;
				case 14:
					whitelayer.alpha += 0.002;
					if (whitelayer.alpha >= 1) {
						play("walk_r");
						velocity.x = 10;
						var p:PlayState;
						parent.black_overlay.alpha += 0.005;
						if (parent.black_overlay.alpha >= 1) {
							t_pushdown += FlxG.elapsed;
							
							Registry.volume_scale -= 0.0015;
							if (t_pushdown > 3 && Registry.volume_scale < 0.002) {
								DH.enable_menu();
								Registry.GE_States[Registry.GE_Finished_Game] = true;
								FlxG.switchState(new EndingState);
							}
						}
					}
					break;
				default:
					
					if (FlxG.volume < 0.002) {
						//Registry.volume_scale = 1;
						Registry.sound_data.stop_current_song();
						FlxG.switchState(new EndingState);	
					}
					break;
			}
		}
		
		private var t_pushdown:Number = 0;
		private var tm_pushdown:Number = 1;
		private var pushdown_val:int = 0;
		
		private function go_logic():void {
			switch (state_counter) {
				case 0:
					if (player.y < tl.y + 16 * 5) {
						player.state = player.S_INTERACT;
						player.be_idle();
						state_counter += 1;
						DH.dialogue_popup("biar: so gald u cud make it lol!");
					}
					break;
				case 1:
					if (DH.a_chunk_is_playing() == true) return;
					
					x = tl.x + 86;
					y = tl.y + 160;
						visible = true;
					play("walk_u");
					
					Registry.GAMESTATE.dialogue_latency = -1;
					DH.dialogue_popup("sag: heeeey dun forget me, lolz!");
					player.state = player.S_INTERACT;
					state_counter += 1;
					break;
				case 2:
					player.state = player.S_INTERACT;
					if (DH.a_chunk_is_playing() == false) {
						velocity.y = -20;
					}
					if (y < tl.y + 16 * 6) {
						velocity.y = 0;
						play("idle_u");
						DH.dialogue_popup("sage: Good work, now get out of here!");
						player.state = player.S_INTERACT;
						state_counter += 1;
					}
					break;
				case 3:
					if (DH.a_chunk_is_playing() == true) return;
					player.state = player.S_INTERACT;
					player.play("walk_u");
					briar_ref.play("walk_u");
					briar_ref.velocity.y = -20;
					briar_ref.alpha -= 0.005;
					player.alpha -= 0.005;
					velocity.y = 0;
					
					t_pushdown += FlxG.elapsed;
					if (t_pushdown > tm_pushdown) {
						t_pushdown = 0;
						if (pushdown_val < 16) pushdown_val += 1;
					}
					briar_ref.framePixels_y_push = pushdown_val;
					player.framePixels_y_push = pushdown_val;
					
					if (Registry.volume_scale > 0) Registry.volume_scale -= 0.01;
					if (player.y <= tl.y + 2) {
						player.velocity.y = 0;
						alpha -= 0.005;
						if (alpha <= 0 && Registry.volume_scale <= 0) {
							
							Registry.E_DESTROY_PLAYSTATE = true;
							Registry.sound_data.stop_current_song();
							Registry.reset_events();
							Registry.reset_subgroups();
							state_counter += 1;
						}
					} else {
						player.y -= 0.4;
					}
					break;
				case 4:
					Registry.sound_data.big_door_locked.play();
					FlxG.flash(0xffffffff, 3, function ():void	 { FlxG.switchState(new EndingState); } );
					// Load some image of the area.
					parent.header_group.setAll("exists", false);
					state_counter += 1;
					break;
				case 5:
					
					break;
			}
		}
		
		private var blank:Object = {
			played: false
		};
		
		private function blank_logic():void {
			if (!blank.played) {
				blank.played = true;
				if (dame_frame == 0 && DH.get_scene_position(DH.name_sage,DH.scene_sage_blank_intro) == 1) {
					player.be_idle();
					DH.dialogue_popup(DH.lookup_string("sage", "BLANK","intro", 1) + Registry.controls[Keys.IDX_ACTION_1] + DH.lookup_string("sage", "BLANK", "intro",2));
					DH.set_scene_to_pos(DH.name_sage, DH.scene_sage_blank_intro, 2);
				} else if (dame_frame == 1 && DH.get_scene_position(DH.name_sage, DH.scene_sage_blank_intro) == 2) {
					player.be_idle();
					DH.dialogue_popup(DH.lookup_string("sage", "BLANK", "intro",3) + Registry.controls[Keys.IDX_PAUSE] + DH.lookup_string("sage", "BLANK","intro", 4));
					DH.set_scene_to_pos(DH.name_sage, DH.scene_sage_blank_intro, 3);
				}
			}
		}
		
		private function crowd_logic():void {
			switch (state_counter) {
				case 0:
					DH.disable_menu();
					wait_then_approach_player(46, 24, "walk_d", "idle_d", "idle_u", 20, 2, DH.scene_sage_crowd_one, DH.name_sage, this);
					break;
				case 1:
					play_chunk_then_proceed(DH.scene_sage_crowd_one);
					break;
				case 2:
					DH.enable_menu();
					idle(DH.scene_sage_crowd_one);
					break;
			}
		}
		
		private function redcave_logic():void {
			switch (state_counter) {
				case 0:
					DH.disable_menu();
					wait_then_approach_player(28, 16, "walk_u", "idle_u", "idle_d", 20, 2, DH.scene_sage_crowd_one, DH.name_sage, this);
					break;
				case 1:
					play_chunk_then_proceed(DH.scene_sage_redcave_one);
					break;
				case 2:
					DH.enable_menu();
					idle(DH.scene_sage_redcave_one);
					
					break;
			}
		}
		
		private function bedroom_logic():void {
			switch (state_counter) {
				case 0:
					DH.disable_menu();
					wait_then_approach_player(48, 24, "walk_l", "idle_l", "idle_r", 20, 2, DH.scene_sage_bedroom_after_boss, DH.name_sage, this);
					break;
				case 1:
					play_chunk_then_proceed(DH.scene_sage_bedroom_after_boss);
					break;
				case 2:
					DH.enable_menu();
					idle(DH.scene_sage_bedroom_after_boss);
					break;
					
					
			}
		}
		private function nexus_logic():void {
			switch (state_counter) {
				case 0: // Initial cutscene when entering from bLANK
					wait_then_approach_player(64, 32, "walk_d", "idle_d", "idle_u", 20, 2, DH.scene_sage_nexus_enter_nexus, DH.name_sage, this);
					
					break;
				case 1:
					DH.disable_menu();
					play_chunk_then_proceed(DH.scene_sage_nexus_enter_nexus);
					
					break;
				case 2: // Idle logic, messages change based on game state
					DH.enable_menu();
					
					
					if (Registry.GE_States[Registry.GE_got_all_cards_inanarea] && DH.scene_is_dirty(DH.name_sage,DH.scene_sage_nexus_all_card_first) == false) {
						idle(DH.scene_sage_nexus_all_card_first);
					} else if (1 == Registry.CUTSCENES_PLAYED[Cutscene.Windmill_Opening]) {
						idle(DH.scene_sage_nexus_after_windmill);
					} else if (0 == Registry.CUTSCENES_PLAYED[Cutscene.Windmill_Opening] && Registry.GE_States[Registry.GE_Redcave_Boss_Dead_Idx] && Registry.GE_States[Registry.GE_Crowd_Boss_Dead_Idx]) {
						idle(DH.scene_sage_nexus_before_windmill);
					} else if (Registry.GE_States[Registry.GE_Bedroom_Boss_Dead_Idx]) {
						idle(DH.scene_sage_nexus_after_bed);
					} else if (Registry.GE_States[Registry.GE_ent_str]) {
						idle(DH.scene_sage_nexus_after_ent_str);
					} else {
						idle(DH.scene_sage_nexus_enter_nexus);
					}
					break;
			}
			
		}
		
		private function overworld_logic():void {
			switch (state_counter) {
				case 0:
					DH.disable_menu();
					wait_then_approach_player(56, 28, "walk_d", "idle_d", "idle_u", 20, 5, DH.scene_sage_overworld_bedroom_entrance, DH.name_sage, this);
					break;
				case 1:
					player.invincible_timer = 0.3;
					player.invincible = true;
					play_chunk_then_proceed(DH.scene_sage_overworld_bedroom_entrance);
					break;
				case 2:
					player.dontMove = true;
					player.state = player.S_GROUND;
					if (!b1 && player.broom.is_active()) {
						b1 = true;
					} else if (b1 && !player.broom.is_active()) {
						b1 = false;
						player.dontMove = false;
						player.state = player.S_INTERACT;
						state_counter++;
 						Registry.subgroup_interactives.push(this); 
					}
					
					
					break;
				case 3:
					play_chunk_then_proceed(DH.scene_sage_overworld_bedroom_entrance);
					if (state_counter != 3) {
						player.state = player.S_GROUND;
					}
					break;
				case 4:
					DH.enable_menu();
					idle(DH.scene_sage_overworld_bedroom_entrance);
					break;
				case 5:
					Registry.subgroup_interactives.push(this);
					state_counter = 4;
					
			}
		}
		public var ctr:int = 0;
		private function terminal_logic():void {
			
			active_region.x = x - 2;
			active_region.y = y - 2;
			immovable = true;
			FlxG.collide(this, player);
			EventScripts.face_and_play(this, player, "idle");
			if (ctr == 0) {
				if (EventScripts.distance(player, this) < 46) {
					// play intro text at least once
					if (DH.scene_is_dirty(DH.name_sage, DH.scene_sage_terminal_entrance) == false) {
						Registry.GAMESTATE.dialogue_latency = -1;
						player.be_idle();
						DH.start_dialogue(DH.name_sage, DH.scene_sage_terminal_entrance);
					}
					ctr++;
				}
			} else if (ctr == 1) {
				// autoplay if you have 36 or more
				if (DH.nc(player, active_region) || (EventScripts.distance(player, this) < 46 && Registry.nr_growths >= 36)) {
					player.be_idle();
					if (Registry.nr_growths < 18) {
						DH.start_dialogue(DH.name_sage, DH.scene_sage_terminal_entrance, "", 1);
					} else if (Registry.nr_growths < 36) {
						DH.start_dialogue(DH.name_sage, DH.scene_sage_terminal_entrance, "", 2);
					} else {		
						Registry.GAMESTATE.dialogue_latency = -1;
						DH.start_dialogue(DH.name_sage, DH.scene_sage_terminal_etc,"",0);				
						ctr++;
					}
				}
			} else if (ctr == 2) {
				if (DH.a_chunk_is_playing()  == false) {
					KeyBlock.sig_change = true;
					ctr++;
				}
			} else if (ctr == 3) {
				if (player.y < tl.y + 55) {
					xml.@alive = "false";
					DH.start_dialogue(DH.name_sage, DH.scene_sage_terminal_etc, "", 1);
					ctr++;
					player.be_idle();
				} else if (DH.nc(player, active_region)) {
					DH.dialogue_popup("...");
				}
			} else if (ctr == 4) {
			}
		}
		/**
		 * Wait, face the player, and talk if the player talks to them while standing on the ground
		 * @param	scene
		 */
		private function idle(scene:String):void 
		{
			FlxG.collide(this, player);
			EventScripts.face_and_play(this, player, "idle");
			if (Registry.keywatch.JP_ACTION_1 && player.state == player.S_GROUND && player.overlaps(active_region) && EventScripts.are_facing_opposite(this, player)) {
				EventScripts.face_and_play(player, this, "idle");
				DH.start_dialogue(DH.name_sage, scene);
				player.be_idle();
			}
		}
		
		private function play_chunk_then_proceed(scene:String):void 
		{	
			if (DH.a_chunk_just_finished()) {
				state_counter++;
				DH.dont_need_recently_finished();
			} else if (!DH.a_chunk_is_playing()) {
				DH.start_dialogue(DH.name_sage, scene);
			} 
		}
		
		/**
		 * Helper for sage waiting then appraoching the player, dealing with dirty scene if needed
		 * @param	init_distance	Distance at which NPC should approach player 
		 * @param	stop_distance	Distance at which NPC stops moving and plays final_anim
		 * @param	init_anim	Anim played by NPC when moving to player
		 * @param	final_anim	Anim played by NPC when stops moving
		 * @param	init_player_anim	Anim played by player when NPC moves to player
		 * @param	speed	Speed atwhich NPC moves to player
		 * @param	skip_to	If scene is dirty, what to set state_coutner to
		 * @param	scene	The name of the scene
		 * @param	npc_name	Name of the NPC
		 * @param	npc_ref	The reference of the npc that will be moving
		 */
		private function wait_then_approach_player(init_distance:int, stop_distance:int, init_anim:String,final_anim:String,init_player_anim:String,speed:int,skip_to:int,scene:String,npc_name:String,npc_ref:*):void 
		{
			if (player.state != player.S_AIR && EventScripts.distance(player, npc_ref) < init_distance) {
				player.state = player.S_INTERACT; // Freeze the player.
				npc_ref.play(init_anim);
				EventScripts.scale_vector(npc_ref, player, velocity, speed);
				
				if (EventScripts.distance(player, npc_ref) < stop_distance) {
					DH.dont_need_recently_finished();
					npc_ref.play(final_anim);
					velocity.y = velocity.x = 0;
					state_counter++;
				}
				
				
				if (DH.scene_is_dirty(npc_name, scene)) {
					DH.dont_need_recently_finished();
					state_counter = skip_to;
					velocity.y = velocity.x = 0;
					player.state = player.S_GROUND;
					return;
				}
				player.play(init_player_anim);
			}
		}
		
		public function on_anim_change(name:String, frame:int, index:int):void {
			if (name == "walk_l" || name == "idle_l") {
				scale.x = -1;
			} else {
				scale.x = 1;
			}
		}
		
		override public function destroy():void 
		{
			
			if (briar_ref != null) {
				parent.sortables.remove(briar_ref, true);
				briar_ref.destroy();
				briar_ref = null;
			}
			
			if (whitelayer != null) {
				parent.sortables.remove(whitelayer, true);
				whitelayer.destroy();
				whitelayer = null;
			}
			
			DH.a_chunk_just_finished();
			DH.enable_menu();
			super.destroy();
		}
		
	}

}