package entity.enemy.bedroom 
{
	import data.CLASS_ID;
	import data.SoundData;
	import entity.enemy.circus.Lion;
	import entity.gadget.Dust;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.EventScripts;
	import helper.SpriteFactory;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Annoyer extends FlxSprite 
	{
		
		public var xml:XML;
		[Embed (source = "../../../res/sprites/enemies/annoyer.png")] public static var S_ANNOYER_SPRITE:Class;
		public var target:Player;
		
		private var state:int = -1;
		
		private var S_WAIT:int = -1;
		private var S_APPROACH:int = 0;
		private var S_CIRCLE:int = 1;
		private var S_ATTACK:int = 2;
		private var S_DEAD:int = 3;
		private var S_HIT:int = 4;
		private var hit_timer:Number = 0.25;
		
		private var WAIT_TIMER_MAX:Number = 0.25;
		private var APPROACH_DISTANCE:int = 64;
		private var CIRCLE_DISTANCE:int = 24;
		private var wait_timer:Number = 0.25;
		private var CIRCLE_TIMER_MAX:Number = 3.00;
		private var circle_timer:Number = 3.00;
		private var swoop_to_point:Point = new Point(0, 0);
		
		private var rotate_radius:Number = 20;
		private var rotate_velocity:Number = 0.14;
		
		private var just_hit_timer:Number = 0.4;
		private var just_hit:Boolean = false;
		public var cid:int = CLASS_ID.ANNOYER;
		
		public var INCREMENTED_REG:Boolean = false;
		public var parent:*;
		
		
		private var frame_type:int = 0;
		private var T_NORMAL:int = 0;
		private var T_SUPER:int = 2;
		
		private var fireballs:FlxGroup = new FlxGroup(4);
		private var t_fireball:Number = 0;
		private var tm_fireball:Number = 2.3;
		private var vel_fireball:int = 30;
		
		
		public function Annoyer(x:int,y:int,_xml:XML,_player:Player,_parent:*) 
		{
				super(x, y);
				xml = _xml;
				target = _player;
				loadGraphic(S_ANNOYER_SPRITE, true, false, 16, 16);
				if (Registry.CURRENT_MAP_NAME == "TRAIN") {
					addAnimation("flap", [6, 7], 4, true);
				} else if (Registry.BOI && Registry.CURRENT_MAP_NAME == "REDCAVE") {
					addAnimation("flap", [8, 9], 8, true);
				} else if (parseInt(xml.@frame) == T_SUPER) {
					addAnimation("flap", [12,13,14,15,16,17], 8, true);
				} else {
					addAnimation("flap", [0, 1, 2, 3,4,5], 8, true);
				}
				play("flap");
				height = 7;
				width = 8;
				solid = false;
				offset.x = 3;
				offset.y = 2;
				health = 1;
				parent = _parent;
				
				if (xml.@alive == "false") {
					Registry.GRID_ENEMIES_DEAD++;
					exists = false;
					
				}
				
				if (parseInt(xml.@frame) == T_SUPER) {
					frame_type = T_SUPER;
					for (var i:int = 0; i < fireballs.maxSize; i++) {
						var fireball:FlxSprite = new FlxSprite;
						fireball.loadGraphic(Lion.lion_fireball_sprite, true, false, 16, 16);
						fireball.width = fireball.height = 8;
						fireball.centerOffsets(true);
						fireballs.add(fireball);
						fireball.addAnimation("shoot",[0, 1], 8);
						fireball.addAnimation("poof",[2,3,4,5], 8,false);
						fireball.play("shoot");
					}
					fireballs.setAll("visible", false);
					fireballs.setAll("alive", false);
					
					parent.fg_sprites.add(fireballs);
					health = 2;
				}
		}
		
		
		override public function update():void {
			var dx:Number;
			var dy:Number;
			if (just_hit) {
				just_hit_timer -= FlxG.elapsed;
				if (just_hit_timer < 0 && state != S_DEAD) {
					state = S_WAIT;
					velocity.x = velocity.y = 0;
					just_hit_timer = 0.4;
					just_hit = false;
				}
			}
			
			
			
			
			
			if (frame_type == T_SUPER && (state != S_DEAD)) {
				var fireball:FlxSprite;
				t_fireball += FlxG.elapsed;
				if (t_fireball > tm_fireball) {
					t_fireball = 0;
					fireball = fireballs.getFirstDead() as FlxSprite;
					if (fireball == null) return;
					
					Registry.sound_data.play_sound_group(Registry.sound_data.fireball_group);
					fireball.x = x; fireball.y = y;
					fireball.alpha = 1;
					EventScripts.scale_vector(new Point(x, y), new Point(target.x, target.y), fireball.velocity, vel_fireball);
					fireball.visible = fireball.alive = true;
					fireball.play("shoot");
				}
				
				for each (fireball in fireballs.members) {
					
					if (fireball._curAnim != null && fireball._curAnim.name != "poof") {
						if (fireball.alpha < 0.9 && !target.invincible && fireball.alive && target.overlaps(fireball)) {
							target.touchDamage(1);
							fireball.play("poof");
						}
						fireball.alpha -= 0.002;
						if (fireball.alpha <= 0.6) {
							fireball.play("poof");
						}
						
						if (target.broom.overlaps(fireball) && target.broom.visible) {
							fireball.play("poof");
							Dust.dust_sound.play();
						}	
					} else {
						if (fireball.finished) {
							fireball.alive = fireball.visible = false;
						}
					}
				}
				
				
				
			}
			
				
			if (overlaps(target)) {
				if (xml.@alive != "false") {
					target.touchDamage(1);
				}
			}
			if (target.broom.overlaps(this) && target.broom.visible) {
				hit("broom", target.broom.root.facing);
			}
			
			
			if (parent.state == parent.S_TRANSITION) {
				state = S_WAIT;
			}
	
			
			switch (state) {
				case S_WAIT:
					wait_timer -= FlxG.elapsed;
					if (wait_timer < 0) {
						wait_timer = WAIT_TIMER_MAX;
						dx = x - target.x;
						dy = y - target.y;
						
						if (Math.sqrt(dx * dx + dy * dy) < APPROACH_DISTANCE) state = S_APPROACH;
					}
					break;
				case S_APPROACH: 
					EventScripts.send_property_to(this, "x", target.x + target.width/2 + rotate_radius, 0.6);
					EventScripts.send_property_to(this, "y", target.y + target.height/2, 0.6);
				
					dx = x - (target.x + target.width/2 + rotate_radius)
					dy = y - (target.y  + target.height/2);
					if (Math.sqrt(dx * dx + dy * dy) < 2) state = S_CIRCLE;
					break;
				case S_CIRCLE:
					rotate_about_center_of_sprite(target, this, rotate_radius, rotate_velocity);
					circle_timer -= FlxG.elapsed;
					if (circle_timer < 0) {
						circle_timer = CIRCLE_TIMER_MAX;
						state = S_ATTACK;
						 dx = x - target.x;
						 if (dx < 0) {
							 swoop_to_point.x = (x + 3 * (target.x - x));
						 } else {
							 swoop_to_point.x = (x - 3 * (x - target.x));
						 }
						 
						 
						 dy = y - target.y;
						 if (dy < 0) {
							 swoop_to_point.y = y + 3 * (target.y - y);
						 } else {
							 swoop_to_point.y = y - 3 * (y - target.y);
						 }
						 
					}
					
					break;
				case S_ATTACK:
					var res:Boolean = EventScripts.send_property_to(this, "x", swoop_to_point.x, 2.5);
					var res2:Boolean = EventScripts.send_property_to(this, "y", swoop_to_point.y, 2.5);
					if (res && res2) {
						state = S_APPROACH;
						rotate_angle = 0;
					}
					break;
				case S_HIT:
					
					FlxG.collide(this, parent.curMapBuf);
					hit_timer -= FlxG.elapsed;
					if (hit_timer < 0) {
						//explode
						Registry.sound_data.play_sound_group(Registry.sound_data.enemy_explode_1_group);
						solid = false;
						loadGraphic(SpriteFactory.SPRITE_ENEMY_EXPLODE_2, true, false, 24, 24);
						addAnimation("explode", [0, 1, 2, 3, 4], 12, false);
						play("explode");
						velocity.x = velocity.y = 0;
						state = S_DEAD;
					}
					break;
				case S_DEAD:
					if (frame == 5) {
						EventScripts.drop_small_health(x, y,0.5);
						exists = false;
					}
					if (!INCREMENTED_REG) {
						Registry.GRID_ENEMIES_DEAD++;
						INCREMENTED_REG = true;
					}
					xml.@alive = "false";
					fireballs.setAll("exists", false);
					break;
			}
			
			
			
			if (parent.state != parent.S_TRANSITION) {
				if (x < Registry.CURRENT_GRID_X * 160) x  = Registry.CURRENT_GRID_X * 160;
				if (x > (Registry.CURRENT_GRID_X + 1) * 160 - 16) x = (Registry.CURRENT_GRID_X + 1) * 160 - 16;
				if (y < (Registry.CURRENT_GRID_Y * 160) + 20) y = Registry.CURRENT_GRID_Y * 160 + 20;
				if (y > (Registry.CURRENT_GRID_Y + 1) * 160 + 20 ) y = (Registry.CURRENT_GRID_Y + 1) * 160 + 20;
			}
			
			super.update();
		}
		
		/**
		 * Note, requires the rotatee to have a "rotate_angle" property
		 * that will be updated to reflect its progress around the target
		 */
		private function rotate_about_center_of_sprite(pivot:FlxSprite,rotatee:*,radius:Number,velocity:Number):void {
			var pivot_x:Number = pivot.x + pivot.width / 2;
			var pivot_y:Number = pivot.y + pivot.height / 2;
			rotatee.x = Math.cos(rotatee.rotate_angle) * (radius) + pivot_x - 8;
			rotatee.y = Math.sin(rotatee.rotate_angle) * (radius) + pivot_y - 5;
			rotatee.rotate_angle = (rotatee.rotate_angle + velocity) % 6.28;
		}
		
		public function hit(type:String, hit_dir:uint):int {
			if (!just_hit) {
				Registry.sound_data.player_hit_1.play();
				switch (hit_dir) {
					case UP:
						velocity.y = -150; velocity.x = -30 + 60 * Math.random();
						break;
					case DOWN:
						velocity.y = 150;
						break;
					case LEFT:
						velocity.x = -150;
						break;
					case RIGHT:
						velocity.x = 150;
						break;
				}
				just_hit = true;
				flicker(0.2);
				health--;
				state = S_APPROACH;
				if (health <= 0) state = S_HIT;
			}
			return Registry.HIT_NORMAL;
		}
		
	}

}