package entity.enemy.crowd 
{
	import data.Common_Sprites;
	import global.Registry;
	import helper.EventScripts;
	import helper.Parabola_Thing;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import entity.player.Player;
	import data.CLASS_ID;
	public class Frog extends FlxSprite 
	{
		
		public var xml:XML;
		public var cid:int = CLASS_ID.FROG;
		public var player:Player;
		public var parent:*;
		
		[Embed (source = "../../../res/sprites/enemies/crowd/frog.png")] public static var frog_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/crowd/frog_bullet.png")] public var frog_bullet_sprite:Class;
		
		private var state:int = 0;
		private var s_face_player:int = 0;
		private var s_shoot:int = 1;
		private var s_dying:int = 2;
		private var s_dead:int = 3;
		private var has_shot:Boolean = false
		private var did_shoot_anim:Boolean = false
		private var added_to_parent:Boolean = false;
		
		public var y_bullets:FlxGroup = new FlxGroup();
		public var BULLET_EMPTY_FRAME:int = 3;
		
		private var dame_frame:int;
		private var hit_timer:Number = 0;
		private var hit_timer_max:Number = 1.0;
		
		private var init_latency:Number = 0.8;
		
		
		//dame - p (1), alive , frame (attk type)
		public function Frog(_xml:XML,_player:Player,_parent:*) 
		{
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			/* Frog animations */
			loadGraphic(frog_sprite, true, false, 16, 16);
			if (Registry.BOI && Registry.CURRENT_MAP_NAME == "REDCAVE") {
				addAnimation("idle_d", [6,7], 2, true);
				addAnimation("shoot_d", [8], 3, false);
				addAnimation("shoot_r", [8], 3, false); // DEFAULT: R
				addAnimation("shoot_l", [8], 3, false); 
				addAnimation("shoot_u", [8], 3, false);
			} else {
				addAnimation("idle_d", [0, 1], 2, true);
				addAnimation("shoot_d", [3], 3, false);
				addAnimation("shoot_r", [4], 3, false); // DEFAULT: R
				addAnimation("shoot_l", [4], 3, false); 
				addAnimation("shoot_u", [5], 3, false);
			}
			play("idle_d");
			addAnimationCallback(on_anim_change);
			
			add_sfx("shoot", Registry.sound_data.bubble_triple_group);
			add_sfx("pop", Registry.sound_data.bubble_group);
			
			dame_frame = parseInt(xml.@frame);
			immovable = true;
			health = 2;
			
			for (var i:int = 0; i < 3; i++) {
				var b:FlxSprite = new FlxSprite;
				// TODO: add bullet gfx, test frog placeholders
				b.loadGraphic(frog_bullet_sprite, true, false, 8, 8);
				b.exists = false;
				/* Add bullet shadow anims, of which there are none */
				b.my_shadow = EventScripts.make_shadow("8_small",true);
				b.my_shadow.play("get_big");
				
				
				/* Add bullet animations */
				if (Registry.BOI && Registry.CURRENT_MAP_NAME == "REDCAVE") {
					b.addAnimation("bullet_move", [4,5], 12);
					b.addAnimation("bullet_explode", [2, 3, 3], 8, false);
				} else {
					b.addAnimation("bullet_move", [0, 1], 12);
					b.addAnimation("bullet_explode", [2, 3, 3], 8, false);
				}
				BULLET_EMPTY_FRAME = 3;
				b.play("bullet_move");
				
				y_bullets.add(b);
				var p:Parabola_Thing = new Parabola_Thing(b, 16,0.8 + Math.random(), "offset", "y");
				if (dame_frame == 2) {
					b.velocity.y = 15 * (i + 1);
				} else {
					b.velocity.x = -15 * (i + 1);
				}
				b.parabola_thing = p;
				b.parabola_thing.set_shadow_fall_animation("get_big");
			}
			
			if (xml.@alive == "false") {
				Registry.GRID_ENEMIES_DEAD++;
				exists = false;
			}
		}
		
		public function on_anim_change(name:String, frame:int, index:int):void {
			if (name == "shoot_l") {
				scale.x = -1;
			} else {
				scale.x = 1;
			}
		}
		
		override public function update():void 
		{
			
			if (init_latency > 0) {
				init_latency -= FlxG.elapsed;
				return;
			}
			
			if (player.overlaps(this) && visible && player.state != player.S_AIR) {
				player.touchDamage(1);
			}
			if (health <= 0 && state != s_dead) {
				state = s_dying;
			}
			var b:FlxSprite;
			if (!added_to_parent) {
				added_to_parent = true;
				//get draw order right later
				for each (b in y_bullets.members) {
					if (b == null) continue;
					parent.bg_sprites.add(b.my_shadow)
					parent.fg_sprites.add(b);
				}
			}
			
			hit_timer -= FlxG.elapsed;
			if (player.broom.overlaps(this) && player.broom.visible) {
				if (hit_timer <= 0) {
					flicker(hit_timer_max);
					hit_timer = hit_timer_max;
					health--;
					play_sfx(HURT_SOUND_NAME);
				}
			}
			
			if (state == s_face_player) {
				
				var dx:int = player.x - x;
				var dy:int = player.y - y;
				
				if (dx > 0) {
					if (Math.abs(dy) < dx) {
						facing = RIGHT;
					} else if (dy > 0) {
						facing = DOWN;
					} else {
						facing = UP;
					}
				} else {
					if (Math.abs(dy) < Math.abs(dx)) {
						facing = LEFT;
					} else if (dy > 0) {
						facing = DOWN;
					} else {
						facing = UP;
					}
				}
				
				if (EventScripts.distance(player, this) < 64) {
					state = s_shoot;
					
				}
			} else if (state == s_shoot) {
				if (!did_shoot_anim) {
					
					if (facing == DOWN) {
						play("shoot_d");
					} else if (facing == LEFT) {
						play("shoot_l");
					} else if (facing == RIGHT) {
						play("shoot_r");
					} else {
						play("shoot_u");
					}
					did_shoot_anim = true;
					
					for each (b in y_bullets.members) {
						if (b == null) continue;
						b.my_shadow.play("get_small");
						b.parabola_thing.set_shadow_fall_animation("get_big");
						b.parabola_thing.reset_time();
						b.velocity = EventScripts.scale_vector(this, player, b.velocity, 15 * (y_bullets.members.indexOf(b) + 1)) as FlxPoint;
						b.exists = b.visible = true;
						b.my_shadow.exists = true;
						b.x = b.my_shadow.x = x;
						b.y = b.my_shadow.y = y;
						b.play("bullet_move");
					}
					
					play_sfx("shoot");
				} else {
					var nr_done:int = 0;
					
					for each (b in y_bullets.members) {
						if (b == null) continue;
						if (!b.exists) {
							nr_done++;
							continue;
						}
						// Move until touches player...
						if (!b.parabola_thing.tick()) {
							
							b.my_shadow.y = b.y;
							b.my_shadow.x = b.x;
							if (b.offset.y < 8) {
								if (player.overlaps(b)) {
									player.touchDamage(1);
									b.play("bullet_explode");
								}
							}
						//...or hits ground.
						} else {
							// First time it hits ground, play pop sound.
							if (b.velocity.x != 0 && b.velocity.y != 0) {
								play_sfx("pop");
							}
							b.play("bullet_explode");
							b.velocity.x = b.velocity.y = 0;
							if (b.frame == BULLET_EMPTY_FRAME) {
								b.offset.y = 0;
								b.my_shadow.exists = false;
								b.exists = b.visible = false;				
								nr_done++;
							}
						}
					}
					
					if (nr_done == 3) {
						state = s_face_player;
						did_shoot_anim = false;
						play("idle_d");
						
					}
					
				}
			} else if (state == s_dying) {
				//play("die");
				//sfx
				//do the below once
				trace("dead!");
				state = s_dead;
				Registry.GRID_ENEMIES_DEAD++;
				EventScripts.drop_small_health(x, y, 0.7);
				EventScripts.make_explosion_and_sound(this);
				xml.@alive = "false";
				solid = false;
				visible = false;
			} else if (state == s_dead) {
				for each (b in y_bullets.members) {
					if (b == null) continue;
					if (!b.parabola_thing.tick()) {
						
						b.my_shadow.y = b.y;
						b.my_shadow.x = b.x;
						if (b.offset.y < 8) {
							if (player.overlaps(b)) {
								player.touchDamage(1);
							}
						}
					} else {
						b.play("bullet_explode");
						b.my_shadow.exists = false;
						
						b.velocity.x = b.velocity.y = 0;
						if (b.frame == BULLET_EMPTY_FRAME) {
							b.offset.y = 0;
							b.exists = false;				
						}

					}
				}
			}
			super.update();
		}
		
		
		
		override public function destroy():void 
		{	
			
			for each (var b:FlxSprite in y_bullets.members) {
				
			parent.fg_sprites.remove(b, true);
			}
			super.destroy();
		}
	}

}