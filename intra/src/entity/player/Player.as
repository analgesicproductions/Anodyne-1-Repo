package entity.player 
{
	import data.CLASS_ID;
	import data.TileData;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import helper.Achievements;
	import helper.EventScripts;
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxObject;
	import flash.geom.Point;
	import org.flixel.FlxG;
	import global.Keys;
	import global.Registry;
	import org.flixel.FlxTilemap;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	import org.flixel.system.FlxTile;
	import states.PlayState;
	import entity.gadget.*;
	import entity.decoration.*;
	

	public class Player extends FlxSprite
	{
		[Embed(source = "../../res/sprites/young_player.png")] public static var Player_Sprite:Class;
		[Embed(source = "../../res/sprites/young_player_cell.png")] public static const Cell_Player_Sprite:Class;
		[Embed(source = "../../res/sprites/player_mobile_indicator.png")] public static const Player_Mobile_Indicator_Sprite:Class;
		
		
		[Embed(source = "../../res/sprites/young_player_reflection.png")] public static var Player_reflection_Sprite:Class;
		[Embed(source = "../../res/sprites/broom_reflection.png")] public static var broom_reflection_sprite:Class;
		
		private var keyWatch:Keys;
		private var parent:*;
		public var cid:int = CLASS_ID.PLAYER;
		/* animation constants */
		private var ORIGINAL_WIDTH:int = 16;
		private var ORIGINAL_HEIGHT:int = 16;
		public var DEFAULT_Y_OFFSET:int = 4;
		private var HITBOX_HEIGHT:int = 12;
		private var HITBOX_WIDTH:int = 10;
		public var TRANSITION_IDLE:String = "idle_u";
		
		/* properties associated with moving about the grid*/
		public var gridX:int = 0; //Where on the current grid we are.
		public var gridY:int = 0;
		public var grid_entrance_x:int;
		public var grid_entrance_y:int;
		public var UL_Sentinel:FlxSprite = new FlxSprite();
		public var LR_Sentinel:FlxSprite = new FlxSprite();
		public var midpoint:Point = new Point(0, 0);
		public var hasnt_stepped_off_the_door_yet:Boolean = true;
		
		public var force_position_ticks:int; //i dont know what this is
		
		/* movement constants */
		
		private var walkSpeed:int = 70;
		/**
		 * A base multiplier for the base walkspeed, pre-effects.
		 */
		public var c_vel:Number = 1.0;
		/**
		 * A multiplier for walk-speed, post-effects.
		 */
		public var slow_mul:Number = 1.0;
		public var slow_ticks:int = 0;
		public var additional_x_vel:int = 0;
		public var additional_y_vel:int = 0;
		
		/* some misc movement state vars */
		public var sig_reverse:Boolean = false;
		private var reversed:Boolean = false;
		private var t_reverse:Number = 0;
		private var tm_reverse:Number = 0.9;
		
		public var dontMove:Boolean = false;
		

		/* General 'where the fuck are we' state */
		public var state:int = 0;
		public var S_GROUND:int = 0;
		public var S_AIR:int = 1;
		public var S_RAFT:int = 2;
		public var S_AUTO_JUMP:int = 3;
		public var S_INTERACT:int = 4;
		public var S_ENTER_FALL:int = 5;
		public var S_LADDER:int = 6;
		
		
		
		/* State for raft or on conveyer blah blah */
		public var ON_CONVEYER:uint = NONE;
		private var CONVEYER_VEL:uint = 35;
		private var sink_timer_max:Number = 3/16;
		private var sink_timer:Number = sink_timer_max;
		public var IS_SINKING:Boolean = false;
		public var ON_RAFT:Boolean = false;
		public var raft:Dust;
		public var conveyer_fudge_factor:int = 0; // <_<
		
		/* State for jumping */
		private var jump_period:Number = 0.4*1.15; //length of jump
		private var jump_timer:Number = 0;
		private var JUMP_SHADOW_X_OFF:int = 0;
		private var  JUMP_SHADOW_Y_OFF:int = 8;
		public var just_landed:Boolean =  false;
		private var just_landed_timer:int = 0;
		private var prevent_jump_repeat:Boolean = false;
		private var anim_air_did_up:Boolean = false;
		private var anim_air_did_down:Boolean = false;
		public var no_jump_ticks:int = 0;
		public var s_interact_shadow_visibility_override:Boolean = false;
		
		/* State for autojump */
		public var auto_jump_period:Number = 0;
		public var auto_jump_timer:Number = auto_jump_period;
		public var auto_jump_distance:int = 0;
		public var auto_jump_base_y:int = 0;
		public var AUTO_JUMP_HEIGHT:int = 22;
		public var is_spring_jump:Boolean = false;
		
		/* Stuff associated with getting hit */
		public var SMALL_BUMP_VEL:int = 50;
		public var bump_vel_x:int;
		public var bump_vel_y:int;
		public var do_bump:Boolean = false;
		public var BUMP_TIMER_MAX:Number = 0.2;
		public var bump_timer:Number =  0.2;
		public var zap_timer:Number = 0.1;
		public var ZAP_TIMER_MAX:Number = 0.05;
		
        /* State for falling into hole */
        public var isFalling:Boolean = false; //Slipping
        public var hasFallen:Boolean = false; //
		public var just_fell:Boolean = false;
		public var FALL_TIMER_DEFAULT:Number = 0.016*8 + 0.001;
        public var fallTimer:Number = FALL_TIMER_DEFAULT;
        public var lastGoodPt:Point = new Point();
		public var fall_pt:Point = new Point();
		public var falling_disabled:Boolean = false; // Propelled sets this
		
		/* Dashing */
		private var dashing:Boolean = false;
		public var SIG_DASH:Boolean = false;
		public var SIG_DASH_TYPE:uint = 0x0;
		private var dash_flags:uint = 0x0;
		private var dash_h_state:int = 0;
		private var dash_v_state:int = 0;
        
		/* State for treasure open */
		public var opening_treasure:Boolean = false;
		/* Itmes */
        public var broom:Broom;
		public var health_bar:HealthBar; 
		public var transformer:Transformer;
		
		/* Invincibility */
		public var invincible_timer:Number = 0;
		public var invincible:Boolean = false;
		public var INVINCIBLE_TIME:Number = 0.8;
        
		/* graphics associated with player */
		public var light:Light; 
		public var foot_overlay:Foot_Overlay;
		public var foot_overlay_bg_bg2:Foot_Overlay;
		public var reflection:FlxSprite;
		public var reflection_broom:FlxSprite;
		public var mobile_current:FlxSprite;
		/* Animation state */
		public var ANIM_STATE:int = 0;
		public var ANIM_DEFAULT:int = 0;
		public var ANIM_ATK_R:int = 1;		
		public var ANIM_ATK_L:int = 2;
		public var ANIM_ATK_U:int = 3;
		public var ANIM_ATK_D:int = 4;
		public var ANIM_FALL:int = 5;
		public var ANIM_DEAD:int = 6;
		private var as_idle:int = 7;
		private var idle_ticks:int = 0;
		private var as_walk:int = 8;
		private var as_slumped:int = 9;
		private var last_frame:Object = { walk_l: 0, walk_r: 0, walk_u: 0, walk_d: 0 };
		public var DEATH_FRAME:int;
		
		public var action_latency_max:Number = 0.24;
		public var action_latency:Number = 0.24;
		public static var ATK_DELAY:Number = 0.2;
		public static var WATK_DELAY:Number = 0.35;
		public static var LATK_DELAY:Number = 0.4;
		
		public  var actions_disabled:Boolean = false;
		
		public var step_noise_timer_max:Number = 0.5;
		public var step_noise_timer:Number = step_noise_timer_max;
		
		public var start_in_slump:Boolean = false;
		
		public function reset_anodyne():void {
			hasnt_stepped_off_the_door_yet = true;
			reflection.exists = false;
			reflection_broom.exists = false;
			if (Registry.CURRENT_MAP_NAME == "WINDMILL" || Registry.CURRENT_MAP_NAME == "DEBUG") {
				reflection.exists = true;
				reflection_broom.exists = true;
			}
		
			if (Registry.CURRENT_MAP_NAME == "TRAIN") {
				loadGraphic(Cell_Player_Sprite, true, false, 16, 16);
			} else {
				loadGraphic(Player_Sprite, true, false, 16, 16);
			}
			
            height = HITBOX_HEIGHT;
            width = HITBOX_WIDTH; 
			
			sig_reverse = false;
			if (reversed) {
				reverse_controls();
			}
			reversed = false;
			t_reverse = 0;
			alive = true;
			
			state = S_GROUND;
			offset.y = DEFAULT_Y_OFFSET;
			alpha = 1;
			scrollFactor.x = scrollFactor.y = 1;
			
			
			ANIM_STATE = as_idle;
			play(TRANSITION_IDLE);
			
			if (start_in_slump == true) {
				start_in_slump = false;
				ANIM_STATE = as_slumped;
				play("slumped");
			}
			
			if (Registry.CURRENT_MAP_NAME == "DRAWER" || Registry.E_NEXT_MAP_TURN_ON_LIGHT == true || Registry.CURRENT_MAP_NAME == "BEDROOM") {
				light.exists = true;
				light.visible = true;
				Registry.E_NEXT_MAP_TURN_ON_LIGHT = false;
				if (Registry.CURRENT_MAP_NAME == "BEDROOM") {
					light.setlighttype(Light.T_BEDROOM_BOUNCE);
					light.followee = this;
				} else {
					light.followee = this;
					light.scrollFactor.x = light.scrollFactor.y = 1;
					light.special_type = Light.L_PLAYER;
					light.setlighttype(Light.T_GLOW_LIGHT);
				}
			} else {
				light.visible = false;
				light.exists = false;
			}
			
			
			if (Registry.E_Enter_Fall_Down) {
				Registry.E_Enter_Fall_Down = false;
				Registry.sound_data.fall1.play();
				state = S_ENTER_FALL;
				offset.y = 150;
				dontMove = true;
			}
		}
		
		public function Player(_x:int,_y:int,_keyWatch:Keys,darkness:FlxSprite,_parent:*=null) 
		
        {
            
			super(_x, _y + DEFAULT_Y_OFFSET);
            parent = _parent;
			
			// Init reflection thiniges
			reflection = new FlxSprite();
			reflection.loadGraphic(Player_reflection_Sprite, true, false, 16, 16);
			reflection.exists = false;
			reflection_broom = new FlxSprite();
			reflection_broom.loadGraphic(broom_reflection_sprite, true, false, 16, 16);
			reflection_broom.exists = false;
			
			mobile_current = new FlxSprite();
			mobile_current.loadGraphic(Player_Mobile_Indicator_Sprite, true, false, 5, 5);
			mobile_current.alpha = 0.8;
			if (Intra.is_mobile == false) {
				mobile_current.exists = false;
			}
			
			
			raft = new Dust(0, 0, null, parent);
			raft.exists = false;
			keyWatch = _keyWatch;
            loadGraphic(Player_Sprite, true, false, 16, 16);
			/* add anims */
            addAnimation("walk_d", [1, 0], 6, true);
            addAnimation("walk_r", [2, 3], 8, true);
            addAnimation("walk_u", [4, 5], 6, true);
			addAnimation("walk_l", [6, 7], 8, true);
			
			addAnimation("attack_down", [8, 9], 10, false);
			addAnimation("attack_right", [10, 11], 10, false);
			addAnimation("attack_up", [12, 13], 10, false);
			addAnimation("attack_left", [14, 15], 10, false);
			addAnimation("fall", [28, 29, 30, 31], 5, false);
			addAnimation("die", [25, 26, 27, 24, 25, 26, 27, 24, 25, 26, 27, 32], 6, false);
			addAnimation("slumped", [32]);
			DEATH_FRAME = 32;
			addAnimation("whirl", [25, 26, 27, 24], 12, true);
			
			addAnimation("idle_d", [24], 4, true);
			addAnimation("idle_r", [25], 4, true);
			addAnimation("idle_u", [26], 4, true);
			addAnimation("idle_l", [27], 4, true);
			
			addAnimation("jump_d", [16, 17], 4, true);
			addAnimation("jump_r", [18, 19], 4, true);
			addAnimation("jump_u", [20, 21], 4, true);
			addAnimation("jump_l", [22, 23], 4, true);
			addAnimation("idle_climb", [33]);
			addAnimation("climb", [34, 35], 8, true);
			
			addAnimationCallback(on_anim_change);
			
            height = HITBOX_HEIGHT; offset.y = DEFAULT_Y_OFFSET;
            width = HITBOX_WIDTH; 
			
			play("idle_u");
			ANIM_STATE = as_idle;
			
			/* add sfx */
			add_sfx("jump_down", Registry.sound_data.player_jump_down);
			add_sfx("jump_up", Registry.sound_data.player_jump_up);
			add_sfx("dash_1", Registry.sound_data.dash_pad_1);
			add_sfx("dash_2", Registry.sound_data.dash_pad_2);
			
			update_sentinels();
			UL_Sentinel.makeGraphic(1, 1, 0xffffffff);
			LR_Sentinel.makeGraphic(1, 1, 0xffffffff);
            UL_Sentinel.visible = LR_Sentinel.visible = false;

            lastGoodPt.x = x; lastGoodPt.y = y;
          
			/* Init items */
            broom = new Broom(this, x, y);
			broom.visible = false;
			
			transformer = new Transformer(this, parent);
			
			health_bar = new HealthBar(155, 2, Registry.MAX_HEALTH);
			health_bar.modify_health( -1 * (Registry.MAX_HEALTH - Registry.CUR_HEALTH));
			/* Add light */
			if (Registry.CURRENT_MAP_NAME == "BEDROOM") {
				light = new Light(0, 0, darkness, Light.T_BEDROOM_BOUNCE, false, this, 0, Light.L_BEDROOM_BOUNCE);
				if (Registry.GE_States[Registry.GE_Bedroom_Boss_Dead_Idx]) {
					light.visible = false;
				}
			} else {
				light = new Light(0, 0, darkness, Light.T_GLOW_LIGHT, true, this, 6, Light.L_PLAYER);
				light.exists = false;
				if (Registry.CURRENT_MAP_NAME == "STREET") {
					light.exists = true;
				}
			}
			
			my_shadow = EventScripts.make_shadow("8_small",false,20);
			
			foot_overlay = new Foot_Overlay(this);
			foot_overlay_bg_bg2 = new Foot_Overlay(this);
			
		}
		override public function postUpdate():void 
		{
			super.postUpdate();
			Registry.PLAYER_X = x - 160 * Registry.CURRENT_GRID_X + 3;
			Registry.PLAYER_Y = y - 20 - 160 * Registry.CURRENT_GRID_Y + 4;
		}
		
		public static var Player_mobile_timer:Number = 0;
		public static var Player_mobile_angle:Number = 0;
		override public function update():void {
			
			if (Intra.is_mobile) {
				if (Player_mobile_timer > 0) {
					mobile_current.alpha = 0.9;
					Player_mobile_timer -= FlxG.elapsed;
					mobile_current.x = (x + 8 - 2) - offset.x + (12 * Math.cos(Player_mobile_angle));
					mobile_current.y = (y + 8 - 2) - offset.y - (12 * Math.sin(Player_mobile_angle));
				} else {
					mobile_current.alpha = 0;
				}
			}
			if (Registry.FUCK_IT_MODE_ON) {
				solid = false;
				walkSpeed = 200;
				//walkSpeed = 60;
				
				if (FlxG.keys.justPressed("V")) {
					visible = !visible;
				}
			} else {
				walkSpeed = 70;
				solid = true;
			}
			
			if (sig_reverse) {
				sig_reverse = false;
				if (!reversed) {
					Registry.GFX_WAVE_EFFECT_ON = true;
					reverse_controls();
				}
				reversed = true;
			} else if (reversed) {
				t_reverse += FlxG.elapsed;
				if (t_reverse > tm_reverse) {
					t_reverse = 0;
					reversed = false;
					Registry.GFX_WAVE_EFFECT_ON = false;
					reverse_controls();
				}
			}
			
			
			midpoint.x = (x + width / 2);
			midpoint.y  = (y + height / 2);
			
			
			// Reflection logic.
			// In a map with reflections, if the ***BG*** layer
			// has a certain tile type, then the reflection (drawn between BG and BG2) 
			// should appear and mirror the player's animations 
			if (reflection.exists) {
				var tile_type:int = parent.map.getTile(midpoint.x / 16, (midpoint.y - Registry.HEADER_HEIGHT) / 16);
				reflection.visible = false;
				reflection_broom.visible = false;
				switch (Registry.CURRENT_MAP_NAME) {
					case "DEBUG":
						if (tile_type ==  47) {
							reflection.visible = true;
							reflection_broom.visible = broom.visible;
							reflection_broom.angle = broom.angle;
						}
						break;
					case "WINDMILL":
						if (tile_type == 130) {
							reflection.visible = true;
							reflection_broom.visible = broom.visible;
							reflection_broom.angle = broom.angle;
						}
						break;
				}
				
				reflection_broom.frame = broom.frame;
				
	
				reflection_broom.x = broom.x;
				reflection_broom.y = broom.y + 10;
				if (facing == LEFT) {
					reflection.x = x - 4;
				} else {
					reflection.x = x - 3;
				}
				reflection.y = y + 10;
				reflection.frame = frame;
				reflection.offset.y = -(offset.y - DEFAULT_Y_OFFSET);
			}
			
			
			if (!common_conditions()) {
				return;			
			}
			

			switch (state) {
			case S_GROUND:
				my_shadow.visible = false;
				if (dontMove) {
					velocity.x = 0; velocity.y = 0; 
				}  else {
					ground_movement();  //modify player vels
				}
				
				falling_logic();
				
				
				update_sentinels();
				
				for each (var t:* in Registry.subgroup_interactives) {
					if (t != null) {
						if (t.active_region != null && t.active_region.overlaps(this)) {
							actions_disabled = true;
							break; // As soon as this is true we can stop checking
						} 
					} 
				} 
				if (!hasFallen && !actions_disabled) {
					if (action_latency > 0) {
						action_latency -= FlxG.elapsed;
					} 
					update_actions(Registry.keywatch.ACTION_1,Registry.keywatch.JP_ACTION_1,Registry.bound_item_1);
					update_actions(Registry.keywatch.ACTION_2, Registry.keywatch.JP_ACTION_2, Registry.bound_item_2);
				}
				ground_animation();
				if (just_landed) just_landed = false;
				dash_logic();
				
				break;
			case S_AIR:
				if (dontMove) {
					velocity.x = velocity.y = 0;
				} else {
					air_movement();
					air_animation(); 
				}
				dash_logic();
				
				break;
			case S_AUTO_JUMP:
				solid = false;
				my_shadow.visible = true;
				auto_jump_animation();
				break;
			case S_INTERACT:
				velocity.x = velocity.y = 0;
				if (s_interact_shadow_visibility_override) {
					my_shadow.visible = true;
				} else {
					my_shadow.visible = false;
				}
				/* Don't do anything until whatever put you in
				 * this state takes you out. */
				break;
			case S_ENTER_FALL:
				velocity.x = velocity.y = 0;
				angularVelocity  = 400;
				frame = 2;
				if (EventScripts.send_property_to(this.offset, "y", 0, 1.7)) {
					dontMove = false;
					if (!(Registry.CURRENT_MAP_NAME == "CROWD" && Registry.CURRENT_GRID_X == 3 && Registry.CURRENT_GRID_Y == 4)) { //wHAT YOU GONNA DO PUNK
						angle = 0;
						play("slumped");
						ANIM_STATE = as_slumped;
						FlxG.shake(0.05, 0.4);
						Registry.sound_data.hitground1.play();
						angularVelocity = 0;
					}
					state = S_GROUND;
				}
				break;
			case S_LADDER: 
				ladder_logic();
				
				
				break;
			}
			
			//Reset callback settings
			ON_CONVEYER = NONE;
			if (slow_ticks > 0) {
				slow_ticks--;
			} else {
				slow_mul = 1;
			}
			IS_SINKING = false;
			falling_disabled = false;
			actions_disabled = false;
			
			additional_x_vel = 0;
			additional_y_vel = 0;
			
			if (no_jump_ticks > 0) {
				no_jump_ticks--;
			}
			
			
			super.update();
		}
		
        /* Falling logic */
        public function falling_logic():void {
            /* If you fall reset position to last known safe position */
            if (hasFallen) {
                fallTimer -= FlxG.elapsed;
				dontMove = true;
				x = fall_pt.x - 5;
				y = fall_pt.y + 2;
                if (fallTimer < -1.0 || frame == 31) {
					c_vel = 1.0;
                    fallTimer = FALL_TIMER_DEFAULT;
                    hasFallen = false;
                    x = grid_entrance_x;
					y = grid_entrance_y;
					flicker(1);
					play("idle_d");
					solid = false;
					just_fell = true;
					dontMove = false;
					ANIM_STATE = as_idle;
					//health_bar.modify_health( -1);
                }
				return;
            }
			if (falling_disabled) isFalling = false;
            if (!isFalling) {
            /* If not falling update last known safe position */
				c_vel = 1.0;
                lastGoodPt.x = x;
                lastGoodPt.y = y;
                fallTimer = FALL_TIMER_DEFAULT;
            } else {
            /* Player movement should change here */
				//some other sort of gradual falling??
				//c_vel = 0.5; 
                fallTimer -= FlxG.elapsed;
				if (just_landed) {
					fallTimer = -1;
					just_landed = false;
				}
				/* Fall after a time out, or instantly if dashing */
                if (fallTimer < 0 || (dashing && fallTimer < FALL_TIMER_DEFAULT / 2)) {     
					Registry.sound_data.fall_in_hole.play();
					ANIM_STATE = ANIM_FALL;
                    fallTimer = FALL_TIMER_DEFAULT;
                    hasFallen = true;
                }
				isFalling = false;
            }
        }
		/* Update the sentinels used for map movement. */
		public function update_sentinels():void {
			UL_Sentinel.x = x; UL_Sentinel.y = y;
			LR_Sentinel.x = x + ORIGINAL_WIDTH - 1; LR_Sentinel.y = y + ORIGINAL_HEIGHT - 1;
		}
		public function ground_movement():void {
			
			set_init_vel();
			
			if (velocity.x != 0 && velocity.y!= 0) {
				velocity.x *= .7;
				velocity.y *= .7;
			}
			
			
			if (ANIM_STATE != as_idle && ANIM_STATE != as_walk) {
				velocity.x = velocity.y = 0;
			}
			
			
			
			
			if (do_bump) {
				
				velocity.x = bump_vel_x;
				velocity.y = bump_vel_y;
				bump_timer -= FlxG.elapsed;
				if (bump_timer < 0) { 
					do_bump = false;
					bump_timer  = BUMP_TIMER_MAX; 
					velocity.x = velocity.y = 0;
				}
			} else if (zap_timer < ZAP_TIMER_MAX) {
				slow_mul = 0.5;
				var g:FlxGroup
				zap_timer += FlxG.elapsed;
			}
			
			/* This is pretty nasty. If we transition, and we were on a raft, then
			 * this variable is set to 7, so that we stay on the raft because of
			 * some small instance where we don't collide with the tilemap.
			 * This creates a new "raft" for the player as well. */
			if (conveyer_fudge_factor > 0) {
				conveyer_fudge_factor--;
				if (conveyer_fudge_factor == 1 && raft == null) {
					var _raft:Dust = new Dust(x, y, null,parent);
					_raft.ON_CONVEYER = true;
					parent.player_group.remove(raft, true);
					
					raft = _raft;
					parent.player_group.members.splice(0, 0, raft);
					parent.player_group.length++;
				} else if (conveyer_fudge_factor == 1) {
					
				}
				ON_RAFT = true;
				ON_CONVEYER = ANY;
			}
			
			
			/* Pin the raft to the player, and also increase
			 * the player's velocity accordingly. */
			if (ON_CONVEYER ) {  //set by the callback or the line above
				if (ON_RAFT) { //set raft to be under player. set in Dust collision
					raft.x = x - 2;
					raft.y = y - 2;
				}
				switch (ON_CONVEYER) {
					case UP:
						velocity.y -= CONVEYER_VEL; break;
					case DOWN:
						velocity.y += CONVEYER_VEL; break;
					case LEFT:
						velocity.x -= CONVEYER_VEL; break;
					case RIGHT:
						velocity.x += CONVEYER_VEL; break;
				}
				
				var tidx:int;
				var tile:FlxTile;
				
				if (framePixels_y_push > 0) {
						tidx = EventScripts.get_tile_nr(midpoint.x + 2, midpoint.y, parent.curMapBuf);
						tile = parent.curMapBuf._tileObjects[tidx];
						if (tile.allowCollisions == NONE && tile.callback == null) {
							framePixels_y_push = 0;
							ON_CONVEYER = NONE;
						}
						tidx = EventScripts.get_tile_nr(midpoint.x - 2, midpoint.y, parent.curMapBuf);
						tile = parent.curMapBuf._tileObjects[tidx];
						if (tile.allowCollisions == NONE && tile.callback == null) {
							framePixels_y_push = 0;
							ON_CONVEYER = NONE;
						}
						tidx = EventScripts.get_tile_nr(midpoint.x, midpoint.y + 5, parent.curMapBuf);
						tile = parent.curMapBuf._tileObjects[tidx];
						if (tile.allowCollisions == NONE && tile.callback == null) {
							framePixels_y_push = 0;
							ON_CONVEYER = NONE;
						}
				}
			} else if (parent.state != parent.S_TRANSITION)  {
				/* only reset the raft if we didn't fall off while on it */
				if ((velocity.x != 0 || velocity.y != 0) && raft != null && !isFalling && !hasFallen) {
					tidx = EventScripts.get_tile_nr(midpoint.x, midpoint.y, parent.curMapBuf);
					if (tidx > parent.curMapBuf._tileObjects.length) {
						tidx = 3;
					}
					if (parent.curMapBuf._tileObjects[tidx].callback == TileData.conveyer) {
						 
					} else {
						ON_RAFT = false;
						if (velocity.x > 0) raft.x -= 3;
						if (velocity.x < 0) raft.x += 3;
						if (velocity.y > 0) raft.y -= 3;
						if (velocity.y < 0) raft.y += 3;
						// Move the raft to the playstate's ownership
						parent.player_group.remove(raft, true);
						Registry.subgroup_dust.push(raft);
						parent.bg_sprites.add(raft);
						raft = null;	
					}
				}
			}
			step_noise_timer -= FlxG.elapsed;
			
			if (step_noise_timer < 0 && (velocity.x != 0 || velocity.y != 0)) {
				if (IS_SINKING && step_noise_timer < 0) {
					Registry.sound_data.play_sound_group(Registry.sound_data.water_step_group);
					step_noise_timer = step_noise_timer_max;
				} else if (!IS_SINKING && ON_CONVEYER & ANY) { // sound for walking in puddle
					Registry.sound_data.play_sound_group(Registry.sound_data.puddle_step);
					step_noise_timer = 0.25;
				} else if (foot_overlay.visible && Registry.CURRENT_MAP_NAME == "REDSEA") {
					Registry.sound_data.play_sound_group(Registry.sound_data.puddle_step,0.5);
					step_noise_timer = 0.25;
				}
			}
			velocity.x += additional_x_vel;
			velocity.y += additional_y_vel;
			
			velocity.x *= slow_mul;
			velocity.y *= slow_mul;
		}
		
		// For wheny ou die whilst on a raft, to prevent a "destroy"d raft
		// from being added to the game and blowing shit up
		public function unraftify_safely():void {
			parent.player_group.remove(raft, true);
			raft = null;
		}
        /* visual fx with jumping (shadow, offset interpolation) */
		public function air_animation():void {
			// Play sfx, set the animation, set the shadow, hide the broom.
			if (!anim_air_did_up) {
				broom.visible = false;
				anim_air_did_up = true;
				
				if (ON_CONVEYER) {
					Registry.sound_data.puddle_up.play();
				} else {
					play_sfx("jump_up");
				}
				
				my_shadow.play("get_small");
				ANIM_STATE = as_idle; // Always land in idle state.
				switch (facing) { // Play the jump animation
					case UP:
						play("jump_u");
						break;
					case DOWN:
						play("jump_d");
						break;
					case LEFT:
						play("jump_l");
						break;
					case RIGHT:
						play("jump_r");
						break;
				}
			}
			// Move the shadow iwth the player.
			my_shadow.x = x + JUMP_SHADOW_X_OFF + 1;
			my_shadow.y = y + JUMP_SHADOW_Y_OFF - 3;
			offset.y = DEFAULT_Y_OFFSET + int(( ((-4*24)/(jump_period*jump_period))* jump_timer * (jump_timer - jump_period)));
			jump_timer += FlxG.elapsed;
		
			
			
			// On the way down, change the shadow animation
			if (!anim_air_did_down && jump_timer > jump_period / 2) {
				my_shadow.play("get_big");
				anim_air_did_down = true;
			}
			
			// sfx for landing, change state, set some state flags, fix the offset
			if (jump_timer > jump_period) {
				jump_timer = 0;
				if (ON_CONVEYER) {
					Registry.sound_data.puddle_down.play();
				} else {
					play_sfx("jump_down");
				}
				state = S_GROUND;
				
				my_shadow.visible = false;
				offset.y = DEFAULT_Y_OFFSET;
				just_landed = true;
				anim_air_did_down = anim_air_did_up = false;
			}
		}
		public function air_movement():void {
			
			set_init_vel(0.83);
			
			if (velocity.x != 0 && velocity.y != 0) {
				velocity.x *= .7;
				velocity.y *= .7;
			}
			
			if (ON_RAFT) { 
					if (ON_CONVEYER != NONE) {
						raft.x = x - 2;
						raft.y = y - 2;
					}
			}
			
			velocity.x += additional_x_vel;
			velocity.y += additional_y_vel;
		}
		
		
		private function dash_logic():void {
			var VEL_DASH_1:int = walkSpeed * 1.3;
			var VEL_DASH_2:int = walkSpeed * 1.77;
			if (SIG_DASH) {
				SIG_DASH = false;
				dashing = true;
				switch (SIG_DASH_TYPE) {
					case UP:
						if (dash_flags & DOWN) {
							dash_flags &= ~DOWN;
							dash_v_state = 0;
						} else {
							dash_flags |= UP;
							if (dash_v_state < 2) {
								
								dash_v_state++;
								(dash_v_state == 2) ? play_sfx("dash_2") : play_sfx("dash_1");
							}
						}
						break;
					case DOWN:
						if (dash_flags & UP) {
							dash_flags &= ~UP;
							dash_v_state = 0;
						} else {
							dash_flags |= DOWN;
							if (dash_v_state < 2) {
								dash_v_state++;
								(dash_v_state == 2) ? play_sfx("dash_2") : play_sfx("dash_1");
							}
						}
						break;
					case RIGHT:
						if (dash_flags & LEFT) {
							dash_flags &= ~LEFT;
							dash_h_state = 0;
						} else {
							dash_flags |= RIGHT;
							if (dash_h_state < 2) {
								dash_h_state++;
								(dash_h_state == 2) ? play_sfx("dash_2") : play_sfx("dash_1");
							}
						}
						break;
					case LEFT: 
						if (dash_flags & RIGHT) {
							dash_flags &= ~RIGHT;
							dash_h_state = 0;
						} else {
							dash_flags |= LEFT;
							if (dash_h_state < 2) {
								dash_h_state++;
								(dash_h_state == 2) ? play_sfx("dash_2") : play_sfx("dash_1");
							}
						}
						break;
				}
			}
			
			if (!dashing) return;
			
			// Stop dashing if not pressing the respective move key
			if ((dash_flags & UP) && !keyWatch.UP) {
				dash_flags &= ~UP;
				dash_v_state = 0;
			} else if ((dash_flags & DOWN) && !keyWatch.DOWN) {
				dash_flags &= ~DOWN;
				dash_v_state = 0;
			} else if ((dash_flags & RIGHT) && !keyWatch.RIGHT) {
				dash_flags &= ~RIGHT;
				dash_h_state = 0;
			} else if ((dash_flags & LEFT) && !keyWatch.LEFT) {
				dash_flags &= ~LEFT;
				dash_h_state = 0;
			}
			
			// Stop dashing if touching wall
			if ((dash_flags & touching) & UP) {
				dash_flags &=  ~UP;
				dash_v_state = 0;
			} else if ((dash_flags & touching) & DOWN) {
				dash_flags &=  ~DOWN;
				dash_v_state = 0;
			} else if ((dash_flags & touching) & LEFT) {
				dash_flags &=  ~LEFT;
				dash_h_state = 0;
			} else if ((dash_flags & touching) & RIGHT) {
				dash_flags &=  ~RIGHT;
				dash_h_state = 0;
			}
			
			if (dash_v_state == 1) {
				velocity.y = velocity.y > 0 ? VEL_DASH_1 : -VEL_DASH_1;
			} else if (dash_v_state == 2) {
				velocity.y = velocity.y > 0 ? VEL_DASH_2 : -VEL_DASH_2;
			} else {
				//Decelerate the player, or stop them...
			}
			
			if (dash_h_state == 1) {
				velocity.x = velocity.x > 0 ? VEL_DASH_1 : -VEL_DASH_1;
			} else if (dash_h_state == 2) {
				velocity.x = velocity.x > 0 ? VEL_DASH_2 : -VEL_DASH_2;
			} else {
				
			}
			
			if (dash_flags == 0 || broom.visible) { 
				dashing = false;
			}
		}
		/* largely similar to air anim but we want a different timer 
		 * based on the Jump_Trigger that caused the auto_jump */
		public function auto_jump_animation():void {
			if (!anim_air_did_down) {
				play("jump_d");
				Registry.sound_data.player_jump_up.play();
				my_shadow.frame = 0;
				auto_jump_timer = 0;
				anim_air_did_down = true;
			}
			if (auto_jump_timer > auto_jump_period / 2 && !anim_air_did_up) {
				anim_air_did_up = true;
				my_shadow.play("get_big");
			}
			
			velocity.x = velocity.y = 0;
			my_shadow.x = x + JUMP_SHADOW_X_OFF + 3;
			if (is_spring_jump) {
				my_shadow.y = y + 3;
			} else {
				my_shadow.y = auto_jump_base_y + auto_jump_distance;
			}
			//parabola between two pts
			// x(x - t), where f(t/2) = h. - h = 16, solve for a
			var a:Number = -1 * ( (4 * AUTO_JUMP_HEIGHT) / (auto_jump_period * auto_jump_period));
			offset.y = DEFAULT_Y_OFFSET + int((a * auto_jump_timer * (auto_jump_timer - auto_jump_period)));
			
			// also lerp the distance
			y = auto_jump_base_y + int(auto_jump_distance * (auto_jump_timer / auto_jump_period));
			auto_jump_timer += FlxG.elapsed;
			if (auto_jump_timer > auto_jump_period) {
				solid = true;
				is_spring_jump = false;
				velocity.x = velocity.y = 0;
				auto_jump_timer = 0;
				
				state = S_GROUND;
				
				my_shadow.visible = false;
				offset.y = DEFAULT_Y_OFFSET;
				
				just_landed = true;
				
				anim_air_did_down = false;
				anim_air_did_up = false;
				play("idle_d");
				ANIM_STATE = as_idle;
				
				Registry.sound_data.player_jump_down.play();
			}
		}
		
		private var t_just_left_water:Number = 0;
		private var tm_just_left_water:Number = 0.04;
		/* update ground anim - modifies offset.x */
		public function ground_animation():void {
			if (ON_CONVEYER && IS_SINKING) { //If on a conveyer and sinking, make me sink.
				t_just_left_water = 0;
				sink_timer -= FlxG.elapsed;
				if (sink_timer < 0) {
					sink_timer = sink_timer_max;
					if (framePixels_y_push < 16) {
						framePixels_y_push += 1;
					} else {
						x = grid_entrance_x;
						y = grid_entrance_y;
						framePixels_y_push = 0;
						touchDamage(1);
					}
				}
				
			} else {
				t_just_left_water += FlxG.elapsed;
				if (t_just_left_water > tm_just_left_water) {
					t_just_left_water = 0;
					framePixels_y_push = 0;
				}
			}
			
			// We don't want the bump velocity to change the direction we face.
			if (do_bump) return;
			
			switch (ANIM_STATE) {
			case ANIM_ATK_R:
			case ANIM_ATK_L:
			case ANIM_ATK_D:
			case ANIM_ATK_U:
				if (broom.finished) { 
					ANIM_STATE = as_idle;
					switch (_curAnim.name) {
						case "attack_right":
							play("idle_r");
							break;
						case "attack_up":
							play("idle_u");
							break;
						case "attack_left":
							play("idle_l");
							break;
						case "attack_down":
							play("idle_d");
							break;
					}
					break;
				}
				
				if (frame != 8 && ANIM_STATE == ANIM_ATK_R)  { play("attack_right");   }
				if (frame != 16 && ANIM_STATE == ANIM_ATK_L) { play("attack_left"); }
				if (frame != 12 && ANIM_STATE == ANIM_ATK_U) { play ("attack_up"); }
				if (frame != 22 && ANIM_STATE == ANIM_ATK_D) { play("attack_down"); }
				return;
			case ANIM_FALL:
				play("fall");
				return;
			case ANIM_DEAD:
				return;
			case as_idle:
				if (idle_ticks > 0) {
					idle_ticks -= 1;
					return;
				}
				if (velocity.y < 0) {
					facing = UP;
					play("walk_u");
				} else if (velocity.y > 0) {
					facing = DOWN;
					play("walk_d");
				} else if (velocity.x < 0) {
					facing = LEFT;
					play("walk_l");
				} else if (velocity.x > 0) {
					facing = RIGHT;
					play("walk_r");
				} else {
					switch (facing) {
						case UP:
							play("idle_u");
							break;
						case LEFT:
							play("idle_l");
							break;
						case DOWN:
							play("idle_d");
							break;
						case RIGHT:
							play("idle_r");
							break;
					}
					break;
				}
				ANIM_STATE = as_walk;
				_curFrame = last_frame[_curAnim.name];
				_curIndex = _curAnim.frames[_curFrame];
				
				break;
			case as_walk:
				if (idle_ticks > 0) {
					idle_ticks --;
				}
				if (velocity.x == 0 && velocity.y == 0) {
					ANIM_STATE = as_idle;
					switch (facing) {
						case UP:  last_frame["walk_u"] = _curFrame;   play("idle_u"); break;
						case DOWN: last_frame["walk_d"] = _curFrame;  play("idle_d");  break;
						case LEFT: last_frame["walk_l"] = _curFrame;   play("idle_l"); break;
						case RIGHT: last_frame["walK_r"] = _curFrame; play("idle_r");   break;
					}
				} else {
					if (velocity.y < 0) {
						if (facing != UP || (_curAnim != null && _curAnim.name != "walk_u")) {
							facing = UP;
							play("walk_u");
						} 
					}  else if (velocity.y > 0) {
						if (facing != DOWN) {
							facing = DOWN;
							play("walk_d");
						} 
					} else if (velocity.x < 0) {
						if(facing != LEFT) {
							facing = LEFT;
							play("walk_l");
						}
					} else {
						if (facing != RIGHT) {
							facing = RIGHT;
							play("walk_r");
						}
					}
					
				}
				break;
			case as_slumped:
				if (Registry.keywatch.JP_ACTION_1 || Registry.keywatch.JP_ACTION_2 || Registry.keywatch.UP || Registry.keywatch.DOWN || Registry.keywatch.LEFT || Registry.keywatch.RIGHT) {
					ANIM_STATE = as_idle;
				}
				break;
			}
			
			
			
        }
        public function update_actions(action_is_down:Boolean, just_pressed_action:Boolean, bound_item:String):void {
			
            if (action_is_down) {
                if (bound_item == "BROOM") {
                    if (just_pressed_action && !broom.visible && framePixels_y_push < 8) {
						if (action_latency >= 0) return; //DELAY FOR ATTACK
							
						broom.visible_timer = 0; // Reset this so we do not get the edge case where the broom goes invisible mid-swing from
												// perfectly timing two attacks
						action_latency = action_latency_max;
						
						Registry.sound_data.play_sound_group_randomly(Registry.sound_data.swing_broom_group);
						
						
						if (broom.has_dust) {
							y = int(y);
							x = int(x);
							if (facing == UP) {broom.dust.x = x; broom.dust.y = y - 16; } 
							else if (facing == LEFT) { broom.dust.x = x - 16; broom.dust.y = y; }
							else if (facing == RIGHT) { broom.dust.x = x + 16; broom.dust.y = y; }
							else { broom.dust.x = x; broom.dust.y = y + 16; }
							
							var dust_x:int = broom.dust.x;
							var dust_y:int = broom.dust.y - 20;
							/* Snap dust to nearest tile */
							if (broom.dust.x % 16 <= 9) { broom.dust.x -= broom.dust.x % 16; }
							else { broom.dust.x += (16  - broom.dust.x % 16); }
							if (dust_y % 16 <= 7) { broom.dust.y -= (dust_y % 16); }
							else { broom.dust.y += (16 - dust_y % 16); }
							/* Look into the (unmodified) tilemap to get the tile's number this dust is being dropped on */
							var tile_type:int = parent.map.getTile(broom.dust.x / 16, (broom.dust.y - 20) / 16);
							/* And then actually look up that tile's properties in the current map buffer to figure out
							 * whether we can drop the dust. This is stupid but it works so who cares */
							
							 
							var skip_if_dust_overlaps:Boolean = false;
							for each (var d:Dust in Registry.subgroup_dust) {
								if (d != null) {
									if (broom.dust.overlaps(d) && d != broom.dust) {
										skip_if_dust_overlaps = true;
									}
								}
							}
							 
							if (!skip_if_dust_overlaps && parent.curMapBuf._tileObjects[tile_type].allowCollisions != FlxObject.ANY) { 
								broom.dust.visible = true;
								broom.has_dust = false;
								if (broom.dust._animations != null) {
									broom.dust.play("unpoof");
								}
								Dust.dust_sound.play();
								broom.just_released_dust = true;
							}
							
						
						}
						
						
						broom.visible = true;
						if (facing == RIGHT) {
							broom.angle = 180;
							broom.play("stab",true);
						}else if (facing == DOWN) {
							broom.angle = 270;
							broom.play("stab",true);
						} else if (facing == LEFT) {
							broom.angle = 0;
							broom.play("stab",true);
						} else if (facing == UP) {
							broom.angle = 90;
							broom.play("stab",true);
						}
						 broom.update();
						switch(facing) {
							case LEFT: ANIM_STATE = ANIM_ATK_L; break;
							case UP: ANIM_STATE = ANIM_ATK_U; break;
							case DOWN:  ANIM_STATE = ANIM_ATK_D; break; 
							case RIGHT:	ANIM_STATE = ANIM_ATK_R; break;
						}
					}
                } 
				if (bound_item == "JUMP"  && (ON_RAFT || (ON_CONVEYER == NONE || ON_CONVEYER == ANY)) && !IS_SINKING && !prevent_jump_repeat && no_jump_ticks <= 0 && framePixels_y_push == 0) {
					if (state != S_AIR) {
						state = S_AIR;
						my_shadow.visible = true;
						my_shadow.x = x; my_shadow.y = y;
						prevent_jump_repeat = true;
					}
				}
				
				if (just_pressed_action && bound_item == "TRANSFORMER") {
					transformer.use_item();
				}
			} 
			
			if (!broom.visible && !action_is_down && bound_item == "BROOM") {
				broom.just_released_dust = false;
			} else if (!action_is_down && bound_item == "JUMP") {
				prevent_jump_repeat = false;
			}
        }

        public function touchDamage(damage:int,type:String=" "):void {
			
			if (parent.state == parent.S_DIALOGUE) { //aint no damge in dialogue
				return; 
			}
			if (invincible == false && !isFalling && !flickering) {
				Registry.sound_data.player_hit_1.play();
				flicker(INVINCIBLE_TIME);
				invincible_timer = INVINCIBLE_TIME;
				invincible = true;
				health_bar.modify_health( -damage);
				if (health_bar.cur_health != 0) {
					do_bump = true;
				}
				bump_vel_x = bump_vel_y = 0;
				if (facing == UP) {
					bump_vel_y = SMALL_BUMP_VEL;
				} else if (facing == LEFT) {
					bump_vel_x = SMALL_BUMP_VEL;
				} else if (facing == DOWN) {
					bump_vel_y = -SMALL_BUMP_VEL;
				} else {
					bump_vel_x = - SMALL_BUMP_VEL;
				}
			}
			
			if (type == "zap") {
				zap_timer = 0;
			}
            //bump in direction opposite of facing
        }
		
		public function touches(o:FlxSprite):Boolean {
			if (o is Door) {
				var d:Door = o as Door;
				if (dontMove && d.type == Door.FALL_DOOR) {
					return false;
				}
			}
			if (o.overlaps(this)) {
				return true;
			}
			return false;
		
		}
		/* Update the inventory blah blah */
		public function update_player_inventory(treasure:Treasure):void {
			trace("Get treasure number ", parseInt(treasure.xml.@frame));
			switch (parseInt(treasure.xml.@frame)) {
				case Treasure.IDX_BROOM:
					Registry.inventory[Registry.IDX_BROOM] = true; 
					Achievements.unlock(Achievements.A_GET_BROOM);
					break;
				case Treasure.IDX_KEY:
					Registry.change_nr_keys(1);
					parent.number_of_keys_text.setText("x" + Registry.get_nr_keys().toString(), true, 0, 0, "left", true);
					break;
				case Treasure.IDX_GROWTH:
					trace("Growths", Registry.nr_growths);
					Registry.nr_growths++;
					check_for_card_achvs();
					break;
				case Treasure.IDX_JUMP:
					Registry.inventory[Registry.IDX_JUMP] = true;
					break;
				case Treasure.IDX_WIDE:
					Registry.inventory[Registry.IDX_WIDEN] = true;
					break;
				case Treasure.IDX_LONG:
					Registry.inventory[Registry.IDX_LENGTHEN] = true;
					break;
				case Treasure.IDX_SWAP:
					Registry.inventory[Registry.IDX_TRANSFORMER] = true;
					break;
			}
		}
		
		private function check_for_card_achvs():void {
			if (Registry.CURRENT_MAP_NAME == "WINDMILL") Achievements.unlock(Achievements.A_GET_WINDMILL_CARD);
			if (Registry.nr_growths == 1) Achievements.unlock(Achievements.Card_1);
			if (Registry.nr_growths == 7) Achievements.unlock(Achievements.Card_7);
			if (Registry.nr_growths >= 48) Achievements.unlock(Achievements.A_GET_48_CARDS);
		}
		
		/* reset things that need to be reset */
		public function cleanup_on_grid_transition():void {
			broom.has_dust = false;
			t_reverse = 0;
			if (reversed) {
				Registry.GFX_WAVE_EFFECT_ON = false;
				reversed = false;
				reverse_controls();
			}
		}
		
		public function init_player_group(player_group:FlxGroup,player:Player,map:FlxTilemap):void {
			player_group.add(player.raft);
			player_group.add(player.my_shadow);
			
			player_group.add(player.transformer.selector);
			player_group.add(player.transformer.selected);
			player_group.add(player.transformer);
			
			player_group.add(player); 
			
			player_group.add(player.foot_overlay);
			var p:PlayState = Registry.GAMESTATE;
			
			p.intra_bg_bg2_sprites.add(player.foot_overlay_bg_bg2);
			
			player_group.add(player.light); 
			
			player_group.add(player.broom.wide_attack_h);
			player_group.add(player.broom.wide_attack_v);
			player_group.add(player.broom.long_attack_h);
			player_group.add(player.broom.long_attack_v);
            player_group.add(player.broom); 
			
			player_group.add(player.LR_Sentinel); 
			player_group.add(player.UL_Sentinel);
			if (Intra.is_mobile) {
				player_group.add(player.mobile_current);
			}
			player_group.set_draw_ref(player);
		}
		/**
		 * Checks for conditions that stop the player from updating, or update
		 * various state (temporary invincibility, health...)
		 * @return 0 if player actions should be terminated here. 1 otherise
		 */
		private function common_conditions():int 
		{
			Registry.CUR_HEALTH = health_bar.cur_health;
			
			if (parent.state == parent.S_TRANSITION) {
				dontMove = true;
				velocity.x = velocity.y = 0;
				if (ON_RAFT) {
					raft.x = x - 2;
					raft.y = y - 3;
					conveyer_fudge_factor = 5; // <_<
				}
				
				if (state == S_AIR) {
					my_shadow.x = x + JUMP_SHADOW_X_OFF + 1;
					my_shadow.y = y + JUMP_SHADOW_Y_OFF - 3;
				}
				return 0;
			}
			
			if (parent.SWITCH_MAPS) {
				super.update();
				return 0;
			}
			
			if (!solid && just_fell) {
				solid = true;
				just_fell = false;
			}
			if (!alive) {
				super.update();
				return 0;
				
			}
			
			if (invincible_timer > 0) {
				invincible_timer -= FlxG.elapsed
			} else {
				invincible = false;
				if (!Registry.FUCK_IT_MODE_ON) {
					visible = true;
				}
			}
			

			
			return 1;
		}
		
		private function reverse_controls():void 
		{
			var down_key:String = Registry.controls[Keys.IDX_DOWN];
			var up_key:String = Registry.controls[Keys.IDX_UP];
			Registry.controls[Keys.IDX_DOWN] = up_key;
			Registry.controls[Keys.IDX_UP] = down_key;
			
			var left_key:String = Registry.controls[Keys.IDX_LEFT];
			var right_key:String = Registry.controls[Keys.IDX_RIGHT];
			Registry.controls[Keys.IDX_RIGHT] = left_key;
			Registry.controls[Keys.IDX_LEFT] = right_key;
		}
		
		private var turn_in_place_ticks:int = 0;
		private function set_init_vel(mul:Number=1):void 
		{
			// If actions are disabled (overlapping an NPC or something), then
			// don't do the slidy-push thing
			if (actions_disabled) {
				touching = NONE;
			}
			
			
			if (keyWatch.UP && !keyWatch.DOWN) {
				velocity.y = -mul*walkSpeed*c_vel;
				// Check if we need to push the player to get around corner snags.
				// Looks up tile collision flags and uses those, as well as the 
				// hitbox's corner points to determine whether pushing is needed.
				if (touching == UP) {
					var col_tl:uint = EventScripts.get_tile_collision_flags(x, y - 1, parent.map,parent.curMapBuf);
					var col_tr:uint = EventScripts.get_tile_collision_flags(x + width, y - 1, parent.map,parent.curMapBuf);
					if ((x + width) % 16 < 6 && (col_tl != FlxObject.ANY) && (col_tl != FlxObject.DOWN)) {
						additional_x_vel = -30;
					} else if ((x % 16) > 9 && (col_tr != FlxObject.ANY) && (col_tr != FlxObject.DOWN)) {
						additional_x_vel = 30;
					}
				}
			} else if (keyWatch.DOWN && !keyWatch.UP) {
				velocity.y = mul*walkSpeed*c_vel;
				if (touching == DOWN) {
					var col_bl:uint = EventScripts.get_tile_collision_flags(x, y + height + 1, parent.map, parent.curMapBuf);
					var col_br:uint = EventScripts.get_tile_collision_flags(x + width, y + height + 1, parent.map, parent.curMapBuf);
					if ((x + width) % 16 < 6 && (col_bl != FlxObject.ANY) && (col_bl != FlxObject.UP)) {
						additional_x_vel = -30;
					} else if (x % 16 > 9 && (col_br != FlxObject.ANY) && (col_br != FlxObject.UP)) {
						additional_x_vel = 30;
					}
				}
			} else {
				velocity.y = 0;
				
			}
			if (keyWatch.LEFT && !keyWatch.RIGHT) {
				velocity.x = -mul*walkSpeed*c_vel;
				if (touching == LEFT) {
					var col_tl2:uint = EventScripts.get_tile_collision_flags(x-1, y, parent.map,parent.curMapBuf);
					var col_bl2:uint = EventScripts.get_tile_collision_flags(x-1, y + height, parent.map, parent.curMapBuf);
					if ((y - Registry.HEADER_HEIGHT + height) % 16 < 6 && (col_tl2 != FlxObject.ANY) && (col_tl2 != FlxObject.RIGHT)) {
						additional_y_vel = -30;
					} else if ((y - Registry.HEADER_HEIGHT) % 16 > 9 && (col_bl2 != FlxObject.ANY) && (col_bl2 != FlxObject.RIGHT)) {
						additional_y_vel = 30;
					}
					
				}
			} else if (keyWatch.RIGHT && !keyWatch.LEFT) {
				velocity.x = mul*walkSpeed * c_vel;
				if (touching == RIGHT) {
					var col_tr2:uint = EventScripts.get_tile_collision_flags(x + width + 1, y, parent.map,parent.curMapBuf);
					var col_br2:uint = EventScripts.get_tile_collision_flags(x + width + 1, y + height, parent.map, parent.curMapBuf);
					if ((y - Registry.HEADER_HEIGHT + height) % 16 < 6 && (col_tr2 != FlxObject.ANY) && (col_tr2 != FlxObject.LEFT)) {
						additional_y_vel = -30;
					} else if ((y - Registry.HEADER_HEIGHT) % 16 > 9 && (col_br2 != FlxObject.ANY) && (col_br2 != FlxObject.LEFT)) {
						additional_y_vel = 30;
					}
					
				}
			}  else {
				velocity.x = 0;
			}
			
			if (keyWatch.ACTION_1) {
				turn_in_place_ticks += 1;
				velocity.x = velocity.y = 0;
				if (turn_in_place_ticks > 23) {
					ANIM_STATE = as_idle;
					if (keyWatch.RIGHT) {
						facing = RIGHT;
					} else if (keyWatch.LEFT) {
						facing = LEFT;
					} else if (keyWatch.UP) {
						facing = UP;
					} else if (keyWatch.DOWN) {
						facing = DOWN;
					}
				}
			} else { 
				turn_in_place_ticks = 0;
			}
			
			
		}
		
		private function ladder_logic():void 
		{
			velocity.x = velocity.y = 0;
			if (keyWatch.UP) {
				velocity.y = -walkSpeed*0.7;
				play("climb");
			} else if (keyWatch.DOWN) {
				velocity.y = walkSpeed*0.7;
				play("climb");
			} else {
				play("idle_climb");
			}
			
			if (keyWatch.LEFT) {
				velocity.x = -walkSpeed;
			} else if (keyWatch.RIGHT) {
				velocity.x = walkSpeed;
			}
			
			step_noise_timer -= FlxG.elapsed;
			
			if (step_noise_timer < 0 && (velocity.y != 0)) {
				step_noise_timer = 0.2;
				Registry.sound_data.play_sound_group(Registry.sound_data.ladder_step);
			}
			
			// Make sure the ladder anim doesn't keep playing when leaving ladder state
			state = S_GROUND;
			ANIM_STATE = as_idle;
		}
		
		public function on_anim_change(name:String, _frame:int, _index:int):void {
			switch (name) {
				case "walk_l":
				case "attack_left":
					offset.x = 4;
					break;
				case "walk_r":
				case "attack_right":
					offset.x = 3;
					break;
				case "walk_d":
				case "attack_down":
					offset.x = 3;
					break;
				case "walk_u":
				case "attack_up":
					offset.x = 3;
					break;
			}
		}
		
		public function be_idle():void {
			ANIM_STATE = as_idle;
			idle_ticks = 5;
			switch (facing) {
				case UP:
					play("idle_u");
					break;
				case LEFT:
					play("idle_l");
					break;
				case RIGHT:
					play("idle_r");
					break;
				case DOWN:
					play("idle_d");
					break;
			}
		}
	}

}
