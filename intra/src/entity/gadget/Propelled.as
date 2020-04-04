package entity.gadget 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	/**
	 * A platform that faces a certain direction. When dust is placed on top
	 * and it is jumped on, this will be propelled in that direction, taking
	 * the player with it.
	 */
	public class Propelled extends FlxSprite 
	{
		
		[Embed (source = "../../res/sprites/gadgets/moving_platform.png")] public static var moving_platform_sprite:Class;
		[Embed (source = "../../res/sprites/gadgets/moving_platform_poof.png")] public static var moving_platform_poof_sprite:Class;
		
		
		public var xml:XML;
		public var cid:int = CLASS_ID.PROPELLED;
		public var player:Player;
		public var parent:*;
		private var pushed_to_front:Boolean = false;
		private var Propel_Speed:int = 33;
		
		public var active_region:FlxSprite = new FlxSprite();
		public var dame_frame:int;
		public var is_active:Boolean = false;
		private var init_pt:Point = new Point();
		
		public var dust_poof:FlxSprite = new FlxSprite();
		private var showed_dust_poof:Boolean = false;
		
		
		public var is_propelling:Boolean = false;
		
		private var H_UP_OFF:int = 0;
		private var H_UP_ON:int = 1;
		private var H_DOWN_ON:int = 2;
		private var H_DOWN_OFF:int = 3;
		private var V_UP_OFF:int = 4;
		private var V_UP_ON:int = 5;
		private var V_DOWN_ON:int = 6;
		private var V_DOWN_OFF:int = 7;
		
		private var state:int = 0;
		private var s_normal:int = 0;
		private var s_done:int = 1;
		
		private var is_first_movement:Boolean = true;
	
		/*
		 * dame params - frame: waht direction it faces, as well as the sprite itself. 
		 * should be added to FRONT of "flat gadgets" so that dust is drawn on tope*/
		public function Propelled(_xml:XML,_player:Player,_parent:*) 
		{
			
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			active_region.makeGraphic(10, 10, 0x00123456);
			
			dame_frame = parseInt(xml.@frame);
			
			switch (dame_frame % 4) {
				case 0: facing = UP; break;
				case 1: facing = RIGHT; break;
				case 2:	facing = DOWN; break;
				case 3: facing = LEFT; break;
			}
			
			if (dame_frame > 3) {
				is_active = true;
			} else {
				is_active = false;
			}
			
			dust_poof.makeGraphic(16, 16, 0xffff1233);
			dust_poof.loadGraphic(moving_platform_poof_sprite, true, false, 16, 16);
			dust_poof.addAnimation("poof", [0, 1, 2, 3, 4], 12, false);
			dust_poof.visible = false;
			
			loadGraphic(moving_platform_sprite, true, false, 16, 16);
			
			if (facing == RIGHT || facing == LEFT) {
				if (is_active) {
					frame = 1;
				} else {
					frame = 0;
				}
			} else {
				if (is_active) {
					frame = 5;
				} else {
					frame = 4;
				}
			}
			
			Registry.subgroup_propelled.push(this);
		}
		
		override public function update():void 
		{
		
			/* Draw beneath dust */
			if (!pushed_to_front) {
				//noooo
				pushed_to_front = true;
				parent.bg_sprites.add(active_region);
				parent.bg_sprites.move_to_front(active_region);
				parent.bg_sprites.move_to_front(this);
				parent.bg_sprites.add(dust_poof);
				init_pt.x = x;
				init_pt.y = y;
			}
			
			if (state == s_done) {
				if (active_region.overlaps(player) && !player.hasFallen && player.state != player.S_AIR) {
					player.falling_disabled = true;
				}
				super.update();
				return;
			}
			
			/* Pin active region to moving platform */
			active_region.x = x + 3;
			active_region.y = y + 3;
			if (active_region.overlaps(player) && !player.hasFallen && player.state != player.S_AIR) {
				player.falling_disabled = true;
				set_frame(true);
				if (is_propelling) {
					set_velocity();
				}
				
				if (player.just_landed) {
				if (is_active) {
					is_propelling = true; //start moving
					if (!showed_dust_poof) {
						Dust.dust_sound.play();
						dust_poof.play("poof");
						showed_dust_poof = true;
						dust_poof.visible = true;
						switch (facing) {
							case LEFT:
								dust_poof.x = x + width;
								dust_poof.y = y;
								break;
							case RIGHT:
								dust_poof.x = x - dust_poof.width;
								dust_poof.y = y;
								break;
							case UP:
								dust_poof.x = x;
								dust_poof.y = y + height;
								break;
							case DOWN:
								dust_poof.x = x;
								dust_poof.y = y - dust_poof.height;
								break;
						}
					} else {
						//HI
					}
				}
			}
			} else {
				set_frame(false);
			}
			
			// On the return trip, if the platform is close,
			// then stop it and return it tot he initial state
			if (!is_first_movement) {
				if (EventScripts.distance(this, init_pt) < 3) {
					x = init_pt.x;
					y = init_pt.y;
					reset_moving_props();
				}
			}
			
			
			super.update();
		}
		
		public function turn_on():void {
			if (!is_active) {
				// dont make a noise with the already-activated platforms
				// when entering map
				if (parent == null) {
					trace(Registry.GAMESTATE.sortables.members.indexOf(this));
					trace(Registry.GAMESTATE.members.indexOf(this));
					trace(Registry.GAMESTATE.bg_sprites.members.indexOf(this));
					exists = false;
				}
				if (parent.state != parent.S_TRANSITION) {
					Registry.sound_data.dash_pad_2.play();
				}
				if (frame == H_UP_OFF) {
					frame = H_UP_ON;
				} else if (frame  == V_UP_OFF) {
					frame = V_UP_ON;
				} else if (frame == H_DOWN_OFF) {
					frame = H_DOWN_ON;
					
				} else if (frame == V_DOWN_OFF) {
					frame = V_DOWN_ON;
				}
				is_active = true;
			}
		}
		
		private function set_frame(stepped_on:Boolean):void {
			if (stepped_on) {
				if (frame == H_UP_OFF) {
				Registry.sound_data.button_down.play();
					frame = H_DOWN_OFF;
				} else if (frame == H_UP_ON) {
				Registry.sound_data.button_down.play();
					frame = H_DOWN_ON;
				} else if (frame == V_UP_OFF) {
				Registry.sound_data.button_down.play();
					frame = V_DOWN_OFF;
				} else if (frame == V_UP_ON) {
				Registry.sound_data.button_down.play();
					frame = V_DOWN_ON;
				}
			} else {
				if (frame == H_DOWN_OFF) {
				Registry.sound_data.button_up.play();
					frame = H_UP_OFF;
				} else if (frame == H_DOWN_ON) {
				Registry.sound_data.button_up.play();
					frame = H_UP_ON;
				} else if (frame == V_DOWN_OFF) {
				Registry.sound_data.button_up.play();
					frame = V_UP_OFF;
				} else if (frame == V_DOWN_ON) {
				Registry.sound_data.button_up.play();
					frame = V_UP_ON;
				}
			}
		}
		
		// changes facing (to tell platform where to move next), dust state,
		// etc
		private function reset_moving_props():void 
		{
			is_propelling = false;
			is_active = false;
			if (facing == UP) {
				facing = DOWN;
			} else if (facing == DOWN) {
				facing = UP;
			} else if (facing == LEFT) {
				facing = RIGHT;
			} else {
				facing = LEFT;
			}
			if (frame == H_UP_ON || frame == H_DOWN_ON || frame == H_DOWN_OFF || frame == H_UP_OFF) {
				frame = H_UP_OFF;
			} else {
				frame = V_UP_OFF;
			}
			showed_dust_poof = false;
			dust_poof.visible = false;
			velocity.x = velocity.y = 0;
			is_first_movement = !is_first_movement;
		}
		
		public function set_velocity():void {
			switch (facing) {
				case UP:  player.additional_y_vel = velocity.y = -Propel_Speed;  break;
				case DOWN: player.additional_y_vel =  velocity.y = Propel_Speed; break;
				case RIGHT: player.additional_x_vel = velocity.x = Propel_Speed;  break;
				case LEFT: player.additional_x_vel =  velocity.x = -Propel_Speed; break;
			}
		}
		
		public function propel_from_dust_poof():void {
			is_propelling = true;
		}
		
		//Called by stop markers when they overlap this moving platform.
		public function stop_from_stop_marker(stop_marker:Stop_Marker):void {
			if (is_first_movement) {
				x = stop_marker.x;
				y = stop_marker.y;
				reset_moving_props();
			}
		}
		
		override public function destroy():void 
		{
			dust_poof = null;
			init_pt = null;
			parent.bg_sprites.remove(this, true);
			parent.bg_sprites.remove(active_region, true);
			parent.bg_sprites.remove(dust_poof, true);
			super.destroy();
		}
	}

}