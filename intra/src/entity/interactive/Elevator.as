package entity.interactive 
{
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	import states.ControlsState;
	import states.PauseState;
	
	/**
	 * logic for the elevator in hotel.
	 */
	public class Elevator extends FlxSprite 
	{
		
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		
		private var locations:Array = new Array(new Point(1344, 1360), new Point(1344, 560), new Point(384, 1840), new Point(384, 880));
		
		private var state:int = 0;
		private var s_closed:int = 0;
		private var s_player_leaving:int = 1;
		private var s_open:int = 2;
		private var s_menu:int = 3;
		private var s_leaving:int = 4;
		
	
		
		private var did_init:Boolean = false;
		
		private var open_sensor:FlxSprite;
		private var menu_sensor:FlxSprite;
		
		private var OPEN_FRAME:int = 3;
		private var CLOSED_FRAME:int = 0;
		
		public var text:FlxBitmapFont;
		public var menu:FlxSprite;
		public var selector:FlxSprite;
		public var selector_idx:int = 0;
		public var line_height:int = 8;
		public var min_selector_idx:int = 0;
		public var max_selector_idx:int = 4;
		public var choices:Array = new Array();
		
		private var floor:int;
		
		[Embed (source = "../../res/sprites/gadgets/elevator.png")] public static var Elevator_Sprite:Class;
		
		
		public function Elevator(_xml:XML,_player:Player,_parent:*) 
		{
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			/* Elevator anims */
			loadGraphic(Elevator_Sprite, true, false, 32, 32);
			addAnimation("open", [0, 1, 2, 3], 12, false);
			addAnimation("close", [3, 2, 1, 0], 12, false);
			
			frame = CLOSED_FRAME;
			state = s_closed;
		}
		
		override public function update():void 
		{
			if (!did_init) { // o god
				did_init = true;
				
				open_sensor = new FlxSprite(x, y + 32);
				open_sensor.makeGraphic(32, 32, 0xff992912);
				
				menu_sensor = new FlxSprite(x, y);
				menu_sensor.makeGraphic(32, 20, 0xff991144);
				
				menu_sensor.visible = open_sensor.visible = false;
				
				menu = new FlxSprite(15, Registry.HEADER_HEIGHT + 20);
				menu.loadGraphic(ControlsState.S_CONTROLS, false, false, 135, 125);
				
				//text = EventScripts.init_bitmap_font("Floor?\n", "center", menu.x + 12, menu.y + 4, null, "apple_white");
				text = EventScripts.init_bitmap_font(DH.lk("elevator",0)+"\n", "center", menu.x + 12, menu.y + 4, null, "apple_white");
				text.drop_shadow = true;
				text.x = menu.x + 46;
				text.y = menu.y + 34;
				
				
				
				floor = 1;
				
				for each (var point:Point in locations) {
					if (x == point.x && y == (point.y + Registry.HEADER_HEIGHT)) {
						break;
					}
					floor++;
				}
				
				if (floor != 1) { text.text += DH.lk("elevator",1); choices.push(1); }
				if (floor != 2) { text.text += DH.lk("elevator",2); choices.push(2); }
				if (floor != 3) { text.text += DH.lk("elevator",3); choices.push(3); }
				if (floor != 4) { text.text += DH.lk("elevator",4); choices.push(4); }
				
				
				text.text += DH.lk("elevator",5);
				
				selector = new FlxSprite(menu.x, menu.y);
				selector.loadGraphic(PauseState.arrows_sprite, true, false, 7, 7);
				selector.addAnimation("a", [2, 3], 6, true);
				selector.play("a");
				
				text.scrollFactor = selector.scrollFactor = menu.scrollFactor = new FlxPoint();
				
				parent.bg_sprites.add(open_sensor);
				parent.bg_sprites.add(menu_sensor);
				parent.fg_sprites.add(menu);
				parent.fg_sprites.add(text);
				parent.fg_sprites.add(selector);
				
				menu.visible = text.visible = selector.visible = false;
				
			}
			
			if (state == s_closed) {
				if (player.overlaps(open_sensor)) {
					play("open");
					Registry.sound_data.elevator_open.play();
					state = s_open;
				} else if (player.overlaps(menu_sensor)) {
					state = s_menu;
					menu.visible = text.visible = selector.visible = true;
					selector_idx = 1;
					selector.y = text.y + line_height;
					selector.x = text.x - line_height;
					if (DH.isZH()) {
						selector.y += 8;
						selector.x += 22;
					}
					player.frame = player.offset.y = player.velocity.x = player.velocity.y = 0;
					
					player.offset.y = player.DEFAULT_Y_OFFSET;
					player.invincible_timer = 400000;
					player.invincible = true;
				}
			} else if (state == s_open) {
				if (!player.overlaps(open_sensor)) {
					play("close");
					Registry.sound_data.elevator_close.play();
					state = s_closed;
				}
			} else if (state == s_menu) {
				player.state = player.S_INTERACT;
				if (Registry.keywatch.JP_DOWN && (selector_idx < max_selector_idx)) {
					Registry.sound_data.play_sound_group(Registry.sound_data.menu_move_group);
					selector.y += line_height;
					if (DH.isZH()) selector.y += 4;
					selector_idx++;
				} else if (Registry.keywatch.JP_UP && (selector_idx > min_selector_idx + 1)) {
					Registry.sound_data.play_sound_group(Registry.sound_data.menu_move_group);
					selector.y -= line_height;
					if (DH.isZH()) selector.y -= 4;
					selector_idx--;
				} else if (Registry.keywatch.JP_ACTION_1) {
					menu.visible = text.visible = selector.visible = false;
					Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
					if (selector_idx == max_selector_idx) { //cancel
						state = s_leaving;
						player.invincible_timer = 0;
						play("open");
						player.offset.y = player.DEFAULT_Y_OFFSET;
						Registry.sound_data.elevator_open.play();
					} else { // move
						Registry.ENTRANCE_PLAYER_X = locations[choices[selector_idx -1] - 1].x + 8;
						Registry.ENTRANCE_PLAYER_Y = locations[choices[selector_idx -1] - 1].y + Registry.HEADER_HEIGHT + 30;
						parent.SWITCH_MAPS = true;
						Registry.NEXT_MAP_NAME = "HOTEL";
						player.state = player.S_GROUND;
					}
				}
				
			} else if (state == s_leaving) {
				player.state = player.S_GROUND;
				if (!player.overlaps(menu_sensor)) {
					state = s_open;
				}
			}
			
			//if elevator event triggered, go to "arrived closed" state, blocking event, open doors, move player out, go to open
			
			//normal: 
			// stay closed until player is close enough (cloed state)
			// do open animation, either go back to close or: (open state)
				// if player steps inside, freeze the controls, close the door (state)
					// --> pop up menu with the other 3 floors and CANCEL, if chosen, do the transition, if CNACEL:
						// -->  open doors, move player out and give back control (return to closed). (blocking event) 
				
			super.update();
		}
		
		private function move_player_out():Boolean {
			return false;
		}
		
		// -1: exit, 0: ongoing, 1, 2, 3, 4 - floor change
		private function menu_state():int {
			return 0;
		}
		
		override public function destroy():void 
		{
			
			super.destroy();
			text = null;
			menu = menu_sensor = selector = open_sensor = null;
		}
	}

}