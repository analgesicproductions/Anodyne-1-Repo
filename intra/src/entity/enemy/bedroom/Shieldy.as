package entity.enemy.bedroom 
{
	import data.CLASS_ID;
	import entity.gadget.Switch_Pillar;
	import entity.player.HealthBar;
	import entity.player.HealthPickup;
	import entity.player.Player;
	import helper.EventScripts;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;	
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import global.Registry;
	import states.PlayState;
	/**
	 * ...
	 * @author Seagaia	 */
	public class Shieldy  extends FlxSprite
	{
		[Embed (source = "../../../res/sprites/enemies/shieldy.png")] public static var SPRITE_SHIELDY:Class;
		public var xml:XML;
		public var just_hit:Boolean = false;
		public var hit_timer_max:Number = 0.4;
		public var hit_timer:Number = 0.4;
		public var parent:PlayState;
		public static var FLOATING_VELOCITY:int = 30;
		public static var T_LEFT:int = 4;
		public static var T_UP:int = 5;
		public static var T_RIGHT:int = 6;
		public static var T_DOWN:int = 7;
		public var INCREMENTED_REGISTRY:Boolean = false;
		
		public var state:int;
		public static var S_L:int = 0;
		public static var S_R:int = 1;
		public static var S_U:int = 2;
		public static var S_D:int = 3;
		public static var S_NOTHING:int = 4;
		public var ul_pt:FlxSprite;
		public var dr_pt:FlxSprite;
		
		public var cid:int = CLASS_ID.SHIELDY;
		public var player:Player;
	
		
		public function Shieldy(x:int,y:int,_xml:XML,_parent:PlayState) 
		{
			super(x  +2, y);
			xml = _xml;
			parent = _parent;
			loadGraphic(SPRITE_SHIELDY, true, false, 16, 16);
			addAnimation("float", [1, 2, 1, 0], 5, true);
			//addAnimation("unhurt", [4], 7, true);
			addAnimation("front_hit", [16, 17, 18, 1], 12, false);
			addAnimation("back_hit", [13, 1], 12);
			//addAnimation("die", [8, 9, 10, 11,14], 10, false);
			play("float");
			immovable = true;
			solid = true;
			height = 10;
			width = 10;
			
			offset.x = 3;
			offset.y = 4;
			health = 2;
			
			switch (parseInt(xml.@frame)) {
				case 0: state = S_NOTHING; break;
				case T_LEFT: velocity.x =  - FLOATING_VELOCITY; state = S_L;  break;
				case T_RIGHT: velocity.x = FLOATING_VELOCITY; state = S_R;  break;
				case T_UP: velocity.y = -FLOATING_VELOCITY; state = S_U;  break;
				case T_DOWN: velocity.y = FLOATING_VELOCITY; state = S_D; break;
			}
			
			ul_pt = new FlxSprite(x, y);
			dr_pt = new FlxSprite(x, y + 10);
			ul_pt.makeGraphic(10, 1, 0xffff0000);
			
			dr_pt.makeGraphic(10, 1, 0xffff0000);
			player = _parent.player;
			
			add_sfx("ineffective", Registry.sound_data.shieldy_ineffective);
		}
		
		override public function update():void {
			
			
			if (Registry.is_playstate) {
				if (parent.state != parent.S_TRANSITION) {
					EventScripts.prevent_leaving_map(parent, this);
				}
			}
			
			/* check for hit*/
			if (solid && player.broom.visible && player.broom.overlaps(this)) {
				hit("broom", player.facing);
			}
			/* hurt player */
			if (FlxG.overlap(this, player)) {
				player.touchDamage(1);
			}
			
			/* drop health and animate if die */
			if (health <= 0 && solid) {
				EventScripts.drop_small_health(x,y,0.5);
				if (!INCREMENTED_REGISTRY) {
					INCREMENTED_REGISTRY = true;
					Registry.GRID_ENEMIES_DEAD++;
				}
				EventScripts.make_explosion_and_sound(this);
				visible = false;
				velocity.y = velocity.x = 0;
				Registry.sound_data.shieldy_hit.play();
				exists = false;
				solid = false;
			}
			
			
			if (just_hit) {
				hit_timer -= FlxG.elapsed;
				if (hit_timer < 0) {
					hit_timer = hit_timer_max;
					just_hit = false;
				}
			} else {
				if (health > 0)
					play("float");
			}
			
			/* collide with map and switch dirs */
			ul_pt.x = x;
			ul_pt.y = y;
			dr_pt.x = x;
			dr_pt.y = y + 10;
			switch (state) {
				case S_R: 
					if (touches_something() || FlxG.collide(dr_pt, parent.curMapBuf)) {
						state = S_L;
						velocity.x = -FLOATING_VELOCITY;
					}
					break;
				case S_L: 
					if (touches_something() || FlxG.collide(ul_pt, parent.curMapBuf)) {
						state = S_R;
						velocity.x = FLOATING_VELOCITY;
					}
					break;
				case S_U: 
					if (touches_something() || FlxG.collide(ul_pt, parent.curMapBuf)) {
						state = S_D;
						velocity.y = FLOATING_VELOCITY;
					}
					break;
				case S_D:
					if (touches_something() || FlxG.collide(dr_pt, parent.curMapBuf)) {
						state = S_U;
						velocity.y = -FLOATING_VELOCITY;
					}
					break;
			}
			
			super.update();
		}
		
		private function touches_something():Boolean {
			for each (var sp:Switch_Pillar in Registry.subgroup_switch_pillars) {
				if (sp == null) continue;
				if (sp.overlaps(this) && (sp.frame == sp.up_frame)) return true;
			}
			return false;
		}
		
		
		public function hit(hitter:String, dir_player_facing:uint):int {
			if (hitter == "Pew_Laser") {
				health -= 5;
				return Registry.HIT_NORMAL;
			}
			if (dir_player_facing == FlxObject.DOWN && !just_hit) {
				Registry.sound_data.shieldy_hit.play();
				just_hit = true;
				health --;
				flicker(hit_timer_max / 2);
				play("back_hit");
				return Registry.HIT_NORMAL;
			} else if (!just_hit) {
				play("front_hit");
				play_sfx("ineffective");
				var old_x:int = int(x);
				var old_y:int = int(y);
				switch (dir_player_facing) {
					case LEFT:
						if (x % 160 > 20) {
							x -= 8;
						}
						break;
						
					case UP:
						y -= 8; break;
					case RIGHT:
						if (x % 160 < 125) {
							x += 8; 
						}
						break;
				}
				just_hit = true;
				var tile_type:int = parent.map.getTile(int(int(x) / 16), int((int(y) - 20) / 16));
				if (parent.curMapBuf._tileObjects[tile_type].allowCollisions == FlxObject.ANY) {
					x = old_x;
					y = old_y;
				}
			}
			return -1;
		}
		
	}

}