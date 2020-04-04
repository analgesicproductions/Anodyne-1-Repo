package entity.enemy.hotel 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Seagaia
	 */
	public class Dustmaid extends FlxSprite 
	{
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		
		private var state:int = 0;
		private var s_idle:int = 0;
		private var s_chasing:int = 1;
		private var s_dying:int = 2;
		private var s_dead:int = 3;
		
		private var ctr:int = 0;
		private var freq:int = 10;
		
		private var player_pt:Point = new Point();
		private var pt:Point = new Point();
		
		private var t_hit:Number = 0;
		private var tm_hit:Number = 1.0;
		public var cid:int = CLASS_ID.DUSTMAID;
		[Embed (source = "../../../res/sprites/enemies/hotel/dustmaid.png")] public static var dustmaid_sprite:Class;
		
		public function Dustmaid(_xml:XML,_player:Player,_parent:*) 
		{
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			health = 3;
			state = s_idle;
			alpha = 0.7;
			
			loadGraphic(dustmaid_sprite, true, false, 16, 24);
			width = 8;
			height = 18;
			centerOffsets(true);
			offset.x += 1;
			offset.y += 2;
			addAnimation("idle", [0],1);
			addAnimation("turn_dark", [1,2,1,2],12,false);
			addAnimation("move_r", [5,6],7);
			addAnimation("move_l", [5,6],7);
			addAnimation("move_d", [3,4],7);
			addAnimation("move_u", [7,8],7);
			play("idle");
			
			add_sfx("alert", Registry.sound_data.dustmaid_alert);
			
		}
		override public function preUpdate():void 
		{
			FlxG.collide(this, parent.curMapBuf);
			super.preUpdate();
		}
		override public function update():void 
		{
			
			if (state != s_dying && !player.invincible && player.overlaps(this)) {
				if (state != s_dead) {
					player.touchDamage(1);
				}
			}
			
			t_hit += FlxG.elapsed;
			if (health > 0 && player.broom.visible && state == s_chasing && player.broom.overlaps(this)) {
				if (t_hit > tm_hit) {
					flicker(1);
					t_hit = 0;
					health--;
					play_sfx(HURT_SOUND_NAME);
					if (health == 0) {
						state = s_dying;
					}
					if (state == s_idle) {
						state = s_chasing;
						play("turn_dark");
					}
				}
			}
			
			
			if (state == s_idle) {
				if (player.broom.has_dust) {
					state = s_chasing;
					play("turn_dark");
					alpha = 1;
					play_sfx("alert");
				}
				
			} else if (state == s_chasing) {
				if (_curAnim.name == "turn_dark") {
					if (_curFrame == _curAnim.frames.length - 1) {
					} else {
						return;
					}
				}
				if (ctr == freq) {
					ctr = 0;
					player_pt.x = player.x;
					player_pt.y = player.y;
					pt.x = x;
					pt.y = y;
					scale.x = 1;
					offset.x = 5;
					switch (EventScripts.get_entity_to_entity_dir(pt.x, pt.y, player_pt.x, player_pt.y)) {
						case UP:
							play("move_u");
							offset.x = 1;
							break;
						case LEFT:
							scale.x = -1;
							play("move_l");
							break;
						case RIGHT:
							play("move_r");
							break;
						case DOWN:
							play("move_d");
							break;
					}
					EventScripts.scale_vector(pt, player_pt, velocity, 20);
				}
				
				ctr++;
				
				
			} else if (state == s_dying) {
				//play dying
				//sfx dying
				//alpha -= 0.04;
				alpha = 0;
				if (alpha == 0) {
					EventScripts.drop_small_health(x, y, 0.7);					
					EventScripts.make_explosion_and_sound(this);
					Registry.GRID_ENEMIES_DEAD++;
					state = s_dead;
				}
			} else if (state == s_dead) {
				exists = false;
			}
		
			super.update();
		}
		
	}

}