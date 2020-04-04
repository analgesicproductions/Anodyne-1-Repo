package entity.enemy.bedroom 
{
	import data.CLASS_ID;
	import entity.gadget.Key;
	import entity.player.HealthPickup;
	import entity.player.Player;
	import flash.geom.Point;
	import helper.EventScripts;
	import helper.Parabola_Thing;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSound;
    import org.flixel.FlxSprite;
    import org.flixel.FlxObject;
    import org.flixel.FlxG;
	import global.Registry;
    public class Slime extends FlxSprite
    {
        [Embed ("../../../res/sprites/enemies/slime.png")] public static var Slime_Sprite:Class;
        [Embed ("../../../res/sprites/enemies/bedroom/slime_goo.png")] public var Slime_Goo_Sprite:Class;
		[Embed(source = "../../../res/sprites/enemies/slime_bullet.png")] public static const embed_slime_bullet:Class;
        [Embed ("../../../../../sfx/hit_slime.mp3")] public var Slime_Hit_Sound:Class;
        public var slime_hit_sound:FlxSound = new FlxSound();
		
        public var local_id:int;
        public var gotHit:Boolean = false;
        public var hitTimer:Number = 0;
        public var deathTimer:Number = 0;
        public var HIT_TIMEOUT:Number = 0.3;
		public var xml:XML;
		
		private var state:int = 0;
		private var s_dead:int = 1;
		private  var dropped_health:Boolean = false;
		
		public var type:int;
		public static var NORMAL_T:int = 0;
		public static var KEY_T:int = 1;
		public static var RISE_T:int = 2;
		public static var SUPER_T:int = 3;
		
		public var played_rise:Boolean = false;
		public var has_key:Boolean =  false;
		public var cid:int = CLASS_ID.SLIME;
		public var INCREMENTED_REGISTRY:Boolean = false;
		
		public var change_vel_timer:Number = 0.5;
		public var change_vel_timer_max:Number = 0.5;
		private var VEL:int = 20;
		private var BULLET_VEL:int = 40;
		
		public var t_shoot:Number = 0;
		public var tm_shoot:Number = 1.8;
		public var goo_collide_ticks:int = 4;
	
		
		public var player:Player;
		public var parent:*;
		public var goo_group:FlxGroup = new FlxGroup(7);
		public var goo_bullets:FlxGroup = new FlxGroup(4);
		
		public var move_frame_sound_sync:Boolean = false;
		
        public function Slime(x:int, y:int, _local_id:int, frame_type:int, _xml:XML, _p:Player,_parent:*) {
            super(x, y);
			slime_hit_sound.loadEmbedded(Slime_Hit_Sound, false);
            health = 2;
            loadGraphic(Slime_Sprite, true, false, 16, 16);
			if (Registry.BOI && Registry.CURRENT_MAP_NAME == "REDCAVE") {
				addAnimation("Move", [2,3], 3);
				addAnimation("Hurt", [2,8], 15);
				addAnimation("Dead", [2, 8, 2, 8, 15, 9, 9], 12, false);
			} else {
				addAnimation("Move", [0, 1], 3);
				addAnimation("Hurt", [0, 8], 15);
				addAnimation("Dead", [0, 8, 0, 8, 15, 9, 9], 12, false);
			}
			addAnimation("Rise", [7, 7, 6, 6, 5, 5, 4, 4, 8, 0, 8, 0], 15, false);
			width = height = 12;
			offset.x = offset.y = 2;
			if (frame_type != RISE_T) {
				play("Move");
			} else {
				visible = false;
				solid = true;
			}
            local_id = _local_id;
			xml = _xml;
			
			if (frame_type == KEY_T) {
				has_key = true;
			} else if (frame_type == SUPER_T) {
				VEL = 40;
			}
			type = frame_type;
			
			player = _p;
			parent = _parent;
			
			
			for (var i:int = 0; i < goo_group.maxSize; i++) {
				var goo:FlxSprite = new FlxSprite(0, 0);
				goo.loadGraphic(Slime_Goo_Sprite, true, false, 6, 6);
				if (Registry.BOI && Registry.CURRENT_MAP_NAME == "REDCAVE") {
					goo.addAnimation("move", [4,5,6,7,5,7,5,6,5,4], 5 + int(5 * Math.random()));
				} else {
					goo.addAnimation("move", [0,1,2,3,1,3,1,2,1,0],5 + int(5*Math.random()));
				}
				goo.play("move");
				
				goo.my_shadow = new FlxSprite();
 				goo.my_shadow.makeGraphic(3, 3, 0xff010101);
				goo_group.add(goo);
				parent.bg_sprites.add(goo.my_shadow);
			
				goo.exists = goo.my_shadow.exists = false;
				goo.velocity.x = Math.random() > 0.5 ? -10 - 5 * Math.random() : 10 + 5 * Math.random();
				goo.velocity.y = Math.random() > 0.5 ? -10 - 5 * Math.random() : 10 + 5 * Math.random();
				goo.parabola_thing = new Parabola_Thing(goo, 16, 0.8 + 0.3 * Math.random(), "offset", "y");
				
			}
			
			for (i = 0; i < goo_bullets.maxSize; i++) {
				goo = new FlxSprite(0, 0);
				goo.loadGraphic(Slime_Goo_Sprite, true, false, 6, 6);					

				if (Registry.BOI && Registry.CURRENT_MAP_NAME == "REDCAVE") {
					goo.addAnimation("move", [4,5,6,7,5,7,5,6,5,4], 5 + int(5 * Math.random()));
				} else {
					
					goo.loadGraphic(embed_slime_bullet, true, false, 8,8);
					goo.addAnimation("move", [0, 1], 5 + int(5 * Math.random()));
				}
				goo.play("move");
				
				goo.exists = false;
				goo_bullets.add(goo);
			}
			
			parent.bg_sprites.add(goo_group);
			parent.bg_sprites.add(goo_bullets);
			
			if (xml.@alive == "false") {
				Registry.GRID_ENEMIES_DEAD++;
				exists = false;
			}
			
			add_sfx("walk", Registry.sound_data.slime_walk_group);
			add_sfx("shoot", Registry.sound_data.slime_shoot_group);
			add_sfx("splash", Registry.sound_data.slime_splash_group);
        }
        override public function preUpdate():void 
		{
			FlxG.collide(this, parent.map_bg_2);
			FlxG.collide(this, parent.curMapBuf);
			super.preUpdate();
		}
        override public function update():void {
			
			if (Registry.is_playstate) {
				if (parent.state != parent.S_TRANSITION) {
					EventScripts.prevent_leaving_map(parent, this);
				}
			}
			if (state == s_dead) {
			} else {
				
				if (frame == 1) {
					if (!move_frame_sound_sync) {
						move_frame_sound_sync = true;
						play_sfx("walk");
					}
				} else if (frame == 0) {
					move_frame_sound_sync = false;
				}
			}
			
			/* Hurt logic */
			if (xml.@alive == "true") {
				if (FlxG.overlap(this, player)) {
				    player.touchDamage(1);
				}
				if (player.broom.visible && FlxG.overlap(this, player.broom) ){
					var res:int = hit("broom", player.broom.root.facing);
					if (res == Registry.HIT_KEY) {
						var key:Key = new Key(x, y,player,parent);
						parent.bg_sprites.add(key);
						if (Registry.is_playstate) {
							//bug with roamstate as is
							parent.stateful_gridXML.appendChild(key.xml);
						}
					}
				}
			}
			
			
			// Broken
			if (type == RISE_T) {
				if (Registry.EVENT_OPEN_BROOM) {
					if (!played_rise) {
						play("Rise");
						solid = true;
						visible = true;
					}
					if (frame == 0) play("Move");
				} else {
					return;
				}
			}
			/* If dead, disappear, otherwise, change direction */
            if (health == 0) {
				if (!dropped_health) {
					dropped_health = true;
					EventScripts.drop_small_health(x, y, 0.5);
				}
				xml.@alive = "false";
                if (frame == 9 && state != s_dead) {
                    deathTimer += FlxG.elapsed;
                    if (deathTimer > 0.5) {
						solid = false;
					 	state = s_dead;
						goo_group.setAll("velocity", new FlxPoint(0, 0));
					}
                }
            } else {

				change_vel_timer -= FlxG.elapsed;
				if (!gotHit && change_vel_timer < 0) {
					change_vel_timer = change_vel_timer_max
					velocity.x = VEL * Math.random() - VEL/2;
					velocity.y = VEL * Math.random() - VEL/2;
					if (frame == 1) {
						velocity.x = velocity.y = 0;
					}
				} else {
					if (gotHit) {
						hitTimer += FlxG.elapsed;
					}
					if (hitTimer > HIT_TIMEOUT) {
						play("Move");
						hitTimer = 0; gotHit = false;
					}
				}
			}

			/* update goo effect */
			for each (var goo:FlxSprite in goo_group.members) {
				if (goo != null && goo.exists) { 
					if (goo.parabola_thing.tick()) {
						if (goo.alpha == 1) {
							play_sfx("splash");
						}
						goo.alpha -= 0.01;
						goo.my_shadow.exists = false;
						goo._curAnim = null;
						goo.velocity.x = goo.velocity.y = 0;
					} else {
						goo.my_shadow.x = goo.x;
						goo.my_shadow.y = goo.y;
						FlxG.collide(goo, parent.curMapBuf);
					}
				}
			}
			
			/* do bullets, maybe */
			goo_collide_ticks < 0 ? goo_collide_ticks = 3 : goo_collide_ticks -- ;
			if (type == SUPER_T) {
				t_shoot += FlxG.elapsed;
				if (t_shoot > tm_shoot) {
					t_shoot = 0;
					goo = goo_bullets.getFirstAvailable() as FlxSprite;
					// Only shoot when alive
					if (goo != null && xml.@alive != "false") {
						goo.alpha = 1;
						goo.exists = true;
						goo.x = x; goo.y = y;
						play_sfx("shoot");
						EventScripts.scale_vector( new Point(x, y), new Point(player.x, player.y), goo.velocity, BULLET_VEL);
					}
				}
				for each (goo in goo_bullets.members) {
					if (goo == null || !goo.exists) continue;
					if (goo_collide_ticks == 0) {
						if (FlxG.collide(goo, parent.curMapBuf)) {
							goo.exists = false;
						}
					}
					goo.alpha -= 0.013;
					if (goo.alpha <= 0.3) {
						goo.exists  = false;
						goo.velocity.y = goo.velocity.x = 0;
						
					} else {
						if (!player.invincible && player.state != player.S_AIR && goo.overlaps(player)) {
							goo.velocity.x = goo.velocity.y = 0;
							goo.alpha = 0;
							player.touchDamage(1);
						}
					}
				}
			}
            super.update();
        }

		/**
		 * Uh, getting hit. Type is what hits it. Dir is what direction.
		 * @param	type
		 * @param	dir
		 * @return HIT_NORMAL if died or normal. HIT_KEY if drops key...
		 */
		 
        public function hit(type:String, dir:int):int {
			if (visible == false) return -1;
            if (type == "broom" && !gotHit) {
				for (var i:int = 0; i < 2; i++) {
					var goo:FlxSprite = goo_group.getFirstAvailable() as FlxSprite;
					goo.exists = goo.my_shadow.exists = true;
					goo.x = x;
					goo.y = y;
				}
                health -= 1;
				slime_hit_sound.play();
                if (health == 0) { 
                    velocity.x = velocity.y = 0;
					if (!INCREMENTED_REGISTRY) {
						INCREMENTED_REGISTRY = true;
						Registry.GRID_ENEMIES_DEAD++;
						EventScripts.make_explosion_and_sound(this);
						visible = false;
						play("Dead");
					}
					
					if (has_key) {
						has_key = false;
						gotHit = true;
						return Registry.HIT_KEY;
					}
                    
                } else {
                    play("Hurt");
                }
                switch (dir) {
        
                    case FlxObject.LEFT:    velocity.x = -100; break;
                    case FlxObject.RIGHT:   velocity.x = 100; break;
                    case FlxObject.UP:      velocity.y = -100; break;
                    case FlxObject.DOWN:    velocity.y = 100; break;
                }
            }
            gotHit = true;
			return Registry.HIT_NORMAL;
        }
        
    }

}