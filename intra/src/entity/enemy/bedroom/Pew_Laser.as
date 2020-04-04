package entity.enemy.bedroom 
{
	import data.CLASS_ID;
	import data.SoundData;
	import entity.gadget.Dust;
	import entity.player.Player;
	import global.Registry;
	import org.flixel.*;
	import states.PlayState;
	/**
	 * ...
	 * @author Seagaia
	 */
	
	public class Pew_Laser extends FlxSprite 
	
	{
		//[embed laser gfx
		[Embed (source = "../../../res/sprites/enemies/pew_laser.png")] public static var PEW_LASER:Class;
		[Embed (source = "../../../res/sprites/enemies/pew_laser_bullet.png")] public static var PEW_LASER_BULLET:Class;
		public var xml:XML;
		public var parent:PlayState;
		public var bullets:FlxGroup;
		public var BULLET_TIMER_MAX:Number = 0.5;
		public var cur_velocity:Number = 0;
		public static var BULLET_VELOCITY:Number = 40;
		public static var BULLET_FAST_VELOCITY:Number = 70;
		public var bullet_timer:Number = 1;
		
		private var dir_type:int;
		private static var T_DOWN:int = 0;
		private static var T_RIGHT:int = 1;
		private static var T_UP:int = 2;
		private static var T_LEFT:int = 3;
		private static var T_FAST_DOWN:int = 4;
		private static var T_FAST_RIGHT:int = 5;
		private static var T_FAST_UP:int = 6
		private static var T_FAST_LEFT:int = 7;
		
		private var draw_fix:Boolean = false;
		private var latency_ticks:int = 3;
		
		public var cid:int = CLASS_ID.PEW_LASER;
		public function Pew_Laser(X:Number, Y:Number, _xml:XML,_parent:PlayState) 
		{
			super(X, Y);
			xml = _xml;
			
			//determine frame/animations
			loadGraphic(PEW_LASER, true, false, 16, 16);
			
			if (parseInt(xml.@frame) > 3) {
				cur_velocity = BULLET_FAST_VELOCITY;
			} else {
				cur_velocity = BULLET_VELOCITY;
			}
			
			dir_type = parseInt(xml.@frame);
			immovable = true;
			solid = false;
			bullets = new FlxGroup(5);
			parent = _parent;
			for (var i:int = 0; i < 5; i++) {
				var bullet:FlxSprite = new FlxSprite(x, y);
				bullet.loadGraphic(PEW_LASER_BULLET, true, false, 16, 8);
				bullet.exists = false;
				bullet.has_tile_callbacks =  false;
				bullet.width = 12;
				bullet.height = 8;
				bullets.add(bullet);
				bullet.addAnimation("a", [0, 1], 8, true);
				bullet.addAnimation("b", [4, 5, 6, 7], 8, false);
				bullet.play("a");
			}
			parent.fg_sprites.add(bullets);
			
			
			
				
			
			switch (parseInt(xml.@frame) % 4) {
				case 0: frame = 0; break;
				case 1: frame = 1; bullets.setAll("angle", 270);  break;
				case 2: frame = 2; bullets.setAll("angle", 180);  break;
				case 3: frame = 3; 
				bullets.setAll("angle", 90);  bullets.setAll("width", 8);   
				bullets.setAll("height", 16); 	bullets.setAll("offset", new FlxPoint(2,-4));    
				break;
			}
			
		}
		
		override public function destroy():void {
			//taken care of in remove_otehrobjects etc
			super.destroy();
		}
		
		public function bullet_on_map(b:FlxSprite, m:FlxTilemap):void {
			
			b.play("b");
		}
		override public function update():void {
			bullet_timer -= FlxG.elapsed;
			
			latency_ticks--;
			if (latency_ticks > 0) {
				FlxG.collide(bullets, parent.curMapBuf, bullet_on_map);
			} else {
				latency_ticks = 3;
			}
			
			/*if (!draw_fix) {
				draw_fix = true;
				var idx1:int = parent.members.indexOf(bullets.members[0]);
				parent.members.splice(parent.members.indexOf(this), 1);
				parent.members.splice(idx1, 0, this);
			}*/
			
			for (var j:int = 0; j < bullets.members.length; j++) {
				var b1:FlxSprite = bullets.members[j];
				if ((b1.y < parent.upperBorder) || (b1.y + b1.height > parent.lowerBorder) ||
				 (b1.x + b1.width > parent.rightBorder)  || (b1.x < parent.leftBorder)) {
					 b1.exists = false;
				  }
			} 
			
			for (var i:int = 0; i < bullets.length; i++) {
				// Set exists to false at end of anim
				if (!bullets.members[i].exists) continue;
				if (bullets.members[i].frame == 7) bullets.members[i].exists = false;
				if (dir_type % 2 == 0 && bullets.members[i].velocity.y == 0) {
						
					bullets.members[i].play("b");
					bullets.members[i].velocity.x = bullets.members[i].velocity.y = 0;
					bullets.members[i].solid = false;
					continue;
				}
				/* LOL FUCK IT EVERYTHING BECOMES GLOBAL */
				for (var k:int = 0; k < Registry.subgroup_dust.length; k++) {
					
					if (Registry.subgroup_dust[k].cid == CLASS_ID.DUST) {
						if (Registry.subgroup_dust[k].visible &&  Registry.subgroup_dust[k].frame != Dust.EMPTY_FRAME && Registry.subgroup_dust[k].overlaps(bullets.members[i])) {
							bullets.members[i].play("b");
							bullets.members[i].velocity.x = bullets.members[i].velocity.y = 0;
							bullets.members[i].solid = false;
							break;
						}
					}
				}
				
				for (var ka:int = 0; ka < parent.statefuls.length; ka++) {
					if (parent.statefuls[ka] == null) continue;
					if (parent.statefuls[ka].cid == CLASS_ID.SHIELDY && (parent.statefuls[ka].health > 0) && bullets.members[i]._curAnim.name == "a") {
						if (bullets.members[i].overlaps(parent.statefuls[ka])) {
							parent.statefuls[ka].hit("Pew_Laser", 0);
							bullets.members[i].velocity.x = bullets.members[i].velocity.y = 0;
							bullets.members[i].play("b");
							bullets.members[i].solid = false;
						}
					}
				}
				if (parent.player.overlaps(bullets.members[i]) && bullets.members[i].exists) {
					parent.player.touchDamage(1, "zap");
					bullets.members[i].play("b");
					bullets.members[i].velocity.x = bullets.members[i].velocity.y = 0;
					bullets.members[i].solid = false;
					
				}
			}
			if (bullet_timer < 0) {
				Registry.sound_data.play_sound_group(Registry.sound_data.laser_pew_group);
				var b:FlxSprite = bullets.getFirstAvailable() as FlxSprite;
				if (b != null) {
					b.exists = true;
					b.solid = true;
					b.play("a");
					switch (dir_type) {
						case T_DOWN: case T_FAST_DOWN: b.height = 3; b.velocity.y = cur_velocity; b.y = y + 11;  b.offset.y = 4;  b.x = x + 2; b.offset.x = 2; break;
						case T_UP: case T_FAST_UP: b.height = 3;  b.velocity.y = -cur_velocity; b.y = y + 8; b.x = x + 2;  b.offset.x = 2; b.offset.y = 1; break;
						case T_LEFT: case T_FAST_LEFT:  b.width = 3; b.velocity.x = -cur_velocity; b.x = x + 8; b.offset.y = -4; b.offset.x = 5;  break;
						case T_RIGHT: case T_FAST_RIGHT: b.y = y + 2; b.offset.y = -2;  b.offset.x = 9;  b.velocity.x = cur_velocity; b.x = x + 2; b.width = 3; b.height = 12; break;
					}
					bullet_timer = BULLET_TIMER_MAX;
				}
			}
			super.update();
		}
	}
	
	
	
	

}