package entity.enemy.crowd 
{
	import data.CLASS_ID;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.system.FlxTile;
	
	public class Person extends FlxSprite 
	{
		
		
		
		public var xml:XML;
		public var cid:int = CLASS_ID.PERSON;
		public var player:Player;
		public var parent:*;
		public var switch_dir_timer_max:Number = 1.3;
		public var switch_dir_timer:Number = 0.6;
		public var initial_vel_timeout:Number = 2;
		public var wait:int = 0;
		public var speed:int = 10;
		
		public var cur_x_vel:int = 0;
		public var cur_y_vel:int = 0;
		
		public var init_vel:Point = new Point(0, 0);
		
		public var dame_frame:int;
		
		private var collide_timeout:int = 0;
		
		private var talk_timer:Number;
		
		[Embed (source = "../../../res/sprites/enemies/crowd/person.png")] public static var person_sprite:Class;
		/*
		 * dame params: frame: the direction of player travel this one opposes (or none at all) 
		 * URDLN, unsurprisingly... 01234
		 * direction given away by the way they walk initially
		 * */
		public function Person(_xml:XML,_player:Player,_parent:*) 
		{
			
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			loadGraphic(person_sprite, true, false, 16, 16);
			addAnimation("walk_d", [0, 1], 5);
			addAnimation("walk_r", [2,3], 5);
			addAnimation("walk_u", [4,5], 5);
			addAnimation("walk_l", [2, 3], 5);
			addAnimationCallback(on_anim_change);
			height = 2;
			width = 4;
			offset.y = 13;
			offset.x = 7;
			talk_timer = 0.5 + Math.random();
		
			dame_frame = parseInt(xml.@frame);
			switch (dame_frame) { //urdln
				case 0: init_vel.y = 10; play("walk_d");  break;
				case 1: init_vel.x = 10; play("walk_r"); break;
				case 2: init_vel.y = -10;  play("walk_u");break;
				case 3: init_vel.x = -10;  play("walk_l"); break;
				case 4: init_vel.x = init_vel.y = -10 + 20 * Math.random();  
					if (init_vel.x > 0) {
						play("walk_r");
					} else {
						play("walk_l");
					}
					switch_dir_timer = 0.3;
					switch_dir_timer_max = 0.5;
					drag.x = 20;
					drag.y = 20;
				break;
			}
			
			add_sfx("talk", Registry.sound_data.talk_group);
		}
		
		
		override public function preUpdate():void 
		{
		
			//urdln
			//which dir of travel it blocks
			//allow pushing if touching to olong
			if (collide_timeout > 1) {
				collide_timeout = 0;
				FlxG.collide(parent.curMapBuf, this);
			}  else {
				collide_timeout++;
			}
			
			/* When the player touches,  change player's velocity and
			 * maybe collide with the player as well. */
			if (player.overlaps(this)) {
					player.slow_mul = 0.5; 
					player.slow_ticks = 7;
					player.velocity.x *= 0.25;
					player.velocity.y *= 0.25;
					FlxG.collide(this, player);
					player.velocity.x *= 4;
					player.velocity.y *= 4;
				}
			super.preUpdate();
		}
		override public function update():void 
		{
			
			if (talk_timer < 0) {
				talk_timer = 0.5 + Math.random();
				play_sfx("talk",true);
			} else {
				talk_timer -= FlxG.elapsed;
			}
			
			if (Registry.is_playstate) {
				if (parent.state != parent.S_TRANSITION) {
					EventScripts.prevent_leaving_map(parent, this);
				} else {
					return;
				}
			}
			
			switch_dir_timer -= FlxG.elapsed;
			initial_vel_timeout -= FlxG.elapsed;
			/* Switch directions semi-randomly */
			if (switch_dir_timer < 0) {
				/* Walk in an initial velocity for a fixed period of time */
				if (initial_vel_timeout > 0) {
					velocity.x = init_vel.x;
					velocity.y = init_vel.y;
				} else {
					switch_dir_timer = switch_dir_timer_max;
					if (Math.random() > 0.5) {
						velocity.y = 0;
						if (Math.random() > 0.5) {
							velocity.x = speed;
							play("walk_r");
						} else {
							velocity.x = -speed;
							play("walk_l");
						}
					} else {
						velocity.x = 0;
						if (Math.random() > 0.5) {
							velocity.y = speed;
							play("walk_d");
						} else {
							velocity.y = -speed;
							play("walk_u");
						}
					}
				}
			}
			super.update();
		}
		
		public function on_anim_change(name:String, frame:int, index:int):void {
			if (name == "walk_l") {
				scale.x = -1;
			} else {
				scale.x = 1;
			}
		}
		
	}

}