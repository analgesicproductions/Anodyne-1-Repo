package entity.enemy.apartment 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Teleguy extends FlxSprite 
	{
		
		public var xml:XML;
		private var player:Player;
		private var parent:*;
		
		
		public var state:int = 0;
		private var s_idle:int = 0
		private var s_teleporting:int = 1;
		private var ctr:int = 0;
		private var t_ctr:Number = 0;
		
		
		private var s_attacking:int = 2;
		private var atk_pt:Point = new Point;
		private var attack_speed:Number = 0.9;
		
		private var s_dying:int = 3;
		private var s_dead:int = 4;
		
		public var cid:int = CLASS_ID.TELEGUY;
		
		[Embed(source = "../../../res/sprites/enemies/apartment/teleport_guy.png")] public var teleguy_sprite:Class;
		
		public function Teleguy(_x:XML, _p:Player, _pa:*)
		{
			
			xml = _x;
			player = _p;
			parent = _pa;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			loadGraphic(teleguy_sprite, true, false, 16, 24);
			offset.y = 6;
			height = 16;
			
			/* Add animations */
			addAnimation("idle_d", [0,1], 3);
			addAnimation("idle_r", [2,3], 3); //DEFAULT: RIGHT
			addAnimation("idle_u", [4,5], 3);
			addAnimation("idle_l", [2,3], 3);
			addAnimation("poof", [6,7,8,9],12,false);
			addAnimation("unpoof", [8,7,6], 12,false);
			addAnimation("dying", [0]);
			
			if (xml.@alive == "false") {
				Registry.GRID_ENEMIES_DEAD++;
				state = s_dead;
				alive = false;
			}
			health = 1;
			//FlxG.watch(this, "state", "teleguy state");
			
			add_sfx("up", Registry.sound_data.teleguy_up);
			add_sfx("down", Registry.sound_data.teleguy_down);
		}
		
		
		override public function update():void 
		{
			
			if (alive && player.overlaps(this)) {
				player.touchDamage(1);
			}
			
			//Cleanup before death logic
			if (health <= 0 && state != s_dead && state != s_dying ) {
				t_ctr = 2;
				play("dying");
				state = s_dying;
				xml.@alive = "false";
				alive = false;
			}
			
			// Idle until attacked
			if (state == s_idle) {
				scale.x = 1;
				/* Get the direction to the player and face that way*/
				switch (EventScripts.get_entity_to_entity_dir(x + 8, y + 16, player.x + 5, player.y + 7)) {
					case UP:
						play("idle_u");
						break;
					case DOWN:
						play("idle_d");
						break;
					case RIGHT:
						play("idle_r");
						break;
					case LEFT:
						play("idle_l");
						scale.x = -1;
						break;
				}
				if (player.broom.visible && player.broom.overlaps(this)) {
					state = s_teleporting;
				}
			
			} else if (state == s_teleporting) {
				if (ctr == 0) {
					play_sfx("up");
					play("poof"); //goesto invisible
					t_ctr = 0.5;
					ctr++;
					alive = false;
				} else if (ctr == 1) {
					/* Move behind player, set the point to dash attack to */
					t_ctr -= FlxG.elapsed;
					if (t_ctr < 0) {
						atk_pt.x = x;
						atk_pt.y = y;
						teleport();
						play_sfx("down");
						play("unpoof"); // ends on teleport thing almost done
						ctr++;
						t_ctr = 0.5
					}
				} else if (ctr == 2) {
					/* Face the player before dashing */
					t_ctr -= FlxG.elapsed;
					if (t_ctr < 0) {
						alive = true;
						scale.x = 1;
						if (facing == LEFT) {
							play("idle_l");
							scale.x = -1;
						}
						if (facing == RIGHT) play("idle_r");
						if (facing == DOWN) play("idle_d");
						if (facing == UP) play("idle_u");
						ctr++;
					}
				} else if (ctr == 3) {
					ctr = 0;
					//sfx atack
					state = s_attacking;
					t_ctr = 1.5;
				}
			} else if (state == s_attacking) {
				/* Move to the attack pooint, if attacked, then start teleporting again */
				t_ctr -= FlxG.elapsed;
				if (t_ctr < 0) {
					state = s_idle;
				} else {
					if (player.broom.visible && player.broom.overlaps(this)) {
						if (Math.random() < 0.5) {
							state = s_teleporting;
						} else {
							flicker(1);
							state = s_idle;
							play_sfx(HURT_SOUND_NAME);
							health--;
						}
					}
				}
				
				EventScripts.send_property_to(this, "x", atk_pt.x, attack_speed);
				EventScripts.send_property_to(this, "y", atk_pt.y, attack_speed);
			} else if (state == s_dying) {
				//t_ctr -= FlxG.elapsed;
				//flicker(1);
				t_ctr = -0.1;
				if (t_ctr < 0) {
					state = s_dead;
					Registry.GRID_ENEMIES_DEAD++;
					EventScripts.drop_small_health(x, y, 0.7);					
					EventScripts.make_explosion_and_sound(this);
				}
			} else if (state == s_dead) {
				exists = false;
			}
			
			super.update();
		}
		
		private function teleport():void {
		
			if (player.facing == LEFT) {
				x = player.x + 16;
				y = player.y
				facing = LEFT;
			} else if (player.facing == RIGHT) {
				x = player.x - 16;
				y = player.y;
				facing = RIGHT;
			} else if (player.facing == UP) {
				x = player.x;
				y = player.y + 17;
				facing = UP;
			} else if (player.facing == DOWN) {
				x = player.x;
				y = player.y - 16;
				facing = DOWN;
			}
		}
	}
	


}