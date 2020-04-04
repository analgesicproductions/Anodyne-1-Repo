package entity.enemy.redcave 
{
	/**
	 * ...
	 * @author Seagaia
	 */
	import data.CLASS_ID;
	import entity.player.Player;
	import global.Registry;
	import mx.core.FlexSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import states.PlayState;
	public class Four_Shooter extends FlxSprite
	{
		[Embed(source = "../../../res/sprites/enemies/redcave/f_four_shooter.png")] public static var four_shooter_sprite:Class;
		[Embed(source = "../../../res/sprites/enemies/redcave/f_four_shooter_bullet.png")] public static var four_shooter_bullet_sprite:Class;
		
		
		
		public var cid:int = CLASS_ID.FOUR_SHOOTER;
		public var xml:XML;
		public var timer_max:Number = 1.5;
		public var timer:Number = timer_max;
		public var state:int = 0;
		public var S_STRAIGHT:int = 0;
		public var S_DIAG:int = 1;
		public var bullets:FlxGroup;
		public var NR_BULLETS:int = 12;
		public var parent:PlayState;
		public var VEL:int = 50;
		public var player:Player;
		public function Four_Shooter(_xml:XML, _parent:PlayState, _player:Player)
		{
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			xml = _xml;
			
			bullets = new FlxGroup();
			for (var i:int = 0; i < NR_BULLETS; i++) {
				var bullet:FlxSprite = new FlxSprite(0, 0);
				/* Animations for bullets */
				bullet.loadGraphic(four_shooter_bullet_sprite, true, false, 8, 8);
				bullet.addAnimation("move", [0, 1], 12, true);
				bullet.addAnimation("explode", [2, 3], 10, false);
				
				bullet.play("move");
				bullet.has_tile_callbacks =  false;
				bullets.add(bullet);
				bullet.width = bullet.height = 4;
				bullet.offset.x = bullet.offset.y = 2;
			}
			immovable = true;
			bullets.setAll("alive", false);
			parent = _parent;
			parent.otherObjects.push(bullets);
			player = _player;
			
			/* Animations for four_shooter */
			loadGraphic(four_shooter_sprite, true, false, 16, 16);
			addAnimation("nesw", [0]);
			addAnimation("shoot_then_nesw_to_diag", [0, 1, 2, 2], 3, false);
			addAnimation("diag", [2]);
			addAnimation("shoot_then_diag_to_nesw", [2, 1, 0, 0], 3, false);
			play("nesw");
			
			add_sfx("shoot", Registry.sound_data.four_shooter_shoot_group);
			add_sfx("pop", Registry.sound_data.four_shooter_pop_group);
			
			
		}
		
		override public function update():void 
		{
			FlxG.collide(player, this);
			timer -= FlxG.elapsed;
			if (timer < 0) {
				timer = timer_max;
				shoot();
				rotate();
			} else {
				if (_curAnim.frames.length - 1 == _curFrame) {
					if (state == S_DIAG) {
						play("diag"); 
					} else {
						play("nesw");
					}
				}
			}
			check_overlap();
			super.update();
		}
		
		public function reset_bullet(b:FlxSprite, m:Object):void {
			if (!b.alive) return;
			b.alive = false;
			play_sfx("pop");
			b.velocity.x = b.velocity.y = 0;
			b.play("explode");
		}
		public function check_overlap():void {
			FlxG.collide(bullets, parent.curMapBuf, reset_bullet);
			for each (var b:FlxSprite in bullets.members) {
				if (b != null) {
					if (player.state != player.S_AIR && b.alive && b.overlaps(player)) {
						player.touchDamage(1);
						reset_bullet(b, null);
					}
				}
			}
			
			for each (var s:FlxSprite in bullets.members) {
				if (s == null || !s.alive) continue;
				if (s.velocity.x == 0) {
					if (s.y > parent.lowerBorder) {
						reset_bullet(s, null); continue;
					} else if (s.y < parent.upperBorder) {
						reset_bullet(s, null); continue;
					}
				} else {
					if (s.x > parent.rightBorder) {
						reset_bullet(s, null); continue;
					} else if (s.x < parent.leftBorder) {
						reset_bullet(s, null); continue;
					}
				}
			}
		}
		public function shoot():void {
			var b:FlxSprite;
			var is_diag:Boolean = false;
			play_sfx("shoot");
			if (state == S_DIAG) {
				is_diag = true;
			}
			for (var i:int = 0; i < 4; i ++) {
				b = bullets.getFirstDead() as FlxSprite;
				if (b == null) break;
				b.alive = true;
				b.play("move");
				switch (i) {
					case 0:
						b.velocity.x = -VEL;
						b.x = x - 2;
						b.y = y + 6;
						if (is_diag) { b.velocity.y = VEL * .7;  b.velocity.x = -VEL * .7; 
									   b.y = y + 11; b.x = x + 2; }
										

						break;
					case 1:
						b.velocity.x = VEL;
						b.x = x + 12;
						b.y = y + 7;
						if (is_diag) { b.velocity.y = -VEL * .7;  b.velocity.x = VEL * .7;
									   b.y = y + 2; b.x = x + 11; }
						break;
					case 2:
						b.velocity.y = VEL;
						b.x = x + 6;
						b.y = y + 13	;
						if (is_diag) { b.velocity.y = VEL * .7;  b.velocity.x = VEL * .7; 
										b.x = x + 12;  b.y = y +11; }
						
						break;
					case 3:
						b.velocity.y = -VEL;
						b.x = x + 6;
						b.y = y - 1;
						if (is_diag) { b.velocity.y = -VEL * .7;  b.velocity.x = -VEL * .7;
										b.x = x + 1; b.y  = y + 1; }
						break;
				}
			}
			
			
		}
		public function rotate():void {
			if (state == S_STRAIGHT) {
				play("shoot_then_nesw_to_diag");
				state = S_DIAG;
			} else {
				play("shoot_then_diag_to_nesw");
				state = S_STRAIGHT;
			}
			
		}
		
	}

}