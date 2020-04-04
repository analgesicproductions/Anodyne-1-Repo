package entity.interactive.npc 
{
	import data.CLASS_ID;
	import entity.gadget.Dust;
	import entity.gadget.Treasure;
	import flash.geom.Point;
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.AnoSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import states.PauseState;
	
	/**
	 * ...
	 * @author Melos Han-Tani
	 */
	public class Trade_NPC extends AnoSprite 
	{
		
		public static const cid:int = CLASS_ID.TRADE_NPC;
		private static const T_CAT:int = 0;
		private static const T_MONSTER_OUT:int = 2;
		private static const T_MONSTER_IN:int = 1;
		private static const T_SHOP:int = 3;
		private static const T_ICKY:int = 4;
		
		public var active_region:FlxSprite;
		private var do_update:Function;
		
		public static var cat_ref:FlxSprite;
		public static var cat_dust_ref:FlxSprite;
		private static const s_cat_wait:int = 0;
		private static const s_cat_follow:int = 1;
		private static const s_cat_water:int = 2;
		private static const s_cat_init_scene:int = 3;
		
		private var monster_box:FlxSprite;
		private var monster_box_ar:FlxSprite;
		private var other_cat:FlxSprite;
		private const s_monst_out_present:int = 0; 
		private const s_monst_out_gone:int = 1;
		private const s_monst_out_spooked:int = 2;
		
		
		private const s_monst_in_unhelped:int = 0;
		private const s_monst_in_helped:int = 1;
		private const s_monst_in_giving:int = 2;
		private var dusts:FlxGroup;
		
		private var items:FlxGroup;
		private var card:FlxSprite;
		private const s_shop_helped:int = 0;
		private const s_shop_unhelped:int = 1;
		
		private var ctr:int = 0;
		
		[Embed(source = "../../../res/sprites/npcs/fields_npcs.png")] public static const embed_dame_trade_npc:Class;
		
		
		public function Trade_NPC(args:Array) 
		{
			super(args);
			
			immovable = true;
			active_region = new FlxSprite(0, 0);
			active_region.makeGraphic(20, 20, 0x00000000);
			Registry.subgroup_interactives.push(this);
			
			// Registry.cleanup_on_map_change dealsw ith removnig the cat from memory.
			switch (parseInt(xml.@frame)) {
				case T_CAT:
					if (cat_ref == null) {
						loadGraphic(embed_dame_trade_npc, true, false, 16, 16);
						addAnimation("walk_d", [0,1], 4);
						addAnimation("walk_r", [2,3], 4);
						addAnimation("walk_u", [4,5], 4);
						addAnimation("walk_l", [6, 7], 4);
						width = height = 12;
						offset.x = offset.y = 2;
						play("walk_d");
						parent.bg_sprites.add(this);
						state = s_cat_wait;
						do_update = u_cat;
						
						cat_dust_ref = new FlxSprite;
						cat_dust_ref.loadGraphic(Dust.DUST_SPRITE, true, false, 16, 16);
						cat_dust_ref.addAnimation("poof", [0, 1, 2, 3, 4], 13, false);
						cat_dust_ref.addAnimation("unpoof", [3, 2, 1, 0], 13, false);
						cat_dust_ref.visible = false;
						parent.sortables.add(cat_dust_ref);
						cat_dust_ref.frame = Dust.EMPTY_FRAME;
						
					} else {
						exists = false;
					}
					
					break;
				case T_MONSTER_OUT:
					
					
					
					if (false == Registry.inventory[Registry.IDX_BOX] && false == Registry.GE_States[Registry.GE_tradequesthelpedshopkeeper]) { // Box is not taken, and not given to shop guy yet.
						
						monster_box = new FlxSprite(x, y - 20);
						monster_box.loadGraphic(embed_dame_trade_npc, true, false, 16, 16);
						monster_box.addAnimation("closed", [31], 1);
						monster_box.addAnimation("open", [32], 1);
						monster_box.play("closed");
						monster_box.immovable = true;
						monster_box_ar = new FlxSprite(x, y);
						
						other_cat = new FlxSprite(x, y - 30);
						other_cat.loadGraphic(embed_dame_trade_npc, true, false, 16, 16);
						other_cat.addAnimation("walk_d", [10,11], 4);
						other_cat.addAnimation("walk_r", [12,13], 4);
						other_cat.addAnimation("walk_u", [14,15], 4);
						other_cat.addAnimation("walk_l", [16,17], 4);
						other_cat.play("walk_d");
						other_cat.visible = false;
						
						parent.sortables.add(monster_box);
						parent.sortables.add(other_cat);
					}
					
					// already spooked
					if (Registry.GE_States[Registry.GE_tradequestspookedmonster]) {
						visible = false;
						// If we have the box or have given it to the shopkeeper
						// then do not make anything appear.
						if (Registry.inventory[Registry.IDX_BOX] || Registry.GE_States[Registry.GE_tradequesthelpedshopkeeper]) {
							exists = false;
						}
						state = s_monst_out_gone;
					} else { // not spooked
						loadGraphic(embed_dame_trade_npc, true, false, 16, 16);
						addAnimation("walk_d", [20,21], 4);
						addAnimation("walk_r", [22,23], 4);
						addAnimation("walk_u", [24,25], 4);
						addAnimation("walk_l", [26,27], 4);
						play("walk_d");
						state = s_monst_out_present;
					}
					
					do_update = u_monster_out;
					break;
				case T_MONSTER_IN:
					
					if (Registry.GE_States[Registry.GE_tradequestspookedmonster]) {
						
						loadGraphic(embed_dame_trade_npc, true, false, 16, 16);
						addAnimation("walk_d", [20,21], 4);
						addAnimation("walk_r", [22,23], 4);
						addAnimation("walk_u", [24,25], 4);
						addAnimation("walk_l", [26,27], 4);
						play("walk_d");
						if (Registry.GE_States[Registry.GE_tradequesthelpedmonster]) {
							state = s_monst_in_helped;
							
						} else {
							state = s_monst_in_unhelped;
							
							dusts = new FlxGroup(3);
							for (var i:int = 0; i < dusts.maxSize; i++) {
								var dust:Dust = new Dust(0, 0, null, parent);
								dust.x = tl.x + 16;
								dust.y = tl.y + 16 + 32 * i;
								dusts.add(dust);
							}
						}
						
					} else {
						exists = false;
					}
					
					parent.bg_sprites.add(dusts);
					
					do_update = u_monster_in;
					break;
				case T_SHOP:
					loadGraphic(embed_dame_trade_npc, true, false, 16, 16);
					addAnimation("a", [50,51], 4);
					play("a");
					if (Registry.GE_States[Registry.GE_tradequesthelpedshopkeeper]) {
						state = s_shop_helped;
					} else {
						state = s_shop_unhelped;
					}
					
					items = new FlxGroup(3);
					for (i = 0; i < 3; i++) {
						var item:FlxSprite = new FlxSprite;
						item.loadGraphic(embed_dame_trade_npc, true, false, 16, 16);
						if (i == 2) {
							if (state == s_shop_helped || Registry.inventory[Registry.IDX_JUMP]) {
								item.frame = 57;
							} else {
								item.frame = 56;
							}
						} else {
							item.frame = 54 + i;
						}
						
						item.x = x - 30 + 34 * i;
						item.y = y + 32;
						items.add(item);
					}
					
					parent.bg_sprites.add(items);
					card = new FlxSprite;
					card.loadGraphic(PauseState.card_sheet_embed, true, false, 24, 24);
					card.frame = Registry.CARD_GOLDMAN_IDX;
					card.visible = false;
					parent.fg_sprites.add(card);
					do_update = u_shop;
					break;
				case T_ICKY:
					if (Registry.GE_States[Registry.GE_tradequestspookedmonster] == false) {
						exists = false;
					}
					loadGraphic(embed_dame_trade_npc, true, false, 16, 16);
					addAnimation("walk_d", [10,11], 4);
					addAnimation("walk_r", [12,13], 4);
					addAnimation("walk_u", [14,15], 4);
					addAnimation("walk_l", [16, 17], 4);
					play("walk_d");
					do_update = u_icky;
					break;
			}
		}
		
		override public function destroy():void 
		{
			parent.sortables.remove(monster_box,true);
			if (monster_box != null)  {
				monster_box.destroy();
				monster_box = null;
			}
			
			parent.sortables.remove(other_cat,true);
			if (other_cat != null)  {
				other_cat.destroy();
				other_cat = null;
			}
			
			
			parent.intra_bg_bg2_sprites.remove(dusts, true);
			if (dusts != null)  {
				dusts.destroy();
				dusts = null;
			}
			
			card = null;
			items = null;
			
			
			active_region.destroy();
			active_region = null;
			
			super.destroy();
		}
		override public function update():void 
		{
			do_update();
			super.update();
		}
		
		public var midpoint:Point = new Point();
		public var ON_CONVEYER:Boolean = false;
		override public function preUpdate():void 
		{
			
			
			if (parseInt(xml.@frame) == T_CAT) {
				FlxG.collide(this, parent.curMapBuf);
			}
			super.preUpdate();
		
		}		
		
		private function u_icky():void {
			EventScripts.face_and_play(this, player, "walk");
			active_region.x = x - 2;
			active_region.y = y - 2;
			immovable = true;
			FlxG.collide(player, this);
			if (DH.nc(player, active_region)) {
				DH.start_dialogue(DH.name_miao, "icky");
			}
		}
		
		
		private var t_talk:Number = 0;
		private var tm_talk:Number = 2.5;
		private static const cat_idx_shop:int = 0;
		private static const cat_idx_mitra:int = 1;
		private static const cat_idx_nexus:int = 2;
		private static const cat_idx_icky_worry:int = 3;
		private static const cat_idx_leave_map:int = 4;
		private var hasnt_left:Boolean = true; // said the leave map dialogue?
		
		private function u_cat():void {
			
			midpoint.x = x + (width / 2);
			midpoint.y = y + (height / 2);
			switch (state) {
				case s_cat_wait:
					active_region.x = x - 2;
					active_region.y = y - 2;
					FlxG.collide(this, player);
					if (player.overlaps(active_region) && false == DH.a_chunk_is_playing() && Registry.keywatch.JP_ACTION_1) {
						if (true == Registry.GE_States[Registry.GE_tradequestspookedmonster] && false == DH.scene_is_finished(DH.name_miao, DH.scene_miao_philosophy)) {
							DH.start_dialogue(DH.name_miao, DH.scene_miao_philosophy);
							player.be_idle();
							return;
						}
						if (DH.scene_is_dirty(DH.name_miao, DH.scene_miao_init)) {
							DH.start_dialogue(DH.name_miao, DH.scene_miao_init, "", 2);
							state = s_cat_follow;
						} else {
							DH.start_dialogue(DH.name_miao, DH.scene_miao_init);
							state = s_cat_init_scene;
							ctr = 0;
						}
						player.be_idle();
						cat_ref = this;
						parent.bg_sprites.remove(cat_ref, true);
						parent.sortables.add(cat_ref);
					}
					break;
				case s_cat_init_scene:
					if (ctr == 0) {
						if (false == DH.a_chunk_is_playing()) {
							ctr = 1;
							//Attack
						}
					} else if (ctr == 1) {
						// When attack over
						ctr = 2;
						Registry.GAMESTATE.dialogue_latency = -1;
						DH.start_dialogue(DH.name_miao, DH.scene_miao_init);
						player.be_idle();
						state = s_cat_follow;
					}
					break;
				case s_cat_follow:
					immovable = false;
					// jank
					if (EventScripts.get_tile_nr(midpoint.x, midpoint.y, parent.curMapBuf) == 250) {
						ON_CONVEYER = true;
					}
					
					if (EventScripts.distance(player.midpoint, midpoint) > 16) {
						EventScripts.scale_vector(midpoint, player.midpoint, velocity, 70);
					} else {
						velocity.x = velocity.y = 0;
					}
					
					if (touching & (UP | DOWN)) {
						velocity.y = 0;
					}
					
					if (touching & (LEFT | RIGHT)) {
						velocity.x = 0;
					}
					
					if (velocity.x == 0 && velocity.y == 0) {
						// Do nothing
					} else if (Math.abs(velocity.x) > Math.abs(velocity.y)) {
						if (velocity.x > 0) {
							play("walk_r");
						} else {
							play("walk_l");
						}
					} else {
						if (velocity.y > 0) {
							play("walk_d");
						} else {
							play("walk_u");
						}
					}
					
					// Determine events
					gx = Registry.CURRENT_GRID_X;
					gy = Registry.CURRENT_GRID_Y;
					
					if (gx == 7 && gy == 4) { // shop
						if (DH.get_int_property(DH.name_shopkeeper,"talkedto") != -1) {
							if (t_talk > tm_talk) t_talk = 0; // Want the timer to be local to this room
							t_talk += FlxG.elapsed;
							if (false == DH.a_chunk_is_playing() && t_talk > tm_talk && DH.get_int_property(DH.name_miao, "shop") == -1) {
								Registry.GAMESTATE.dialogue_latency = -1;
								DH.start_dialogue(DH.name_miao, DH.scene_miao_randoms, "", cat_idx_shop);
								player.be_idle();
								DH.increment_property(DH.name_miao, "shop");
							}
						}
					} else if (gx == 5 && gy == 4) { // Mitra
						if (false == DH.a_chunk_is_playing() && DH.scene_is_dirty(DH.name_mitra, DH.scene_mitra_fields_init) == true) {
							if (t_talk > tm_talk) t_talk = 0;
							t_talk += FlxG.elapsed;
							if (t_talk > tm_talk && DH.get_int_property(DH.name_miao, "mitra") == -1) {
								Registry.GAMESTATE.dialogue_latency = -1;
								player.be_idle();
								DH.start_dialogue(DH.name_miao, DH.scene_miao_randoms, "", cat_idx_mitra);
								player.be_idle();
								DH.increment_property(DH.name_miao, "mitra");
							}
						}
					 	
					} else if (gx == 6 && gy == 3) { // Nexus pad
						if (t_talk > tm_talk) t_talk = 0;
						t_talk += FlxG.elapsed;
						if (t_talk > tm_talk && DH.get_int_property(DH.name_miao, "nexus") == -1) {
							DH.start_dialogue(DH.name_miao, DH.scene_miao_randoms, "", cat_idx_nexus);
							player.be_idle();
							DH.increment_property(DH.name_miao, "nexus");
						}
						
					} else {
						t_talk += FlxG.elapsed;
						if (t_talk > 70 && DH.a_chunk_is_playing() == false) {
							Registry.GAMESTATE.dialogue_latency = -1;
							t_talk = 0;
							if (Registry.GE_States[Registry.GE_tradequestspookedmonster] == false) {
								player.be_idle();
								DH.start_dialogue(DH.name_miao, DH.scene_miao_randoms, "", cat_idx_icky_worry);
							} else if (DH.get_int_property(DH.name_miao,"nexus") != -1 && DH.get_int_property(DH.name_miao,"mitra") != -1 && DH.get_int_property(DH.name_miao,"shop") != -1) {
								DH.start_dialogue(DH.name_miao, DH.scene_miao_randoms, "", 5 + int(3 * Math.random()));
								trace("Saying random");
							} 
						}
					}
					
					// Say something if you leave the map
					if ( // 3,3  7,5
						(Registry.CURRENT_GRID_Y < 2 || Registry.CURRENT_GRID_Y > 5 || Registry.CURRENT_GRID_X < 3 || Registry.CURRENT_GRID_X > 7)
						|| (Registry.GAMESTATE.SWITCH_MAPS == true && hasnt_left == true) ) {
						hasnt_left = false;
						player.be_idle();
						leavingleaving = true;
						DH.start_dialogue(DH.name_miao, DH.scene_miao_randoms, "", cat_idx_leave_map);
					}
					
					if (leavingleaving && Registry.GAMESTATE.state != Registry.GAMESTATE.S_TRANSITION) {
						Registry.GAMESTATE.sortables.remove(Trade_NPC.cat_ref, true);
						Registry.GAMESTATE.sortables.remove(Trade_NPC.cat_dust_ref, true);
						state = s_cat_water;
						cat_ref = null;
						cat_dust_ref = null;
					}
					// go to water
					//if distance > 16 from center, move towardsplayer
					
					if (cat_dust_ref != null) {
						cat_dust_ref.x = x - 2;
						cat_dust_ref.y = y;
						cat_dust_ref.height = 3;
					
						if (player.ON_CONVEYER) ON_CONVEYER = true;
						if (ON_CONVEYER && cat_dust_ref.frame == Dust.EMPTY_FRAME) {
							cat_dust_ref.play("unpoof");
							cat_dust_ref.visible = true;
						} else if (!ON_CONVEYER && cat_dust_ref.frame == 0) {
							cat_dust_ref.play("poof");
						}
					}
				
					break;
				case s_cat_water:
					break;
			}
			
			ON_CONVEYER = false;
		}
		private var leavingleaving:Boolean = false;
		
		private static const goldman_idx_run_away:int = 0;
		private static const goldman_idx_give_card:int = 1;
		private static const goldman_idx_box_open:int = 2;
		private static const goldman_idx_icky_thx:int = 3;
		private function u_monster_out():void {
			if (state == s_monst_out_present) {
				if (visible) {
					FlxG.collide(this, player);
				}
			
			}
			
			if (monster_box.visible) {
				FlxG.collide(player, monster_box);
			}
			
			// Monster present, run away if you have the cat
			if (state == s_monst_out_present) {
				active_region.x = x - 2;
				active_region.y = y - 2;
				
				if (DH.a_chunk_is_playing() == false && player.overlaps(active_region) && Registry.keywatch.JP_ACTION_1) {
					player.be_idle();
					if (cat_ref == null) {
						DH.start_dialogue(DH.name_goldman, DH.scene_goldman_outside);
					} else {
						DH.start_dialogue(DH.name_goldman, DH.scene_goldman_etc,"",goldman_idx_run_away);
						Registry.GE_States[Registry.GE_tradequestspookedmonster] = true;
						state = s_monst_out_spooked;
					}
				}			
			// Mosnster, animate it running into cave
			} else if (state == s_monst_out_spooked) {
				if (ctr == 0) {
					player.state = player.S_INTERACT;
					if (false == DH.a_chunk_is_playing()) {
						velocity.y = -40;
						play("walk_u");
						ctr = 1;
					}
				} else if (ctr == 1) {
					if (y < tl.y + 6 * 16) {
						play("walk_r");
						velocity.y = 0;
						velocity.x = 40;
						if (x > tl.x + 160) {
							visible = false;
							player.state = player.S_GROUND;
							ctr = 0;
							state = s_monst_out_gone;	
						}
					}
				}	
				
			// Monster gone. If we're here wait till we interact with box
			// then make it dispappear, small cat pops out, state, etc.
			} else if (state == s_monst_out_gone) {
				monster_box_ar.x = monster_box.x - 2;
				monster_box_ar.y = monster_box.y + 2;
				
				if (ctr == 0) {
					if (DH.a_chunk_is_playing() == false && player.overlaps(monster_box_ar)  && Registry.keywatch.JP_ACTION_1) {
						Registry.GAMESTATE.dialogue_latency = -1;
						Registry.sound_data.broom_hit.play();
						player.actions_disabled = true;
						player.be_idle();
						DH.disable_menu();
						ctr = 1;
						DH.start_dialogue(DH.name_goldman, DH.scene_goldman_etc, "", goldman_idx_box_open);
						monster_box.frame += 1;
						Registry.inventory[Registry.IDX_BOX] = true;
					}
				} else if (ctr == 1) {
					player.actions_disabled = true;
					if (DH.a_chunk_is_playing() == false) {
						other_cat.visible = true;
						monster_box.visible = false; // make box disappear
						monster_box_ar.x -= 1000;
						player.state = player.S_INTERACT;
						player.be_idle();
						other_cat.velocity.x = 20;
						other_cat.play("walk_r");
						ctr = 2;
					}
					
				} else if (ctr == 2) {
					if (other_cat.x > tl.x + 85) {
						other_cat.velocity.x = 0;
						if (DH.a_chunk_is_playing() == false) {
							ctr = 3;
							Registry.GAMESTATE.dialogue_latency = -1;
						DH.start_dialogue(DH.name_goldman, DH.scene_goldman_etc,"", goldman_idx_icky_thx);
							other_cat.play("walk_d");
						}
					}
				} else if ( ctr == 3) {
					player.actions_disabled = true;
					player.state = player.S_INTERACT;
					if (DH.a_chunk_is_playing() == false) {
						player.state = player.S_GROUND;
						DH.enable_menu();	
						other_cat.play("walk_r");
						other_cat.velocity.x = 40;
						ctr = 4;
					} 
				} else if (ctr == 4) {
					if (other_cat.x > tl.x + 6 * 16) {
						other_cat.velocity.x = 0;
						other_cat.play("walk_d");
						ctr++;
					}
				} else if (ctr == 5) {
					monster_box_ar.x = other_cat.x - 2;
					monster_box_ar.y = other_cat.y - 2;
					monster_box_ar.width = 20;
					monster_box_ar.height = 20;
					
					other_cat.immovable = true;
					FlxG.collide(player, other_cat);
					if (player.overlaps(monster_box_ar)) {
						player.actions_disabled = true;
					}
					if (DH.nc(player, monster_box_ar)) {
						player.actions_disabled = true;
						player.be_idle();
						DH.start_dialogue(DH.name_goldman, DH.scene_goldman_etc,"",goldman_idx_icky_thx+1);
					}
				}
			}

		}
		
		private function u_monster_in():void {
			FlxG.collide(this, player);
			active_region.x = x - 2;
			active_region.y = y - 2;
			if (DH.a_chunk_is_playing() == false && player.overlaps(active_region) && Registry.keywatch.JP_ACTION_1) {
				player.be_idle();
				if (Registry.GE_States[Registry.GE_tradequesthelpedmonster]) {
					DH.start_dialogue(DH.name_goldman, DH.scene_goldman_etc, "", goldman_idx_give_card);
				} else {
					DH.start_dialogue(DH.name_goldman, DH.scene_goldman_inside);
				}
			}
			
			if (state == s_monst_in_unhelped) {
				var exists_ct:int = 0;
				for each (var dust:Dust in dusts.members) {
					
					if (!dust.fell_in_hole) {
						exists_ct ++;
					}
				}
				
				for each (dust in Registry.subgroup_dust) {
					if (dust != null && !dust.fell_in_hole) {
						exists_ct += 1;
					}
				}
				if (exists_ct == 0) {
					state = s_monst_in_giving;
				}
			} else if (state == s_monst_in_helped) {
				x = tl.x + 16 * 7;
			} else if (state == s_monst_in_giving) {
				if (ctr == 0) {
					DH.start_dialogue(DH.name_goldman, DH.scene_goldman_etc, "", goldman_idx_give_card);
					ctr = 1;
				} else if (ctr == 1) {
					// give gift
					Registry.GE_States[Registry.GE_tradequesthelpedmonster] = true;
					ctr = 2;
				} else if (ctr == 2) {
					velocity.x = 20;
					play("walk_r");
					if (x  > tl.x + 16 * 7) {
						velocity.x = 0;
						play("walk_d");
						state = s_monst_in_helped;
					}
				}
			}
		}
		
		private var shop_start_anim:Boolean = false;
		private var shop_array:Array = new Array(false, false, false, false);
		private var shop_card_start:Boolean = false;
		private var shop_ctr:int = 0;
		
		private function u_shop():void {
			FlxG.collide(this, player);
			active_region.x = x - 2;
			active_region.y = y - 2;
			
			//if (FlxG.keys.justPressed("B")) {
				//Registry.inventory[Registry.IDX_BOX] = true;
			//} else if (FlxG.keys.justPressed("W")) {
				//Registry.inventory[Registry.IDX_JUMP] = true;
				//Registry.card_states[Registry.CARD_GOLDMAN_IDX] = 1;
			//} else if (FlxG.keys.justPressed("Q")) {
				//Registry.inventory[Registry.IDX_JUMP] = true;
				//Registry.card_states[Registry.CARD_GOLDMAN_IDX] = 0;
			//} else if (FlxG.keys.justPressed("R")) {
				//state = s_shop_unhelped;
			//}
			
			if (shop_card_start) {
				if (shop_ctr == 0) {
					if (parent.state != parent.S_DIALOGUE) {
						card.visible = true;
						card.x = player.x - 8;
						card.y = player.y - 8;
						Registry.sound_data.get_treasure.play();	
						shop_ctr ++;
					}
				} else if (shop_ctr == 1) {
					card.flicker(2);
					shop_ctr++;
				} else if (shop_ctr == 2) {
					if (card.flickering == false) {
						card.exists = false;
					}
				}
			}
			
			
			if (Registry.PLAYSTATE.state != Registry.PLAYSTATE.S_DIALOGUE && player.overlaps(active_region) && Registry.keywatch.JP_ACTION_1) {
				player.be_idle();
				if (DH.get_int_property(DH.name_shopkeeper, "talkedto") == -1) {
					DH.increment_property(DH.name_shopkeeper, "talkedto");
					//DH.dialogue_popup("Finty: Welcome, welcome, my friend Young!  The name’s Prasandhoff--Finty Prasandhoff!  Take a look around at my shop and see if anything catches your eye!");
					DH.dialogue_popup(DH.lk("tradenpc", 0));
				}else if (state == s_shop_helped) {
					//DH.dialogue_popup("Finty: I still appreciate that box!");
					DH.dialogue_popup(DH.lk("tradenpc", 1));
				} else {
					if (Registry.inventory[Registry.IDX_BOX]) {
						Registry.inventory[Registry.IDX_BOX] = false;
						state = s_shop_helped;
						Registry.GE_States[Registry.GE_tradequesthelpedshopkeeper] = true;
						if (Registry.inventory[Registry.IDX_JUMP] && Registry.card_states[Registry.CARD_GOLDMAN_IDX]) {
							//DH.dialogue_popup("Finty: Ah, a box! Thank you so much! Now I can carry all my inventory home at night and back in the morning! As a token of my gratitude, take this ugly--I mean beautiful, collector's edition card!^ Wait a minute...it's not here! What happened to it? Well, here, let me ease your wounds instead!");//Goldman card
							DH.dialogue_popup(DH.lk("tradenpc", 2)+" "+DH.lk("tradenpc",11)+" "+DH.lk("tradenpc",3));
							player.health_bar.modify_health(20);
						}  else if (Registry.inventory[Registry.IDX_JUMP] && Registry.card_states[Registry.CARD_GOLDMAN_IDX] == 0) {
							//DH.dialogue_popup("Finty: Ah, a box! Thank you so much! Now I can carry all my inventory home at night and back in the morning! As a token of my gratitude, take this ugly--I mean beautiful, collector's edition card!");
							DH.dialogue_popup(DH.lk("tradenpc", 2)+" "+DH.lk("tradenpc", 11));
							Registry.card_states[Registry.CARD_GOLDMAN_IDX] = 1;
							Registry.nr_growths++;
							shop_card_start = true;
						} else {
							//DH.dialogue_popup("Finty: Ah, a box! Thank you so much! Now I can carry all my inventory home at night and back in the morning! As a token of my gratitude, take these stylish biking shoes!");
							DH.dialogue_popup(DH.lk("tradenpc", 2)+" "+DH.lk("tradenpc",4));
							Registry.inventory[Registry.IDX_BIKE_SHOES] = true;
							shop_start_anim = true;
						}
						// Give the player the BIKE SHOEZ or a NICE GIFT
					} else {
						//DH.dialogue_popup("Fine morning out, isn't it, my friend?  A fine morning for shopping! I just wish I had a box to carry my inventory around.");
						DH.dialogue_popup(DH.lk("tradenpc", 5));
					}
				}
			}
			
			
			if (shop_start_anim) {
				
				if (items.members[2].frame != 57) {
					items.members[2].acceleration.y = -10;
					
					if (items.members[2].velocity.y < -10 && items.members[2].velocity.y > -15) {
						items.members[2].flicker(1);
					}
					
					if (items.members[2].velocity.y < -25) {
						if (items.members[2].flickering == false) {
							items.members[2].alpha = 0;
							items.members[2].velocity.y = items.members[2].acceleration.y = 0;
							items.members[2].y = items.members[1].y;
							items.members[2].frame = 57;
						}
					}
				} else if (items.members[2].frame == 57) {
					items.members[2].alpha += 0.01;
					if (items.members[2].alpha >= 1) {
						shop_start_anim = false;
					}
				}
			}
			for each (var item:FlxSprite in items.members) {
				item.immovable = true;
				FlxG.collide(player, item);
				if (player.x < item.x  + item.width + 2 && player.x + player.width > item.x - 2&& player.y < item.y + item.height + 2 && player.y +player.height > item.y - 2) {
					if (DH.a_chunk_is_playing() == false && Registry.keywatch.JP_ACTION_1) {
						player.actions_disabled = true;
						player.be_idle();
						if (shop_array[item.frame - 54]) {
							DH.dialogue_popup("Too bad, looks like you can't afford this item!  Come back later, when you have the cash!");
							
							DH.dialogue_popup(DH.lk("tradenpc", 6));
							break;
						}
						switch (item.frame) {
							case 54:
								//DH.dialogue_popup("Finty: Ah, you have a fine eye! You need a better weapon, don't you? Blow your enemies to pieces for only $499.99!");
							DH.dialogue_popup(DH.lk("tradenpc", 7));
								shop_array[0] = true;
								break;
							case 55:
								//DH.dialogue_popup("Finty: That money sack will allow you to accumulate money that you find in The Land! It's yours for a mere $869.99!");
							DH.dialogue_popup(DH.lk("tradenpc", 8));
								shop_array[1] = true;
								break;
							case 56:
								//DH.dialogue_popup("Finty: Oh ho ho, here's a specialty item indeed: clip-in bike shoes so you can be speedy AND stylish! On sale now for just $299.99!");
							DH.dialogue_popup(DH.lk("tradenpc", 9));
								shop_array[2] = true;
								break;
							case 57:
								//DH.dialogue_popup("Finty: Tired of shoving dust around with your piddling little broom?  Eradicate harmful dust particles with this state-of-The-Art vacuum cleaner! Just $749.99, or four easy, monthly payments of $199.99!");
							DH.dialogue_popup(DH.lk("tradenpc", 10));
								shop_array[3] = true;
								break;
						} 
					}
				}
			}
		}
		
	}

}