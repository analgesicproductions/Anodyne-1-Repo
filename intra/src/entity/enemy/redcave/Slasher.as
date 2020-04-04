package entity.enemy.redcave 
{
	import data.CLASS_ID;
	import global.Registry;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import entity.player.Player;
	import org.flixel.FlxU;
	import states.PlayState;
	
	public class Slasher extends FlxSprite 
	{
		[Embed (source = "../../../res/sprites/enemies/redcave/f_slasher.png")] public static var slasher_sprite:Class;
		/* A little confusign: */
		/* wide has down-facing Wide attack, right-facing long attack */
		[Embed (source = "../../../res/sprites/enemies/redcave/f_slasher_wide.png")] public static var wide_atk_sprite:Class;
		/* long has right-facing wide attack, up-facing long attack */
		[Embed (source = "../../../res/sprites/enemies/redcave/f_slasher_long.png")] public static var long_atk_sprite:Class;
		public var harmful_wide_atk_frames:Array = new Array(0, 1, 2);
		public var harmful_long_atk_frames:Array = new Array(3, 4, 5);
		
		
		public var cid:int = CLASS_ID.SLASHER;
		public var xml:XML;
		
		public var long_sprite:FlxSprite = new FlxSprite();
		public var wide_sprite:FlxSprite = new FlxSprite();
		
		public var SPRITE_WIDTH:int = 16;
		public var state:int = 0;
		public var S_MOVE:int  = 0;
		public var move_timer_max:Number = 1.4;
		public var move_timer:Number = 0;
		private var initial_latency:Number = 1.4;
		
		public var S_ATK_LONG:int  = 1;
		public var LONG_ATK_TIMEOUT_MAX:Number = 0.8;
		public var LONG_ATK_TIMEOUT:Number = LONG_ATK_TIMEOUT_MAX;
		public var S_ATK_WIDE:int  = 2;
		public var S_ATK_WIDE_DELAY:int = 3;
		public var WIDE_ATK_DISTANCE:int = 36;
		public var WIDE_ATK_DELAY_MAX:Number = 0.3;
		public var WIDE_ATK_DELAY:Number = WIDE_ATK_DELAY_MAX;
		public var WIDE_ATK_TIMER_MAX:Number = 0.4;
		public var WIDE_ATK_TIMER:Number = WIDE_ATK_TIMER_MAX;
		public var INCREMENTED_REG:Boolean = false;
		
		public var t_warning:Number = 0;
		public var tm_warning:Number = 0.5;
		public var played_warning:Boolean = false;
		
		public var activate_attack_frame:int = 0;
		public var started_attack_anim:Boolean = false;
		
		
		
		
		public var player:Player;
		public var parent:PlayState;
		
		
		public function Slasher(_xml:XML, _parent:PlayState, _player:Player) 
		{
				
			// anims:
			// walk urdl 
			super(parseInt(_xml.@x), parseInt(_xml.@y));
			xml = _xml;
			player = _player;
			parent = _parent;
			
			/** Note to Marina:
			 * All scalings are taken care of for the attack, the default facings of the attacks that
			 * i've programmed for are commented below */
			/* Add attack animations */
			long_sprite.loadGraphic(long_atk_sprite, true, false, 16, 48);
			long_sprite.addAnimation("tall", [3, 4, 5, 6], 12, false); //Faces up, from the long sprite sheet
			long_sprite.addAnimation("wide", [3, 4, 5, 6], 12, false); // Faces right, from the wide spritesheet
			long_sprite.play("tall");
			
			// 10 x 36
			
			wide_sprite.loadGraphic(wide_atk_sprite, true, false, 48, 16);
			wide_sprite.addAnimation("tall", [0, 1, 2, 6], 12, false);  // Faces right, from the long spritesheet
			wide_sprite.addAnimation("wide", [0, 1, 2, 6], 12, false); //faces down, from the wide spritesheet
			wide_sprite.play("wide");
			
			parent.otherObjects.push(long_sprite);
			parent.otherObjects.push(wide_sprite);
			
			health = 3;
			
			/* Add slasher's animations */
			/* Spritesheet horizontal facing is RIGHT */
			loadGraphic(slasher_sprite, true, false, 24, 24);
			addAnimation("float_d", [0, 1], 3);
			addAnimation("float_l", [2, 3], 3);
			addAnimation("float_r", [2, 3], 3);
			addAnimation("float_u", [4, 5], 3);
			addAnimation("warning_d", [6,6], 10,false); //Duplicate the last frame
			addAnimation("warning_l", [7,7], 10,false);
			addAnimation("warning_r", [7,7], 10,false);
			addAnimation("warning_u", [8,8], 10,false);
			addAnimation("attack_d", [9,9], 10,false);
			addAnimation("attack_l", [10,10], 10,false);
			addAnimation("attack_r", [10,10], 10,false);
			addAnimation("attack_u", [11,11], 10, false);
			addAnimation("die", [9, 10, 11,11], 3, false);
			play("float_d");
			addAnimationCallback(on_anim_change);
			width = height = 16;
			centerOffsets(true);
			
			
			if (xml.@alive == "false") {
				Registry.GRID_ENEMIES_DEAD++;
				exists = false;
			}
			
			add_sfx("attack", Registry.sound_data.slasher_atk);
		
		}
		
		override public function preUpdate():void 
		{
			FlxG.collide(this, parent.curMapBuf);
			super.preUpdate();
		}
		
		override public function update():void 
		{
			
			if (touching != NONE) {
				velocity.x = velocity.y = 0;
			}
			if (initial_latency > 0) {
				initial_latency -= FlxG.elapsed;
				return;
			}
			if (Registry.is_playstate) {
				if (parent.state != parent.S_TRANSITION) {
					EventScripts.prevent_leaving_map(parent, this);
				}
			}
			/* Chceck if dead */
			if (xml.@alive == "false") {
				// When the death anim finishes, blow up
				//if (_curAnim.frames.length - 1 == _curFrame) {
				/* Always immediately blow up unless we do make a death anim*/
				if (1) {
					visible = false;
					if (!INCREMENTED_REG) {
						EventScripts.drop_big_health(x, y, 1);
						INCREMENTED_REG = true;
						Registry.GRID_ENEMIES_DEAD++;
						EventScripts.make_explosion_and_sound(this);
					}
					wide_sprite.visible = long_sprite.visible = false;
				}
				return;
			}
			if (state == S_MOVE) {
				movement();
			} else {
				if (!started_attack_anim) {
					started_attack_anim = true;
					switch (_curAnim.name) {
						case "warning_r": 
							play("attack_r");
							break;
						case "warning_l": 
							play("attack_l");
							break;
						case "warning_d": 
							play("attack_d");
							break;
						case "warning_u": 
							play("attack_u");
							break;
					}
				/* Some frame in the attack animation trigger sthe appearance of the slash attack */
				} else if (_curFrame >= activate_attack_frame) {
					velocity.x = velocity.y = 0;
					attack(); //Decrement the attack timers until state change
				}
			}
			collisions();
			check_for_death();
			super.update();
		}
		
		private function check_for_death():void {
			if (health <= 0) {
				xml.@alive = "false";
				play("die");
			}
		}
		public function on_anim_change(name:String, frame:int, index:int):void {
			if (name == "float_r" || name == "warning_r" || name == "attack_r") {
				scale.x = -1; 
			} else {
				scale.x = 1;
			}
		}
		
		private var t_move:Number = 0;
		public function movement():void { 
			t_move += FlxG.elapsed;
			if (t_move > 0.25) {
				t_move = 0;
				EventScripts.scale_vector(this, player, velocity, 20);
			}
			//EventScripts.send_property_to(this, "x", player.x + 8, 0.3);
			//EventScripts.send_property_to(this, "y", player.y + 8, 0.3);
			var dx:int = (player.x + 8) - (x + SPRITE_WIDTH/2);
			var dy:int = (player.y + 8) - (y + SPRITE_WIDTH / 2);
			
			if (!played_warning) {
				facing = EventScripts.get_entity_to_entity_dir(x + SPRITE_WIDTH / 2, y + SPRITE_WIDTH / 2, player.x + 8, player.y + 8);
				switch (facing) {
					case UP:
						play("float_u");
						break;
					case RIGHT:
						play("float_r");
						break;
					case LEFT:
						play("float_l"); 
						break;
					case DOWN:
						play("float_d");
						break;
				}
			}
			
			move_timer -= FlxG.elapsed;
			if (move_timer < 0) {
				if (!played_warning) {
					switch (_curAnim.name) {
						case "float_r":
							play("warning_r");
							break;
						case "float_d":
							play("warning_d");
							break;
						case "float_u":
							play("warning_u");
							break;
						case "float_l":
							play("warning_l");
							break;
					}
					played_warning = true;
				}
				t_warning += FlxG.elapsed;
				if (t_warning > tm_warning) {
					played_warning = false;
					t_warning = 0;
					move_timer = move_timer_max;
					if (Math.sqrt(dx * dx + dy * dy) < WIDE_ATK_DISTANCE) {
						state = S_ATK_WIDE;
						play_sfx("attack");
						update_wide_pos();
					//sfx
					//anim
					} else {
						play_sfx("attack");
						state = S_ATK_LONG;
						update_long_pos();
					}
				}
				
			}
		}
		
		public function update_long_pos():void {
			
			long_sprite.visible = true;
			long_sprite.scale.x = 1;
			long_sprite.scale.y = 1;
			/* Determine position of long attack */
			
			
			if (facing & (UP | DOWN)) {
				long_sprite.loadGraphic(long_atk_sprite, true, false, 16, 48);
				
				
				long_sprite.x = x + (SPRITE_WIDTH / 2) - long_sprite.width / 2;
				long_sprite.play("tall");
				
				
					long_sprite.width = 10; long_sprite.height = 36;
					long_sprite.offset.x = 3; long_sprite.x += 3;
				if (facing & UP) { // UP
					long_sprite.y = y - 48; //sorry
					long_sprite.offset.y = 12;
					long_sprite.y += 12;
				} else {
					long_sprite.scale.y = -1; // DOWN
					long_sprite.y = y + SPRITE_WIDTH ;
				}
			} else {
				long_sprite.loadGraphic(wide_atk_sprite, true, false, 48, 16);
				long_sprite.y = y + SPRITE_WIDTH / 2 - long_sprite.height / 2;
				long_sprite.play("wide");
				
				long_sprite.width = 36; long_sprite.height = 10;
				long_sprite.y += 3; long_sprite.offset.y = 3;
				
				if (facing & LEFT) { //LEFT
					
					long_sprite.scale.x = -1;
					long_sprite.x = x - 48; //so sorry
					
					long_sprite.offset.x = 12;
					long_sprite.x += 12;
				} else {
					long_sprite.x = x + SPRITE_WIDTH; //RIGHT
				}
			}
		}
		
		public function update_wide_pos():void {
			wide_sprite.visible = true;
			wide_sprite.angle = 0;
			wide_sprite.scale.x = wide_sprite.scale.y = 1;
			if (facing & (UP | DOWN)) {
				wide_sprite.loadGraphic(wide_atk_sprite, true, false, 48, 16);
				wide_sprite.x = x + SPRITE_WIDTH / 2 - wide_sprite.width / 2;
				wide_sprite.play("wide");
				
				wide_sprite.height = 10;
				wide_sprite.width = 36;
				wide_sprite.offset.x = 6;
				wide_sprite.x += 6;
				//36x10
				if (facing & UP) {			// up
					wide_sprite.angle = 180;
					wide_sprite.y = y - 10;
					
					wide_sprite.offset.y = 6;
					wide_sprite.y += 6;
					
				} else {//down
					
					wide_sprite.y = y + 10;
				}
			} else {
				wide_sprite.loadGraphic(long_atk_sprite, true, false, 16, 48);
				wide_sprite.y = y + SPRITE_WIDTH / 2 - wide_sprite.height / 2;
				wide_sprite.play("tall");
				
				wide_sprite.height = 36;
				wide_sprite.offset.y = 6;
				wide_sprite.y += 6;
				
				wide_sprite.width = 10;
				if (facing & RIGHT) { //r right
					wide_sprite.x = x + SPRITE_WIDTH;
				} else { // left
					wide_sprite.scale.x = -1;
					wide_sprite.x = x - wide_sprite.width;
					
					wide_sprite.offset.x = 6;
					wide_sprite.x += 6;
				}
			}
			
			//if (Math.sqrt(dx * dx + dy * dy) > WIDE_ATK_DISTANCE + 3) { //can get a good attack range here
			//	state = S_MOVE;
				//wide_sprite.visible = false;
				//anim of enemy
			
			
		}
		private function collisions():void {
			
			if (long_sprite.visible) {
				if (harmful_long_atk_frames.indexOf(long_sprite._curIndex) != -1) {
					if (long_sprite.overlaps(player)) player.touchDamage(1);
				}
			}
			if (wide_sprite.visible) {
				if (harmful_wide_atk_frames.indexOf(wide_sprite._curIndex) != -1) {
					if (wide_sprite.overlaps(player) && player.state == player.S_GROUND) player.touchDamage(1);
				}
			}
			/*if (player.overlaps(this)) {
				player.touchDamage(1);
			}*/
			if (player.broom.visible) {
				if (player.broom.overlaps(this)) {
					if (!flickering) {
						flicker(1);
						health--;
						play_sfx(HURT_SOUND_NAME);
						
					}
				}
			}
		}
		
		/* update timers - long transitions back to move, wide can continue
		 * to transition to wide */
		public function attack():void {
			if (state == S_ATK_LONG) {
				LONG_ATK_TIMEOUT -= FlxG.elapsed;
				if (LONG_ATK_TIMEOUT < 0) {
					state = S_MOVE;
					started_attack_anim = false;
					LONG_ATK_TIMEOUT = LONG_ATK_TIMEOUT_MAX;
					long_sprite.visible = false;
					return;
				}
			} else {
				/** This is a huge mess, the logic has been commented
				 * to act like the long attack, so it piggy backs on the
				 * code that does warning and attack */
				if (state == S_ATK_WIDE_DELAY) {
					WIDE_ATK_DELAY -= FlxG.elapsed;
					if (WIDE_ATK_DELAY < 0) {
						WIDE_ATK_DELAY = WIDE_ATK_DELAY_MAX;
				//		state = S_ATK_WIDE;
						state = S_MOVE;
						started_attack_anim = false;
						wide_sprite.visible = false;
						move_timer = move_timer_max / 2;
						//wide_sprite.visible = true;
						//update_wide_pos();
						//sfx
						//anim
					}
				} else {
					
					WIDE_ATK_TIMER -= FlxG.elapsed;
					if (WIDE_ATK_TIMER < 0) {
						WIDE_ATK_TIMER = WIDE_ATK_TIMER_MAX;
						state = S_ATK_WIDE_DELAY;
						wide_sprite.visible = false;
						return;
					}
					
				}
			}
		}
		
	}

}
