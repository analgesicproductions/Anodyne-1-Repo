package entity.enemy.crowd 
{
	import flash.geom.Point;
	import global.Registry;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	import entity.player.Player;
	import data.CLASS_ID;
	
	/**
	 * pretty self explanatoory
	 * falls from ceiling and rolls across the room stops on other side
	 * roomm should be empty from obstacles or this looks awkward
	 */
	public class Spike_Roller extends FlxSprite 
	{
		public var xml:XML;
		public var cid:int = CLASS_ID.SPIKE_ROLLER;
		public var player:Player;
		public var parent:*;
		
		public var added_extras:Boolean = false;
		private var transitioned_in:Boolean = false;
		public var dame_type:int = 0;
		private var state:int = 0;
		private var s_hidden:int = 0;
		private var s_fall:int = 1;
		private var s_roll:int = 2;
		private var s_stopped:int = 3;
		
		private var vel_x:int = 0;
		private var vel_y:int = 0;
		private var Fall_Rate:Number = 1.0;
		private var init_pt:Point = new Point();
		
		private var is_bounce:Boolean = false;
		private var bounce_vel:int = 45;
		private var ctr:int = 0;
		
		
		[Embed (source = "../../../res/sprites/enemies/crowd/spike_roller.png")] public var Spike_Roller_Sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/crowd/spike_roller_horizontal.png")] public static var Spike_Roller_Sprite_H:Class;
		[Embed (source = "../../../res/sprites/enemies/crowd/spike_roller_shadow.png")] public var vert_shadow_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/crowd/spike_roller_horizontal_shadow.png")] public var hori_shadow_sprite:Class;
		
		
		
		// Dame: Frame: URLD 0123
		// Bounce - 4567
		public function Spike_Roller(_xml:XML,_player:Player,_parent:*) 
		{
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			dame_type = parseInt(_xml.@frame);
			
			my_shadow = new FlxSprite(x, y);

			switch (dame_type % 4) {
				case 0:
					loadGraphic(Spike_Roller_Sprite_H, true, false, 128, 16);
					height = 12;
					my_shadow.loadGraphic(hori_shadow_sprite, true, false, 128, 16);
					vel_y = -20;
					facing = UP; break;
				case 1:
					loadGraphic(Spike_Roller_Sprite, true, false, 16, 128);
					width = 12;
					vel_x = 20;
					my_shadow.loadGraphic(vert_shadow_sprite, true, false, 16, 128);
					facing = RIGHT; break;
				case 3:
					loadGraphic(Spike_Roller_Sprite_H, true, false, 128, 16);
					height = 12;
					my_shadow.loadGraphic(hori_shadow_sprite, true, false, 128, 16);
					vel_y = 20;
					facing = DOWN; break;
				case 2:
					loadGraphic(Spike_Roller_Sprite, true, false, 16, 128);
					width = 12;
					my_shadow.loadGraphic(vert_shadow_sprite, true, false, 16, 128);
					vel_x = -20;
					facing = LEFT; break;
					
			}
			
			/* ADd spike roller animations */
			addAnimation("roll_l", [0, 1], 5);
			addAnimation("roll_r", [0, 1], 5); // DEFAULT RIGHT
			addAnimation("roll_d", [0, 1], 5); //DEFAULT DOWN
			addAnimation("roll_u", [0, 1], 5);
			addAnimation("idle", [0]);
			play("idle");
			
			/* add shadow animations */
			my_shadow.addAnimation("hiding", [0]);
			my_shadow.addAnimation("fall", [0], 2);
			my_shadow.play("hiding");
			my_shadow.flicker( -1);
			
			
			visible = my_shadow.visible = false;
			
			/* If bounce type */
			if (dame_type > 3) {
				has_tile_callbacks = false;
				offset.y = 0;
				is_bounce = true;
				play("roll_l");		
				if (vel_x > 0) {
					play("roll_r");
				} else if (vel_x < 0) {
					play("roll_l");
				} else if (vel_y < 0) {
					play("roll_u");
				} else {
					play("roll_d");
				}
				visible = true;
			} else {
				offset.y = 80;
				immovable = true;
			}
			
			Registry.subgroup_spike_rollers.push(this);
		}
		override public function preUpdate():void 
		{
			ctr++;
			if (is_bounce && ctr == 4) {
				ctr = 0;
				FlxG.collide(this, parent.curMapBuf);
			}
			super.preUpdate();
		}
		private function bounce_logic():void {
			if (touching) {
				if (touching & LEFT) {
					play("roll_r");
					velocity.x = bounce_vel;
				} else if (touching & RIGHT) {
					play("roll_l");
					scale.x = -1;
					velocity.x = -bounce_vel;
				} else if (touching & DOWN) {
					play("roll_u");
					scale.y = -1;
					velocity.y = -bounce_vel;
				} else {
					play("roll_d");
					velocity.y = bounce_vel;
				}
		
				Registry.sound_data.hitground1.play();
			}
			
	
			if (player.state != player.S_AIR && player.overlaps(this)) {
				player.touchDamage(1);
			}
			
		}
		
		private var move_that_shit_to_front_ticks:int = 5;
		private var moveeeeeeeeeeeed:Boolean = false;
		override public function update():void 
		{
			
			if (!added_extras) {
				added_extras = true;
				init_pt.x = x;
				init_pt.y = y;
				if (is_bounce) {
					velocity.x = vel_x * 2;
					velocity.y = vel_y * 2;
					parent.sortables.remove(this, true);
					parent.bg_sprites.add(this);
				} else {
					my_shadow.x = x;
					my_shadow.y = y;
					parent.bg_sprites.add(my_shadow);
					parent.sortables.remove(this, true);
					parent.fg_sprites.add(this);
				}
			}
			
			
			if (move_that_shit_to_front_ticks > 0) {
				move_that_shit_to_front_ticks -= 1;
			} else {
				if (Registry.CURRENT_MAP_NAME != "BLUE" && Registry.CURRENT_MAP_NAME != "CIRCUS" && moveeeeeeeeeeeed == false && is_bounce )  {
					moveeeeeeeeeeeed = true;
					parent.bg_sprites.move_to_front(this);
					
				}
			}
			
			if (parent.state == parent.S_TRANSITION) {
				if (!transitioned_in) {
					x = init_pt.x;
					y = init_pt.y;
				} else {
					velocity.x = velocity.y = 0;
				}
				return;
			} else {
				transitioned_in = true;
			}
			
			if (is_bounce) {
				bounce_logic();
				return;
			}
			switch (state) {
				case s_hidden:
					if (player.overlaps(my_shadow)) {
						state = s_fall;
						my_shadow.play("fall");
						my_shadow.exists = true;
						exists = true;
						Registry.sound_data.fall1.play();
						my_shadow.visible = visible = true;
					}
					break;
				case s_fall:
					offset.y -= Fall_Rate;
					if (offset.y < 0) {
						if (facing == UP || facing == DOWN) {
							offset.y = 2;
						} else {
							offset.y = 0;
							offset.x = 2;
						}
						Registry.sound_data.hitground1.play();
						state = s_roll;
						velocity.x = vel_x;
						velocity.y = vel_y;
						parent.fg_sprites.remove(this, true);
						parent.bg_sprites.add(this);
						my_shadow.visible = false;
								
						if (vel_x > 0) {
							play("roll_r");
						} else if (vel_x < 0) {
							play("roll_l");
							scale.x = -1;
						} else if (vel_y < 0) {
							play("roll_u");
							scale.y = -1;
						} else {
							play("roll_d");
						}
						
					}
					break;
				case s_roll:
					if (player.state != player.S_AIR && (player.overlaps(this)) ) {
						player.touchDamage(1);
					}
					if (Math.abs(init_pt.x - x) >= 112) {
						Registry.sound_data.hitground1.play();
						velocity.x = 0; 
						state = s_stopped;
					} else if (Math.abs(init_pt.y - y) >= 112) {
						Registry.sound_data.hitground1.play();
						velocity.y = 0;
						state = s_stopped;
					}
					break;
				case s_stopped:
					frame = 0;
					if (player.state != player.S_AIR && (player.overlaps(this)) ) {
						player.touchDamage(1);
					}
					
					break;
			}
			super.update();
		}
	}

}