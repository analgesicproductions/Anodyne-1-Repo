package global 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.system.FlxDebugger;
	//import flash.ui.GameInput;
	//import flash.events.GameInputEvent;
	//import flash.ui.GameInputControl;
	//import flash.ui.GameInputDevice;

	/* A handy dandy "sprite" that keeps track of keypresses,
	 * and allows easy, global modification of what keypresses do what
	 * (as to welcome alternate control schemes without heavy rewriting!) */
	public class Keys extends FlxSprite
	{
	
		// Read by the game for determinig actions
		public var UP:Boolean = false;
		public var DOWN:Boolean = false;
		public var LEFT:Boolean = false;
		public var RIGHT:Boolean = false;
		public var JP_RIGHT:Boolean = false;
		public var JP_LEFT:Boolean = false;
		public var JP_DOWN:Boolean = false;
		public var JP_UP:Boolean = false;
		public var JR_RIGHT:Boolean = false;
		public var JR_LEFT:Boolean = false;
		public var JR_UP:Boolean = false;
		public var JR_DOWN:Boolean = false;
        public var JUST_PRESSED_PAUSE:Boolean = false;
        public var JUST_RELEASED_PAUSE:Boolean = false;
		public var ACTION_1:Boolean = false;
		public var ACTION_2:Boolean = false;
        public var JP_ACTION_1:Boolean = false;
		public var JP_ACTION_2:Boolean = false;
		
		
		// For joypad crap
		public var ALLOW_JP_RIGHT:Boolean = false;
		public var ALLOW_JP_LEFT:Boolean = false;
		public var ALLOW_JP_DOWN:Boolean = false;
		public var ALLOW_JP_UP:Boolean = false;
        public var ALLOW_JP_ACTION_1:Boolean = false;
		public var ALLOW_JP_ACTION_2:Boolean = false;
		public var ALLOW_JP_PAUSE:Boolean = false;
		
		
		// Bools for mobile input
		public var SIG_JP_RIGHT:Boolean = false;
		public var SIG_JP_LEFT:Boolean = false;
		public var SIG_JP_DOWN:Boolean = false;
		public var SIG_JP_UP:Boolean = false;
		public static var FORCE_ACTION_1:Boolean = false;
		public static var FORCE_ACTION_2:Boolean = false;
		public static var FORCE_RIGHT:Boolean = false;
		public static var FORCE_DOWN:Boolean = false;
		public static var FORCE_UP:Boolean = false;
		public static var FORCE_LEFT:Boolean = false;
		public static var FORCE_PAUSE:Boolean = false;
		
		
		/* Index into the serialized controls array to figure out key bindings */
		public static var IDX_UP:int = 0;
		public static var IDX_DOWN:int = 1;
		public static var IDX_LEFT:int = 2;
		public static var IDX_RIGHT:int = 3;
		public static var IDX_ACTION_1:int = 4;
		public static var IDX_ACTION_2:int = 5;
		public static var IDX_PAUSE:int = 7;
		
		public function Keys() 
		{
			
			//initGameInput();
			super(-5000, 0);
		}
		
		/*
		public function initGameInput() {
			if (!gameInputInitialized) {
				gameInputInitialized = true;
				gameInput = new GameInput();
				trace("Initialized gameinput");
				gameInput.addEventListener(GameInputEvent.DEVICE_ADDED, handleDeviceAdded);
				gameInput.addEventListener(GameInputEvent.DEVICE_REMOVED, handleDeviceRemovedEvent);
			}
		}
		
		public static var gameInputDevice:GameInputDevice;
		public static var gameInput:GameInput;
		public static var gameInputExists:Boolean = false;
		public static var gameInputID:String = "";
		public static var gameInputName:String = "";
		public static var gameInputInitialized:Boolean = false;
		
		public function handleDeviceAdded(e:GameInputEvent):void {
			trace(11111);
			if (gameInputExists) return;
			gameInputDevice = e.device;
			gameInputName = gameInputDevice.name;
			gameInputID = gameInputDevice.id;
			gameInputExists = true;
			trace("Added " + gameInputName+" with ID: " + gameInputID);
		}
		
		public function handleDeviceRemovedEvent(e:GameInputEvent):void {
			
			trace("Trying to remove " + e.device.name +" with ID: " + e.device.id);
			if (e.device.name == gameInputName && e.device.id == gameInputID) {
				trace("Removed!");
				gameInputExists = false;
				gameInputDevice = null;
			} else {
				trace("Didn't remove.");
			}
		}
		*/
		
		
		public static var has_joypad:Boolean = false;
		public static var nr_axes:int = 0;
		public static var nr_btns:int = 0;
	
		
		public static function init_joypad():void {
			if (Intra.IS_WINDOWS) {
				nr_axes = Main.joy.getTotalAxes(0);
				nr_btns = Main.joy.getTotalButtons(0);
				trace("Joypad 0 has ", nr_axes, " axes ", nr_btns, " buttons");
			} else if (Intra.IS_MAC) {
				
				nr_axes = Main.mac_joy_manager.joysticks[0].axes.length;
				nr_btns = Main.mac_joy_manager.joysticks[0].buttons.length;
				trace("Joypad 0 has ", nr_axes, " axes ", nr_btns, " buttons");
			}
			if (nr_axes > 4) nr_axes = 4;
		}
		
		// Give the state of a certain control binding, based on an index into the joybinds array
		public static function get_joy_state(idx:int):Boolean {
			if (Intra.IS_WINDOWS || Intra.IS_MAC) {
				// Hacky way to ignore uninitizliaed controls
				if (Registry.joybinds[IDX_ACTION_1] == Registry.joybinds[IDX_DOWN]) {
					return false;
				}
				// axes first (one state for each dir), then buttons
				// ID is an axis state
				var id:int = Registry.joybinds[idx];
				if (Math.abs(id) - 1 < 2 * nr_axes) {
					var axis_state:Number;
					var new_id:int = Math.abs(id) - 1;
					
					if (Intra.IS_WINDOWS) {
						axis_state = Main.joy.getAxis(0, int(new_id / 2));
					} else if (Intra.IS_MAC) {
						axis_state = Main.mac_joy_manager.joysticks[0].getAxis(int(new_id / 2));
					}
					
					if (id < 0) { // Threshold is negative
						if (axis_state < -0.25) {
							return true;
						} 
					} else {
						if (axis_state > 0.25) {
							return true;
						}
					}
				} else {
					var button_state:Boolean;
					id = id - 1 - 2 * nr_axes;
					if (Intra.IS_WINDOWS) {
						return Main.joy.buttonIsDown(0, id);
					} else if (Intra.IS_MAC) {
						return Main.mac_joy_manager.joysticks[0].getButton(id);
					}
					
				}
			} else if (Intra.is_ouya) {
				//if (Main.game_input_device != null) {
					//var min:Number = Main.game_input_device.getControlAt(Registry.joybinds[idx]).minValue;
					//var max:Number = Main.game_input_device.getControlAt(Registry.joybinds[idx]).maxValue;
					//var val:Number = Main.game_input_device.getControlAt(Registry.joybinds[idx]).value;
					//
					// BLIND GUESS!!!
					//if (val > min) {
						//return true;
					//}
				//}
				//if (idx == IDX_UP) {
					//if (joypad.DPAD_UP || joypad.STICK_UP) {
						//return true;
					//}
				//} else if (idx == IDX_RIGHT) {
					//return joypad.DPAD_RIGHT || joypad.STICK_RIGHT;
				//} else if (idx == IDX_DOWN) {
					//return joypad.DPAD_DOWN || joypad.STICK_DOWN;
				//} else if (idx == IDX_LEFT) {
					//return joypad.DPAD_LEFT || joypad.STICK_LEFT;
				//} else if (idx == IDX_ACTION_1) {
					//return joypad.BUTTON_O;
				//} else if (idx == IDX_ACTION_2) {
					//return joypad.BUTTON_U;
				//} else if (idx == IDX_PAUSE) {
					//if (joypad.BUTTON_Y) {
						//return true;
					//}
				//}
				
			}
			return false;
		}
		
		public static function joy_any_button():Boolean {
			if (Intra.IS_WINDOWS) {
				for (var i:int = 0; i < nr_btns; i++) {
					if (Main.joy.buttonIsDown(0, i)) {
						return true;
					}
				}
			} else if (Intra.IS_MAC) {
				for (i = 0; i < nr_btns; i++) {
					if (Main.mac_joy_manager.joysticks[0].getButton(i)) {
						return true;
					}
				}
			}
			return false;
		}
		
		public static function joy_any_axis():int {
			if (Intra.IS_WINDOWS) {
				for (var i:int = 0; i < nr_axes; i++) {
					if (Math.abs(Main.joy.getAxis(0, i)) > 0.25) {
						if (Main.joy.getAxis(0, i) < 0) {
							return -1;
						} else {
							return 1;
						}
					}
				}
			} else if (Intra.IS_MAC) { 
				for (i = 0; i < nr_axes; i++) {
					if (Math.abs(Main.mac_joy_manager.joysticks[0].getAxis(i)) > 0.25) {
						if (Main.mac_joy_manager.joysticks[0].getAxis(i) < 0) {
							return -1;
						} else {
							return 1;
						}
					}
				}
			}
			return 0;
		}
		
		// Returns the button ID as ready for serialization (offset by 1, shifted over for being a button)
		public static function joy_get_first_active_button_id():int {
			var i:int = 0;
			if (Intra.IS_WINDOWS) {
				for (i = 0; i < nr_btns; i++) {
					if (Main.joy.buttonIsDown(0, i)) {
						return i + 1 + 2 * nr_axes;
					}
				}
			} else if (Intra.IS_MAC) {
				for (i = 0; i < nr_btns; i++) {
					if (Main.mac_joy_manager.joysticks[0].getButton(i)) {
						return i + 1 + 2 * nr_axes;
					}
				}
			}
			return 0;
		}
		
		public static function joy_get_first_active_axis_id():int {
			var i:int = 0;
			if (Intra.IS_WINDOWS) {
				for (i = 0; i < nr_axes; i++) {
					if (Math.abs(Main.joy.getAxis(0, i)) > 0.7) {
						if (Main.joy.getAxis(0, i) < 0) {
							return -(1 + i*2); // OFFSET - usually left or down
						} else {
							return 2 + i*2; // OFFSET + 1 - usually right or up
						}
					}
				}
			} else if (Intra.IS_MAC) {
				for (i = 0; i < nr_axes; i++) {
					if (Math.abs(Main.mac_joy_manager.joysticks[0].getAxis(i)) > 0.7) {
						if (Main.mac_joy_manager.joysticks[0].getAxis(i) < 0) {
							return -(1 + i * 2);
						} else {
							return 2 + i * 2;
						}
					}
				}
			}
			return 0;
		}
		
		public static function get_axis_stats():String {
			var s:String = "";
			var axis_state:Number = 0;
			for (var i:int = 0; i < nr_axes; i++) {
				
				if (Intra.IS_WINDOWS) {
					axis_state = Main.joy.getAxis(0, i);
				} else if (Intra.IS_MAC) {
					axis_state = Main.mac_joy_manager.joysticks[0].getAxis(i);
				}
				if (axis_state < -0.7) {
					s += "-";
				} else if (axis_state > 0.7) {
					s += "+";
				} else {
					s += "0";
				}
			}
			return s;
		}
		
		public static function 	get_btn_stats():String {
			var s:String = "";
			var bs:Boolean = false;
			for (var i:int = 0; i < nr_btns; i++) {
				if (Intra.IS_WINDOWS) {
					bs = Main.joy.buttonIsDown(0, i);
				} else if (Intra.IS_MAC) {
					bs = Main.mac_joy_manager.joysticks[0].getButton(i);
				}
				if (bs){
					s += "1";
				} else {
					s += "0";
				}
				if (i == 15) {
					s += "\n     ";
				}
			}
			return s;
		}
		
		
		override public function update():void {
			//if (!Intra.is_ouya) {
			UP = FlxG.keys.pressed(Registry.controls[IDX_UP]);
			DOWN = FlxG.keys.pressed(Registry.controls[IDX_DOWN]);
			LEFT = FlxG.keys.pressed(Registry.controls[IDX_LEFT]);
			RIGHT = FlxG.keys.pressed(Registry.controls[IDX_RIGHT]);
			JP_UP = FlxG.keys.justPressed(Registry.controls[IDX_UP]);
			JP_DOWN = FlxG.keys.justPressed(Registry.controls[IDX_DOWN]);
			JP_LEFT = FlxG.keys.justPressed(Registry.controls[IDX_LEFT]);
			JP_RIGHT = FlxG.keys.justPressed(Registry.controls[IDX_RIGHT]);
			
			JR_UP = FlxG.keys.justReleased(Registry.controls[IDX_UP]);
			JR_RIGHT = FlxG.keys.justReleased(Registry.controls[IDX_RIGHT]);
			JR_LEFT = FlxG.keys.justReleased(Registry.controls[IDX_LEFT]);
			JR_DOWN = FlxG.keys.justReleased(Registry.controls[IDX_DOWN]);
			

			
			JUST_PRESSED_PAUSE = FlxG.keys.justPressed(Registry.controls[IDX_PAUSE]);
			if (Registry.disable_menu) {
				JUST_PRESSED_PAUSE = false;
			}
			if (FORCE_PAUSE && false == Registry.disable_menu) {
				FORCE_PAUSE = false;
				JUST_PRESSED_PAUSE = true;
			}
			
			
			JUST_RELEASED_PAUSE = FlxG.keys.justReleased(Registry.controls[IDX_PAUSE]);
			
			JP_ACTION_1 = FlxG.keys.justPressed(Registry.controls[IDX_ACTION_1]);
			JP_ACTION_2 = FlxG.keys.justPressed(Registry.controls[IDX_ACTION_2]);
			ACTION_1 = FlxG.keys.pressed(Registry.controls[IDX_ACTION_1]);
			ACTION_2 = FlxG.keys.pressed(Registry.controls[IDX_ACTION_2]);
					
			//}
			
			
			if ((Intra.IS_WINDOWS && Main.joy != null && Keys.has_joypad) || (Intra.IS_MAC && Keys.has_joypad && Main.mac_joy_manager.joysticks[0] != null) || (0 && Intra.is_ouya)) {
				if (get_joy_state(IDX_LEFT)) {
					if (!LEFT && ALLOW_JP_LEFT) {
						JP_LEFT = true;
						ALLOW_JP_LEFT = false;
					}
					LEFT = true;
				} else {
					if (!ALLOW_JP_LEFT) {
						JR_LEFT = true;
					}
					ALLOW_JP_LEFT = true;
				}
				
				if (get_joy_state(IDX_RIGHT)) {
					if (!RIGHT && ALLOW_JP_RIGHT) {
						JP_RIGHT = true;
						ALLOW_JP_RIGHT = false;
					}
					RIGHT = true;
				} else {
					if (!ALLOW_JP_RIGHT) {
						JR_RIGHT = true;
					}
					ALLOW_JP_RIGHT = true;
				}
				
				if (get_joy_state(IDX_DOWN)) {
					if (!DOWN && ALLOW_JP_DOWN) {
						JP_DOWN = true;
						ALLOW_JP_DOWN= false;
					}
					DOWN = true;
					
				} else {
					if (!ALLOW_JP_DOWN) {
						JR_DOWN = true;
					}
					ALLOW_JP_DOWN = true;
				}
				
				if (get_joy_state(IDX_UP)) {
					if (!UP && ALLOW_JP_UP) {
						JP_UP = true;
						ALLOW_JP_UP = false;
					}
					UP = true;
				} else {
					if (!ALLOW_JP_UP) {
						JR_UP = true;
					}
					ALLOW_JP_UP = true;
				}
				
				if (get_joy_state(IDX_ACTION_1)) {
					if (!ACTION_1 && ALLOW_JP_ACTION_1) {
						JP_ACTION_1 = true;
						ALLOW_JP_ACTION_1 = false;
					}
					ACTION_1 = true;
				} else {
					ALLOW_JP_ACTION_1 = true;
				}
				
				if (get_joy_state(IDX_ACTION_2)) {
					if (!ACTION_2 && ALLOW_JP_ACTION_2) {
						JP_ACTION_2 = true;
						ALLOW_JP_ACTION_2 = false;
					}
					ACTION_2 = true;
				} else {
					ALLOW_JP_ACTION_2 = true;
				}
				
				if (get_joy_state(IDX_PAUSE)) {
					if (ALLOW_JP_PAUSE) {
						ALLOW_JP_PAUSE = false;
						JUST_PRESSED_PAUSE = true;
					}
				} else  {
					ALLOW_JP_PAUSE = true;
				}
				
					//var a:Array = new Array();
					//var asdf:int = 0;
				//for (var asdf:int = 0; asdf < nr_btns; asdf++) {
					//a.push(int(Main.joy.buttonIsDown(0, asdf)));
				//}
				//for (asdf = 0; asdf < nr_axes + 2; asdf++) {
					//a.push(Main.joy.getAxis(0, asdf));
				//}
				//trace(a);
			}
			
			if (Intra.is_ouya) {
				
				if (FORCE_ACTION_2) {
					ACTION_2 = true;
					JP_ACTION_2 = true;
					FORCE_ACTION_2 = false;
				}
			}
			if (Intra.is_mobile) {
				if (FORCE_ACTION_1) {
					ACTION_1 = true;
					JP_ACTION_1 = true;
					FORCE_ACTION_1 = false;
				}
				
				if (FORCE_ACTION_2) {
					ACTION_2 = true;
					JP_ACTION_2 = true;
					FORCE_ACTION_2 = false;
				}
				
				if (SIG_JP_DOWN) {
					SIG_JP_DOWN = false;
					JP_DOWN = true;
				}
				
				if (SIG_JP_UP) {
					SIG_JP_UP = false;
					JP_UP = true;
				}
				
				if (SIG_JP_RIGHT) {
					SIG_JP_RIGHT = false;
					JP_RIGHT = true;
				}
				
				if (SIG_JP_LEFT) {
					SIG_JP_LEFT = false;
					JP_LEFT = true;
				}
				
				if (FORCE_RIGHT) {
					RIGHT = true;
				} 
				if (FORCE_DOWN) {
					DOWN = true;
				} 
				if (FORCE_UP) {
					UP = true;
				}
				if (FORCE_LEFT) {
					LEFT = true;
				}
			}
			
			if (Intra.allow_fuck_it_mode && FlxG.keys.justPressed("SPACE")) { 
				Registry.FUCK_IT_MODE_ON = !Registry.FUCK_IT_MODE_ON;
			}
			super.update();
		}
	}

}