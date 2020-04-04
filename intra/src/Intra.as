package {
//	import com.amanitadesign.steam.SteamEvent;
	//import com.newgrounds.*;
//	import com.newgrounds.components.MedalPopup;
	import data.Common_Sprites;
	import data.SoundData;
	import entity.decoration.Light;
	import entity.enemy.crowd.Person;
	import entity.player.Player;
	import extension.JoyQuery.Joystick;
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeWindowIcon;
	import flash.desktop.SystemIdleMode;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageAspectRatio;
	import flash.display.StageDisplayState;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.StageOrientationEvent;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	import flash.events.VideoEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.AudioPlaybackMode;
	import flash.media.SoundMixer;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import global.*;
	import helper.Achievements;
	import helper.DH;
	import helper.S_NPC;
	import mx.managers.SystemManagerGlobals;
	import org.flixel.*;
	import states.*;
	public class Intra extends FlxGame {
		
		public static var intraintra:Intra;
		public static var scale_ctr:int = 0;
		public var did_init_fullscreening:Boolean = false;
		private var full_scale_offset:Point = new Point(0, 0);
		private var ratio:Number;
		private var is_landscape:Boolean = true;
		
		private var oriented_landscape:Boolean = false;
		private var oriented_portrait:Boolean = false;
		public static var frame_x_px:int = 8; // Extra pixels
		public static var frame_y_px:int = 26;
		public static var did_window_config:Boolean = false;
		
		public static var is_release:Boolean = false; //  Makes the game in demo mode (I know, sorry)
		public static var is_demo:Boolean = false; // Set this for normal release version.
		public static var is_melos:Boolean = false; // Don't know what this does.
		public static var is_test:Boolean = false; 
		public static var is_web:Boolean = false; // Newgrounds achievements/other things in menu
		public static var is_air:Boolean = false; // Joystick stuff off/on
		public static var is_mobile:Boolean = false; // Is this the mobile version	
		public static var is_ios:Boolean = false;
		public static var is_ouya:Boolean = false;
	
		public static var IS_WINDOWS:Boolean = false;
		public static var IS_MAC:Boolean = false;
		public static var IS_LINUX:Boolean = false;
	
		
		public static var allow_fuck_it_mode:Boolean = false;
		private var did_init_window_fix:Boolean = false;
		
		private var did_mobile_setup:Boolean = false;
		public static var mobile_is_rhand:Boolean = true;
		
		public static var force_scale:Boolean = false;
		public static var scale_factor:int = 3;
		public static const SCALE_TYPE_WINDOWED:int = 0;
		public static const SCALE_TYPE_INT:int = 1;
		public static const SCALE_TYPE_FIT:int = 2;
		
		// Hitboxes
		public var no_zone:Rectangle = new Rectangle(1, 1, 1, 1);
		public var up_sprite:Bitmap;
		public var down_sprite:Bitmap;
		public var left_sprite:Bitmap;
		public var right_sprite:Bitmap;
		
		public var a1_sprite:Bitmap;
		public var a2_sprite:Bitmap;
		public var pause_sprite:Bitmap;
		
		public var MOBILE_DPAD_SCALE:Number = 1;
		public var MOBILE_ACTIONS_SCALE:Number = 1;
		public var MOBILE_PAUSE_SCALE:Number = 1;

		
		// Actual gui iimages
		private static var icon_thumb:Bitmap;
		private static var icon_dpad:Bitmap;
		private static var icon_dpad_frame:int = 0;
		private static var icon_pause:Bitmap;
		private static var icon_c:Bitmap;
		private static var icon_x:Bitmap;
		private static var icon_menu:Bitmap;
		private static var icon_x_frame:int = -1;
		private static var icon_c_frame:int = -1;
		private static var icon_menu_frame:int = -1;
		
		public var mobile_bg:Bitmap;
		public static var left_bar:Bitmap;
		public static var right_bar:Bitmap;
		public var move_point_id:int = -1;
		
		
		[Embed(source = "res/sprites/mobile/button_c.png")] public static const embed_mobile_c:Class;
		[Embed(source = "res/sprites/mobile/button_x.png")] public static const embed_mobile_x:Class;
		[Embed(source = "res/sprites/mobile/button_menu.png")] public static const embed_mobile_pause:Class;
		[Embed(source = "res/sprites/mobile/button_dpad.png")] public static const  embed_mobile_dpad:Class;
		[Embed(source = "res/sprites/mobile/screenedge_left.png")] public static const embed_bar_left:Class;
		[Embed(source = "res/sprites/mobile/screenedge_right.png")] public static const  embed_bar_right:Class;
		[Embed(source = "res/sprites/mobile/thumb.png")] public static const embed_thumb:Class;
	
		
		// Holds entire bitmap data
		private static var dpad_data:Bitmap;
		private static var x_data:Bitmap;
		private static var c_data:Bitmap;
		private static var menu_data:Bitmap;
		
		private var t_up:Number = 0;
		private var tm_up:Number = 0.2;
		
		public function Intra() {
			
            for (var i:int = 0; i < Registry.DOOR_INFO.length; i++) {
                Registry.DOOR_INFO[i] = new Array();
				
            }
			Registry.embed2saveXML();
            Registry.checkDoorInfo();
			Registry.sound_data = new SoundData();
			Common_Sprites.init();
			DH.init_dialogue_state();
			
			Registry.CUR_HEALTH = Registry.MAX_HEALTH = 6;
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			is_demo = true; // Lots of little flags of whether debug stuff works - set true for release
			//is_release = true; // Prevents leaving FIELDS, make windmill red gate msg show up, makes "buy demo/greenlight" appear
			//is_mobile = true; // Makes different config options show, pulls up the gui...
			//is_web  = true; // Should the config for air that freezes the game go away, also turns on NG medals
			if (is_web) {
				did_window_config = true;
			}
			
		    is_test = false; // Whether tutorial popups appear - false to make appear
			allow_fuck_it_mode = false;
			
			//debug_mode();
			if (!is_demo) {
				Registry.autosave_on = false; // !!!!!!!
				did_init_fullscreening = true;
				debug_mode();
				Registry.SAVE_NAME = "ANODYNE_DEMO_SAVE_123";
			}
			var ps:Class = make_play_or_roam_state();
			var active:Class;
				
			// Default values, may change with the Save.load() call
			Registry.GE_States[Registry.GE_MOBILE_IS_RHAND] = true;
			Registry.GE_States[Registry.GE_MOBILE_IS_XC] = true;
			
			if (is_demo) {
				if (Save.load(true)) {
					did_init_fullscreening = true; //recall settings
				} // So we don't the screen config if the dirty flag is "y"
				active = ps;
			} else {
				active = ps;
			}
			
			if (Intra.IS_MAC) {
				did_init_fullscreening = true;
			}
			
			if (is_ouya) {
				did_init_fullscreening = true;
				did_window_config = true;
			}
			
			mobile_is_rhand = Registry.GE_States[Registry.GE_MOBILE_IS_RHAND];
			
			//NOTE THAT AUTOSAVING OVERWRITES STUFF WHEN TESTING 
			//Registry.FUCK_IT_MODE_ON = true;
			super(160, 180, TitleState, 3);
			//super(160, 180, IntroScene, 3);
			//super(160, 180, EndingState, 3);
			if (is_mobile) {
				intraintra = this;
				frame_x_px = frame_y_px = 0;
			} 
			
			//Registry.CURRENT_MAP_NAME = "SPACE";
			//Registry.ENTRANCE_PLAYER_X = 160*3;
			//Registry.ENTRANCE_PLAYER_Y = 160 * 3;
			//
			//super(160, 180,  active, 3, 60,30);
			FlxG.volume = 1;
			
			if (is_ouya) {
				Registry.controls = new Array("UP", "DOWN", "LEFT", "RIGHT", "ENTER", "OUYA_A", "Z", "OUYA_START");
				Main.debugstring += "event listener added\n";
				NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handle_back_menu, false, 0, true);
			}
			
		}
		
		private var win_joy_remove_timer:Number = 1;
		private var force_normalize:Boolean = false;
		private var t_normalize:Number = 0;
		private var ouya_init:Boolean = false;
		override protected function update():void 
		{		
			if (Intra.is_mobile && icon_thumb != null) {
				if (thumb_icon_timer > 0) {
					thumb_icon_timer -= FlxG.elapsed;
					icon_thumb.alpha = 0.9;
				} else {
					icon_thumb.alpha = 0;
				}
			}
			
			if (Registry.FUCK_IT_MODE_ON) {
				if (FlxG.keys.justPressed("L")) {
					if (DH.language_type == DH.LANG_en) {
						DH.set_language(DH.LANG_ja);
					} else {
						DH.set_language(DH.LANG_en);
					}
				}
			}
			if (FlxG.keys.justPressed("B")) {
				backwards = !backwards;
				trace(backwards);
			}
			//if (is_ouya) {
				//if (stage != null && !ouya_init) {
					//ouya_init = true;
					//joypad.init(stage);
				//}
				//if (joypad.attached_once == false) {
					//if (GameInput.numDevices > 0) {
						//Main.debugstring += "forcing attach\n";
						//joypad.handleDeviceAttached(new GameInputEvent(GameInputEvent.DEVICE_ADDED, true, false, GameInput.getDeviceAt(0)));
						//
					//}
				//}
			//}
			
			
			if (t_back_dim > 0) {
				t_back_dim -= FlxG.elapsed;
				if (t_back_dim < 0) {
					stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				}
			}
			if (t_normalize > 0) {
				t_normalize -= FlxG.elapsed;
				if (t_normalize < 0) {
					stage.displayState = StageDisplayState.NORMAL;
				}
			}
			if (Registry.FUCK_IT_MODE_ON) {
				update_fuck_it();
			}
			
			update_controller();
				
			if (!is_mobile) {
				update_not_mobile();
			} else {
				if (activate_timer > 0) {
					activate_timer -= FlxG.elapsed;
					if (activate_timer < 0) {
						handle_orientation_change(new StageOrientationEvent(StageOrientationEvent.ORIENTATION_CHANGE, false, false, null, stage.deviceOrientation));
					}
					if (force_normalize) {
						t_back_dim = 3;
						t_normalize = 1;
						force_normalize = false;
					}
						stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				}
				
				
				if (!did_mobile_setup && stage != null) {
					did_mobile_setup = true;
					
					
					if (stage.deviceOrientation == StageOrientation.ROTATED_LEFT || stage.deviceOrientation == StageOrientation.ROTATED_RIGHT || stage.orientation == StageOrientation.ROTATED_LEFT || stage.orientation == StageOrientation.ROTATED_RIGHT) {
						oriented_landscape = true;
						trace("Start in landscape");
					} else {
						oriented_portrait = true;
						trace("Start in portrait");
					}
					
					
					if (Intra.is_ios) {
						// Add for iOS
						SoundMixer.audioPlaybackMode = AudioPlaybackMode.AMBIENT;
					} else {
						stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
						Main.debugstring += stage.stageWidth.toString() + "." + stage.stageHeight.toString() + "\n" + stage.fullScreenWidth.toString() + "." + stage.fullScreenHeight.toString() + "\n";
						activate_timer = 1;
						force_normalize = true;
					}
					Main.max_uo.set_defaults(stage.stageWidth, stage.stageHeight,stage.fullScreenWidth,stage.fullScreenHeight,oriented_landscape,oriented_portrait);
					if (Main.ui_offsets.save_array != null) {
						// have to enforce minimums to be tappable
						if (Main.ui_offsets.scale_landscape_dpad <= 0.85) {
							Main.ui_offsets.set_defaults(stage.stageWidth, stage.stageHeight,stage.fullScreenWidth,stage.fullScreenHeight,oriented_landscape,oriented_portrait);
						}
					} else {
						Main.ui_offsets.set_defaults(stage.stageWidth, stage.stageHeight,stage.fullScreenWidth,stage.fullScreenHeight,oriented_landscape,oriented_portrait);
					}
					NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
					
					var long_length:int = stage.fullScreenWidth > stage.fullScreenHeight ? stage.fullScreenWidth : stage.fullScreenHeight;
					mobile_bg = new Bitmap(new BitmapData(long_length + 100, long_length + 100, true, 0xff06101b));
					mobile_bg.x = mobile_bg.y = 0;
					stage.addChildAt(mobile_bg, 0);
					position_ui();
				
					// These don't need to be added to check for logical overlaps!!
					//stage.addChild(up_sprite);
					//stage.addChild(down_sprite);
					//stage.addChild(left_sprite);
					//stage.addChild(right_sprite);
					//stage.addChild(pause_sprite);
					//stage.addChild(a1_sprite);
					//stage.addChild(a2_sprite);
					//
					// These are the graphics the player sees, but logically do nothing.

					set_dpad_frame(4);
					set_button_frame(0);
					set_button_frame(1);
					set_button_frame(2);
					
					//
					//stage.addEventListener(MouseEvent.MOUSE_MOVE, handle_touch_move);
					//stage.addEventListener(MouseEvent.MOUSE_UP, handle_mouse_click);
					//stage.addEventListener(MouseEvent.MOUSE_DOWN, handle_mouse_click);
					stage.addEventListener(TouchEvent.TOUCH_MOVE, handle_touch_move);
					stage.addEventListener(TouchEvent.TOUCH_BEGIN, handle_mouse_click);
					stage.addEventListener(TouchEvent.TOUCH_END, handle_mouse_click);
					
					stage.addEventListener(Event.DEACTIVATE, handle_deactivate);
					stage.addEventListener(Event.ACTIVATE, handle_activate);
					stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE, handle_orientation_change);
					
					if (!Intra.is_ios) {
						NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handle_back_menu, false, 0, true);
					}
					//FlxG.mouse.show();
					
				}
				
				if (stage != null) {
					if (oriented_landscape) {
						if (x != Main.ui_offsets.landscape_game.x) {
							x = Main.ui_offsets.landscape_game.x;
							y = Main.ui_offsets.landscape_game.y;
						}
					} else {
						if (x != Main.ui_offsets.portrait_game.x) {
							x = Main.ui_offsets.portrait_game.x;
							y = Main.ui_offsets.portrait_game.y;
						}
					}
				}
			}
			super.update();
		}
		
		private var t_back_dim:Number = 0;
		public function handle_back_menu(event:KeyboardEvent):void {
			if (is_ouya) {
				if (event.keyCode == Keyboard.BACK) {
					Main.debugstring += "BACK\n";
					Keys.FORCE_ACTION_2 = true;
					event.stopImmediatePropagation();
					event.preventDefault();
				} else if (event.keyCode == Keyboard.MENU) {
					Main.debugstring += "MENU\n";
					Registry.keywatch.JUST_PRESSED_PAUSE = true;
					event.preventDefault();
					event.stopImmediatePropagation();
				}
				return;
			}
			if (is_ios) return;
			// only android..
			if (event.keyCode == Keyboard.BACK) {
				t_back_dim = 0.5;
				stage.displayState = StageDisplayState.NORMAL;
				Keys.FORCE_ACTION_2 = true;
				// Ask title or playstate to exit.
				// They'll set their own timer, so mobile_okay will be true during that time
				if (!Registry.MOBILE_OKAY_TO_EXIT_WITH_BACK) {
					event.preventDefault();
					event.stopImmediatePropagation();
				Registry.MOBILE_ASK_TO_EXIT_WITH_BACK = true;
					trace("Requested to exit!");
				} else {
					trace("Exiting!");
					NativeApplication.nativeApplication.exit();
				}
			} else if (event.keyCode == Keyboard.MENU) {
				Registry.keywatch.JUST_PRESSED_PAUSE = true;
				event.preventDefault();
				event.stopImmediatePropagation();
			} 
		}

		// Set frame of dpad
		public static function set_dpad_frame(frame:int):void {
			if (frame > 8 || frame == icon_dpad_frame) return;
			
			var w:int = icon_dpad.width;
			var h:int = w;
			var xoff:int = w * (frame % 3);
			var yoff:int = w * int(frame / 3);
			
			var r:Rectangle = new Rectangle(xoff, yoff, w, h);
			var p:Point = new Point(0, 0);
			icon_dpad.bitmapData.copyPixels(dpad_data.bitmapData, r, p);
			icon_dpad_frame = frame;
			
			
			r = null;
			p = null;
		}
		
		/**
		 * 
		 * @param	id 0 for x, 1, for c, 2, for pause , , ,,  
		 * @param	UP true = up frame
		 */
		public static function set_button_frame(id:int, UP:Boolean=true):void {
			
			if (id == 0) {
				if (UP && icon_x_frame == 0) {
					return;
				} else if (!UP && icon_x_frame == 1) {
					return;
				}
			} else if (id == 1) {
				if (UP && icon_c_frame == 0) {
					return;
				} else if (!UP && icon_c_frame == 1) {
					return;
				}
			} else if (id == 2) {
				if (UP && icon_menu_frame == 0) {
					return;
				} else if (!UP && icon_menu_frame == 1) {
					return;
				}
			}
			
			var w:int; var h:int; var xoff:int; var yoff:int;
			var r:Rectangle;
			var p:Point = new Point(0, 0);
			xoff = 0;
			if (id == 0) {
				w = icon_x.width; h = icon_x.height;
				if (false == UP) xoff = 0;
				r = new Rectangle(xoff, 0, w, h);
				icon_x.bitmapData.copyPixels(x_data.bitmapData, r, p);
				if (UP) {
					icon_x_frame = 0;
				} else {
					icon_x_frame = 1;
				}
			} else if (id == 1) {
				w = icon_c.width; h = icon_c.height;
				if (false == UP) xoff = 0;
				r = new Rectangle(xoff, 0, w, h);
				icon_c.bitmapData.copyPixels(c_data.bitmapData, r, p);
				if (UP) {
					icon_c_frame = 0;
				} else {
					icon_c_frame = 1;
				}
			} else if (id == 2) {
				w = icon_pause.width; h = icon_pause.height;
				if (false == UP) xoff = 0;
				r = new Rectangle(xoff, 0, w, h);
				icon_pause.bitmapData.copyPixels(menu_data.bitmapData, r, p);
				if (UP) {
					icon_menu_frame = 0;
				} else {
					icon_menu_frame= 1;
				}
			} else if (id == 3) {
				w = icon_thumb.width; h = icon_thumb.height;
				r = new Rectangle(0, 0, w, h);
				icon_thumb.bitmapData.copyPixels(thumb_data.bitmapData, r, p);
			}
			
			r = null;
			p = null;
		}
		
		//public function mobile_flip_handedness():void {
			//Registry.GE_States[Registry.GE_MOBILE_IS_RHAND] = !Registry.GE_States[Registry.GE_MOBILE_IS_RHAND];
			//Intra.mobile_is_rhand = Registry.GE_States[Registry.GE_MOBILE_IS_RHAND];
			//var big_off:int = Math.max(up_sprite.x, Math.min(a2_sprite.x,a1_sprite.x));
			//if (up_sprite.x > a1_sprite.x) {
				//a1_sprite.x += big_off;
				//a2_sprite.x += big_off;
				//pause_sprite.x += big_off;
				//left_sprite.x = up_sprite.x = down_sprite.x = 0;
				//right_sprite.x -= big_off;
			//} else {
				//a1_sprite.x -= big_off;
				//a2_sprite.x -= big_off;
				//pause_sprite.x = 0;
				//left_sprite.x = up_sprite.x = down_sprite.x = big_off;
				//right_sprite.x += big_off;
			//}
			//reposition_ui();
		//}
		//public function mobile_flip_x_c():void {
			//Registry.GE_States[Registry.GE_MOBILE_IS_XC] = !Registry.GE_States[Registry.GE_MOBILE_IS_XC];
			//var old_x:int = a1_sprite.x;
			//a1_sprite.x = a2_sprite.x;
			//a2_sprite.x = old_x;
			// also flip The ICONS
			//reposition_ui();
	//
		//}
		public function handle_deactivate(e:Event):void {
			SoundMixer.stopAll();
		}
		
		public var activate_timer:Number = 0;
		public function handle_activate(e:Event):void {
			if (Registry.sound_data != null && Registry.sound_data.current_song != null) {
				Registry.sound_data.current_song.play();
			}
			TitleState.restart_on_mobile_enter = true;
			stage.displayState = StageDisplayState.NORMAL;
			// Add a latency before we send the reorient event 
			activate_timer = 1;
			force_normalize = true;
		}
		
		public function maybe_update_action_gui(x:int,y:int):void {
			if (inside(x, y, a1_sprite)) {
				set_button_frame(1, false); // C!! FUCK
			} else {
				set_button_frame(1, true);
			}
			
			if (inside(x, y, a2_sprite)) {
				set_button_frame(0, false);
			} else {
				set_button_frame(0, true);
			}
			
			if (inside(x, y, pause_sprite)) {
				set_button_frame(2, false);
			} else {
				set_button_frame(2, true);
			}
		}
		
		public function turn_on_touch_only_listeners(on:Boolean = false):void {
			if (on == true) {
					Multitouch.inputMode = MultitouchInputMode.GESTURE;
					stage.removeEventListener(TouchEvent.TOUCH_MOVE, handle_touch_move);
					stage.removeEventListener(TouchEvent.TOUCH_BEGIN, handle_mouse_click);
					stage.removeEventListener(TouchEvent.TOUCH_END, handle_mouse_click);
					
					stage.addEventListener(TransformGestureEvent.GESTURE_SWIPE, handle_swipe);
					stage.addEventListener(MouseEvent.MOUSE_MOVE, handle_touch_move);
					stage.addEventListener(MouseEvent.MOUSE_UP, handle_mouse_click);
					stage.addEventListener(MouseEvent.MOUSE_DOWN, handle_mouse_click);
			} else {
					Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
					stage.removeEventListener(TransformGestureEvent.GESTURE_SWIPE, handle_swipe);
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, handle_touch_move);
					stage.removeEventListener(MouseEvent.MOUSE_UP, handle_mouse_click);
					stage.removeEventListener(MouseEvent.MOUSE_DOWN, handle_mouse_click);
				
					stage.addEventListener(TouchEvent.TOUCH_MOVE, handle_touch_move);
					stage.addEventListener(TouchEvent.TOUCH_BEGIN, handle_mouse_click);
					stage.addEventListener(TouchEvent.TOUCH_END, handle_mouse_click);
			}
			
		}
		
		public function handle_swipe(e:TransformGestureEvent):void {
			if (e.type == TransformGestureEvent.GESTURE_SWIPE) {
				Keys.FORCE_ACTION_1 = true;
			}
		}
		
		public var thumb_icon_timer:Number = 0;
		public function handle_touch_move(e:*):void {
			
			var x:int = e.stageX;
			var y:int = e.stageY;
			
			// For testing touch movemnet without using the phone
			//if (1) {
				//var mx:Number = icon_dpad.x + (icon_dpad.width / 2);
				//var my:Number = icon_dpad.y + (icon_dpad.height / 2);
				//Player.Player_mobile_angle = Math.atan2(my - y, x - mx);
				//Player.Player_mobile_timer = 1;
				//thumb_icon_timer = 0.25;
				//icon_thumb.x = x - icon_thumb.width / 2;
				//icon_thumb.y = y - icon_thumb.height / 2;
				//return;
			//}
			
			if (MobileConfig.in_progress) {
				config_on_touch_move(x, y);
				return;
			}
			// If this is a in-game-area-move id, try to move around the screen
			//if (e.type == TouchEvent.TOUCH_MOVE) {
				if (no_zone.contains(x, y) && game_move_ids.indexOf(e.touchPointID) != -1) {
					//trace("NO ZONE!", x, y);
					//Keys.FORCE_RIGHT = false;
					//set_dpad_frame(4);
					//return;
					move_from_touching_game_area(x, y);
					return;
					
					// otherwise if we're still in the array then don't move elsewhere
				} else if (game_move_ids.indexOf(e.touchPointID) != -1) {
					return;
				}
			
				// Don't let move events cancel movnig on the dpad
				if (move_ids.indexOf(e.touchPointID) == -1) {
					return;
					if (inside(x, y, a1_sprite) || inside(x, y, a2_sprite) || inside(x, y, pause_sprite)) {
						return;
					}
				}
			//} else {
				//if (no_zone.contains(x, y)) {
					//move_from_touching_game_area(x, y);
				//} else {
					//Keys.FORCE_RIGHT = Keys.FORCE_LEFT = false;
					//Keys.FORCE_UP = Keys.FORCE_DOWN = false;
				//}
				//return;
			//}
			var flags:uint = 0x0;
			if (inside(x, y, up_sprite)) {
				flags |= 8; // U
				Keys.FORCE_UP = true;
				Keys.FORCE_DOWN = false;
			}  else if (inside(x, y, down_sprite)) {
				Keys.FORCE_UP = false;
				flags |= 2; // D
				Keys.FORCE_DOWN = true;
			} else {
				Keys.FORCE_DOWN = Keys.FORCE_UP = false;
			}
			
			if (inside(x, y, left_sprite)) {
				flags |= 1; // L
				Keys.FORCE_LEFT = true;
				Keys.FORCE_RIGHT = false;
			} else if  (inside(x, y, right_sprite)) {
				flags |= 4; // R
				Keys.FORCE_RIGHT = true;
				Keys.FORCE_LEFT = false;
			} else {
				Keys.FORCE_RIGHT = Keys.FORCE_LEFT = false;
			}
			
			if (flags != 0) {
				
				if (actually_moved_ids.indexOf(e.touchPointID) == -1) {
					actually_moved_ids.push(e.touchPointID);
				}
				var mx:Number = icon_dpad.x + (icon_dpad.width / 2);
				var my:Number = icon_dpad.y + (icon_dpad.height / 2);
				Player.Player_mobile_angle = Math.atan2(my - y, x - mx);
				Player.Player_mobile_timer = 1;
				thumb_icon_timer = 0.25;
				icon_thumb.x = x - icon_thumb.width / 2;
				icon_thumb.y = y - icon_thumb.height / 2;
			}
			// i guess this could be more straightforward if we change the image.
			switch (flags) {
				case 0: // none
					set_dpad_frame(4);
					break;
				case 1: 
					set_dpad_frame(3);
					break;
				case 2:
					set_dpad_frame(7);
					break;
				case 3:
					set_dpad_frame(6);
					break;
				case 4:
					set_dpad_frame(5);
					break;
				case 12:
					set_dpad_frame(2);
					break;
				case 6:
					set_dpad_frame(8);
					break;
				case 9:
					set_dpad_frame(0);
					break;
				case 8:
					set_dpad_frame(1);
					break;
			}
			
		}
		
		// f ucking FUCK
		private function inside(x:int, y:int, s:*):Boolean {
			
			if (x >= s.getRect(stage).x  && x <= (s.getRect(stage).x + s.width) && y >= s.getRect(stage).y && y <= (s.getRect(stage).y + s.height)) {
				return true;
			}
			return false;
		}
		public static var allow_dpad_move:Boolean = true;
		public static var allow_game_move:Boolean = true;
		public function handle_mouse_click(e:*):void {
			if (Registry.keywatch == null) return;
			
			if (MobileConfig.in_progress) {
				if (e.type == TouchEvent.TOUCH_BEGIN || e.type == MouseEvent.MOUSE_DOWN) {
					config_on_touch_down(e.stageX, e.stageY);
				} else if (e.type == TouchEvent.TOUCH_END || e.type == MouseEvent.MOUSE_UP) {
					config_on_touch_up(e.stageX, e.stageY);
				}
				return;
			}
			// If hitboxes of dpad and actions overlap and we're moving, 
			// Don't let a tap cancel movement
			var ismoveid:Boolean = false;
			if (e.type == TouchEvent.TOUCH_BEGIN || e.type == TouchEvent.TOUCH_END) {
				ismoveid = move_ids.indexOf(e.touchPointID) != -1;
			}
			
			if (e.type == TouchEvent.TOUCH_BEGIN) {
				if (TitleState.mobile_message_done == false) {
					
					if (oriented_landscape) {
						var myrect:Rectangle = new Rectangle(Main.ui_offsets.landscape_game.x * Main.ui_offsets.scale_landscape_game + 480 * Main.ui_offsets.scale_landscape_game - 80 * 3 * Main.ui_offsets.scale_landscape_game, 
						
						Main.ui_offsets.landscape_game.y * Main.ui_offsets.scale_landscape_game + 540 * Main.ui_offsets.scale_landscape_game - 40 * 3 * Main.ui_offsets.scale_landscape_game, 16 * 3 * Main.ui_offsets.scale_landscape_game, 16 * 3 * Main.ui_offsets.scale_landscape_game);
						if (myrect.containsPoint(new Point(e.stageX,e.stageY))){
							backwards = !backwards;
							FlxG.flash(0xffff0000, 0.5);
						}
					} else {
						var scaleOK:Number = Main.ui_offsets.scale_portrait_game;
						var myrect:Rectangle = new Rectangle(Main.ui_offsets.portrait_game.x * scaleOK + 480 * scaleOK - 80 * 3 * scaleOK, Main.ui_offsets.landscape_game.y * scaleOK + 540 * scaleOK - 40 * 3 * scaleOK, 16 * 3 * scaleOK, 16 * 3 * scaleOK);
						if (myrect.containsPoint(new Point(e.stageX,e.stageY))) {
							backwards = !backwards;
							FlxG.flash(0xffff0000, 0.5);
						}
					}
					
				}
			}
		
			if (inside(e.stageX, e.stageY, a1_sprite)) {
				if (e.type == TouchEvent.TOUCH_BEGIN || e.type == MouseEvent.MOUSE_DOWN) {
					Keys.FORCE_ACTION_1 = true;
					return;
				}
				if (e.type == TouchEvent.TOUCH_END || e.type == MouseEvent.MOUSE_UP) {
					if (!ismoveid) {
						return;		
					}else if (ismoveid) {
						Keys.FORCE_LEFT = false; Keys.FORCE_RIGHT = false; Keys.FORCE_UP = false; Keys.FORCE_DOWN = false;
						set_dpad_frame(4);
					}
				}
			} else if (inside(e.stageX, e.stageY, a2_sprite)) {
				if (e.type == TouchEvent.TOUCH_BEGIN || e.type == MouseEvent.MOUSE_DOWN) {
					Keys.FORCE_ACTION_2 = true;
					return;
				}
				if (e.type == TouchEvent.TOUCH_END || e.type == MouseEvent.MOUSE_UP) {
					if (!ismoveid) {
						return;		
					}else if (ismoveid) {
						Keys.FORCE_LEFT = false; Keys.FORCE_RIGHT = false; Keys.FORCE_UP = false; Keys.FORCE_DOWN = false;
						set_dpad_frame(4);
					}
				}
			} else if (inside(e.stageX, e.stageY, pause_sprite)) {
				if (e.type == TouchEvent.TOUCH_BEGIN || e.type == MouseEvent.MOUSE_DOWN) {
					Registry.keywatch.JUST_PRESSED_PAUSE = true;
					return;
				}
				if (e.type == TouchEvent.TOUCH_END || e.type == MouseEvent.MOUSE_UP) {
					if (!ismoveid) {
						return;		
					}else if (ismoveid) {
						Keys.FORCE_LEFT = false; Keys.FORCE_RIGHT = false; Keys.FORCE_UP = false; Keys.FORCE_DOWN = false;
						set_dpad_frame(4);
					}
				}
			}
			
			if (e.type == TouchEvent.TOUCH_END) {
				
				// if the movement caused movement via the dpad
				// then if it is released it should stop all movement
				if (no_zone.contains(e.stageX,e.stageY) || game_move_ids.indexOf(e.touchPointID) != -1 || actually_moved_ids.indexOf(e.touchPointID) != -1) {
					Keys.FORCE_DOWN = Keys.FORCE_LEFT = Keys.FORCE_RIGHT = Keys.FORCE_UP = false;
				}
				if (inside(e.stageX, e.stageY, left_sprite)) {
					Keys.FORCE_LEFT = false;
					set_dpad_frame(4);
				} else if (inside(e.stageX, e.stageY, right_sprite)) {
					Keys.FORCE_RIGHT = false;
					set_dpad_frame(4);
				} 
				if (inside(e.stageX, e.stageY, up_sprite)) {
					Keys.FORCE_UP = false;
					set_dpad_frame(4);
				} else if (inside(e.stageX, e.stageY, down_sprite)) {
					Keys.FORCE_DOWN= false;
					set_dpad_frame(4);
				} 
				var abc:int = 0;
				for (abc = 0; abc < 5; abc++) {
					if (move_ids.indexOf(e.touchPointID) != -1) {
						move_ids.splice(move_ids.indexOf(e.touchPointID), 1);
					}
					if (game_move_ids.indexOf(e.touchPointID) != -1) {
						game_move_ids.splice(game_move_ids.indexOf(e.touchPointID), 1);
					}
					if (actually_moved_ids.indexOf(e.touchPointID) != -1) {
						actually_moved_ids.splice(actually_moved_ids.indexOf(e.touchPointID), 1);
					}
					
				}
				
				return;
			}
			
		
			// Tapping - fire just-pressed event for menu, 
			// then also call handle_touch_move to start the player moving.
			if (e.type == TouchEvent.TOUCH_BEGIN  || e.type == MouseEvent.MOUSE_DOWN) {
				var et:Object = new Object();
				
				et["stageX"] = e.stageX;
				et["stageY"] = e.stageY;
				if (e.type == TouchEvent.TOUCH_BEGIN) {
					et["touchPointID"] = e.touchPointID;
					 //test android with and then without
					//et["type"] = TouchEvent.TOUCH_MOVE;
				}
				
				// Any touch that doens't start in X/C/Pause should be "able" to become 
				var doreturn:Boolean = false;
				
				if (e.type == MouseEvent.MOUSE_DOWN) {
					if (no_zone.contains(e.stageX, e.stageY)) {
						Keys.FORCE_ACTION_2 = true;
					}
				}
				
				if (inside(e.stageX, e.stageY, left_sprite)) {
					Registry.keywatch.SIG_JP_LEFT = true;
					doreturn = true;
				} else if (inside(e.stageX, e.stageY, right_sprite)) {
					Registry.keywatch.SIG_JP_RIGHT = true;
					doreturn = true;
				} 
				
				if (inside(e.stageX, e.stageY, up_sprite)) {
					Registry.keywatch.SIG_JP_UP = true;
					doreturn = true;
				} else if (inside(e.stageX, e.stageY, down_sprite)) {
					Registry.keywatch.SIG_JP_DOWN = true;
					doreturn = true;
				} 
				
				// If it starts in nothing, then it can become a movement
				if (e.type == TouchEvent.TOUCH_BEGIN) {
					if (!no_zone.contains(e.stageX, e.stageY)) {
						doreturn = true;
					}
					if (doreturn) {
						if (allow_dpad_move) {
							move_ids.push(e.touchPointID);
							handle_touch_move(et);
						}
						et = null;
						return;
					}
					if (allow_game_move && no_zone.contains(e.stageX, e.stageY)) {
						move_ids.push(e.touchPointID);
						game_move_ids.push(e.touchPointID);
						move_from_touching_game_area(e.stageX, e.stageY);
					}
				}
				et = null;
				return;
			}
		}
		public var move_ids:Array = new Array();
		public var game_move_ids:Array = new Array();
		public var actually_moved_ids:Array = new Array();
		public static function force_window(sclfctr:int):void {
			force_scale = true;
			scale_factor = sclfctr;
			scale_ctr = 0;
		}
	
		public function resize():void {
			var ratio:Number;
			var ssp:int;
			
			if (NativeApplication.nativeApplication.activeWindow == null) return;
			
			if (!did_init_window_fix) {
				did_init_window_fix = true;
				NativeApplication.nativeApplication.activeWindow.width += frame_x_px;
				NativeApplication.nativeApplication.activeWindow.height += frame_y_px;
			}
			
			if (scale_factor <= 0) {
				scale_factor = 3;
			}
			switch (scale_ctr) {
				case 1: //Windowed
					
					ratio = scale_factor / 3;
					stage.displayState = StageDisplayState.NORMAL;
					NativeApplication.nativeApplication.activeWindow.width = int(480 * ratio) + frame_x_px;
					NativeApplication.nativeApplication.activeWindow.height = int(540 * ratio) + frame_y_px;
					Preloader.display.scaleX = ratio;
					Preloader.display.scaleY = ratio;
					x = y = 0;
					
					break;
				case 2: // Fullscreen integer scaling
					ratio = scale_factor / 3;
					// Don't scale past the size of screen
					stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
					Preloader.display.scaleX = ratio;
					Preloader.display.scaleY = ratio;
					ssp = (Capabilities.screenResolutionX - (480 * ratio)) / 2;
					x = ssp / ratio;
					ssp = (Capabilities.screenResolutionY - (540 * ratio)) / 2;
					y = ssp / ratio;
					full_scale_offset.x = x;
					full_scale_offset.y = y;
					
					break;
				case 3: // Stretched proportionaly (full screen)
					stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
					if (stage.fullScreenHeight > stage.fullScreenWidth) {
						ratio = Capabilities.screenResolutionX / 480;
						ssp = (Capabilities.screenResolutionY - (540 * ratio)) / 2;
						x = 0;
						y = ssp / ratio;
						is_landscape = false;
					} else {
						ratio = Capabilities.screenResolutionY / 540;
						ssp = (Capabilities.screenResolutionX - (480 * ratio)) / 2; //Screen-space pixels to move to the right
						x = ssp / ratio; // In stage-space, only move by enough pixels that will make everything look okay when it's scaled to screen space
						y = 0;
						is_landscape = true;
					}
					Preloader.display.scaleX =  Preloader.display.scaleY = ratio; // For some reason this scale value gets set or something if I do it earlier. oh well!
					full_scale_offset.x = x;
					full_scale_offset.y = y;
					scale_ctr = 0;
					break;
			}
		}
		public function debug_mode():void {
			Registry.inventory[0] = true; //broom
			Registry.inventory[1] = true; // jump
			Registry.inventory[2] = true; //transfomrer
			Registry.inventory[4] = true; //widen
			Registry.inventory[5] = true; //lengthe
			Registry.inventory[6] = true;
			Registry.inventory[7] = true;
			Registry.inventory[8] = true;
			//Registry.inventory[Registry.IDX_BOX] = true;
			Registry.bound_item_1 = "BROOM";
			Registry.bound_item_2 = "JUMP";
			Registry.GE_States[Registry.GE_ENTERED_NEXUS_ONCE] = true;
			Registry.CUR_HEALTH =12;
			Registry.MAX_HEALTH = 12;
		}
		
		

		
		
		private static function make_play_or_roam_state():Class
		{
			Registry.set_is_playstate(Registry.CURRENT_MAP_NAME);
			var state:Class;
			if (Registry.is_playstate) {
				state = PlayState as Class;
			} else {
				state = RoamState as Class;
			}
			return state;
		}
		
		//private function reposition_ui():void 
		//{
			//var dead_space_l:int = left_sprite.x + left_sprite.width;
			//var dead_space_w:int = right_sprite.x - (left_sprite.x + left_sprite.width);
			//var dead_space_h:int = down_sprite.y - (up_sprite.y + up_sprite.height);
			//var dead_space_top:int = up_sprite.y + up_sprite.height;
			//
			// Center the circle icon in the dead spot.
			///*if (dead_space_w - icon_dpad.width < 0) {
				//icon_dpad.x = dead_space_l;
			//} else {
				//icon_dpad.x = dead_space_l + (dead_space_w - icon_dpad.width) / 2;
			//}*/
			//icon_dpad.x = dead_space_l + (dead_space_w - icon_dpad.width) / 2;
			//icon_dpad.y = (stage.stageHeight - 144 ) / 2; 
			//icon_dpad.y = (stage.stageHeight - (icon_dpad.height)) / 2;
			//
			//
			///*if (dead_space_h - icon_dpad.height < 0) {
				//icon_dpad.y = dead_space_top;
			//} else {
				//icon_dpad.y = dead_space_top + (dead_space_h - icon_dpad.height) / 2;
			//}*/
			//
			// Stick directions around it
			//
			//var W:int = a1_sprite.width + a2_sprite.width; // well, in theory
			//
			//icon_x.y = a2_sprite.y + (a2_sprite.height - icon_x.height);
			//icon_c.y = a2_sprite.y + (a2_sprite.height - icon_x.height);
			//if (Registry.GE_States[Registry.GE_MOBILE_IS_XC]) {
				//icon_x.x = a2_sprite.x + a2_sprite.width - icon_x.width - 15;
				//icon_c.x = a1_sprite.x + 15;
				//icon_x.x = a2_sprite.x + (((W/2)  - icon_x.width) / 2);
				//icon_c.x = icon_x.x + (W / 2);
			//} else {
				//icon_c.x = a1_sprite.x + (((W / 2) - icon_x.width) / 2);
				//icon_x.x = icon_c.x + (W / 2);
				//icon_x.x = a2_sprite.x + 15;
				//icon_c.x = a1_sprite.x + a1_sprite.width - icon_c.width - 15;
			//}
			//
			// If scaling is different, move them a bit more
			//
			//
			//icon_pause.x = pause_sprite.x + (pause_sprite.width - icon_pause.width) / 2;
			//icon_pause.y = pause_sprite.y + (pause_sprite.height - icon_pause.height) / 2;
		//}
		
		public var addedBG:Boolean = false;
		private function update_not_mobile():void 
		{
			if (is_ouya) {
				if (!did_mobile_setup) {
					
				if (stage != null) {
					
					
					
					if (stage.fullScreenWidth >= stage.fullScreenHeight) {
						ratio = int(3 * (stage.fullScreenHeight / 540.0)) / 3.0;
						
					} else {
						var maybe_x:Number = int(3 * (stage.fullScreenWidth / 480.0)) / 3.0;
						var maybe_y:Number= int(3 * (stage.fullScreenHeight / 540.0)) / 3.0;
						ratio = maybe_x < maybe_y ? maybe_x : maybe_y;
						
						
					}
					
					Preloader.display.scaleX = Preloader.display.scaleY = ratio;
					var ssp:int = 0;
					ssp = (stage.fullScreenWidth - (480 * ratio)) / 2;
					x = ssp / ratio;
					ssp = (stage.fullScreenHeight - (540 * ratio)) / 2;
					y = ssp / ratio;
					did_mobile_setup = true;
				}
				}
				return;
				
			}
			
			
			if (!addedBG) {
				addedBG = true;
				var _b:Bitmap = new Bitmap(new BitmapData(Capabilities.screenResolutionX/10, Capabilities.screenResolutionY/10, false, 0xFF000000));
				_b.scaleX = 11;
				_b.scaleY = 11;
				stage.addChildAt(_b, 0);
			}
			
			// Hitting "ESC" windows the screen. Make sre the game resizes accordingly 
			if (stage.displayState == "normal") { //windowed 
				if (force_scale == false && scale_ctr != 1) {
					force_scale = true;
					scale_ctr = 0;	
				}
				if (is_test) {
					for (var poop:int = 0; poop < Registry.Nexus_Door_State.length; poop++) {
						//Registry.Nexus_Door_State[poop] = true;
					}	
				}
			} else if (scale_ctr == 0) { //strethced fullscreen
				x = full_scale_offset.x;
				y = full_scale_offset.y;
			} else if (scale_ctr == 2) { //int scaled FS
				x = full_scale_offset.x;
				y = full_scale_offset.y;
			}	
		
		
			if (FlxG.keys.justPressed("F4") || !did_init_fullscreening || force_scale) {
				force_scale = false;
				if (false == did_init_fullscreening) {
					scale_ctr++;
					scale_ctr = 1; // Forc einteeer scalegin
					did_init_fullscreening = true;
					if (stage.fullScreenHeight < stage.fullScreenWidth) {
						scale_factor = int(stage.fullScreenHeight / 180);
					} else {
						scale_factor = int(stage.fullScreenWidth / 160);
					}
				}
				scale_ctr++;
				resize();
			}
		}
		
		private function update_fuck_it():void 
		{
			/*
			if (Achievements.Steamworks != null && Achievements.Steamworks.isReady) {
				if (FlxG.keys.ONE && FlxG.keys.justPressed("SPACE")) {
					Achievements.Steamworks.setAchievement(Achievements.achvname[Achievements.A_GET_BROOM]);
				}
				
				if (FlxG.keys.TWO && FlxG.keys.justPressed("SPACE")) {
					Achievements.Steamworks.clearAchievement(Achievements.achvname[Achievements.A_GET_BROOM]);
				}
				
				if (FlxG.keys.THREE && FlxG.keys.justPressed("SPACE")) {
					Achievements.Steamworks.clearAchievement(Achievements.achvname[Achievements.A_GET_BROOM]);
					Achievements.Steamworks.clearAchievement(Achievements.achvname[Achievements.A_DEFEAT_BRIAR]);
					Achievements.Steamworks.clearAchievement(Achievements.achvname[Achievements.A_GET_48_CARDS]);
					Achievements.Steamworks.clearAchievement(Achievements.achvname[Achievements.A_GET_WINDMILL_CARD]);
					Achievements.Steamworks.clearAchievement(Achievements.achvname[Achievements.A_100_PERCENT_ANY_TIME]);
					Achievements.Steamworks.clearAchievement(Achievements.achvname[Achievements.A_100_PERCENT_SUB_3_HR]);
				}
			}
			*/
			
			if (FlxG.keys.justPressed("R")) {
				for (var y:int = 36; y < 48; y++) {
					Registry.card_states[y] = 1;
					Registry.nr_growths++;
				}
			}
			
			if (FlxG.keys.justPressed("Q")) {
				for (var xx:int = 0; xx < 36; xx++) {
					Registry.card_states[xx] = 1;
					Registry.nr_growths++;
				}
				Registry.card_states[Registry.CARD_GOLDMAN_IDX] = 1;
				Registry.nr_growths++;
				
				Registry.inventory[Registry.IDX_TRANSFORMER] = true;
				Registry.inventory[Registry.IDX_WIDEN] = true;
				Registry.inventory[Registry.IDX_BROOM] = true;
				Registry.inventory[Registry.IDX_LENGTHEN] = true;
				Registry.inventory[Registry.IDX_JUMP] = true;
				
				Registry.MAX_HEALTH = 16;
				
			}
			
			if (FlxG.keys.justPressed("S")) {
				for (var i:int = 11; i <= Registry.IDX_WHITE; i++) {
					Registry.inventory[i] = true;
				}
			}
			
			if (FlxG.keys.justPressed("W")) {
				Registry.playtime = 3 * 60 * 59;
			}
		}
		
		private function fit_game_zone():void 
		{
			return;
			var smaller:int = stage.stageHeight < stage.stageWidth ? stage.stageHeight : stage.stageWidth;
			if (oriented_landscape) {
				
				ratio = smaller / 540.0;
				x = (stage.stageWidth - 480 * ratio) / 2;
			} else if (oriented_portrait) {
				ratio = smaller / 480.0;
				x = 0;
			}
			
			x /= ratio; // cause the "unscaled coords" don't change with scaling
			
			Preloader.display.scaleY = ratio;
			Preloader.display.scaleX = ratio;
		}
		
		private function update_controller():void 
		{
			if (IS_WINDOWS && Main.joy != null) {
				if (false == Keys.has_joypad  && Main.joy.exists) {
					if (Main.joy.getTotal() > 0) {
						trace("JOYPAD DETECTED!");
						Keys.has_joypad = true;
						Keys.init_joypad();
					} else {
						trace("NO JOYPAD DETECTED!");
						Main.joy.exists = false;
					}
				}
			
				// Handle controller connects/disconnects in Windows
				win_joy_remove_timer -= FlxG.elapsed;
				if (win_joy_remove_timer < 0) {
					win_joy_remove_timer = 1.5;
					if (Keys.has_joypad) {
						if (Main.joy.getTotal() < 1) {
							trace("JOYPAD DISCONNECTED");
							Keys.has_joypad = false;
							Keys.FORCE_PAUSE = true;
						}
					} else {
						if (Main.joy.getTotal() > 0) {
							// Only re-activate controller if
							// we've configured, to not confuse user
							trace("JOYPAD RECONNECTED");
							if (Registry.GE_States[Registry.GE_DID_JOYPAD_CONFIG_ONCE]) {
								Main.joy.exists = true;
							}
						}
					}
				}
			}
			
			if (IS_MAC && Main.mac_joy_manager != null) {
				if (false == Keys.has_joypad && Main.macmanexists) {
					if (Main.mac_joy_manager.numberOfJoysticks() > 0 && Main.mac_joy_manager.joysticks[0] != null) {
						trace("JOYPAD DETECTED!");
						Keys.has_joypad = true;
						Keys.init_joypad();
					} else {
						trace("NO JOYPAD DETECTED!");
						Main.macmanexists = false;
					}
				}
				
				win_joy_remove_timer -= FlxG.elapsed;
				if (win_joy_remove_timer < 0) {
					win_joy_remove_timer = 1.5;
					if (Keys.has_joypad) {
						if (Main.mac_joy_manager.numberOfJoysticks() < 1) {
							trace("JOYPAD DISCONNECTED");
							Keys.has_joypad = false;
							Keys.FORCE_PAUSE = true;
						}
					} else {
						if (Main.mac_joy_manager.numberOfJoysticks() > 0) {
							// Only re-activate controller if
							// we've configured, to not confuse user
							trace("JOYPAD RECONNECTED");
							//if (Registry.GE_States[Registry.GE_DID_JOYPAD_CONFIG_ONCE]) {
								for (var fuckme:int = 0; fuckme < Main.mac_joy_manager.joysticks.length; fuckme++) {
									if (Main.mac_joy_manager.joysticks[fuckme] != null) {
										Main.mac_joy_manager.joysticks[0] = Main.mac_joy_manager.joysticks[fuckme];
										break;
									}
								}
								Main.macmanexists = true;
							//}
						}
					}
				}
				
			}
		}
		
		public function resize_mobile_game():void {
			
			trace("resize Scale ctr", Intra.scale_ctr);
			trace("fit: ", Intra.SCALE_TYPE_FIT);
			var l:int;
			var s:int;
			if (stage.stageWidth > stage.stageHeight) {
				l = stage.stageWidth;
				s = stage.stageHeight;
			} else {
				l = stage.stageHeight;
				s = stage.stageWidth;
			}
			
			
			if (Intra.scale_ctr == Intra.SCALE_TYPE_FIT) {
				if (oriented_portrait) {
					Main.ui_offsets.scale_portrait_game = Math.min((2 * l / 3) / 480.0, s / 480.0);
				} else {
					Main.ui_offsets.scale_landscape_game =  s / 540.0;
				}
			} else {
				if (oriented_portrait) {
					Main.ui_offsets.scale_portrait_game = int(3 * Math.min((2 * l / 3) / 480.0, s / 480.0)) / 3.0;
				} else {
					Main.ui_offsets.scale_landscape_game = int(3 * (s / 540.0)) / 3.0;	
				}
			}
			
			if (oriented_portrait) {
				Preloader.display.scaleY = Main.ui_offsets.scale_portrait_game;
				Preloader.display.scaleX = Main.ui_offsets.scale_portrait_game;
				Main.ui_offsets.portrait_game.x = (s - 480.0 * Main.ui_offsets.scale_portrait_game) / 2;
				Main.ui_offsets.portrait_game.x /= Main.ui_offsets.scale_portrait_game;
				Main.ui_offsets.portrait_game.y = 0;
			} else {
				Preloader.display.scaleY = Main.ui_offsets.scale_landscape_game;
				Preloader.display.scaleX =  Main.ui_offsets.scale_landscape_game;
				Main.ui_offsets.landscape_game.x = (l - 480.0 * Main.ui_offsets.scale_landscape_game) / 2;
				Main.ui_offsets.landscape_game.x /= Main.ui_offsets.scale_landscape_game; // ???
				Main.ui_offsets.landscape_game.y = (s - 540.0 * Main.ui_offsets.scale_landscape_game) / 2;
				Main.ui_offsets.landscape_game.y /= Main.ui_offsets.scale_landscape_game;
			}
			set_no_zone();
			
			position_bars();
		}
		
		private static var thumb_data:Bitmap;
		private function position_ui():void 
		{
			dpad_data = new embed_mobile_dpad;
			x_data = new embed_mobile_x;
			c_data = new embed_mobile_c;
			menu_data = new embed_mobile_pause;
			thumb_data = new embed_thumb;
			Main.ui_offsets.scale_landscape_c_a2 = Main.max_uo.scale_landscape_c_a2;
			
			Main.ui_offsets.scale_landscape_x_a1 = Main.max_uo.scale_landscape_x_a1;
			Main.ui_offsets.scale_landscape_pause = Main.max_uo.scale_landscape_pause;
			Main.ui_offsets.scale_landscape_dpad = Main.max_uo.scale_landscape_dpad;
			Main.ui_offsets.scale_portrait_c_a2 = Main.max_uo.scale_portrait_c_a2;
			Main.ui_offsets.scale_portrait_x_a1 = Main.max_uo.scale_portrait_x_a1;
			Main.ui_offsets.scale_portrait_pause = Main.max_uo.scale_portrait_pause;
			Main.ui_offsets.scale_portrait_dpad = Main.max_uo.scale_portrait_dpad;
			
			if (icon_c != null) {
				stage.removeChild(icon_c);
				stage.removeChild(icon_pause);
				stage.removeChild(icon_x);
				stage.removeChild(icon_thumb);
				stage.removeChild(icon_dpad);
			}
			
			function scaleBitmapData(bitmapData:BitmapData, scale:Number):BitmapData {
				scale = Math.abs(scale);
				var width:int = (bitmapData.width * scale) || 1;
				var height:int = (bitmapData.height * scale) || 1;
				var transparent:Boolean = true;
				var result:BitmapData = new BitmapData(width, height, transparent,0x00000000);
				var matrix:Matrix = new Matrix();
				matrix.scale(scale, scale);
				result.draw(bitmapData, matrix);
				return result;
			}
			if (oriented_landscape) {
				Preloader.display.scaleY = Main.ui_offsets.scale_landscape_game;
				Preloader.display.scaleX = Main.ui_offsets.scale_landscape_game;
				dpad_data = new Bitmap(scaleBitmapData(dpad_data.bitmapData, Main.ui_offsets.scale_landscape_dpad));
				c_data = new Bitmap(scaleBitmapData(c_data.bitmapData, Main.ui_offsets.scale_landscape_c_a2));
				x_data =  new Bitmap(scaleBitmapData(x_data.bitmapData, Main.ui_offsets.scale_landscape_x_a1));
				menu_data = new Bitmap( scaleBitmapData(menu_data.bitmapData, Main.ui_offsets.scale_landscape_pause));
				thumb_data = new Bitmap(scaleBitmapData(thumb_data.bitmapData, Main.ui_offsets.scale_landscape_dpad*1.5));
				
				icon_dpad = new Bitmap(new BitmapData(144*Main.ui_offsets.scale_landscape_dpad, 144*Main.ui_offsets.scale_landscape_dpad));
				icon_c = new Bitmap(new BitmapData(48*Main.ui_offsets.scale_landscape_c_a2, 96*Main.ui_offsets.scale_landscape_c_a2));
				icon_x = new Bitmap(new BitmapData(48*Main.ui_offsets.scale_landscape_x_a1, 96*Main.ui_offsets.scale_landscape_x_a1));
				icon_pause = new Bitmap(new BitmapData(96 * Main.ui_offsets.scale_landscape_pause, 48 * Main.ui_offsets.scale_landscape_pause));
				icon_thumb = new Bitmap(new BitmapData((icon_dpad.width*1.5)/2, (icon_dpad.height*1.5)/2));
				
				icon_dpad.x = Main.ui_offsets.landscape_dpad.x;
				icon_dpad.y = Main.ui_offsets.landscape_dpad.y;
				
				icon_c.x = Main.ui_offsets.landscape_c_a2.x;
				icon_c.y = Main.ui_offsets.landscape_c_a2.y;
				
				icon_x.x = Main.ui_offsets.landscape_x_a1.x;
				icon_x.y = Main.ui_offsets.landscape_x_a1.y;
				
				icon_pause.x = Main.ui_offsets.landscape_pause.x;
				icon_pause.y = Main.ui_offsets.landscape_pause.y;
			} else {
				Preloader.display.scaleY = Main.ui_offsets.scale_portrait_game;
				Preloader.display.scaleX = Main.ui_offsets.scale_portrait_game;
				dpad_data = new Bitmap(scaleBitmapData(dpad_data.bitmapData, Main.ui_offsets.scale_portrait_dpad));
				c_data = new Bitmap(scaleBitmapData(c_data.bitmapData, Main.ui_offsets.scale_portrait_c_a2));
				x_data =  new Bitmap(scaleBitmapData(x_data.bitmapData, Main.ui_offsets.scale_portrait_x_a1));
				menu_data = new Bitmap( scaleBitmapData(menu_data.bitmapData, Main.ui_offsets.scale_portrait_pause));
				
				thumb_data = new Bitmap(scaleBitmapData(thumb_data.bitmapData, Main.ui_offsets.scale_portrait_dpad*1.5));
				icon_dpad = new Bitmap(new BitmapData(144*Main.ui_offsets.scale_portrait_dpad, 144*Main.ui_offsets.scale_portrait_dpad));
				icon_c = new Bitmap(new BitmapData(48*Main.ui_offsets.scale_portrait_c_a2, 96*Main.ui_offsets.scale_portrait_c_a2));
				icon_x = new Bitmap(new BitmapData(48*Main.ui_offsets.scale_portrait_x_a1, 96*Main.ui_offsets.scale_portrait_x_a1));
				icon_pause = new Bitmap(new BitmapData(96*Main.ui_offsets.scale_portrait_pause, 48*Main.ui_offsets.scale_portrait_pause));
				icon_thumb = new Bitmap(new BitmapData((icon_dpad.width*1.5)/2, (icon_dpad.height*1.5)/2));
				
				icon_dpad.x = Main.ui_offsets.portrait_dpad.x;
				icon_dpad.y = Main.ui_offsets.portrait_dpad.y;
				
				icon_c.x = Main.ui_offsets.portrait_c_a2.x;
				icon_c.y = Main.ui_offsets.portrait_c_a2.y;
				
				icon_x.x = Main.ui_offsets.portrait_x_a1.x;
				icon_x.y = Main.ui_offsets.portrait_x_a1.y;
				
				icon_pause.x = Main.ui_offsets.portrait_pause.x;
				icon_pause.y = Main.ui_offsets.portrait_pause.y;
			}
			
			// okay fuck me
				if (icon_pause.y + icon_pause.height > stage.stageHeight) {
					var diffffff:int = stage.stageHeight - (icon_pause.y + icon_pause.height);
					icon_pause.y += diffffff;
				}
			
			stage.addChild(icon_c);
			stage.addChild(icon_pause);
			stage.addChild(icon_x);
			stage.addChild(icon_dpad);
			stage.addChild(icon_thumb);
			
			icon_c_frame = icon_dpad_frame = icon_x_frame = icon_menu_frame = -1;
			icon_dpad.alpha = 0.5;
			icon_c.alpha = 0.5;
			icon_x.alpha = 0.5;
			icon_pause.alpha = 0.5;
			set_dpad_frame(4);
			set_button_frame(0);
			set_button_frame(1);
			set_button_frame(2);
			set_button_frame(3);
			//icon_dpad.alpha = 0.8;
			

			set_hit_zones();
			
			set_no_zone();
			
			position_bars();
			resize_mobile_game();
			
		}
		
		private var mc_in_something:Boolean = false;
		private var mc_moving_thing:Bitmap;
		
		private function config_on_touch_up(x:int, y:int):void {
			if (oriented_landscape) {
				if (mc_moving_thing == icon_c) {
					Main.ui_offsets.landscape_c_a2.x = mc_moving_thing.x;
					Main.ui_offsets.landscape_c_a2.y = mc_moving_thing.y;
				} else if (mc_moving_thing == icon_dpad) {
					Main.ui_offsets.landscape_dpad.x = mc_moving_thing.x;
					Main.ui_offsets.landscape_dpad.y = mc_moving_thing.y;
				} else if (mc_moving_thing == icon_x) {
					Main.ui_offsets.landscape_x_a1.x = mc_moving_thing.x;
					Main.ui_offsets.landscape_x_a1.y = mc_moving_thing.y;
				} else if (mc_moving_thing == icon_pause) { 
					Main.ui_offsets.landscape_pause.x = mc_moving_thing.x;
					Main.ui_offsets.landscape_pause.y = mc_moving_thing.y;
				}
			} else {
				if (mc_moving_thing == icon_c) {
					Main.ui_offsets.portrait_c_a2.x = mc_moving_thing.x;
					Main.ui_offsets.portrait_c_a2.y = mc_moving_thing.y;
				} else if (mc_moving_thing == icon_dpad) {
					Main.ui_offsets.portrait_dpad.x = mc_moving_thing.x;
					Main.ui_offsets.portrait_dpad.y = mc_moving_thing.y;
				} else if (mc_moving_thing == icon_x) {
					Main.ui_offsets.portrait_x_a1.x = mc_moving_thing.x;
					Main.ui_offsets.portrait_x_a1.y = mc_moving_thing.y;
				} else if (mc_moving_thing == icon_pause) { 
					Main.ui_offsets.portrait_pause.x = mc_moving_thing.x;
					Main.ui_offsets.portrait_pause.y = mc_moving_thing.y;
				}
			}
			mc_moving_thing = null;
		}
		
		private function config_on_touch_move(x:int, y:int):void {
			if (mc_moving_thing == null) {
				return;
			}
			if (oriented_landscape) {
				Registry.modified_mobile_landscape = true;
			} else if (oriented_portrait) {
				Registry.modified_mobile_portrait  = true;
			}
			var l:int = stage.stageWidth >= stage.stageHeight ? stage.stageWidth : stage.stageHeight;
			var s:int = stage.stageWidth < stage.stageHeight ? stage.stageWidth : stage.stageHeight;
			var new_x:int =  x - (mc_moving_thing.width / 2);
			var new_y:int = y - (mc_moving_thing.height / 2);
			if (oriented_landscape) {
				if (new_x < 0 || new_x + mc_moving_thing.width > l || new_y < 0 || new_y + mc_moving_thing.height > s) {
					return;
				}
			} else {
				if (new_x < 0 || new_x + mc_moving_thing.width > s || new_y < 0 || new_y + mc_moving_thing.height > l) {
					return;
				}
			}
			mc_moving_thing.x = new_x;
			mc_moving_thing.y = new_y;
		}
		
		private function  config_on_touch_down (x:int, y:int):void {
			if (inside(x, y, icon_c)) {
				mc_moving_thing = icon_c;
			} else if (inside(x, y, icon_dpad)) {
				mc_moving_thing = icon_dpad;
			}  else if (inside(x, y, icon_pause)) {
				mc_moving_thing = icon_pause;
			}  else if (inside(x, y, icon_x)) {
				mc_moving_thing = icon_x;
			} else if (no_zone.contains(x, y)) {
				if (no_zone.intersects(icon_x.getRect(stage)) || no_zone.intersects(icon_c.getRect(stage)) || no_zone.intersects(icon_pause.getRect(stage)) || no_zone.intersects(icon_dpad.getRect(stage))) {
					//Registry.sound_data.player_hit_1.play();
					//return;
				}
				set_hit_zones();
				MobileConfig.done = true;
			}
			
		}
		
		private function set_hit_zones():void 
		{
			var w:int = oriented_landscape ? Main.ui_offsets.scale_landscape_dpad * 144.0 : Main.ui_offsets.scale_portrait_dpad * 144.0;
			var h:int = w;
			var w_dpad_deadzone:int = 8 * (w / 144.0);
			
			// extra move scale
			var ems:Number = 2;
			up_sprite = new Bitmap(new BitmapData(w, ems*0.8*(h - w_dpad_deadzone) / 2,true, 0xaa990000));
			down_sprite = new Bitmap(new BitmapData(w,ems*0.8*(h - w_dpad_deadzone) / 2, true, 0xaa990000));
			
			left_sprite = new Bitmap(new BitmapData(ems*0.8*0.67*(w - w_dpad_deadzone)/2,h, true, 0x66009900));
			right_sprite = new Bitmap(new BitmapData(ems*0.8*0.67*(w - w_dpad_deadzone)/2,h, true, 0x66009900));
			a2_sprite = new Bitmap(new BitmapData(icon_x.width,icon_x.height,true, 0xaaff0000));
			a1_sprite = new Bitmap(new BitmapData(icon_c.width, icon_c.height, true, 0xaa00ff00));
			pause_sprite = new Bitmap(new BitmapData(icon_pause.width, icon_pause.height, true, 0xaa00ff00));
			
			a2_sprite.x = icon_x.x; a2_sprite.y = icon_x.y;
			a1_sprite.x = icon_c.x; a1_sprite.y = icon_c.y;
			pause_sprite.x = icon_pause.x; pause_sprite.y = icon_pause.y;
			
			left_sprite.x = icon_dpad.x - left_sprite.width/4 - 2; left_sprite.y = icon_dpad.y;
			up_sprite.x = icon_dpad.x; up_sprite.y = icon_dpad.y - 2 - up_sprite.height/2;
			right_sprite.x = icon_dpad.x + 2 + icon_dpad.width - (3*right_sprite.width/4); right_sprite.y = icon_dpad.y;
			down_sprite.x = icon_dpad.x; down_sprite.y = icon_dpad.y + 2 + icon_dpad.height - down_sprite.height/2;
		}
		
		private function position_bars():void 
		{
			if (left_bar != null) {
				stage.removeChild(left_bar);
			}
			if (right_bar != null) {
				stage.removeChild(right_bar);
			}
			left_bar = new Bitmap(new BitmapData(4, no_zone.height + 2));
			right_bar = new Bitmap(new BitmapData(4, no_zone.height + 2));
			
			var left_bar_data:Bitmap  = new embed_bar_left;
			var right_bar_data:Bitmap = new embed_bar_right;
				
			var r:Rectangle = new Rectangle(0, 0, 4, 2);
			var p:Point = new Point(0, 0);
			
			while (p.y + 2 <= left_bar.height) {
				left_bar.bitmapData.copyPixels(left_bar_data.bitmapData,r,p)
				p.y += 2;
			}
			p.y = 0;	
			while (p.y + 2 <= right_bar.height) {
				right_bar.bitmapData.copyPixels(right_bar_data.bitmapData, r, p);
				p.y += 2;
			}
			left_bar.x = no_zone.x - 4;
			left_bar.y = right_bar.y = no_zone.y;
			right_bar.x = (no_zone.x + no_zone.width);
			stage.addChildAt(left_bar, 1);
			stage.addChildAt(right_bar, 2);
		}
		
		private function set_no_zone():void 
		{
			if (oriented_landscape) {
				no_zone = new Rectangle(Main.ui_offsets.landscape_game.x * Main.ui_offsets.scale_landscape_game, Main.ui_offsets.landscape_game.y * Main.ui_offsets.scale_landscape_game, 480 * Main.ui_offsets.scale_landscape_game, 540 * Main.ui_offsets.scale_landscape_game);
			} else {
				no_zone = new Rectangle(Main.ui_offsets.portrait_game.x * Main.ui_offsets.scale_portrait_game, Main.ui_offsets.portrait_game.y * Main.ui_offsets.scale_portrait_game, 480 * Main.ui_offsets.scale_portrait_game, 540 * Main.ui_offsets.scale_portrait_game);
			}
		}
		
		private function move_from_touching_game_area(x:int,y:int):void 
		{
			Keys.FORCE_DOWN = Keys.FORCE_RIGHT = Keys.FORCE_LEFT = Keys.FORCE_UP = false;
			var regx:int = 0; var regy:int = 0; // Relative to topleft corner of 10x10 game area
			var xoff:Number = (x - no_zone.x); // relative to player, up-y is positive
			xoff *= (1 / Preloader.display.scaleX);
			xoff /= 3;
			regx = xoff;
			xoff -= Registry.PLAYER_X;
			var yoff:Number =  ((y - no_zone.y));
			yoff *= (1 / Preloader.display.scaleY);
			yoff /= 3;
			yoff -= 20;
			regy = yoff;
			yoff -= Registry.PLAYER_Y;
			yoff *= -1;
			if (Math.abs(xoff) < 0.0001) xoff = 0.0001;
			var slope:Number = yoff / xoff;
		
			
			if (Math.abs(yoff) < 10 && Math.abs(xoff) < 10) {
				if (regx <= 16) {
					Keys.FORCE_LEFT = true;
					return;
				} else if (regx >= 144) {
					Keys.FORCE_RIGHT = true;
					return;
				} else if (regy <= 16) {
					Keys.FORCE_UP = true;
					return;
				} else if (regy >= 144) {
					Keys.FORCE_DOWN = true;
					return;
				} else {
					Keys.FORCE_DOWN = Keys.FORCE_UP = Keys.FORCE_LEFT = Keys.FORCE_RIGHT = false;
					return;
				}
			}
			
			if (xoff >= 0 && yoff >= 0) { // Quad 1
				if (slope < .56) {
					Keys.FORCE_RIGHT = true;
				} else if (slope < 1.8) {
					Keys.FORCE_RIGHT = true;
					Keys.FORCE_UP = true;
				} else {
					Keys.FORCE_UP = true;
				}
			} else if (xoff < 0 && yoff >= 0) {
				if (slope > -.56) {
					Keys.FORCE_LEFT = true;
				} else if (slope > -1.8) {
					Keys.FORCE_LEFT = true;
					Keys.FORCE_UP = true;
				} else {
					Keys.FORCE_UP = true;
				}
			} else if (xoff < 0 && yoff < 0) {
				if (slope < .56) {
					Keys.FORCE_LEFT = true;
				} else if (slope < 1.8) {
					Keys.FORCE_LEFT = true;
					Keys.FORCE_DOWN = true;
				} else {
					Keys.FORCE_DOWN = true;
				}
			} else {
				if (slope > -.56) {
					Keys.FORCE_RIGHT = true;
				} else if (slope > -1.8) {
					Keys.FORCE_RIGHT = true;
					Keys.FORCE_DOWN = true;
				} else {
					Keys.FORCE_DOWN = true;
				}
			}
		
		}
		
		public function fuck():void {
			var d:String = stage.deviceOrientation;
			
			if (d.toLowerCase().indexOf("rotated") != -1) {
				
			}
			//StageOrientation.
		}
		
		public static var backwards:Boolean = false;
		
		// Landscape - suspend, phone is default portrait. Game turns into portrait coords.
		// Resume game in landscape, landscape event sometimes missed?
		// hack: give a timer to reorient everything after resuming :) 
		public function handle_orientation_change(e:StageOrientationEvent, force:String = ""):void {
			
			var force_landscape:Boolean = false;
			var force_portrait:Boolean = false;
			if (force.indexOf("landscape") != -1) {
				force_landscape  = true;
			} else if (force.indexOf("portrait") != -1) {
				force_portrait = true;
			}
			
			
			
			trace("orientation changed to: " + e.afterOrientation);
			if ((backwards && e.afterOrientation.toLowerCase().indexOf("rotated") == -1) || (!backwards && e.afterOrientation.toLowerCase().indexOf("rotated") != -1)) {
				oriented_portrait = false;
				oriented_landscape = true;
				//FlxG.flash(0xffff0000);
				
				Main.max_uo.set_defaults(stage.stageWidth, stage.stageHeight,stage.fullScreenWidth,stage.fullScreenHeight,oriented_landscape,oriented_portrait);
				if (Registry.modified_mobile_landscape == false) {
					Main.ui_offsets.set_defaults(stage.stageWidth, stage.stageHeight, stage.fullScreenWidth, stage.fullScreenHeight, oriented_landscape, oriented_portrait);
				}
				position_ui();
			} else if (!force_landscape && !force_portrait && e.afterOrientation.toLowerCase().indexOf("unknown") != -1) {
				return;
			} else {
				oriented_landscape = false;
				oriented_portrait = true;
				//FlxG.flash(0xff00ff00);
				Main.max_uo.set_defaults(stage.stageWidth, stage.stageHeight,stage.fullScreenWidth,stage.fullScreenHeight,oriented_landscape,oriented_portrait);
				if (Registry.modified_mobile_portrait == false) {
					Main.ui_offsets.set_defaults(stage.stageWidth, stage.stageHeight,stage.fullScreenWidth,stage.fullScreenHeight,oriented_landscape,oriented_portrait);
				}	
				position_ui();
			}
			if (!Intra.is_ios) {
				stage.displayState = StageDisplayState.NORMAL;
				t_back_dim = 0.5;
			}
			trace(stage.stageWidth, stage.stageHeight);
			trace(stage.fullScreenWidth, stage.fullScreenHeight);
			
			position_bars();
		}
		
	}
}
