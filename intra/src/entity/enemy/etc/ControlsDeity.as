package entity.enemy.etc 
{
	import data.CLASS_ID;
	import global.Keys;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	import global.Registry;
	import states.ControlsState;
	import states.PlayState;
	import flash.events.KeyboardEvent;
	import entity.player.Player;
	
	/**
	 * straightforward, an invisible event thing that
	 * lets you set hte movement controls
	 * @author Seagaia
	 */
	public class ControlsDeity extends FlxSprite 
	{//FUCK IT!!!
		
		public var cid:int = CLASS_ID.CONTROLSDEITY;
		public var xml:XML;
		public var text:FlxBitmapFont = new FlxBitmapFont(Registry.C_FONT_BLACK, 8, 8, Registry.C_FONT_BLACK_STRING, 27);
		public var state:int = 1;
		public var S_CONTROL:int = 0;
		public var control_ctr:int = 0;
		public var S_NORMAL:int = 1;
		public var normal_ctr:int = 0;
		public var S_CONTROL_2:int = 2;
		public var recent_key_code:int = 1000;
		
		public var player:Player;
		public var input:String = "  ";
		public var portal:FlxSprite = new FlxSprite(120, 100);
		public var type:int = 0;
		public var T_1:int = 0;
		public var T_2:int = 1;
		public function ControlsDeity(x:int,y:int,_xml:XML,_player:Player) 
		{
			super(x, y);
			xml = _xml;
			player = _player;
			
			makeGraphic(1, 1, 0xffffffff);
			
			FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			portal.makeGraphic(16, 16, 0xffffff00);
			portal.visible = false;
			
			if (parseInt(xml.@frame) == 1) type = T_2;
			
			if (type == T_1) {
				text.setText("                 \nMove. \n" + Registry.controls[Keys.IDX_UP] +", " + Registry.controls[Keys.IDX_DOWN]
					 + ",\n" + Registry.controls[Keys.IDX_LEFT] + ", " + Registry.controls[Keys.IDX_RIGHT] +
					 "\nESC to\nchange controls.",
					 true, 0, 0, "center", true);
				text.x = 10; 
				text.y = 24;
			} else if (type == T_2) {
				text.setText("Interact. \nUse " + Registry.controls[Keys.IDX_ACTION_1] + " or " + Registry.controls[Keys.IDX_ACTION_2]
				+ ".\nESC to \nchange controls.", true, 0, 0, "center", true);
				//text.scrollFactor = new FlxPoint(0, 0);
				text.x = 5 + 320; //hehheh
				text.y = 24;
			}
		}
		
		override public function update():void {
			super.update();
			switch (state) {
				case S_CONTROL:
					update_control();
					break;
				case S_CONTROL_2:
					update_control_2();
					break;
				case S_NORMAL:
					if (FlxG.keys.justPressed("SPACE")) {
						if (type == T_2)
							state = S_CONTROL_2;
						else 
							state = S_CONTROL;
						player.dontMove = true;
					}
					break;
			}
			
		}
		public function update_control_2():void {
			
			if (recent_key_code != 1000) {
					Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
					input = FlxG.keys.getKeyName(recent_key_code);
					trace(input);
					recent_key_code = 1000;
					if (input == "SPACE") {
						input = "  ";
						return;
					}
			}
			switch (control_ctr) {
				case 0:
					text.text = "Press what you want\nto use for\naction 1.";
					if (input != "  ") {
						if (is_valid(Keys.IDX_ACTION_1, input)) break;
						control_ctr++;
						Registry.controls[Keys.IDX_ACTION_1] = input;
					} 
					break;
				case 1:
					text.text = "Press what you want\nto use to for\n action 2\n";
					if (input != "  ") {
						if (is_valid(Keys.IDX_ACTION_2, input)) break;
						control_ctr++;
						Registry.controls[Keys.IDX_ACTION_2] = input;
					} 
					break;
				case 2:
					text.setText("Interact. \nUse " + Registry.controls[Keys.IDX_ACTION_1] + " or " + Registry.controls[Keys.IDX_ACTION_2]
				+ ".\nESC to \nchange controls.", true, 0, 0, "center", true);
					control_ctr = 0;
					state = S_NORMAL;
					player.dontMove = false;
					break;
			}
			input = "  ";
			return;
		}
		public function update_control():void {
			if (recent_key_code != 1000) {
					Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
					input = FlxG.keys.getKeyName(recent_key_code);
					trace(input);
					recent_key_code = 1000;
					if (input == "SPACE") {
						input = "  ";
						return;
					}
			}
			switch (control_ctr) {
				case 0:
					text.text = "Press what you want\nto use to move\nupwards.\n";
					if (input != "  ") {
						if (is_valid(Keys.IDX_UP, input)) break;
						control_ctr++;
						Registry.controls[Keys.IDX_UP] = input;
					} 
					break;
				case 1:
					text.text = "Press what you want\nto use to move\ndownwards.\n";
					if (input != "  ") {
						if (is_valid(Keys.IDX_DOWN, input)) break;
						control_ctr++;
						Registry.controls[Keys.IDX_DOWN] = input;
					} 
					break;
				case 2:
					text.text = "Press what you want\nto use to move\nto the left.\n";
					if (input != "  ") {
						if (is_valid(Keys.IDX_LEFT, input)) break;
						control_ctr++;
						Registry.controls[Keys.IDX_LEFT] = input;
					} 
					break;
				case 3:
					text.text = "Press what you want\nto use to move\nto the right.\n";
					if (input != "  ") {
						if (is_valid(Keys.IDX_RIGHT, input)) break;
						control_ctr++;
						Registry.controls[Keys.IDX_RIGHT] = input;
					} 
					break;
				case 4:
					text.setText("Move here with\n" + Registry.controls[Keys.IDX_UP] +", " + Registry.controls[Keys.IDX_DOWN]
						 + ",\n" + Registry.controls[Keys.IDX_LEFT] + ", " + Registry.controls[Keys.IDX_RIGHT] +
						 "\nPress ESC to set\ndifferent controls",
						 true, 0, 0, "center", true);
						control_ctr = 0;
						state = S_NORMAL;
						player.dontMove = false;
						break;
					
					
				
			}
			input = "  ";
			return;
		}
		
		public function is_valid(index:int, input:String):int {
			trace("----");
			trace("input: ", input);
			for (var i:int = 0; i < index; i++) {
				trace(Registry.controls[i]);
				if (input == "ESCAPE") return 1;
				if (Registry.controls[i] == input) return 1;
			}
			
			return 0;
		}
		public function reportKeyDown(event:KeyboardEvent):void {
			recent_key_code = event.keyCode;
		}
		
		override public function destroy():void {
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			super.destroy();
		}
	}

}