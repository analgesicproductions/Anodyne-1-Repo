package helper 
{
	/**
     * ...
     * @author seagaia


     */
	import data.CLASS_ID;
	import data.Common_Sprites;
	import entity.enemy.etc.Briar_Boss;
	import entity.player.HealthPickup;
	import flash.geom.Point;
	import global.Registry;
	import mx.core.FlexSprite;
	import org.flixel.FlxPoint;
    import org.flixel.FlxSprite;
    import org.flixel.FlxG;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	import org.flixel.system.FlxTile;
	import states.DialogueState;
	import states.PlayState;
    public class EventScripts extends FlxSprite
    {
        
		[Embed (source = "../res/sprites/enemies/enemy_explode_2.png")] public static var small_explosion_sprite:Class;
		
		public var xml:XML;
		public var cid:int = CLASS_ID.EVENT_SCRIPT;
        public function EventScripts() {
			super(0, 0);
			makeGraphic(1, 1, 0x00ffffff);
			xml = <event></event>;
		}
        public static function move_to_x_and_stop(o:FlxSprite, vel:Number, x:Number):void {
            if (vel > 0 && o.x > x) {
                o.velocity.x = 0;
            } else if (vel < 0 && o.x < x) {
                o.velocity.x = 0;
            } else {
                o.velocity.x = vel;
            }
            return;
        }
        
		public static function move_to_x(o:FlxSprite, vel:Number, x:Number):Boolean {
			o.velocity.x = vel;
			if (vel < 0) {
				if (o.x <= x) return true;
			} else {
				if (o.x >= x) return true;
			}
			return false;
		}
        public static function check_x_zero(...args):Boolean {
            var next:FlxSprite;
            var ret:Boolean = true;
            for (var i:int = 0; i < args.length; i++) {
                next = args[i];
                if (next.velocity.x != 0)  {
                    ret = false; 
                    break;
                }
            }
            return ret;
        }
        
        /**
         * Decreases or increases the given FlxSprite's alpha at rate to a target value.
         * -rate for decrease, +rate for increase.
         * @return  true if the alpha reached the target value, false otherwise
         */
          
        
        public static function send_alpha_to(o:FlxSprite, target:Number, rate:Number):Boolean {
            if (rate > 0) {
                if (o.alpha >= target) return true;
                o.alpha = Math.min(1, o.alpha + rate);
            } else {
                if (o.alpha <= target) return true;
                o.alpha = Math.max(0, o.alpha + rate);
            }
            return false;
        }
        
		public static function send_property_to(o:Object, property:String, target:Number, rate:Number):Boolean {
			if (rate < 0) rate *= -1;
			
			if (o[property] > target) {
				o[property] = Math.max(target, o[property] - rate);
			} else if (o[property] < target) {
				o[property] = Math.min(target, o[property] + rate);
			}
			if (o[property] == target) return true;
			return false;
		}
		
		/**
		 * 
		 * @param	chance 	A number from 0 to 1, the probability of the health dropping
		 */
		public static function drop_small_health(x:int,y:int,chance:Number):void {
			var hp:HealthPickup = new HealthPickup(x, y, HealthPickup.HP_1, Registry.GAMESTATE);
			if (Math.random() > (1 - chance)) {
				if (Registry.is_playstate) {
					Registry.GAMESTATE.otherObjects.push(hp); //So we remove these on screen transition
					Registry.GAMESTATE.bg_sprites.add(hp); //So these are immediately drawn
				} else {
					Registry.GAMESTATE.entities.push(hp);
					Registry.GAMESTATE.add(hp);
				}
			}
		}
		
		public static function drop_big_health(x:int,y:int,chance:Number):void {
			var hp:HealthPickup = new HealthPickup(x, y, HealthPickup.HP_3, Registry.GAMESTATE);
			if (Math.random() > (1 - chance)) {
				if (Registry.is_playstate) {
					Registry.GAMESTATE.otherObjects.push(hp);
					Registry.GAMESTATE.bg_sprites.add(hp);
				} else {
					Registry.GAMESTATE.entities.push(hp);
				}
			}
		}
		
		/**
		 * Create an explosion sprite and add it to the current draw group.
		 * @param	enemy	The enemy that's exploding - used for deciding the explosion
		 */
		/* Images for explosions are embedded at the top of EventScripts.as */
		/* Sounds are managed in SoundData.as */
		public static function make_explosion_and_sound(enemy:FlxSprite,ignore:int=0,this_parameter:int=0):void {
			var class_name:String = FlxU.getClassName(enemy, true);
			var explosion:FlxSprite = new FlxSprite(enemy.x, enemy.y);
			
			/* Make the explosion */
			
			/* Later, load the explosion and sound based on the class name. */
			switch (class_name) { // e.g., "Dog", "Lion", "Contort"
				case "Velociraptor X3000":
					// load the graphic, add animation, offset the explosion, play a sound
					break;
				default: // Executed when there is no case statement for the enemy
					
					if (ignore == 1) {
						explosion.loadGraphic(Briar_Boss.embed_dust_explosion, true, false, 48, 48);
						explosion.addAnimation("explode", [0, 1, 2, 3, 4, 5], 12, false);
						explosion.x += enemy.width * Math.random();
						explosion.y += enemy.height * Math.random();
					} else if (ignore == 2) {
						explosion.loadGraphic(Briar_Boss.embed_ice_explosion, true, false, 24, 24);
						explosion.addAnimation("explode", [0, 1, 2, 3,4], 15, false);
						explosion.x += enemy.width * Math.random();
						explosion.y += enemy.height * Math.random();
					} else if (ignore == 3) {
						explosion.loadGraphic(small_explosion_sprite, true, false, 24, 24);
						explosion.addAnimation("explode", [0, 1, 2, 3, 4], 12, false);
						explosion.x += enemy.width * Math.random();
						explosion.y += enemy.height * Math.random();
						
					} else if (Registry.CURRENT_MAP_NAME == "TRAIN") {
						explosion.loadGraphic(small_explosion_sprite, true, false, 24, 24);
						explosion.addAnimation("explode", [5,6,7,8,9], 10, false);
						explosion.x -= 4;
						explosion.y -= 4;
						
					} else {
						explosion.loadGraphic(small_explosion_sprite, true, false, 24, 24);
						explosion.addAnimation("explode", [0, 1, 2, 3, 4], 12, false);
						explosion.x -= 4;
						explosion.y -= 4;
					}
					
					
					Registry.sound_data.play_sound_group(Registry.sound_data.enemy_explode_1_group);
					break;
			}
			
			if (ignore > 0) {
				Registry.GAMESTATE.fg_sprites.add(explosion);
			} else {
				Registry.GAMESTATE.bg_sprites.add(explosion);
			}
			explosion.play("explode");
			
			
			/* Play sound */
		
		}
		public static function boss_drop_health_up(x:int, y:int):void {
			trace("Boss dropping health up");
			var hp:HealthPickup = new HealthPickup(x, y, HealthPickup.HP_EXTEND,Registry.GAMESTATE);
			hp.xml = fake_xml("HealthPickup", x.toString(), y.toString(), HealthPickup.HP_EXTEND.toString(), "true", "2");
			Registry.GAMESTATE.stateful_gridXML.appendChild(hp.xml);
			Registry.GAMESTATE.bg_sprites.add(hp);
		}
		
		/**
		 * Create a fake xml to be used for some sprite that wasnte
		 * exported with dame
		 * @param	name 	name of the node
		 * @param	x		x value	
		 * @param	y		y value
		 * @param	type_attr		value of "type" if relevant
		 * @return		the new xml objet
		 */
		public static function fake_xml(name:String,x:String,y:String,type_attr:String="",alive:String="true",p:String="0",frame:String="0"):XML {
			var xml:XML = < Root x = "0" y = "0" p = "" alive = "" type = "" frame = "" /> ;
			trace(xml.toXMLString());
			xml.setName(name);
			xml.@p = p;
			xml.@["x"] = x;
			xml.@y = y;
			xml.@frame = frame;
			xml.@alive = alive;
			xml.@type = type_attr;
			trace(xml.toXMLString());
			
			return xml;
			
		}
		
		
		/**
		 * Rotates ROTATEE about PIVOT's top-left pt with offset (off_x,off_y),
		 * at some velocity (per game tick), at a radius of...radius!
		 * 
		 * ROTATEE NEEDS A rotate_angle PROPERTY.
		 */
		public static  function rotate_about_center_of_sprite(pivot:FlxSprite,rotatee:*,radius:Number,velocity:Number,off_x:int=-8,off_y:int=-5):void {
			var pivot_x:Number = pivot.x + pivot.width / 2;
			var pivot_y:Number = pivot.y + pivot.height / 2;
			
			
			rotatee.x = Math.cos(rotatee.rotate_angle) * (radius) + pivot_x + off_x;
			rotatee.y = Math.sin(rotatee.rotate_angle) * (radius) + pivot_y + off_y;
			rotatee.rotate_angle = (rotatee.rotate_angle + velocity) % 6.28;
		}
		
		/** 
		 * Gives the angle swept from the x axis to ((x1,y1),(x2,y2)) by treating x1,y1 as the origin
		 * */
		
		public static function get_angle(x1:Number, y1:Number, x2:Number, y2:Number):Number  {
			
			var x:Number = x2 - x1;
			var y:Number = y2 - y1;
			return Math.atan2(y, x);
		}
		
		
		/**
		 * Set "out" to be a vector in the direction of to - from, 
		 * with magnitude new_mag.
		 * @param	from
		 * @param	to
		 * @param	out
		 * @param	new_mag
		 * @return
		 */
		public static function scale_vector(from:*, to:*, out:*, new_mag:Number ):FlxPoint {
			
			var dx:Number = to.x - from.x;
			var dy:Number = to.y - from.y;
			var mag:Number = Math.sqrt(dx * dx + dy * dy);
			var scale:Number = new_mag / mag;
			out.x = scale * dx;
			out.y = scale * dy;
			return out;
		}
		
		/**
		 * Return the distance between two points.
		 * Input is any objects with an x and y property.
		 */
		public static function distance(a:*, b:*):Number {
			var dx:Number = a.x - b.x;
			var dy:Number = a.y - b.y;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		public static function prevent_leaving_map(playstate:PlayState,o:FlxSprite):void {
			if (o.y < playstate.upperBorder) o.y = playstate.upperBorder;
			if (o.y + o.height > playstate.lowerBorder) o.y = playstate.lowerBorder - o.height;
			if (o.x + o.width > playstate.rightBorder) o.x = playstate.rightBorder - o.width;
			if (o.x < playstate.leftBorder) o.x = playstate.leftBorder;
		}
		
		/**
		 * Inits a bitmap font object with the default
		 * variables for Anodyne
		 * Types: black apple_black apple_white
		 */
		public static function init_bitmap_font(text:String = " ", alignment:String = "center", x:int = 0, y:int = 0, scrollFactor:Point = null, type:String="black"):FlxBitmapFont {
			
			var b:FlxBitmapFont;
			
			switch (type) {
			case "apple_black":
				if (DH.language_type == DH.LANG_ja) {
					b = new FlxBitmapFont(Registry.C_FONT_JP_WHITE,8,8, Registry.jp_string, 50, 0, 0, 0,0);
				}  else if (DH.language_type == DH.LANG_ko) {
					b = new FlxBitmapFont(Registry.C_FONT_KO_WHITE, 8, 8, Registry.ko_string, 64, 0, 0, 0, 0);
				} else if (DH.language_type == DH.LANG_zhs) {
					b = new FlxBitmapFont(Registry.C_FONT_ZHS_WHITE, 11, 12, Registry.zhs_string, 72, 0, 0, 0, 0);
				} else if (DH.language_type == DH.LANG_es || DH.language_type == DH.LANG_pt || DH.language_type == DH.LANG_it) {
					b = new FlxBitmapFont(Registry.C_FONT_ES_WHITE, 6, 8, Registry.es_string, 27, 0, 0, 0, 0);
				} else { // english, normal font
				b = new FlxBitmapFont(Registry.C_FONT_APPLE_BLACK, Registry.APPLE_FONT_w, Registry.FONT_h, Registry.C_FONT_APPLE_BLACK_STRING, Registry.FONT_cpl, 0, 0, 0, 1);
				}
				break;
			case "apple_white":
				if (DH.language_type == DH.LANG_ja) {
					b = new FlxBitmapFont(Registry.C_FONT_JP_WHITE, 8, 8, Registry.jp_string, 50, 0, 0, 0, 0);
				} else if (DH.language_type == DH.LANG_ko) {
					b = new FlxBitmapFont(Registry.C_FONT_KO_WHITE, 8, 8, Registry.ko_string, 64, 0, 0, 0, 0);
				} else if (DH.language_type == DH.LANG_zhs) {
					b = new FlxBitmapFont(Registry.C_FONT_ZHS_WHITE, 11, 12, Registry.zhs_string, 72, 0, 0, 0, 0);
				}else if (DH.language_type == DH.LANG_es || DH.language_type == DH.LANG_pt || DH.language_type == DH.LANG_it) {
					b = new FlxBitmapFont(Registry.C_FONT_ES_WHITE, 6, 8, Registry.es_string, 27, 0, 0, 0, 0);
				} else { // english, normal font
					b = new FlxBitmapFont(Registry.C_FONT_APPLE_WHITE, Registry.APPLE_FONT_w, Registry.FONT_h, Registry.C_FONT_APPLE_WHITE_STRING, Registry.FONT_cpl, 0, 0, 0, 1);	
				}
				break;
			case "apple_white_OLD":
				b = new FlxBitmapFont(Registry.C_FONT_APPLE_WHITE, Registry.APPLE_FONT_w, Registry.FONT_h, Registry.C_FONT_APPLE_WHITE_STRING, Registry.FONT_cpl, 0, 0, 0, 1);	
				break;
			case "black":
			default:
				b = new FlxBitmapFont(Registry.C_FONT_BLACK, Registry.FONT_w, Registry.FONT_h, Registry.C_FONT_BLACK_STRING, Registry.FONT_cpl, 0, 0, 0, 0);
				break;
			}
			b.setText(text, true, 0, 0, alignment, true);
			b.x = x;
			b.y = y;
			if (scrollFactor == null) {
				b.scrollFactor.x = b.scrollFactor.y = 0;
			} else {
				b.scrollFactor.x = scrollFactor.x;
				b.scrollFactor.y = scrollFactor.y;
			}
			return b;
		}
		
		/**
		 * This function keeps a sprite's hitbox entirely in the specified
		 * box, and flips its velocities when needed to keep it inside the box.
		 * @return RES, where RES = X_FLIP | Y_FLIP, where X_FLIP = 0b01, Y_FLIP = 0b10
		 */
		public static function bounce_in_box(o:FlxSprite, x_max:int, x_min:int, y_max:int, y_min:int):int {
				var res:int = 0;
				if (o.velocity.x < 0) {
					if (o.x < x_min) {
						o.velocity.x *= -1; res |= 1;
					}
				} else {
					if (o.x + o.width > x_max) {
						o.velocity.x *= -1; res |= 1;
					}
				}
				
				if (o.velocity.y < 0) {
					if (o.y < y_min) {
						o.velocity.y *= -1; res |= 2;
					} 
				} else {
					if (o.y + o.height > y_max) {
						o.velocity.y *= -1; res |= 2;
					}
				}
				return res;
		}
		
		/**
		 * Lookup the tile at (x,y) of map, and then check its properties according to submap. 
		 * @param	x
		 * @param	y
		 * @param	map
		 * @param	submap
		 * @return
		 */
		public static function get_tile_collision_flags(x:int, y:int, map:FlxTilemap,submap:FlxTilemap):uint {
			var tile_type:int = map.getTile(x / 16, (y - Registry.HEADER_HEIGHT) / 16);
			
			if (submap._tileObjects[tile_type] == null) return NONE;
			
			return submap._tileObjects[tile_type].allowCollisions;
		}
		
		/**
		 * Get the direction from entity 1's position (e1x,e1y) to entity
		 * 2's position (e2x,e2y), using the rotated quadrants method.
		 * 
		 * @param	e1x
		 * @param	e1y
		 * @param	e2x
		 * @param	e2y
		 * @return The FlxObject constant showing where the 2nd entity is relative to entity 1
		 */
		public static function get_entity_to_entity_dir(e1x:int, e1y:int, e2x:int, e2y:int):uint {
			
			var dx:int = e2x - e1x;
			var dy:int = e2y - e1y;
			
			if (dx > 0) {
				if (Math.abs(dy) < dx) {
					return RIGHT;
				} 
			} else {
				if (Math.abs(dy) < Math.abs(dx)) {
					return LEFT;
				} 
			}
			return ((dy > 0) ?  DOWN : UP);
		}
		
		/**
		 * Makes e1's facing flag set towards e2. Also then plays the associated directional
		 * animation - prefix+"_"+{d,u,r,l} 
		 */
		public static function face_and_play(e1:*, e2:*, prefix:String = "idle"):String {
			e1.facing = get_entity_to_entity_dir(e1.x, e1.y, e2.x, e2.y);
			switch (e1.facing) {
				case UP:
					e1.play(prefix + "_u");
					break;
				case DOWN:
					e1.play(prefix + "_d");
					break;
				case LEFT:
					e1.play(prefix + "_l");
					break;
				case RIGHT:
					e1.play(prefix + "_r");
					break;
			}
			return (e1._curAnim == null) ? "" : e1._curAnim.name;
		}
		
		public static function play_based_on_facing(e1:*,prefix:String = "idle"):String {
			switch (e1.facing) {
				case UP:
					e1.play(prefix + "_u");
					break;
				case DOWN:
					e1.play(prefix + "_d");
					break;
				case LEFT:
					e1.play(prefix + "_l");
					break;
				case RIGHT:
					e1.play(prefix + "_r");
					break;
			}
			return (e1._curAnim == null) ? "" : e1._curAnim.name;
		}
		
		/**
		 * Checks if e1 and e2's facing flags are directional opposites.
		 * @param	e1
		 * @param	e2
		 * @return  True or False.
		 */
		public static function are_facing_opposite(e1:*, e2:*):Boolean {
			if (e1.facing == UP && e2.facing == DOWN) return true;
			if (e2.facing == UP && e1.facing == DOWN) return true;
			if (e1.facing == LEFT && e2.facing == RIGHT) return true;
			if (e2.facing == LEFT && e1.facing == RIGHT) return true;
			
			return false;
			 
		}
		
		/**
		 * Create a shadow specified by name, and adds the animations get_big and get_small,
		 * and also makes it invisible. You still need to add it to the parent.
		 * @param	name : 8_small 
		 * @return the shadow
		 */
		public static function make_shadow(name:String,visible:Boolean=false,fps:int=8):FlxSprite {
			var shadow:FlxSprite = new FlxSprite;
			
			switch (name) {
				case "8_small":
				default:
					shadow.loadGraphic(Common_Sprites.shadow_sprite_8_8, true, false, 8, 8);
					shadow.addAnimation("get_big", [0, 1, 2, 3], fps, false);
					shadow.addAnimation("get_small", [3, 2, 1, 0], fps, false);
					shadow.play("get_big");
					shadow.visible = visible;
					
					break;
			}
			
			return shadow;
			
		}
		
		/**
		 * Called by create() in PlayState and roamstate, this returns a reference to the loaded
		 * autosave icon. Gives it an animation, to boot.
		 * @param	autosave_icon
		 * @param	autosave_icon_embed
		 * @return
		 */
		public static function init_autosave_icon(autosave_icon:FlxSprite, autosave_icon_embed:Class):FlxSprite {
			
			autosave_icon = new FlxSprite(160 - 80 - 32, 20);//(160 - 2 - 64, 20 + 160 - 2 - 64);
			autosave_icon.loadGraphic(autosave_icon_embed, true, false, 64, 16);
			autosave_icon.visible = false;
			autosave_icon.addAnimation("a", [0, 1, 2, 3, 4, 5], 8, true);
			autosave_icon.play("a");
			autosave_icon.scrollFactor.x = autosave_icon.scrollFactor.y = 0;
			return autosave_icon;
		}
		
		/**
		 * Gets the tile's collision flags at (x,y) (default screenspace coords)
		 * @param	x
		 * @param	y
		 * @param	map
		 * @param	screen_coords
		 * @return
		 */
		public static function get_tile_allow_collisions(x:int, y:int, map:FlxTilemap, screen_coords:Boolean = true):uint {

			if (screen_coords) {
				var _x:int = (x % 160) / 16; //FCK IT
				var _y:int = ((y - 20) % 160) / 16; 
				var tile_idx:int = map.getTileByIndex(_y * 10 + _x);
				var tile:FlxTile = map._tileObjects[tile_idx];
				return tile.allowCollisions;
			}
			return NONE;
		}
		
		public static function get_tile_nr(x:int, y:int, map:FlxTilemap):int {
			var _x:int = (x % 160) / 16; //FCK IT
			var _y:int = ((y - 20) % 160) / 16; 
			var tile_idx:int = map.getTileByIndex(_y * 10 + _x);
			return tile_idx;
		}
		
		public static function fade_and_switch(name:String):void {
			Registry.E_FADE_AND_SWITCH = true;
			Registry.E_FADE_AND_SWITCH_SONG = name;
			Registry.E_FADED = false;
		}
		
		/**
		 * Increments timer until it reaches timer_max, then sets timer to 0.
		 * @param	timer
		 * @param	timer_max
		 * @return false if timer < timer_max, true otherwise
		 */
		public static function time_cond(ref:*,timer:String, timer_max:String):Boolean {
			ref[timer] += FlxG.elapsed;
			if (ref[timer] > ref[timer_max]) {
				ref[timer] = 0;
				return true;
			}
			return false;
		}
    }

}