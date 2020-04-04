package entity.enemy.etc 
{
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.system.FlxTile;
	
	public class Chaser extends FlxSprite 
	{
		private var xml:XML;
		private var player:Player;
		private var parent:*;
		
		
		private var state:int;
		private const s_idle:int = 0;
		private const s_moving:int = 1;
		
		private var dame_type:int;
		private var dt_hori:int = 0;	
		private var dt_vert:int = 1;
		
		private var float_vel:int = 15;
		
		private var tl:Point;
		
		private var lookahead:Point;
		
		
		[Embed(source = "../../../res/sprites/enemies/etc/chaser.png")] public static var embed_chaser_sprite:Class;
		
		public function Chaser(_xml:XML, _player:Player, _parent:*) 
		{
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			dame_type = parseInt(xml.@frame);
			
			state = s_idle;
			
			tl = new Point(Registry.CURRENT_GRID_X * 160, Registry.CURRENT_GRID_Y * 160 + Registry.HEADER_HEIGHT);
			lookahead = new Point(0, 0);
			
			
			loadGraphic(embed_chaser_sprite, true, false, 16, 32);
			width = height = 8;
			offset.y = 20;
			offset.x = 4;
			x += 4;
			y += 20;
			// MARINA_ANIMS
			if (dame_type == dt_hori) {
				frame = 6;
			} else {
				frame = 4;
			}
			addAnimation("d", [4, 5], 8);
			addAnimation("r", [6,7], 8);
			addAnimation("u", [8, 9], 8);
			addAnimation("l", [10,11], 8);
			addAnimationCallback(on_anim_change);
			
		}
		
		override public function preUpdate():void 
		{
			super.preUpdate();
		}
		
		override public function update():void 
		{
			if (Registry.keywatch.JP_ACTION_1) {
				Registry.sound_data.play_sound_group(Registry.sound_data.mover_move_group);
			}
			
			if (player.broom.visible) {
				if (Math.abs(velocity.x) < 100 && Math.abs(velocity.y) < 100) {
					velocity.x *= 1.025;
					velocity.y *= 1.025;
				}
			} else {
				float_vel = 15;
			}
			switch (state) {
				case s_idle:
					
					if (dame_type == dt_hori) {
						if (player.y > y - player.height && player.y < y + height) {
							state = s_moving;
							Registry.sound_data.play_sound_group(Registry.sound_data.mover_die_group);
							if (player.x > x) {
								velocity.x = float_vel;
								play("r");
 							} else {
								velocity.x = -float_vel;
								play("l");
							}
						}
					} else if (dame_type == dt_vert) {
						if (player.x + player.width > x && player.x < x + width) {
							state = s_moving;
							Registry.sound_data.play_sound_group(Registry.sound_data.mover_die_group);
							if (player.y > y) {
								play("d");
								velocity.y = float_vel;
							} else {
								play("u");
								velocity.y = -float_vel;
							}
						}
					}
					break;
				case s_moving:
					if (EventScripts.get_tile_allow_collisions(lookahead.x,lookahead.y,parent.curMapBuf)) {
						switch (facing) {
							case UP:
								facing = DOWN;
								play("d");
								velocity.y *= -1;
								break;
							case DOWN:
								play("u");
								facing = UP;
								velocity.y *= -1;
								break;
							case LEFT:
								play("r");
								facing = RIGHT;
								velocity.x *= -1;
								break;
							case RIGHT:
								play("l");
								facing = LEFT;
								velocity.x *= -1;
								break;
						}
					}
					// Now update the lookahead point to reflect the possible state change above
					if (facing & (UP | DOWN)) {
						if (facing & UP) {
							lookahead.y = y;
							lookahead.x = x + width / 2;
						} else {
							lookahead.x = x + width / 2;
							lookahead.y = y + height;
						}
					} else {
						if (facing & RIGHT) {
							lookahead.x = x + width;
							lookahead.y = y + height / 2;
						} else {
							lookahead.x = x;
							lookahead.y = y + height / 2;
						}
					}
					
					// Check to kill the player
					if (player.overlaps(this)) {
						player.touchDamage(6);
					}
					break;
			}
			super.update();
		}
		
		private function on_anim_change(name:String, frame:int, index:int):void {
			switch (name) {
				case "u":
					facing = UP;
					break;
				case "d":
					facing = DOWN;
					break;
				case "l":
					facing = LEFT;
					break;
				case "r":
					facing = RIGHT;
					break;
			}
		}
		
		override public function destroy():void 
		{
			tl = null;
			super.destroy();
		}
	}

}