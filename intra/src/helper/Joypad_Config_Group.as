package helper 
{
	import global.Keys;
	import global.Registry;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	import states.PauseState;
	
	/**
	 * ...
	 * @author Melos Han-Tani
	 */
	public class Joypad_Config_Group extends FlxGroup 
	{
		
		public var controls:FlxBitmapFont = EventScripts.init_bitmap_font("JOYPAD CONFIG", "left", 5, 20, null, "apple_white");
		public var instructions:FlxBitmapFont = EventScripts.init_bitmap_font("h", "left", 5, 65, null, "apple_white");
		public var yesno:FlxBitmapFont = EventScripts.init_bitmap_font("Yes   No", "center", 20, 140, null, "apple_white");
		public var debugtext:FlxBitmapFont = EventScripts.init_bitmap_font(".", "left", 2, 150, null, "apple_white");
		public var selector:FlxSprite = new FlxSprite;
		
		
		public static var REAL_JOYBINDS:Array;
		private var state:int = 0;
		private var cursor_state:int = 0;
		
		private const S_DETECTED:int = 0;
		private const S_INPUT:int = 1;
		private const S_IDLE:int = -1;
		private const S_DONE:int = 2;
		private const S_TEST:int = 3;
		
		private var move_square:FlxSprite = new FlxSprite(100, 110);
		private var goal_square:FlxSprite = new FlxSprite(20, 130);
		
		private var blackscrn:FlxSprite = new FlxSprite(0, 0);
		public function Joypad_Config_Group() 
		{
			
			blackscrn.makeGraphic(160, 180, 0xff000000);
			blackscrn.scrollFactor = new FlxPoint(0, 0);
			add(blackscrn);
			add(controls);
			add(instructions);
			add(yesno);
			add(debugtext);
			
			set_instructions_text();	
			
			selector.loadGraphic(PauseState.arrows_sprite, true, false, 7, 7);
			selector.frame = 2;
			selector.scrollFactor = new FlxPoint(0, 0);
			selector.x = yesno.x - 8;
			selector.y = yesno.y;
			add(selector);
			
			move_square.scrollFactor.x = goal_square.scrollFactor.x = 0;
			move_square.scrollFactor.y = goal_square.scrollFactor.y = 0;
			move_square.makeGraphic(16, 16, 0xfff0f0f0);
			goal_square.makeGraphic(16, 16, 0xffff0000);
			add(move_square);
			add(goal_square);
			move_square.visible = goal_square.visible = false;
			
		}
		
		// keys_idx is 0 to 7
		// so earlier it was checking input_id != keys_idx
		// that person was having errors with action 1 + 2, which are keys_idx = 4 and 5
		// it wasn't detecting a duplicate when keys_idx = 5
		// they had two axes, meaning button input_id would be from 5 to ...
		// meaning the checkk is 5 != 5. his controller probably double-inputs presses?
		// this should work now..
		private function no_dups(input_id:int,keys_idx:int):Boolean {
			for (var i:int = 0; i < 8; i++) {
				if (Registry.joybinds[i] == input_id && i != keys_idx) {
					return false;
				}
			}
			return true;
		}
		private var delay:Number = 1;
		private var timeout:Number = 15;
		private var wait_time:Number = 4;
		override public function update():void 
		{
			
			// Force an exit out of the config if we d/c while configing
			if (Keys.has_joypad == false || (Intra.IS_MAC && Main.mac_joy_manager.joysticks[0] == null)) {
				state = S_DONE;
				return;
			}
			
			if (Main.mac_joy_manager != null) {
				for (var a:int = 1; a < Main.mac_joy_manager.joysticks.length; a++) {
					if (Main.mac_joy_manager.joysticks[a] != null) {
						Main.mac_joy_manager.joysticks[0] = Main.mac_joy_manager.joysticks[a];
						break;
					}
				}
			}
			
			debugtext.text = "Axes " + Keys.get_axis_stats() + "\n" + "Btns " + Keys.get_btn_stats() + "\n" + Keys.nr_axes.toString() + "/" + Keys.nr_btns.toString();
			
			if (state == S_DETECTED) {
				if (FlxG.keys.justPressed("SPACE")) {
					state = S_DONE;
					cursor_state = 0;
					selector.x -= 40;
				} else if (cursor_state == 0 && (1 == Keys.joy_any_axis() || Registry.keywatch.JP_RIGHT)) {
					cursor_state = 1;
					selector.x += 40;
					
				} else if (cursor_state == 1 &&  (-1 == Keys.joy_any_axis() || Registry.keywatch.JP_LEFT)) {
					cursor_state = 0;
					selector.x -= 40;
				} else if (Keys.joy_any_button() || FlxG.keys.any()) {
					if (Registry.keywatch.RIGHT || Registry.keywatch.LEFT) return;
					if (cursor_state == 0) {
						for (var j:int = 0; j < 8; j++) {
							Registry.joybinds[j] = 0;
						}
							
						yesno.visible = false;
						selector.visible = false;
						instructions.visible = false;
						state = S_IDLE;
						
					} else {
						trace(Registry.joybinds);
						state = S_DONE;
						cursor_state = 0;
						selector.x -= 40;
					}
				}
			} else if (state == S_IDLE) {
				controls.text = "Don't press anything.\n\nConfig starting in\n\n" + wait_time.toFixed(2);
				wait_time -= FlxG.elapsed;
				if (wait_time < 0) {
					wait_time = 4;
					controls.text = "Press input for\nUP.";
					state = S_INPUT;
				}
			} else if (state == S_INPUT) {
				
				if (delay > 0) {
					delay -= FlxG.elapsed;
					return;
				}
				
				if (Keys.joy_get_first_active_button_id() != 0 || Keys.joy_get_first_active_axis_id() != 0) {
					
					var next_id:int = Keys.joy_get_first_active_button_id();
					if (next_id == 0) {
						next_id = Keys.joy_get_first_active_axis_id();
					}
					
					debugtext.text += "(" + next_id.toString() + ")";
					
					if (cursor_state == 0) {
						if (no_dups(next_id, Keys.IDX_UP) == false) return;
						Registry.joybinds[Keys.IDX_UP] = next_id;
						controls.text = "Press input for\nRIGHT.";
					} else if (cursor_state == 1) {
						if (no_dups(next_id, Keys.IDX_RIGHT) == false) return;
						Registry.joybinds[Keys.IDX_RIGHT] = next_id;
						controls.text = "Press input for\nDOWN.";
					} else if (cursor_state == 2) {
						if (no_dups(next_id, Keys.IDX_DOWN) == false) return;
						Registry.joybinds[Keys.IDX_DOWN] = next_id;
						controls.text = "Press input for\nLEFT.";
					} else if (cursor_state == 3) {
						if (no_dups(next_id, Keys.IDX_LEFT) == false) return;
						Registry.joybinds[Keys.IDX_LEFT] = next_id;
						controls.text = "Press input for\nConfirm.";
					} else if (cursor_state == 4) {
						if (no_dups(next_id, Keys.IDX_ACTION_1) == false) return;
						Registry.joybinds[Keys.IDX_ACTION_1] = next_id;
						controls.text = "Press input for\nCancel.";
					} else if (cursor_state == 5) {
						if (no_dups(next_id, Keys.IDX_ACTION_2) == false) return;
						Registry.joybinds[Keys.IDX_ACTION_2] = next_id;
						controls.text = "Press input for\nPause.";
					} else if (cursor_state == 6) {
						if (no_dups(next_id, Keys.IDX_PAUSE) == false) return;
						Registry.joybinds[Keys.IDX_PAUSE] = next_id;
					}
					cursor_state++;
					if (cursor_state == 7) {
						cursor_state = 0;
						controls.text = "Move the white square\nto the red square\nto confirm.\n\nOr, wait for the timer\nto run out\nto rebind the controls.";
						instructions.visible = true;
						instructions.y += 24;
						
						goal_square.visible = move_square.visible = true;
						state = S_TEST; //Need to do test thing
					}
					
				}
			} else if (state == S_TEST) {
				timeout -= FlxG.elapsed;
						instructions.y = 89;
				instructions.text = timeout.toFixed(2);
				if (timeout < 10) instructions.text += " ";
				
				if (Keys.get_joy_state(Keys.IDX_ACTION_1)) {
					instructions.text += "  CONFIRM: ON\n";
				} else {
					instructions.text += "  CONFIRM: OFF\n";
				}
				
				if (Keys.get_joy_state(Keys.IDX_ACTION_2)) {
					instructions.text += "       CANCEL:  ON\n";
				} else {
					instructions.text += "       CANCEL:  OFF\n";
				}
				
				
				if (Keys.get_joy_state(Keys.IDX_PAUSE)) {
					instructions.text += "       PAUSE:   ON\n";
				} else {
					instructions.text += "       PAUSE:   OFF\n";
				}
				
				if (timeout <= 0) {
					reset_before_leave();
					state = S_DETECTED;
					return;
				}
				
				if (Registry.keywatch.LEFT) {
					move_square.velocity.x = -20;
				} else if (Registry.keywatch.RIGHT) {
					move_square.velocity.x = 20;
				} else {
					move_square.velocity.x = 0;
				}
				
				if (Registry.keywatch.UP) {
					move_square.velocity.y = -20;
				} else if (Registry.keywatch.DOWN) {
					move_square.velocity.y = 20;
				} else {
					move_square.velocity.y = 0;
				}
				
				if (move_square.overlaps(goal_square)) {
					REAL_JOYBINDS = Registry.joybinds;
					state = S_DONE;
				}
			} else if (state == S_DONE) {
				
			}
			
			super.update();
		}
		
		public function is_done():Boolean {
			if (state == S_DONE) {
				state = S_DETECTED;
				reset_before_leave();
				return true;
			}
			return false;
		}
		
		private function set_instructions_text():void 
		{
			if (Registry.GE_States[Registry.GE_DID_JOYPAD_CONFIG_ONCE] == false) {
				instructions.text = "Joypad detected for\nthe first time.\n\nConfiguration is\nnecessary!\n\nConfigure?\n(Skip w/ SPACE)";
				Registry.GE_States[Registry.GE_DID_JOYPAD_CONFIG_ONCE] = true;
			} else {
				instructions.text = "Joypad detected.\n\nReconfigure?\n(Skip w/ SPACE)\n";
			}
		
		}
		
		private function reset_before_leave():void 
		{
			timeout = 15;
			goal_square.visible = move_square.visible = false;
			move_square.velocity.x = move_square.velocity.y = 0;
			move_square.x = 100; move_square.y = 110;
			set_instructions_text();
			yesno.visible = true;
			delay = 1;
			selector.visible = true;
			instructions.y -= 24;
			controls.text = "JOYPAD CONFIG";
		}
	}

}