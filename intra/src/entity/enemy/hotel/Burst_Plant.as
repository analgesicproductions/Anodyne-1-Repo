package entity.enemy.hotel 
{
	import data.CLASS_ID;
	import data.Common_Sprites;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.EventScripts;
	import helper.Parabola_Thing;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	public class Burst_Plant extends FlxSprite
	{
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		
		public var bullets:FlxGroup = new FlxGroup(8);
		private var added_to_parent:Boolean = false;
		
		private var t_timeout:Number = 0;
		private var tm_timeout:Number = 1;
		
		
		private var t_hurt:Number = 0;
		private var tm_hurt:Number = 1.0;
		
		
		private var state:int = 0;
		private var s_idle:int = 0;
		private var s_charge:int = 1;
		private var t_charge:Number = 0;
		private var tm_charge:Number = 0.5;
		private var s_shoot:int = 2;
		private var s_dying:int = 3;
		private var s_dead:int = 4;
		public var cid:int = CLASS_ID.BURSTPLANT;
		private var max_x_vel:int = 50;
		
		private var init_latency:Number = 0.4;
	
		
		[Embed(source = "../../../res/sprites/enemies/hotel/burst_plant.png")] public static var burst_plant_sprite:Class;
		[Embed(source = "../../../res/sprites/enemies/hotel/burst_plant_bullet.png")] public static var burst_plant_bullet_sprite:Class;
		
		public function Burst_Plant(_xml:XML,_player:Player,_parent:*) 
		{
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			/* Burst Plant Anims */
			loadGraphic(burst_plant_sprite, true, false, 16, 16);
			addAnimation("idle", [0], 1);
			addAnimation("charge", [0, 1], 8);
			addAnimation("shoot", [3]);
			play("idle");
			
			for (var i:int = 0; i < bullets.maxSize; i++) {
				/* Bullet and bullet shadow anims */
				var bullet:FlxSprite = new FlxSprite();
				bullet.loadGraphic(burst_plant_bullet_sprite, true, false, 8, 8);
				bullet.addAnimation("move", [0, 1], 12);
				bullet.addAnimation("explode", [2, 3, 4,4], 10, false);
				bullet.play("move");
				
				bullet.my_shadow = new FlxSprite();
				bullet.my_shadow.loadGraphic(Common_Sprites.shadow_sprite_8_8, true, false, 8, 8);
				bullet.my_shadow.addAnimation("get_big", [0, 1, 2, 3], 8, false);
				bullet.my_shadow.addAnimation("get_small", [3, 2, 1, 0], 8, false);
				bullet.my_shadow.play("get_big");
				
				bullets.add(bullet);
				bullet.parabola_thing = new Parabola_Thing(bullet, 24 + int(10 * Math.random()), 0.7 + Math.random(), "offset", "y");
				bullet.velocity.x = 10;
			}
			
			tm_timeout = 0.4 + Math.random();
			
			health = 2;
			
			if (xml.@alive == "false") {
				Registry.GRID_ENEMIES_DEAD++;
				exists = false;
			}
			
			add_sfx("shoot", Registry.sound_data.bubble_triple_group);
			add_sfx("pop", Registry.sound_data.four_shooter_pop_group);
		}
		
		override public function update():void 
		{
			
			if (!added_to_parent ) {
				added_to_parent = true;
				parent.fg_sprites.add(bullets);
				for each (var b:FlxSprite in bullets.members) {
					parent.bg_sprites.add(b.my_shadow);
				}
			}
			
			if (init_latency >  0) {
				init_latency -= FlxG.elapsed;
				return;
			}
			
			//get hurt and transition to dying if needed
			if ((t_hurt > tm_hurt) && player.broom.visible && player.broom.overlaps(this)) {
				if (state != s_dying && state != s_dead) {
					health--;
					play_sfx(HURT_SOUND_NAME);
					t_hurt = 0;
					flicker(tm_hurt);
					if (health <= 0) {
						state = s_dying;
					}
				}
			} else {
				t_hurt += FlxG.elapsed;
			}
			
			var subctr:int = 0;
			var bullet:FlxSprite;
			if (state == s_idle) { //wait a bit before charging
				t_timeout += FlxG.elapsed;
				if (t_timeout > tm_timeout) {
					play("charge");
					state = s_charge;
					t_timeout = 0;
					tm_timeout = 0.4 + Math.random();
				}
			} else if (state == s_charge) {
				t_charge += FlxG.elapsed; //charge
				if (t_charge > tm_charge) {
					for each (bullet in bullets.members) { //init pos, vel etc - randomized a bit of course
						bullet.x = bullet.my_shadow.x =  x + 5;
						bullet.y = bullet.my_shadow.y = y + 6;
						
						bullet.exists = bullet.my_shadow.exists = true;
						bullet.parabola_thing.reset_time();
						bullet.play("move");
						bullet.my_shadow.play("get_small");
						bullet.parabola_thing.set_shadow_fall_animation("get_big"); // Reset the bullet fall anim thing
						
						var sign:int = Math.random() > 0.5 ? -1 : 1;
						max_x_vel = 10 + 30 * Math.random();
						if (subctr > 0) {
							bullet.velocity.x = -max_x_vel + 2 * max_x_vel * Math.random();
							bullet.velocity.y = sign * Math.sqrt(max_x_vel * max_x_vel - bullet.velocity.x * bullet.velocity.x);
						} else { //one bullet tries to hit the player
							EventScripts.scale_vector(new Point(x, y), new Point(player.x, player.y), bullet.velocity, 2.5 * max_x_vel);
							bullet.parabola_thing.period = 1.5;
						}
						subctr++;
					}
					t_charge = 0;
					state = s_shoot;
					play("shoot");
					play_sfx("shoot");
				}
			} else if (state == s_shoot) {
				for each (bullet in bullets.members) { //move the bullets' offsets
					bullet.my_shadow.x = bullet.x;
					bullet.my_shadow.y = bullet.y;
					if (bullet.parabola_thing.tick()) {
						//do something
						subctr++;
						if (bullet.exists) { // If bullet hits ground, explode
							bullet.my_shadow.exists = false;
							bullet.play("explode");
							bullet.velocity.x = bullet.velocity.y = 0;
							
							if (bullet.frame == bullet._curAnim.frames.length - 1) {
								bullet.exists = false;
								play_sfx("pop");
							}
						}
					}
					if (bullet.offset.y <= 4) {
						if (!player.invincible && player.overlaps(bullet) && bullet.velocity.x != 0) {
							player.touchDamage(1);
						}
					}
					
				}
				if (subctr == bullets.maxSize) {
					play("idle");
					state = s_idle;
				}
			} else if (state == s_dying) {
				//die, sfx...
				//timer...
				state = s_dead;
				Registry.GRID_ENEMIES_DEAD++;
				EventScripts.drop_small_health(x, y, 0.7);					
				EventScripts.make_explosion_and_sound(this);
				xml.@alive = "false";
			} else if (state == s_dead) {
				bullets.setAll("exists", false);
				for each (bullet in bullets.members) {
					bullet.my_shadow.exists = false;
				}
			
				
				exists = false;
			}
			super.update();
		}
		
	}

}