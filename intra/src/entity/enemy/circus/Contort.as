package entity.enemy.circus 
{
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.EventScripts;
	import helper.Parabola_Thing;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * Mechanically the same as a shieldy at first,
	 * but hitting it once splits it into
	 * two balls that bounce about the room. and blood. eeew
	 */
	public class Contort extends FlxSprite 
	{
		
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		[Embed (source = "../../../res/sprites/enemies/circus/contort_small.png")] public static var contort_small_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/circus/contort_big.png")] public static var contort_big_sprite:Class;
		
		private var BIG_HEALTH:int = 3;
		private var t_big_hit:Number = 0;
		private var tm_big_hit:Number = 1.5;
		private var just_hurt:Boolean = false;
		private var big_death_timeout:Number = 1.0;
		
		private var t_small_roll:Number = 0;
		private var tm_small_roll:Number = 0.8;
		
		private var state:int = 0;
		private var s_big_roll:int = 0;
		private var s_big_dying:int = 1;
		private var s_big_dead:int = 2;
		private var big_is_h_flipped:Boolean = false;
		private var big_is_v_flipped:Boolean = false;
		
		private var VEL:int = 35;
		
		public var small_sprites:FlxGroup = new FlxGroup(3);
		
		private var added_to_parent:Boolean = false;
		private var collide_ctr:int = 0;
		private var tl:Point = new Point(0, 0);
		
		private var did_normal:Boolean = false;
		
		public function Contort(_xml:XML, _player:Player, _parent:*) 
		{
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			/* Add anims for the big sprite */
			loadGraphic(contort_big_sprite, true, false, 16, 32);
			height = 12;
			width = 12;
			offset.x = 2;
			offset.y = 20;
			addAnimation("move", [0, 1, 2, 1], 9);
			play("move");
			health = BIG_HEALTH;
			
			tl.x = Registry.CURRENT_GRID_X * 160;
			tl.y = Registry.CURRENT_GRID_Y * 160 + Registry.HEADER_HEIGHT;
			
			for (var i:int = 0; i < small_sprites.maxSize; i++) {
				var ss:FlxSprite  = new FlxSprite();
				ss.loadGraphic(contort_small_sprite, true, false, 16, 16);
				//yellow purple blue
				switch (i) {
					case 0:
						ss.addAnimation("move", [0,1], 9, true); //b
						break;
					case 1:
						ss.addAnimation("move", [4,5], 9, true);//p
						break;
					case 2: //y
						ss.addAnimation("move", [2,3], 9, true); //y 
						break;
				}
				ss.visible = false;
				ss.play("move");
				ss.offset.y = 12 * i;
				
				ss.my_shadow = EventScripts.make_shadow("8_small", true);
				ss.parabola_thing = new Parabola_Thing(ss, 16 + 8 * i, 1.2, "offset", "y");
				ss.parabola_thing.set_shadow_fall_animation("get_big");
				
				small_sprites.add(ss);
				parent.bg_sprites.add(ss.my_shadow);
			}
			
			if (xml.@alive == "false") {
				exists = false;
			} 
			
			
		}
		
		override public function preUpdate():void 
		{
			if (collide_ctr == 3) {
				collide_ctr = 0;
				FlxG.collide(parent.curMapBuf, this);
			} else {
				collide_ctr++;
			}
			super.preUpdate();
		}
		override public function update():void 
		{
			if (!added_to_parent) {
				if (parent.state == parent.S_NORMAL) {
					added_to_parent = true;
					parent.sortables.add(small_sprites);
					
					velocity.x = Math.random() > 0.5 ? VEL : -VEL;
					velocity.y = Math.random() > 0.5 ? VEL : -VEL;
				}
				
				return;
			}
			
			big_logic();
			
			super.update();
		}
		
		private function big_logic():void 
		{
			
			if (did_normal && parent.state == parent.S_TRANSITION) {
				velocity.x = velocity.y = 0;
				small_sprites.setAll("velocity", new FlxPoint(0, 0));
				//EventScripts.prevent_leaving_map(parent, this);
			} else {
				did_normal = true;
			}
			
			if (state == s_big_roll) {
				
				
				if (x < tl.x) {
					touching = LEFT;
					
				} else if (x + width > tl.x + 160) {
					touching = RIGHT;
				} else if (y < tl.y ) {
					touching = UP;
				} else if (y + height > tl.y + 160) {
					touching = DOWN;
				}
				
				//Bounce 
				if (touching != NONE) {
					if (touching & RIGHT) {
						velocity.x = -VEL;
					} else if (touching & LEFT) {
						velocity.x = VEL;
					}
					
					if (touching & UP) {
						velocity.y = VEL;
					} else if (touching & DOWN) {
						velocity.y = -VEL;
					}
					
					velocity.x = velocity.x - 10 + 20 * Math.random();
					velocity.y = velocity.y - 10 + 20 * Math.random();
				}
				
				//Hit player
				if (!player.invincible && player.overlaps(this)) {
					player.touchDamage(1);
				}
				
				//Damage logic
				if (!just_hurt && player.broom.visible && player.broom.overlaps(this)) {
					health--;
					t_big_hit = 0;
					flicker(tm_big_hit);
					just_hurt = true;
					
				} else {
					if (just_hurt) {
						t_big_hit += FlxG.elapsed;
						if (t_big_hit > tm_big_hit) {
							just_hurt = false;
						}
					}
				}
				
					
				if (health == 0) {
					play("release_smalls");
					state = s_big_dying;
					velocity.x = velocity.y = 0;
				}
			} else if (state == s_big_dying) {
				big_death_timeout -= FlxG.elapsed;
				if (big_death_timeout < 0) {
					solid = visible = false;
					state = s_big_dead;
					
					EventScripts.make_explosion_and_sound(this);
					/* Init small sprites */
					small_sprites.setAll("visible", true);
					small_sprites.setAll("x", x+2);
					small_sprites.setAll("y", y + 2);
					for each (var ss:FlxSprite in small_sprites.members) {
						ss.my_shadow.x = ss.x + 4;
						ss.my_shadow.y = ss.y + 6;
						ss.velocity.x = Math.random() > 0.5 ? VEL : -VEL;
						ss.velocity.y = Math.random() > 0.5 ? VEL : -VEL;
						ss.velocity.x = ss.velocity.x - 5 + 10 * Math.random();
						ss.velocity.y = ss.velocity.y - 5 + 10 * Math.random();
						ss.health = 1;
						ss.flicker(1);
						ss.my_shadow.play("get_small");
					}
				}
			} else if (state == s_big_dead) {
				var sub_ctr:int = 0;
				for each (var _ss:FlxSprite in small_sprites.members) {
					if (_ss.parabola_thing.tick()) {
						_ss.my_shadow.visible = false;
					}
					if (parent.state != parent.S_TRANSITION) {
						EventScripts.prevent_leaving_map(parent, _ss);
					}
					_ss.my_shadow.x = _ss.x + 4;
					_ss.my_shadow.y = _ss.y + 6;
					FlxG.collide(parent.curMapBuf, _ss);
					
					if (t_small_roll > tm_small_roll) {
						_ss.velocity.x = Math.random() > 0.5 ? VEL : -VEL;
						_ss.velocity.y = Math.random() > 0.5 ? VEL : -VEL;
						
						_ss.velocity.x = _ss.velocity.x - 5 + 10 * Math.random();
						_ss.velocity.y = _ss.velocity.y - 5 + 10 * Math.random();
					}
					
					
					if (x < tl.x || x + width > tl.x + 160) {
						velocity.x *= -1;
					} else if (y < tl.y || y + height > tl.y + 160) {
						velocity.y *= -1;
					}
					
					if (_ss.health > 0) {
						if (!player.invincible && player.overlaps(_ss)) {
							player.touchDamage(1);
						}
						if (!flickering && player.broom.visible && player.broom.overlaps(_ss)) {
							_ss.health --;
							_ss.my_shadow.exists = false;
							EventScripts.drop_small_health(_ss.x, _ss.y, 0.4);
							EventScripts.make_explosion_and_sound(_ss);
						}
					} else {
						_ss.alpha -= 0.07;
						if (_ss.alpha == 0) {
							sub_ctr++;
						}
					}
				}
				
				if (t_small_roll > tm_small_roll) {
					t_small_roll = 0;
				}
				t_small_roll += FlxG.elapsed;
				
				if (sub_ctr == 3) {
					Registry.GRID_ENEMIES_DEAD++;
					exists = false;
				}
				// Keep track of the small guys
			}
		}
		

		override public function destroy():void 
		{
			parent.sortables.remove(small_sprites, true);
			small_sprites = null;
			super.destroy();
		}
	}

}