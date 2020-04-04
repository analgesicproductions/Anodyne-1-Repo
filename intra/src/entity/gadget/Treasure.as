package entity.gadget 
{
	import data.CLASS_ID;
	import entity.player.Broom;
	import entity.player.HealthBar;
	import entity.player.Player;
	import global.Keys;
	import helper.Achievements;
	import helper.Cutscene;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import global.Registry;
	import data.SoundData;
	import states.PauseState;
	/**
	 * @author Seagaia
	 */
	
	public class Treasure extends FlxSprite
	{
		[Embed (source = "../../res/sprites/gadgets/treasureboxes.png")] public static var S_TREASURE_SPRITE:Class;
		[Embed(source = "../../res/sprites/inventory/item_jump_shoes.png")] public static var embed_jump_shoes:Class;
		[Embed(source = "../../res/sprites/inventory/item_long_attack.png")] public static var embed_long_attack:Class;
		[Embed(source = "../../res/sprites/inventory/item_wide_attack.png")] public static var embed_wide_attack:Class;
		[Embed(source = "../../res/sprites/inventory/item_tranformer.png")] public static var embed_transformer:Class;
		[Embed(source = "../../res/sprites/menu/secret_trophies.png")] public static const embed_secret_trophies:Class;
		public var CLOSED_BEDROOM:int = 0;
		public var OPEN_BEDROOM:int = 1;
		public var CLOSED_STREET:int = 0;
		public var OPEN_STREET:int = 1;
		
		
		public var xml:XML;
		public var parent:*;
		public var CONTENT:int;
		public var item:FlxSprite;
		public var item_flicker_timer:Number = 1;
		public var item_flickered:Boolean =  false;
		
		public var cid:int = CLASS_ID.TREASURE;
		public var active_region:FlxSprite = new FlxSprite;
		/* These reference the frame of the DAME object, and let the PlayState know what item to grant
		 * to the player. */
		public static const IDX_BROOM:int = 0;
		public static const IDX_KEY:int = 1;
		public static const IDX_GROWTH:int = 2;
		private var start_growth_anim:Boolean = false;
		private var ctr:int = 0;
		private var t:Number = 0;
		
		
		public static const IDX_JUMP:int = 3;
		public static const IDX_WIDE:int = 4;
		public static const IDX_LONG:int = 5;
		public static const IDX_SWAP:int = 6;
		
		public static const IDX_goldenpoo:int = 7;
		public static const IDX_can_of_spam:int = 8;
		public static const IDX_missingno:int = 9;
		public static const IDX_aus_heart:int = 10;
		public static const IDX_electric:int = 11;
		public static const IDX_kittystatue:int = 12;
		public static const IDX_melos:int = 13;
		public static const IDX_marina:int = 14;
		public static const IDX_black:int = 15;
		public static const IDX_red:int = 16;
		public static const IDX_green:int = 17;
		public static const IDX_blue:int = 18;
		public static const IDX_white:int = 19;
		
		public static const IDX_SECRETS_MAX:int = 40;
		
		public static const IDX_NOTHING:int = 100;
		
		public function Treasure(_x:int, _y:int, _xml:XML, _parent:* )
		{
			super(_x, _y);
			
			parent = _parent;
			xml = _xml;
			immovable = true;
			loadGraphic(S_TREASURE_SPRITE, true, false, 16, 16);
			if (Registry.CURRENT_MAP_NAME == "BEDROOM") {
				frame = CLOSED_BEDROOM;
			} else if (Registry.CURRENT_MAP_NAME == "STREET") {
				frame  = CLOSED_STREET;
			} else if (Registry.CURRENT_MAP_NAME == "TRAIN") {
				frame = 4;
			}
			CONTENT = xml.@frame;
			item = new FlxSprite(x, y);
			if (CONTENT >= IDX_goldenpoo && CONTENT <= IDX_SECRETS_MAX) {
				item.loadGraphic(embed_secret_trophies, true, false, 16, 16);
			}
			switch (CONTENT) {
				case IDX_BROOM:
					item.loadGraphic(Broom.Icon_Broom_Sprite, false, false, 16, 16);
					break;
				case IDX_KEY:
					item.loadGraphic(Key.C_KEY_SPRITE, false, false, 16, 16);
					break;
				case IDX_GROWTH:
					item.loadGraphic(PauseState.card_sheet_embed, false, false, 24, 24);
					item.frame = get_card_frame();
					item.scale.x = 0.5;
					item.scale.y = 0.5;
					item.x -= 4;
					if (xml != null && xml.@alive == "false") {
						Registry.card_states[item.frame] = 1;
					}
					// oops
					if (xml.@alive == "false" && item.frame != uint.MAX_VALUE) {
						if (Registry.card_states[item.frame] == 0) {
							Registry.nr_growths++;
							Registry.card_states[item.frame] = 1;
						}
					}
					if (item.frame == uint.MAX_VALUE) {
						item.makeGraphic(16, 16, 0xffff0000);
					}
					trace("Loading card with frame ", item.frame);
					
					if (item.frame == Registry.CARD_GOLDMAN_IDX && Registry.GE_States[Registry.GE_tradequesthelpedshopkeeper] && Registry.card_states[Registry.CARD_GOLDMAN_IDX]) {
						CONTENT = IDX_NOTHING;
					}
					break;
				case IDX_LONG:
					item.loadGraphic(embed_long_attack, false, false, 16, 16);
					break;
				case IDX_WIDE:
					item.loadGraphic(embed_wide_attack, false, false, 16, 16);
					break;
				case IDX_JUMP:
					item.loadGraphic(embed_jump_shoes, false, false, 16, 16);
					break;
				case IDX_SWAP:
					item.loadGraphic(embed_transformer, false, false, 16, 16);
					break;
				case IDX_goldenpoo:
					item.frame = 0; break;
				case IDX_can_of_spam:
					item.frame = 1; break;
				case IDX_missingno:
					item.frame = 2; break;
				case IDX_kittystatue:
					item.frame = 5; break;
				case IDX_aus_heart:
					item.frame = 3; break;
				case IDX_electric:
					item.frame = 4; break;
				case IDX_melos:
					item.frame = 6; break;
				case IDX_marina:
					item.frame = 7; break;
				case IDX_black:
					item.frame = 8; break;
				case IDX_red:
					item.frame = 9; break;
				case IDX_green:
					item.frame = 10; break;
				case IDX_blue:
					item.frame = 11; break;
				case IDX_white:
					item.frame = 12; break;
				default:
					item.makeGraphic(16, 16, 0xff00ff00);
					break;
			}
			item.visible = false;
			
			if (xml.@alive == "false") {
				frame++;
			}
			
			active_region.makeGraphic(10, 3, 0x00000000); 
			active_region.x = x + 3;
			active_region.y = y + 16;
			
			Registry.subgroup_interactives.push(this);
		}
		
		private function get_card_frame():int {
			var _x:int;
			var _y:int;
			if (Registry.is_playstate) {
				_x = Registry.CURRENT_GRID_X;
				_y = Registry.CURRENT_GRID_Y;
			} else {
				_x = parseInt(xml.@x);
				_y = parseInt(xml.@y);
			}
			
			var a:Array = PauseState.card_data[Registry.CURRENT_MAP_NAME];
			for each (var o:Object in a) {
				if (_x == o.x && _y == o.y) {
					return o.id;
				}
			}
			return -1;
		}
		
		private var dont_do_shit:Boolean = false;
		override public function update():void {
			if (item.visible) {
				if (CONTENT == IDX_GROWTH && !start_growth_anim) {
					if (item.frame != uint.MAX_VALUE) {
						if (Registry.CURRENT_MAP_NAME == "NEXUS") {
							Registry.card_states[48] = 1;
							Achievements.unlock(Achievements.A_GET_49TH_CARD);
						} else {
							Registry.card_states[item.frame] = 1;
						}
						parent.player.state = parent.player.S_GROUND;
					} 
				
					
					start_growth_anim = true;
					
				} else if (CONTENT == IDX_NOTHING) {
					item.visible = false;
					Registry.GAMESTATE.player.be_idle();
					//DH.dialogue_popup("Goldman: What? It's not there? That shopkeeper must have stolen it!");
					DH.dialogue_popup_misc_any("treasure", 10);
					
				} else if (CONTENT != IDX_GROWTH) {
					EventScripts.send_property_to(item, "y", y - 16, 0.5)
				
					if (!item_flickered) {
						parent.player.state = parent.player.S_GROUND;
						item_flickered = true;
						item.flicker(item_flicker_timer);
					}
					if (!item.flickering) item.visible = false;
				}
			}
			
				
			FlxG.collide(parent.player, this);
			if (frontTouches(parent.player) && Registry.keywatch.JP_ACTION_1 && xml.@alive == "true") {
				if (Registry.CURRENT_MAP_NAME == "WINDMILL" && Registry.CUTSCENES_PLAYED[Cutscene.Windmill_Opening] == 0) {
					dont_do_shit = true;
					//DH.dialogue_popup("Some strange force stops this treasure box from being opened.");
					DH.dialogue_popup(DH.lk("treasure",0));
				}
				if (dont_do_shit) return;
				parent.player.update_player_inventory(this);
				item.visible = true;
				parent.player.state = parent.player.S_INTERACT;
				Registry.sound_data.get_treasure.play();
				Achievements.is_200_percent();
				if (CONTENT == IDX_BROOM) {
					Registry.bound_item_1 = "BROOM";
					//DH.dialogue_popup("An engraving on the broom handle reads: \"Press " + Registry.controls[Keys.IDX_ACTION_1] + " to sweep.\"");
					DH.dialogue_popup(DH.lk("treasure", 1) + " " + Registry.controls[Keys.IDX_ACTION_1] + " " + DH.lk("treasure", 2));
					
				} else if (CONTENT == IDX_KEY && Registry.CURRENT_MAP_NAME == "STREET") {
					//DH.dialogue_popup("This key may be used a single time to open up a locked barrier.");
					DH.dialogue_popup_misc_any("treasure", 3);
				} else if (CONTENT == IDX_JUMP) {
					Registry.bound_item_2 = "JUMP";
					//DH.dialogue_popup("A mysterious pair of boots has nothing but the branding on it, which says \"Press " + Registry.controls[Keys.IDX_ACTION_2]+"\".");
					DH.dialogue_popup(DH.lk("treasure", 4) + " " + Registry.controls[Keys.IDX_ACTION_2] + " " + DH.lk("treasure", 5));
				} else if (CONTENT == IDX_WIDE) {
					//DH.dialogue_popup("A few words on the broom extension read \"Equip the WIDEN upgrade in the menu to have the broom release harmful dust to the left and right.\"");
					DH.dialogue_popup_misc_any("treasure", 6);
				} else if (CONTENT == IDX_LONG) {
					//DH.dialogue_popup("A few words on the broom extension read \"Equip the EXTEND upgrade in the menu for the broom to release harmful dust in front of the broom's normal reach.\"");
					DH.dialogue_popup_misc_any("treasure", 7);
				} else if (CONTENT == IDX_SWAP) {
					//DH.dialogue_popup("A note next to the broom extension: \"Hello, Young. Use this SWAP upgrade on two tiles to switch their places. It may be a while before you can use this everywhere, but it should serve you well for the time being.\"");
					DH.dialogue_popup_misc_any("treasure", 8);
				} else if (CONTENT == IDX_goldenpoo) {
					Registry.inventory[Registry.IDX_POO] = true;
					Achievements.unlock(Achievements.A_GET_GOLDEN_POO);
				} else if (CONTENT == IDX_can_of_spam) {
					Achievements.unlock(Achievements.Trophy_1);
					Registry.inventory[Registry.IDX_SPAM] = true;
				} else if (CONTENT == IDX_electric) {
					Achievements.unlock(Achievements.Trophy_1);
					Registry.inventory[Registry.IDX_ELECTRIC] = true;
				} else if (CONTENT == IDX_missingno) {
					Achievements.unlock(Achievements.Trophy_1);
					Registry.inventory[Registry.IDX_MISSINGNO] = true;
				} else if (CONTENT == IDX_aus_heart) {					
					DH.dialogue_popup_misc_any("treasure", 9);
					//DH.dialogue_popup("YOU FOUND A HEART!!! Maximum Health increased by...zero.");
					Registry.inventory[Registry.IDX_AUS_HEART] = true;
				} else if (CONTENT == IDX_kittystatue) {
					Registry.inventory[Registry.IDX_KITTY] = true;
				} else if (CONTENT == IDX_marina) {
					Registry.inventory[Registry.IDX_MARINA] = true;
				} else if (CONTENT == IDX_melos) {
					Registry.inventory[Registry.IDX_MELOS] = true;
				}else if (CONTENT == IDX_black) {
					Registry.inventory[Registry.IDX_BLACK] = true;
					if (Registry.inventory[Registry.IDX_WHITE]) {
						Achievements.unlock(Achievements.A_GET_BW_CUBES);
					}
				}else if (CONTENT == IDX_red) {
					Registry.inventory[Registry.IDX_RED] = true;
					Achievements.unlock(Achievements.A_GET_RED_CUBE);
				}else if (CONTENT == IDX_green) {
					Registry.inventory[Registry.IDX_GREEN] = true;
					Achievements.unlock(Achievements.A_GET_GREEN_CUBE);
				}else if (CONTENT == IDX_blue) {
					Registry.inventory[Registry.IDX_BLUE] = true;
					Achievements.unlock(Achievements.A_GET_BLUE_CUBE);
				}else if (CONTENT == IDX_white) {
					Registry.inventory[Registry.IDX_WHITE] = true;
					if (Registry.inventory[Registry.IDX_BLACK]) {
						Achievements.unlock(Achievements.A_GET_BW_CUBES);
					}
				}
				
				if (CONTENT >= IDX_goldenpoo && CONTENT < IDX_SECRETS_MAX) {
					Registry.GE_States[Registry.GE_HAVE_A_SECRET] = true;
				}
				xml.@alive = "false";
				frame++;
			}
			
			if (start_growth_anim) {
				growth_anim();
			}
			
			super.update();
		}
		
	
		private function growth_anim():void {
			switch (ctr) {
				case 0:
					
					ctr++;
					break;
				case 1:
					item.scale.x += (0.5 * FlxG.elapsed);
					item.scale.y += (0.5 * FlxG.elapsed);
						if (item.y > Registry.CURRENT_GRID_Y * 160 + 20 + 80) { 
							item.y -= (24 * FlxG.elapsed);
						} else {
							item.y += (24 * FlxG.elapsed);
						}
					if (item.scale.x >= 1) {
						item.scale.x = item.scale.y = 1;
						ctr++;
					}
					break;
				case 2:
					t += FlxG.elapsed;
					if (t > 1) {
						t = 0;
						ctr++;
						if (item.y > Registry.CURRENT_GRID_Y * 160 + 20 + 80) {
							item.acceleration.y = -80;
							item.angularVelocity = 50;
							item.angularAcceleration = 200;
						} else {
							item.acceleration.y = 80;
							item.angularVelocity = -50;
							item.angularAcceleration = -200;
							
						}
					}
					break;
				case 3:
					item.scale.x += FlxG.elapsed*3;
					item.scale.y += FlxG.elapsed*3;
					item.alpha -= FlxG.elapsed / 2;
					if (item.alpha <= 0) {
						item.visible = false;
						ctr++;
					}
					break;
			}
			
		}
		
		public function frontTouches(o:FlxSprite):Boolean {
			return (o.x >= (x - Registry.TILE_WIDTH / 2) && o.x <= (x + Registry.TILE_WIDTH / 2) &&
					o.y <= (y + Registry.TILE_WIDTH + 2) && o.y >= (y + Registry.TILE_WIDTH - 3));
		}
		
		override public function destroy():void 
		{
			super.destroy();
			if (active_region != null) active_region.destroy();
			active_region = null;
			item = null;
		}
		
		
		
	}

}