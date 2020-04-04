package entity.enemy.circus 
{
	import data.Common_Sprites;
	import entity.gadget.Dust;
	import entity.player.Player;
	import flash.geom.Point;
	import global.Registry;
	import helper.EventScripts;
	import helper.Parabola_Thing;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class Lion extends FlxSprite 
	{
		[Embed (source = "../../../res/sprites/enemies/circus/lion.png")] public static var lion_sprite:Class;
		[Embed (source = "../../../res/sprites/enemies/circus/lion_fireballs.png")] public static var lion_fireball_sprite:Class;
		
		
		public var xml:XML;
		public var player:Player;
		public var parent:*;
		
		private var max_health:int = 4;
		private var is_hurt:Boolean = false;
		
		private var hori_hitbox:FlxSprite = new FlxSprite;
		private var H_OFF_X:int = 3;
		private var H_OFF_Y:int = 11;
		private var vert_hitbox:FlxSprite = new FlxSprite;
		private var V_OFF_X:int = 10;
		private var V_OFF_Y:int = 4;
		private var hitbox:FlxSprite;
		
		private var state:int = 0;
		private var state_pace:int = 0;
		private var t_pace:Number = 0;
		private var tm_pace:Number = 0.8;
		private var vel_pace:Number = 43;
		private var ctr_pace:int = 0;
		
		private var state_shoot:int = 1;
		private var fireballs:FlxGroup = new FlxGroup(10);
		private var vel_fireball:int = 88;
		private var max_fireball_x_distance:int = 80;
		private var ctr_shoot:int = 0;
		private var t_shoot:Number = 0;
		private var tm_shoot:Number = 0.165;
		private var tm_shoot_warning:Number = 0.8;
		private var ctr_shots:int = 0;
		private var max_shots:int = 18;
		
		private var state_charge:int = 2;
		private var ctr_charge:int = 0;
		private var vel_charge:int = 110;
		private var t_charge:Number = 0;
		private var h_shadow:FlxSprite = new FlxSprite;
		private var v_shadow:FlxSprite = new FlxSprite;
		
		
		private var state_dying:int = 3;
		
		private var did_init:Boolean = false;
		
		public function Lion(_xml:XML, _player:Player, _parent:*) 
		{
			xml = _xml;
			player = _player;
			parent = _parent;
			super(parseInt(xml.@x), parseInt(xml.@y));
			
			health = max_health;
			solid = false;
			
			loadGraphic(lion_sprite, true, false, 32, 32);
			addAnimation("walk_l", [0, 1], 5);
			addAnimation("walk_r", [0, 1], 5);
			addAnimation("walk_d", [10,11], 5);
			addAnimation("walk_u", [5,6], 5);
			
			addAnimation("warn_l", [3], 5, true);
			addAnimation("warn_r", [3], 5, true);
			
			addAnimation("shoot_l", [2], 15, true);
			addAnimation("shoot_r", [2], 15, true);
			addAnimation("shoot_d", [12], 15, true);
			addAnimation("shoot_u", [7], 15, true);
			
			addAnimation("pounce_r", [4]);
			addAnimation("pounce_l", [4]);
			addAnimation("pounce_u", [9]);
			addAnimation("pounce_d", [14]);
			
			play("walk_r");
			addAnimationCallback(on_anim_change);
			
			
			add_sfx("shoot", Registry.sound_data.fireball_group);
			
			/* Make shadows */
			h_shadow.loadGraphic(Common_Sprites.shadow_sprite_28_10, true, false, 28, 10);
			v_shadow.loadGraphic(Common_Sprites.shadow_sprite_28_10, true, false, 28, 10);
			v_shadow.visible = h_shadow.visible = false;
			h_shadow.frame = v_shadow.frame = 4; 
			h_shadow.offset.x = -2; h_shadow.offset.y = -24;
			v_shadow.offset.y = -12;
			v_shadow.scale.x = 0.5; v_shadow.scale.y = 2; // Remove when you add teha ctual shadows
			
			parabola_thing = new Parabola_Thing(this, 12, 1.0, "offset", "y");
			
			hori_hitbox.makeGraphic(26, 13, 0x00ff0000);
			vert_hitbox.makeGraphic(10, 20, 0x0000ff00);
			hitbox = hori_hitbox;
			hitbox.velocity.x = vel_pace;
			
			for (var i:int = 0; i < fireballs.maxSize; i++) {
				var fireball:FlxSprite = new FlxSprite;
				
				fireball.loadGraphic(lion_fireball_sprite, true, false, 16, 16);
				fireball.width = fireball.height = 8;
				fireball.centerOffsets(true);
				
				fireball.addAnimation("shoot", [0, 1], 10);
				fireball.addAnimation("poof", [2,3,4,5], 10,false);
				fireball.play("shoot");
				fireball.alive = fireball.exists = false;
				fireballs.add(fireball);
			}
			
			if (xml.@alive == "false") {
				Registry.GRID_ENEMIES_DEAD++;
				exists = false;
			}
			
			state = state_pace;
		}
	
		override public function update():void 
		{
			if (parent.state == parent.S_TRANSITION) {
				hitbox.velocity.x = hitbox.velocity.y = 0;
				return;
			}
			if (!did_init) {
				did_init = true;
				center_hitboxes();
				parent.fg_sprites.add(vert_hitbox);
				parent.fg_sprites.add(hori_hitbox);
				parent.fg_sprites.add(fireballs);
				parent.bg_sprites.add(v_shadow);
				parent.bg_sprites.add(h_shadow);
			}
			
			//Graphic pinned to hitbox (hitbox moves)
			if (hitbox == vert_hitbox) {
				x = hitbox.x - V_OFF_X;
				y = hitbox.y - V_OFF_Y;
			} else if (hitbox == hori_hitbox) {
				x = hitbox.x - H_OFF_X;
				y = hitbox.y - H_OFF_Y;
			}
			
			//Stop moving if touchign solid tile
			FlxG.collide(hitbox, parent.curMapBuf);
			
			if (hitbox.touching != NONE) {
				hitbox.velocity.x = hitbox.velocity.y = 0;
			}
			
			//hurt player
			if (!player.invincible && player.overlaps(hitbox)) {
				player.touchDamage(1);
			}
			
			// Get hurt
			if (!flickering && player.broom.visible && player.broom.overlaps(hitbox)) {
				flicker(1);
				is_hurt = true;
				play_sfx(HURT_SOUND_NAME);
				health--;
				if (health <= 0) {
					state = state_dying;
				}
			} else {
				is_hurt = false;
			}
			
			if (state == state_pace) {
				pace_state();
			} else if (state == state_shoot) {
				shoot_state();
			} else if (state == state_charge) {
				charge_state();
			} else if (state == state_dying) {
				alpha -= 0.05;
				if (alpha == 0) {
					Registry.GRID_ENEMIES_DEAD++;
					EventScripts.make_explosion_and_sound(this);
					exists = false;
					v_shadow.exists = h_shadow.exists = false;
				}
			}
			
			super.update();
		}
		
		public function on_anim_change(name:String, frame_nr:uint, frame_index:uint):void {
			if (name == "walk_l" || name == "shoot_l" || name == "warn_l" || name == "pounce_l") {
				facing = LEFT;
				scale.x = -1;
			} else {
				scale.x = 1;
				if (name == "walk_r" || name == "shoot_r") {
					facing = RIGHT;
				} else if (name == "walk_u" || name == "shoot_u") {
					facing = UP;
				} else if (name == "walk_d" || name == "shoot_d") {
					facing = DOWN;
				} 
			}
		}
		
		private function center_hitboxes():void 
		{
			hori_hitbox.x = x + H_OFF_X;
			hori_hitbox.y = y + H_OFF_Y;
			vert_hitbox.x = x + V_OFF_X;
			vert_hitbox.y = y + V_OFF_Y;
		}
		
		private function pace_state():void 
		{
			t_pace += FlxG.elapsed;
			if (t_pace > tm_pace) {
				t_pace = 0;
				ctr_pace = int(6 * Math.random());
				var r:Number = Math.random();
				if (r < 0.25) {
					state = state_shoot;
					if (player.x > x + 16) {
						play("warn_r");
					} else {
						play("warn_l");
					}
					
					return;
				} else if (r < 0.55) {
					state = state_charge;
					return;
				}
				switch (ctr_pace) {
					case 0:
						hitbox = hori_hitbox;
						hitbox.velocity.x = vel_pace;
						hitbox.velocity.y = 0;
						center_hitboxes();
						play("walk_r");
						break;
					case 1: 
						hitbox = vert_hitbox;
						hitbox.velocity.x = 0;
						hitbox.velocity.y = vel_pace;
						play("walk_d");
						center_hitboxes();
						break;
					case 2:
						hitbox = hori_hitbox;
						hitbox.velocity.y = 0;
						hitbox.velocity.x = -vel_pace;
						play("walk_l");
						center_hitboxes();
						break;
					case 3:
						hitbox = vert_hitbox;
						hitbox.velocity.x = 0;
						hitbox.velocity.y = -vel_pace;
						play("walk_u");
						center_hitboxes();
						break;
					default:
						//hitbox.velocity.x = hitbox.velocity.y = 0;
						break;
				}
			}
		}
		
		private function shoot_state():void 
		{
			hitbox.velocity.x = hitbox.velocity.y = 0;
			
			var fireball:FlxSprite;
			
			if (ctr_shoot == 0) {
				t_shoot += FlxG.elapsed;
				if (t_shoot <= tm_shoot_warning) {
					return;
				} else {
					t_shoot = 0;
					ctr_shoot++;
				}
			}
			
			
			// Periodically shoot a fireball
			t_shoot += FlxG.elapsed;
			if (t_shoot > tm_shoot) {
				t_shoot = 0;
				if (ctr_shots < max_shots && fireballs.countDead() > 0) {
					fireball = fireballs.getFirstDead() as FlxSprite;
					if (fireball != null) {
						ctr_shots++;
						play_sfx("shoot");
						face_player();
						switch (facing) {
							case UP:
								fireball.x = x + width / 2;
								fireball.y = y - 2;
								EventScripts.scale_vector(getMidpoint(), new Point(x + 32*Math.random(), y - 32), fireball.velocity, vel_fireball);
								break;
							case DOWN:
								fireball.x = x + width / 2;
								fireball.y = y + height + 2;
								EventScripts.scale_vector(getMidpoint(), new Point(x + 32*Math.random(), y + 32), fireball.velocity, vel_fireball);
								break;
							case RIGHT:
								fireball.x = x + width;
								fireball.y = y + 6;
								EventScripts.scale_vector(new Point(x + width, y + 6), new Point(x + 80, y - 26 + 52*Math.random()), fireball.velocity, vel_fireball);
								break;
							case LEFT:
								fireball.x = x;
								fireball.y = y + 6;
								EventScripts.scale_vector(new Point(x, y + 6), new Point(x - 30, y - 26 + 52*Math.random()), fireball.velocity, vel_fireball);
								break;
						}
						fireball.exists = fireball.alive = true;
						fireball.finished = false;
						fireball.play("shoot");
					}
				} else {
					ctr_shots = 0;
					state = state_pace;
				}
			}
			// Fireballs hit player and map
			for each (fireball in fireballs.members) {
				
				if (fireball._curAnim != null && fireball._curAnim.name != "poof") {
				for each (var dust:Dust in Registry.subgroup_dust) {
					if (dust != null) {
						if (dust.visible && dust.overlaps(fireball)) {
							fireball.play("poof"); fireball.finished  = false;
						}
					}
				}
				if (fireball.alive) {
					if (!player.invincible && player.overlaps(fireball)) {
						player.touchDamage(1);
						fireball.play("poof"); fireball.finished  = false;
						//fireball.alive = false;
					}
					if (player.broom.visible && player.broom.overlaps(fireball)) {
						fireball.play("poof"); fireball.finished  = false;
						//fireball.alive = false;
					}
				}
				if (Math.abs(fireball.x - x)  > max_fireball_x_distance) {
					//fireball.alive = fireball.exists = false;
					
					fireball.play("poof"); fireball.finished  = false;
				} else if (Math.abs(fireball.y - y) > max_fireball_x_distance) {
					//fireball.alive = fireball.exists = false;
					fireball.play("poof"); fireball.finished  = false;
					
				}
			}
				
				if (fireball.finished && fireball._curAnim != null && fireball._curAnim.name == "poof" ) {
					fireball.exists = fireball.alive = false;
					fireball.play("shoot");
				}
			}
			
			
			// If hurt then go back to charge
			if (is_hurt) {
				ctr_shots = max_shots;
			}
		}
		
		private function charge_state():void 
		{
			if (ctr_charge == 0) { // Walk away forom the player
				hitbox = hori_hitbox;
				center_hitboxes();
				hitbox.velocity.x = 20;
				hitbox.velocity.y = 0;
				if (player.x > x) {
					hitbox.velocity.x *= -1;
					play("walk_l");
				} else {
					play("walk_r");
				}
				ctr_charge++;
			} else if (ctr_charge == 1) { // Face the player
				t_charge += FlxG.elapsed;
				if (t_charge > 1.4) {
					hitbox.velocity.x = hitbox.velocity.y = 0;
					if (_curAnim.name == "walk_r") {
						hitbox.velocity.x = -10;
						play("warn_l");
					} else {
						hitbox.velocity.x = 10;
						play("warn_r");
					}
					t_charge = 0;
					ctr_charge++;
					
				}
			} else if (ctr_charge == 2) { //pause a little
				t_charge += FlxG.elapsed;
				if (t_charge > 0.6) {
					t_charge = 0;
					ctr_charge++;
				}
			} else if (ctr_charge == 3) { //dash to theplayer
				EventScripts.scale_vector(new Point(x, y), new Point(player.x, player.y), hitbox.velocity, vel_charge);
				ctr_charge++;
				scale.x = 1;
				switch (EventScripts.get_entity_to_entity_dir(x, y, player.x, player.y)) {
					case UP:
						v_shadow.visible = true;
						play("pounce_u");
						break;
					case DOWN:
						v_shadow.visible = true;
						play("pounce_d");
						break;
					case LEFT:
						h_shadow.visible = true;
						play("pounce_l");
						break;
					case RIGHT:
						h_shadow.visible = true;
						play("pounce_r");
						break;
				}
				if (v_shadow.visible) {
					v_shadow.x = x;
					v_shadow.y = y;
				} else {
					h_shadow.x = x;
					h_shadow.y = y;
				}
				
			} else if (ctr_charge == 4) { //Check the graphic against tilemap to avoid weird graphics steppingoutside the bounds
				solid = true;
				
				if (v_shadow.visible) {
					v_shadow.x = x;
					v_shadow.y = y;
				} else {
					h_shadow.x = x;
					h_shadow.y = y;
				}
				FlxG.collide(this, parent.curMapBuf);
				if (parabola_thing.tick() || (touching != NONE && offset.y > 4)) {
					offset.y = 0;
					parabola_thing.reset_time();
					h_shadow.visible = v_shadow.visible =  false;
					hitbox.velocity.x = hitbox.velocity.y = 0;
					ctr_charge = 0;
					if (_curAnim.name == "pounce_l") {
						play("walk_l");
					} else if (_curAnim.name == "pounce_r") {
						play("walk_r");
					} else if (_curAnim.name == "pounce_d") {
						play("walk_d");
					} else {
						play("walk_u");
						
					}
					state = state_pace;
				}
				solid = false;
			}
		}
		
		/* Get dy/dx and the slope to figure out which way to face */
		private function face_player():void {
			var midpoint:FlxPoint = getMidpoint();
			var dy:Number = midpoint.y - player.midpoint.y;
			var dx:Number = midpoint.x - player.midpoint.x;
			var eps:Number = 0.0001;
			(Math.abs(dx) < eps) ? (dx < 0 ? dx = -0.1 : dx = 0.1) : 1;
			var m:Number = Math.abs(dy / dx);
			if (m > 1) {
				if (dy > 0) {
					if (state == state_shoot) {
						play("shoot_u");
					} else {
						play("walk_u")
					}
				} else {
					if (state == state_shoot) {
						play("shoot_d");
					} else {
					play ("walk_d");
					}
				}
					
			} else {
				if (dx > 0) {
					if (state == state_shoot) {
						play("shoot_l");
					} else {
					play("walk_l");
					}
				} else {
					if (state == state_shoot) {
						play("shoot_r");
					} else {
					play("walk_r");
					}
				}
			}
		}
		
		override public function destroy():void 
		{
			fireballs = null;
			h_shadow = null;
			hori_hitbox = null;
			hitbox = null;
			v_shadow = null;
			vert_hitbox = null;
			
			super.destroy();
		}
	}

}