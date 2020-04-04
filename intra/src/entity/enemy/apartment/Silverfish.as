package entity.enemy.apartment 
{
	import data.CLASS_ID;
	import entity.gadget.Gate;
	import entity.gadget.Switch_Pillar;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Silverfish extends FlxSprite 
	{
		
		[Embed (source = "../../../res/sprites/enemies/apartment/silverfish.png")] public static var silverfish_sprite:Class;
		
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		
		private var state:int = 0;
		private var s_normal:int = 0;
		private var s_seen:int = 1;
		private var s_turning:int = 2;
		private var s_dying:int = 3;
		private var s_gas:int = 4;
		
		private var t_turn:Number = 0;
		private var tm_turn:Number = 0.8;
		
		private var vel:int = 50;
		private var death_timer:Number = 0.7;
		private var seen_distance:Number = 30; //
		
		private var init_latency:Number = 1.0;
		
		public var cid:int = CLASS_ID.SILVERFISH;
		
		public function Silverfish(_xml:XML,_player:Player,_parent:*) 
		{
			
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			/* Add silverifsh adnimations*/
			loadGraphic(silverfish_sprite, true, false, 16, 16);
			addAnimation("move_l", [6, 7], 7, true);
			addAnimation("move_d", [4, 5], 7, true);
			addAnimation("move_r", [6, 7], 7, true); // DEFAULT: RIGHT
			addAnimation("move_u", [8, 9], 7, true);
			addAnimation("idle_d", [4], 12, true);
			addAnimation("idle_u", [8], 12, true);
			addAnimation("idle_r", [6], 12, true); // DEFAULT: RIGHT
			addAnimation("idle_l", [6], 12, true);
			 
			
			
			
			
			//addAnimation("die", [4, 5], 30, true);
			
			// LDRU
			switch (parseInt(xml.@frame)) {
				case 0:
					play("idle_l");
					scale.x = -1;
					facing = LEFT; break;
				case 1:
					play("idle_d");
					facing = DOWN; break;
				case 2:
					play("idle_r");
					facing = RIGHT;  break;
				case 3:
					play("idle_u");
					facing = UP;   break;
			}
			
			add_sfx("move", Registry.sound_data.sf_move);
		}
		
		
		override public function preUpdate():void 
		{
			
			if (FlxG.collide(this, parent.curMapBuf) && state == s_seen) {
				state = s_turning;
			}
			for each (var gate:Gate in Registry.subgroup_gates) {
				if (gate == null) continue;
				if (FlxG.collide(gate, this) && state == s_seen) {
					state = s_turning;
				}
			}
			super.preUpdate();
		}
		override public function update():void 
		{
			
			if (y < Registry.CURRENT_GRID_Y * 160 - 16) {
				exists = false;
				
			}
			if (init_latency > 0) {
				init_latency -= FlxG.elapsed;
				return;
			}
			// get hurt
			if (player.broom.visible && player.broom.overlaps(this) && state != s_dying) {
				state = s_dying;
			}
			
			//hurt player
			if (player.overlaps(this)) {
				player.touchDamage(1);
			}
			
			//get gased maybe
			if (state != s_gas) {
				for each (var gas:FlxSprite in Registry.subgroup_gas) {
					if (gas == null || !gas.visible) continue;
					if (gas.alpha > 0.3 && gas.overlaps(this)) {
						state = s_gas;
						play_sfx("move");
						drag.x = drag.y = 10;
						var p:Point = new Point(player.x, player.y);
						var _p:Point = new Point(x, y);
						EventScripts.scale_vector(_p, p, velocity, 70);
						EventScripts.face_and_play(this, player, "move");
						if (facing != LEFT) {
							scale.x = 1;
						} else {
							scale.x = -1;
						}
						
						
					}
				}
			
			}
			
		
			
		
			
			if (state == s_normal) {
				if (sees(player) || (EventScripts.distance(player,this) < seen_distance)) {
					//play sfx, then move
					flip_and_move();
					play_sfx("move");
					state = s_seen;
				}
			} else if (state == s_seen) {
				if (touching != NONE) {
					state = s_turning;
				}
			} else if (state == s_turning) {
				velocity.x = velocity.y = 0;
				t_turn += FlxG.elapsed;
				
				
				if (facing & LEFT) {
					facing = LEFT;
					play("idle_l");
				} else if (facing & UP) {
					facing = UP;
					play("idle_u");
				} else if (facing & RIGHT) {
					facing = RIGHT;
					play("idle_r");
				} else if (facing & DOWN) {
					facing = DOWN;
					play("idle_d");
				}
				
				
				if (t_turn > tm_turn) {
					t_turn = 0;
					scale.x = 1;
					if (facing & LEFT) {
						facing = UP;
					} else if (facing & UP) {
						facing = RIGHT;
					} else if (facing & RIGHT) {
						facing = DOWN;
					} else if (facing & DOWN) {
						facing = LEFT;
						scale.x = -1;
					}
				} else if (sees(player) || (EventScripts.distance(player, this) < seen_distance) ) {
					facing = EventScripts.get_entity_to_entity_dir(x,y,player.x,player.y);
					t_turn = 0;
					state = s_seen;
					play_sfx("move");
					flip_and_move();
				}
			} else if (state == s_dying) {
				//play("die");
				//death_timer -= FlxG.elapsed;
				death_timer = -0.1;
				if (death_timer < 0) {
					EventScripts.make_explosion_and_sound(this);
					Registry.GRID_ENEMIES_DEAD++;
					EventScripts.drop_small_health(x, y, 0.5);
					exists = false;
					play_sfx(HURT_SOUND_NAME);
				}
			} else if (state == s_gas) {
				if (velocity.x < 2) {
					state = s_dying;
				}
			}
			
				// stop at switch pillars
			for each (var sp:Switch_Pillar in Registry.subgroup_switch_pillars) {
				if (sp == null) continue;
			
				if (sp.frame == sp.up_frame && sp.overlaps(this)) {
					var yes:Boolean = false;
					if (velocity.x > 0 && sp.x > x) {
						yes = true;
					} else if (velocity.x < 0 && sp.x < x) {
						yes = true;
					} else if (velocity.y > 0 && sp.y > y) {
						yes = true;
					} else if (velocity.y < 0 && sp.y < y) {
						yes = true;
					}
					if (yes) {
						velocity.x = velocity.y = 0;
						state = s_turning;
					}
				}
			}
			
			super.update();
		}
		
		private function flip_and_move():void {
			scale.x = 1;
			if (facing & LEFT) {
				velocity.x = vel;
				facing = RIGHT;
				play("move_r");
				
			} else if (facing & RIGHT) {
				scale.x = -1;
				facing = LEFT;
				velocity.x = -vel;
				play("move_l");
			} else if (facing & UP) {
				facing = DOWN;
				velocity.y = vel;
				play("move_d");
			} else if (facing & DOWN) {
				facing = UP;
				velocity.y = -vel;
				play("move_u");
			}
		}
		//finish this
		private function sees(o:FlxObject):Boolean {
			if (facing == LEFT) {
				if (o.x < x && (o.y + o.height > y) && (o.y < y + height)) return true;
			} else if (facing == RIGHT) {
				if (o.x > x && (o.y + o.height > y) && (o.y < y + height)) return true;
			} else if (facing == UP) {
				if ((o.y + o.height < y) && (o.x < x + width) && (o.x + o.width > x)) return true;
			} else {
				if ((o.y > y + height) && (o.x < x + width) && (o.x + o.width > x)) return true;
			}
			return false;
		}
	}

}