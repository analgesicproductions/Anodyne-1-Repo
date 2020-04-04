package entity.gadget 
{
	/**
	 * A keyblock. These open up if you have a key.
	 * Its sprite is set based on the frame in the level editor.
	 * Alive refers to whether it has been opened. DUHH
	 * @author Seagaia
	 */
	import data.CLASS_ID;
	import data.Common_Sprites;
	import entity.interactive.NPC;
	import entity.player.Player;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import data.SoundData;
	import global.Registry;

	public class KeyBlock extends FlxSprite
	{
		
		public var type:String = "KeyBlock";
		public var O:int = 16; //Offset for animation when unlocked
		public var xml:XML;
		public var cid:int = CLASS_ID.KEYBLOCK;
		public var sentinel:FlxSprite; 
		public var active_region:FlxSprite;
		
		private var is_big:Boolean = false;
		private var player:Player;
		private var start_unlock_anim:Boolean = false;
		private var ctr:int = 0;
		private var key_sprite:FlxSprite;
		private var t:Number = 0;
		private var tm:Number = 0.8;
		
		public static var sig_change:Boolean = false;
		private var explosion:FlxSprite;
		
		[Embed (source = "../../res/sprites/gadgets/keyhole.png")] public var C_KEYBLOCK_SPRITE:Class;
		[Embed (source = "../../res/sprites/gadgets/gate_green.png")] public var green_gate_embed:Class;
		/**
		 * 
		 * @param	_x
		 * @param	_y
		 * @param	_frame frame type
		 * @param	_xml  Reference to the sprites xml (if any)
		 */
		public function KeyBlock(_x:int, _y:int, _frame:int,_player:Player,_xml:XML = null) 
		{
			super(_x , _y);
			sentinel = new FlxSprite(x -2, y - 2);
			sentinel.immovable = true;
			sentinel.makeGraphic(20, 20, 0x00ffffff);
			
			loadGraphic(C_KEYBLOCK_SPRITE, true, false, 16, 16);
			
			frame = _frame;
			immovable = true;
			if (_xml != null) {
				xml = _xml;
			}
			
			if (frame == 2 && Registry.CURRENT_MAP_NAME == "OVERWORLD") {
				loadGraphic(green_gate_embed, true, false, 32, 16);
				addAnimation("open", [0, 1, 2, 3, 4, 5], 12, false);
				is_big = true;
				if (xml.@alive == "false") {
					exists = false;
				}
			} else if (Registry.CURRENT_MAP_NAME == "WINDMILL") {
				switch (frame) {
					case 1:
						loadGraphic(green_gate_embed, true, false, 32, 16);
					addAnimation("open", [7, 1, 2, 3, 4, 5], 12, false);
						frame = 7;
						break;
						//blue
					case 2:
						loadGraphic(green_gate_embed, true, false, 32, 16);
					addAnimation("open", [0, 1, 2, 3, 4, 5], 12, false);
						break;
						//green
					case 3:
						loadGraphic(green_gate_embed, true, false, 32, 16);
						frame = 6;
					addAnimation("open", [6, 1, 2, 3, 4, 5], 12, false);
						break;
						//redcave
				}
					if (xml.@alive == "false") {
						exists = false;
					}
					is_big = true;
			} else if (frame == 4) { // card gate
				loadGraphic(green_gate_embed, true, false, 32, 16);
				if (xml.@alive == "false") {
					exists = false;
				}
				is_big = true;
				if (Registry.CURRENT_MAP_NAME == "OVERWORLD") {
					frame = 8; // 5 card door
					addAnimation("open", [8, 1, 2, 3, 4, 5], 12, false);
				} else if (Registry.CURRENT_MAP_NAME == "TERMINAL") {
					frame = 14;
					addAnimation("open", [14, 1, 2, 3, 4, 5], 12, false);
				} else if (Registry.CURRENT_MAP_NAME == "BEACH") {
					frame = 9;
					addAnimation("open", [9, 1, 2, 3, 4, 5], 12, false);
				} else if (Registry.CURRENT_MAP_NAME == "SUBURB") {
					frame = 10;
					addAnimation("open", [10, 1, 2, 3, 4, 5], 12, false);
				} else if (Registry.CURRENT_MAP_NAME == "TRAIN") {
					frame = 13;
					addAnimation("open", [13, 1, 2, 3, 4, 5], 12, false);
				} else if (Registry.CURRENT_MAP_NAME == "BLANK") {
					if (Registry.CURRENT_GRID_Y > 3 && Registry.CURRENT_GRID_Y < 7) { // 48
						//frame = 12;'
						frame = 11; //Changed so you cn get to the debug area with 47
						
						addAnimation("open", [12, 1, 2, 3, 4, 5], 12, false);
					} else if(Registry.CURRENT_GRID_Y >= 7) {
						frame = 16;
						addAnimation("open", [16, 1, 2, 3, 4, 5], 12, false);
					} else { // 47
						frame = 11;
						addAnimation("open", [11, 1, 2, 3, 4, 5], 12, false);
					}
				} else if (Registry.CURRENT_MAP_NAME == "NEXUS") {
					frame = 15;
						addAnimation("open", [15, 1, 2, 3, 4, 5], 12, false);
				} 
				active_region = sentinel;
				
				Registry.subgroup_interactives.push(this);
			} else if (Registry.CURRENT_MAP_NAME == "FIELDS") {
				
				loadGraphic(green_gate_embed, true, false, 32, 16);
				frame = 6;
				addAnimation("open", [6, 1, 2, 3, 4, 5], 12, false);
				is_big = true;
				if (xml.@alive == "false") {
					exists = false;
				}
			} else {
				addAnimation("open", [O, O + 1, O + 2, O + 3, O + 4], 10, false);
				tm = 0.2;
			}
			
			player = _player;
			
		}
		
		public function unlock():void {
			Registry.sound_data.unlock.play();
			
			play("open");
			xml.@alive = false;
			solid = false;
			
			
			
		}
		
		override public function update():void 
		{
			FlxG.collide(this, player);
			
			if (FlxG.keys.justPressed("G") && Intra.is_test) {
				Registry.nr_growths += 18;
				trace("New growhts: ", Registry.nr_growths); 
			}
			
			if (!is_big) {
				if (FlxG.overlap(player, sentinel)) {
					t -= FlxG.elapsed;
					
					if (t < 0 && Registry.get_nr_keys() > 0 && xml.@alive == true) {
						unlock();
						xml.@alive = false;
						Registry.change_nr_keys( -1);
						Registry.GAMESTATE.number_of_keys_text.text = "x" + Registry.get_nr_keys().toString();
					} else if (t < 0 && xml.@alive == "true" && alive && player.state == player.S_GROUND) {
						player.be_idle();
						DH.dialogue_popup(DH.lk("keyblock",0));
						alive = false;
					}
				} else {
					t = tm;
				}
			}
			
			if (sig_change) {
				explosion = new FlxSprite;
				explosion.loadGraphic(EventScripts.small_explosion_sprite, true, false, 24,24);
				explosion.x = x + 4;
				explosion.y = y - 4;
				Registry.GAMESTATE.fg_sprites.add(explosion);
				explosion.addAnimation("explode", [0, 1, 2, 3, 4], 12, false);
				Registry.sound_data.play_sound_group(Registry.sound_data.enemy_explode_1_group);
				explosion.play("explode");
				sig_change = false;
				frame = 17;
			}
			
			if (is_big && xml.@alive == true) {
				sentinel.x = x + 6;
				sentinel.y = y - 3;
				sentinel.width = 10;
				
				if (Registry.CURRENT_MAP_NAME == "OVERWORLD" && active_region == null) {
					if (player.overlaps(sentinel) && player.state == player.S_GROUND && Registry.inventory[Registry.IDX_GREEN_KEY]) {
						start_unlock_anim = true;
						
					}
				} else if (Registry.CURRENT_MAP_NAME == "WINDMILL") {
					if (player.overlaps(sentinel) && player.state == player.S_GROUND) {
						switch (frame) {
							case 0:
								if (Registry.inventory[Registry.IDX_GREEN_KEY]) {
									start_unlock_anim = true;
								}
								break;
							case 6: // red
								if (Registry.inventory[Registry.IDX_RED_KEY]) {
									start_unlock_anim = true;
								}
								break;
							case 7:
								if (Registry.inventory[Registry.IDX_BLUE_KEY]) {
									start_unlock_anim = true;
								}
								break;
						}
					}
				} else if (Registry.CURRENT_MAP_NAME == "FIELDS") {
					if (player.overlaps(sentinel) && player.state == player.S_GROUND) {
						if (Registry.inventory[Registry.IDX_RED_KEY]) {
							start_unlock_anim = true;
						}
					}
				} else { // It's a fuckin' card gate! 
					var open_the_gate:Boolean = false;
					
					if (Registry.CURRENT_MAP_NAME == "OVERWORLD") { // 4 Cards
						if (Registry.nr_growths < 4 && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {	
							player.be_idle();
							DH.dialogue_popup(DH.lk("keyblockgate", 0));
							//DH.dialogue_popup("The gate stares, petrified. It won't open until it senses four cards...");
						} else if (Registry.nr_growths >= 4 && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {
							player.be_idle();
							DH.dialogue_popup(DH.lk("keyblockgate", 1));
							//DH.dialogue_popup("Sensing four cards, the gate decides to open.");
							open_the_gate = true;
						}
					} else if (Registry.CURRENT_MAP_NAME == "TERMINAL") {
						if (Registry.nr_growths < 36 && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {	
							player.be_idle();
							DH.dialogue_popup(DH.lk("keyblockgate", 2));
							//DH.dialogue_popup("The gate stubbornly remains in place.");
						} else if (Registry.nr_growths >= 36 && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {
							player.be_idle();
							DH.dialogue_popup(DH.lk("keyblockgate", 3));
							//DH.dialogue_popup("The gate senses all of the cards, and decides to open.");
							open_the_gate = true;
						}
					} else if (Registry.CURRENT_MAP_NAME == "BEACH") { // 8
						if (Registry.nr_growths < 8 && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {	
							player.be_idle();
							DH.dialogue_popup(DH.lk("keyblockgate", 2));
						} else if (Registry.nr_growths >= 8 && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {
							player.be_idle();
							DH.dialogue_popup(DH.lk("keyblockgate", 4));
							open_the_gate = true;
						}
						
					} else if (Registry.CURRENT_MAP_NAME == "TRAIN") { // 24
						if (Registry.nr_growths < 24 && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {	
							player.be_idle();
							DH.dialogue_popup(DH.lk("keyblockgate", 2));
						} else if (Registry.nr_growths >= 24 && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {
							player.be_idle();
							DH.dialogue_popup(DH.lk("keyblockgate", 4));
							//DH.dialogue_popup("The gate senses enough cards, and decides to open.");
							open_the_gate = true;
						}
						
					} else if (Registry.CURRENT_MAP_NAME == "SUBURB") { // 16 
						if (Registry.nr_growths < 16 && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {	
							player.be_idle();
							DH.dialogue_popup(DH.lk("keyblockgate", 2));
						} else if (Registry.nr_growths >= 16 && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {
							player.be_idle();
							DH.dialogue_popup(DH.lk("keyblockgate", 4));
							//DH.dialogue_popup("The gate senses enough, and decides to open.");
							open_the_gate = true;
						}
						
					} else if (Registry.CURRENT_MAP_NAME == "BLANK") {
						if (Registry.CURRENT_GRID_Y > 3 && Registry.CURRENT_GRID_Y < 7) {
							if ( Registry.nr_growths < 47 && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {
								player.be_idle();
								DH.dialogue_popup(DH.lk("keyblockgate", 2));
							} else if (Registry.nr_growths >= 47  && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {
								player.be_idle();
								DH.dialogue_popup(DH.lk("keyblockgate", 5));
							open_the_gate = true;
							}
						} else if (Registry.CURRENT_GRID_Y >= 7) {
							if (player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {
								//DH.dialogue_popup("It remains closed.");
								DH.dialogue_popup(DH.lk("keyblockgate", 6));
								player.be_idle();
							}
						} else {
							if ( Registry.nr_growths < 47  && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1 ) {
								player.be_idle();
								DH.dialogue_popup(DH.lk("keyblockgate", 2));
							} else if (Registry.nr_growths >= 47  && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {
								player.be_idle();
								DH.dialogue_popup(DH.lk("keyblockgate", 5));
							open_the_gate = true;
							}
							
						}
					} else if (Registry.CURRENT_MAP_NAME == "NEXUS") {
						if (Registry.nr_growths < 49 && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {
							player.be_idle();
							DH.dialogue_popup("....");
						} else if (Registry.nr_growths >= 49 && player.overlaps(sentinel) && Registry.keywatch.JP_ACTION_1) {
							player.be_idle();
							DH.dialogue_popup("!!!");
							open_the_gate = true;
						}
					}
					
					if (xml.@alive == "true" && !start_unlock_anim && open_the_gate && player.overlaps(sentinel) && player.state == player.S_GROUND) {
						start_unlock_anim = true;
						ctr = 4; // Skip key shit
					}
				}
				
				if (start_unlock_anim) {
					unlock_anim();
				}
			}
			super.update();
		}
		
		override public function destroy():void 
		{
			active_region = sentinel = null;
			super.destroy();
		}
		private function unlock_anim():void {
				var sub_ctr:int = 0;
			if (ctr == 0 ) {
				player.state = player.S_INTERACT;
				player.be_idle();
				key_sprite = new FlxSprite(player.x, player.y - 16);
				key_sprite.loadGraphic(NPC.key_green_embed, true, false, 16, 16);
				key_sprite.alpha = 0;
				Registry.GAMESTATE.fg_sprites.add(key_sprite);
				if (Registry.CURRENT_MAP_NAME == "WINDMILL") {
					switch (frame) {
						case 0:
							key_sprite.frame = 0; //WHO NEED SCOMMENTS ANYWAYS
							break;
						case 6: //blue
							key_sprite.frame = 2;
							break;
						case 7: // red
							key_sprite.frame = 4;
							break;
					}
				} else if (Registry.CURRENT_MAP_NAME == "FIELDS")  {
					key_sprite.frame = 2;
				} else {
					Registry.sound_data.stop_current_song();
				}
				ctr++;
			} else if (ctr == 1) {
				if (EventScripts.send_alpha_to(key_sprite, 1, 0.02)) ctr++;
			} else if (ctr == 2) {
				key_sprite.flicker(0.5);
				if (EventScripts.send_property_to(key_sprite, "y", y, 0.2)) sub_ctr++;
				if (EventScripts.send_property_to(key_sprite, "x", x + 8, 0.2)) sub_ctr++;
				if (sub_ctr == 2) {
					ctr++;
					Registry.sound_data.player_jump_down.play();
				}
			} else if (ctr == 3) {
				if (EventScripts.send_alpha_to(key_sprite, 0, -0.025)) {
					ctr++;
				}
				
			} else if (ctr > 3 && ctr < 9) {
				t += FlxG.elapsed;
				if (t > tm) {
					trace(ctr);
					FlxG.shake(0.02, 0.3);
					t = 0;
					Registry.sound_data.hitground1.play();
					ctr++;
					if (frame == 0 || frame == 6 || frame == 7 || frame >= 8 ) {
						frame = 1;
					} else {
						frame++;
					}
				}
			} else if (ctr == 9) {
				Registry.sound_data.open.play();
				if (Registry.CURRENT_GRID_Y == 6 && Registry.CURRENT_MAP_NAME == "WINDMILL" && Intra.is_release) {
					DH.dialogue_popup("A voice: Nice work! You've gotten as far as this demo goes. For the completionists, there are a total of 12 cards to find in this demo.");
				}
				player.state = player.S_GROUND;
				xml.@alive = "false";
				solid = false;
				start_unlock_anim = false;
				
				x -= 160;
				sentinel.x -= 160;
			}
		}
		
		
	}

}