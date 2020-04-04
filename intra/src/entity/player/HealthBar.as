package entity.player 
{
	import flash.geom.Point;
	import global.Registry;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	public class HealthBar extends FlxGroup
	{
		/**
		 * 
		 * @param	_x	x coordinate of the top-right health box.
		 * @param	_y	y coordinate of the top-right health box.
		 * @param	health	Max number of health boxes to show.
		 */
		
		public var cur_health:int;
		public var max_health:int;
		public var health_boxes:Array;
		
		public var BOX_WIDTH:int = 11;
		public var BOX_HEIGHT:int = 6;
		public var BOX_SPACING:int = -3;
		
		public var COLOR_FULL:uint = 0x7d1818;
		public var COLOR_EMPTY:uint = 0x494949;
		
		public var FULL_FRAME:int = 0;
		public var EMPTY_FRAME:int = 1;
		
		public var NO_SCROLL:FlxPoint = new FlxPoint(0, 0);
		public var x:int; 
		[Embed (source = "../../res/sprites/inventory/health_piece.png")] public static var health_piece_sprite:Class;
		
		public function HealthBar(_x:int,_y:int,_max_health:int) 
		{
			super(16);
			x = _x;
			y = _y;
			for (var i:int = 0; i < _max_health; i++) {
				make_box(i+1);
				
			}
			max_health = _max_health;
			cur_health = max_health;
			// Thse values are deserialized when continuing a save
			Registry.MAX_HEALTH = max_health; // Want to do this because in the testing mode 
			Registry.CUR_HEALTH = cur_health; // Sometimes we do construct a health bar more than once.
		}
		
		public function make_box(i:int):void {
			i--;
			var health_box:FlxSprite = new FlxSprite;
			
			health_box.x = (x - BOX_WIDTH - 8 * (7 - i % 8)) - 7 * int(i / 8);
			health_box.y = y + int(i / 8) * (BOX_HEIGHT + 1);
			
			health_box.loadGraphic(health_piece_sprite, true, false, BOX_WIDTH, BOX_HEIGHT);
			health_box.alpha = 1;
			health_box.scrollFactor = NO_SCROLL;
			health_box.addAnimation("flash", [0, 2], 7, true);
			health_box.addAnimation("full", [0], 0,false);
			
			add(health_box);
		}
		/**
		 * 
		 * @param	change_amount	How much the health changes
		 * @return	-1 if the change resulted in 0 health, 1 if full, 0 otherwise
		 */
		public function modify_health(change_amount:int):int {
			var nrChanges:int = 0;
			var health_box:FlxSprite;
			if (change_amount < 0) {
				if ( -change_amount > cur_health) change_amount = -cur_health;
				cur_health = Math.max(0, cur_health + change_amount);
				while (nrChanges < -change_amount) {
					health_box = getLastAlive() as FlxSprite;
				
					if (health_box == null) return -1;
					health_box.alive = false;
					health_box.frame = EMPTY_FRAME;
					nrChanges++;
				}
			} else if (change_amount > 0) {
				cur_health = Math.min(max_health, cur_health + change_amount);
				while (nrChanges < change_amount) {
					// Iterate backwards to find the most recent emptied health box, then make it visible
					for (var i:int = 0; i < members.length; i++) {
						if (members[i] != null && members[i].alive == false) {
							members[i].alive = true;
							members[i].frame = FULL_FRAME;
							break;
						} else if (i == max_health - 1) {
							members[0].play("full");
							return 1;
						}
					}
					nrChanges++;
				}
			}
			
			if (cur_health == 1) {
				members[0].play("flash");
			} else if (cur_health > 1) {
				members[0].play("full");
			}
			
			return 0;
		}
		
		public static function upgrade_health(player:Player):void {
			player.health_bar.make_box(player.health_bar.max_health + 1); // Extend bar 
			player.health_bar.max_health ++; // Reflect changes in health bar state
			player.health_bar.modify_health(player.health_bar.max_health); // Heal player
			Registry.MAX_HEALTH++; // Reflect changes in global state
		}
		override public function update():void {
			super.update();
		}
		
	}

}