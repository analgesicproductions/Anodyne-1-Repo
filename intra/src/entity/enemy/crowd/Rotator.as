package entity.enemy.crowd 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import global.Registry;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * Simple enemy - harmful sprite rotates about center thing
	 * @author Seagaia
	 */
	public class Rotator extends FlxSprite 
	{
		
		[Embed (source = "../../../res/sprites/enemies/crowd/f_rotator.png")] public static var rotator_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/crowd/f_rotator_ball.png")] public static var rotator_ball_sprite:Class;
		public var xml:XML;
		public var cid:int = CLASS_ID.ROTATOR;
		public var player:Player;
		public var sprite_ball:FlxSprite;
		public var avel:Number = 0.02;
		public var r:Number = 0;
		
		private var t_timeout:Number = 1.4;
		/**
		 * dame props:
		*	frame: both the sprite to use as well as the rotational radius/speed... see types
		* 
		 */
		public function Rotator(_xml:XML,_player:Player)
		{
			xml = _xml;
			player = _player;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			
			sprite_ball = new FlxSprite(0, 0);
			sprite_ball.loadGraphic(rotator_ball_sprite, true, false, 8, 8);
			sprite_ball.rotate_angle = 0;
			sprite_ball.addAnimation("ball_move", [0, 1], 10);
			sprite_ball.play("ball_move");
			
			sprite_ball.width = sprite_ball.height = 4;
			sprite_ball.offset.x = sprite_ball.offset.y = 2;
			sprite_ball.x += 2; sprite_ball.y += 2;
			
			loadGraphic(rotator_sprite, true, false, 16, 16);
			
			
			width = 6;
			height = 5;
			offset.x = 5;
			offset.y = 2;
			x += 5; y += 2;
			
			
			addAnimation("tower_pulsate", [0, 1], 10);
			play("tower_pulsate");
			immovable = true;
			
		}
		
		override public function update():void 
		{
			
			if (r < 59) {
				r += 0.5;
			}
			EventScripts.rotate_about_center_of_sprite(this, sprite_ball, r, avel, 8, 8);
			FlxG.collide(player, this);
			if (Registry.GAMESTATE.state != Registry.GAMESTATE.S_TRANSITION && sprite_ball.overlaps(player) && player.state != player.S_AIR) {
				
				player.touchDamage(1);
			}
			super.update();
		}
	}

}