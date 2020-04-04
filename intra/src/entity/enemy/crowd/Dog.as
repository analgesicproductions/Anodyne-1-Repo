package entity.enemy.crowd 
{
	import entity.gadget.Gate;
	import entity.gadget.Switch_Pillar;
	import flash.geom.Point;
	import global.Registry;
	import org.flixel.FlxG;
	import helper.EventScripts;
	import org.flixel.FlxObject;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import entity.player.Player;
	import data.CLASS_ID;
	import org.flixel.FlxTilemap;
	
	public class Dog extends FlxSprite 
	{
		public var xml:XML;
		public var cid:int = CLASS_ID.DOG;
		public var player:Player;
		public var parent:*;
		//dame props - alive (false or true), p (1)
		[Embed (source = "../../../res/sprites/enemies/crowd/dog.png")] public static var dog_sprite:Class;
		
		
		private var timer:Number = 0;
		
		private var state:int = 0;
		private var s_pace:int = 0;
		private var pace_vel:int = 20;
		private var pace_timer_max:Number = 1.0;
		
		private var s_alert:int = 1;
		private var alert_timer_max:Number = 1.0;
		private var s_attack:int = 2;
		private var attack_pts:Array = new Array(new Point(), new Point(), new Point(), new Point(), new Point());
		private var vel_base_attack:Number = 60;
		private var attack_speeds:Array = new Array(1.1, 1.4, 1.4, 1.6, 1.7);
		private var attack_timer_max:Number = 1.0; //latency before dog "gives up" going to a pt
		
		private var	s_attack_phase:int = 0;
		private var s_dead:int = 3;
		
		private var Dead_Frame:int = 7;
		
		private var hit_timer_max:Number = 1.5;
		private var hit_timer:Number = 0;
		
		private var active_region:FlxObject = new FlxObject(0, 0, 96, 96);
		
		private var type:int = 0;
		private var T_NORMAL:int = 0;
		private var T_SUPER:int = 1;
		
		public function Dog(_xml:XML,_player:Player,_parent:*) 
		{
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			/* DOG ANIMATIONS*/
			loadGraphic(dog_sprite, true, false, 16, 16);
			width = height = 12;
			offset.y = offset.x = 2;
			drag.x = 20;
			
			addAnimation("stop_d", [0]);
			/* walk_l is walk_r reflected */
			addAnimation("walk_l", [2, 3], 4, true);
			addAnimation("walk_r", [2, 3], 4, true);
			addAnimation("alert", [4, 5], 5);
			/* attack_l is attack_r reflected */
			addAnimation("attack_r", [6, 7],6,true);
			addAnimation("attack_l", [6, 7 ],6,true);
			addAnimation("die", [1, 2, 3, 4, 4, 3, 1, 3, 2, 1,7], 15, false);
			
			addAnimationCallback(set_scale);
			
			if (xml.@alive == "false") {
				Registry.GRID_ENEMIES_DEAD++;
				exists = false;
			}
			
			
			if (parseInt(xml.@type) == T_SUPER) {
				type = T_SUPER;
				health = 3;
			} else {
				health = 3;
				type = T_NORMAL;
			}
			
			add_sfx("bark", Registry.sound_data.dog_bark_group);
			add_sfx("dash", Registry.sound_data.dog_dash);
		}
		override public function preUpdate():void 
		{	
			FlxG.collide(parent.curMapBuf, this);
			super.preUpdate();
		}
		
		override public function update():void 
		{
			if (Registry.is_playstate) {
				if (parent.state != parent.S_TRANSITION) {
					EventScripts.prevent_leaving_map(parent, this);
				}
			}
			
			for each (var sp:Switch_Pillar in Registry.subgroup_switch_pillars) {
				if (sp != null && (sp.frame == sp.up_frame)) {
					FlxG.collide(sp, this);
				}
			}
			if (player.state != player.S_AIR && player.overlaps(this) && (xml.@alive != "false")) {
				player.touchDamage(1);
			}
			
			for each (var g:Gate in Registry.subgroup_gates) {
				if (g != null) {
					if (g.overlaps(this)) {
						velocity.x = velocity.y = 0;
					}
				}
			}
			
			/* pin active region to self */
			active_region.x = x - 40;
			active_region.y = y - 40;
			if (hit_timer < hit_timer_max) {
				hit_timer += FlxG.elapsed;
			}
			
			/* die if health too low */
			if (health <= 0 && state != s_dead) {
				state = s_dead;
			} else if (state != s_dead) {
				if (hit_timer >= hit_timer_max) {
					if (player.broom.overlaps(this) && player.broom.visible) {
						hit_timer = 0;
						health--;					
						flicker(hit_timer_max);
						play_sfx(HURT_SOUND_NAME);
					}
				}
			}
			/* pace and wait for player to get near */
			if (state == s_pace) {
				timer += FlxG.elapsed;
				if (timer > pace_timer_max) {
					if (FlxG.random() > 0.33) {
						play("walk_r");
						velocity.x = pace_vel;
					} else {
						if (FlxG.random() > 0.5) {
							play("walk_l");
							velocity.x = -pace_vel;
						} else {
							play("stop_d");
							velocity.x = 0;
						}
					}
					timer = 0;
				}
				if (active_region.overlaps(player)) {
					state = s_alert;
					velocity.x = velocity.y = 0;
					play("alert");
					play_sfx("bark");
					timer = 0;
				}
			/* set points for dash attack */
			} else if (state == s_alert) {
				timer += FlxG.elapsed;
				if (timer > alert_timer_max) {
					state = s_attack;
					timer = 0;
					velocity.y = 30;
					/* Set up points for dog to dash to */
					attack_pts[0].x = player.x - 50 + 12 * Math.random(); // LEFT
					attack_pts[0].y = player.y - 8;
					
					attack_pts[1].x = player.x + 30 + 12 * Math.random();
					attack_pts[1].y = player.y - 8; // right
					
					attack_pts[2].x = player.x - 50 + 12*Math.random();
					attack_pts[2].y = player.y - 8; // DOWN
					
					EventScripts.scale_vector(new Point(x, y), attack_pts[0], velocity, vel_base_attack * attack_speeds[0]);
					
					
					if (velocity.x > 0) {
						play("attack_r");
					} else {
						play("attack_l");
					}
				}
			/* dash to points and then reset */
			} else if (state == s_attack) {
				var p_done:int = 0;
				
				timer += FlxG.elapsed;
				if (timer > attack_timer_max) {
					velocity.x = velocity.y = 0;
					timer = 0;
					p_done = 2;
					s_attack_phase++;
					
				}
				/* When the dash timer runs out*/
				if (p_done == 2) {
					
					/* If SUPER dog,dynamically determine dash points */
					if (s_attack_phase <= 4 && type == T_SUPER) {
						if (player.x > x) {
							attack_pts[s_attack_phase].x = player.x + 25;// RIGHT
							attack_pts[s_attack_phase].y = player.y + 8;
						} else {
							attack_pts[s_attack_phase].x = player.x - 28; // LEFT
							attack_pts[s_attack_phase].y = player.y - 8;
						}
					}
					/* change the velocity if the dog doesn't need to stop */
					if (s_attack_phase < 5) {
						EventScripts.scale_vector(new Point(x, y), attack_pts[s_attack_phase], velocity, vel_base_attack * attack_speeds[s_attack_phase]);
					}
					/* Set the correct attacking anim*/
					if (velocity.x > 0) {
						play("attack_r");
					} else {
						play("attack_l");
					}
					
					/* State change */
					if (type == T_NORMAL && s_attack_phase > 2) {
						state = s_pace;
						velocity.x = velocity.y = 0;
						play("walk_r");
						s_attack_phase = 0;
					} else if (s_attack_phase > 4) {
						state = s_pace;
						s_attack_phase = 0;
					} else {
						
					play_sfx("dash");
					}
				}
			} else if (state == s_dead) {
			//	if (frame == Dead_Frame) {
					xml.@alive = "false";
					Registry.GRID_ENEMIES_DEAD++;
					EventScripts.drop_small_health(x, y, 1.0);
					EventScripts.make_explosion_and_sound(this);
					//play die sound effect
					exists = false; // :(
				//}
			}
			super.update();
		}
		
		public function set_scale(name:String,frame_nr:uint,frame_idx:uint):void {
			if (name == "walk_l" || name == "stop_l") {
				scale.x = -1;
			} else if (name == "attack_l") {
				scale.x = -1;
			} else {
				scale.x = 1;
			}
			
			
		}
		
	
	}

}