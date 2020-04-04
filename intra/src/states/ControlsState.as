package states 
{
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import global.Registry;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	import global.Keys;
	import org.flixel.FlxG;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Seagaia
	 */
	public class ControlsState extends PushableFlxState
	{

		[Embed (source = "../res/sprites/inventory/controls.png")] public static var S_CONTROLS:Class;
		public var bg:FlxSprite = new FlxSprite(0, 0);
		public var instruction:FlxBitmapFont;
		
		public var controls:FlxBitmapFont;
		public var i:int = 0;
		private var input:String;
		private var recent_key_code:uint = 1000;
		public var updating:Boolean = false;
		private var filler:String = "                   \n";
		public var is_blank_world:Boolean = false;
		
		public function ControlsState() {
			create();
		}
		override public function create():void {
			
			controls = EventScripts.init_bitmap_font(" ", "center", 8,16, null, "apple_white");
			instruction = EventScripts.init_bitmap_font(" ", "center", 22, 102, null, "apple_white");
			
			//instruction.setText("Press " + Registry.controls[Keys.IDX_LEFT] + "\nto set controls.\n"+Registry.controls[Keys.IDX_PAUSE]+"\n to cancel.", true, 0, 0, "center", true);
			instruction.setText(DH.lk("controls",0) + " "+Registry.controls[Keys.IDX_LEFT] + "\n"+DH.lk("controls",1)+"\n"+Registry.controls[Keys.IDX_PAUSE]+"\n "+DH.lk("controls",2), true, 0, 0, "center", true);
			instruction.x = 25; instruction.y = 102; instruction.scrollFactor = new FlxPoint(0, 0);
			bg.scrollFactor = new FlxPoint(0, 0);
			bg.x = 16;
			bg.y = 16;
			bg.loadGraphic(S_CONTROLS, false, false, 135, 125);
			
			add(bg);
			
			controls.setText(filler, true, 0, 0,  "center", true);
			controls.x = 18; controls.y = 16; controls.scrollFactor = new FlxPoint(0, 0);
			instruction.color = controls.color = 0xffffff;
			instruction.drop_shadow = controls.drop_shadow = true;
			FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			add(controls);
			add(instruction);
		}
		
		override public function destroy():void {
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			controls.destroy();
			controls = null;
			instruction.destroy();
			instruction = null;
			bg = null;
			super.destroy();
		}
		
		public function change_text():void {
			remove(controls, true);
			remove(instruction, true);
			
			controls = EventScripts.init_bitmap_font(" ", "center", 8,16, null, "apple_white");
			instruction = EventScripts.init_bitmap_font(" ", "center", 22, 102, null, "apple_white");
			
			if (DH.language_type == DH.LANG_ko) {
			instruction.setText(Registry.controls[Keys.IDX_LEFT] + "\n" + DH.lk("controls", 1) + "\n" + Registry.controls[Keys.IDX_PAUSE] + "\n " + DH.lk("controls", 2), true, 0, 0, "center", true);
				 
			} else {
			instruction.setText(DH.lk("controls", 0) + " " + Registry.controls[Keys.IDX_LEFT] + "\n" + DH.lk("controls", 1) + "\n" + Registry.controls[Keys.IDX_PAUSE] + "\n " + DH.lk("controls", 2), true, 0, 0, "center", true);
			}
			
			instruction.x = 25; instruction.y = 102; instruction.scrollFactor = new FlxPoint(0, 0);
			
			controls.setText(filler, true, 0, 0,  "center", true);
			controls.x = 18; controls.y = 16; controls.scrollFactor = new FlxPoint(0, 0);
			
			instruction.color = controls.color = 0xffffff;
			instruction.drop_shadow = controls.drop_shadow = true;
			
			add(controls);
			add(instruction);
		}
		public function reportKeyDown(event:KeyboardEvent):void {
			recent_key_code = event.keyCode;
		}
		override public function update():void {
			
			if (is_blank_world) {
				controls.setText(filler+DH.lk("controls",3)+": " + Registry.controls[Keys.IDX_UP] +
							 "\n"+DH.lk("controls",4)+": " + Registry.controls[Keys.IDX_DOWN] +
							 "\n"+DH.lk("controls",5)+": " + Registry.controls[Keys.IDX_LEFT] +
							 "\n"+DH.lk("controls",6)+": " + Registry.controls[Keys.IDX_RIGHT], true, 0, 0, "center", true);
			} else {
			
				var jump:String = "???";
				if (Registry.inventory[Registry.IDX_JUMP]) {
					jump = DH.lk("controls",7);
				}
				controls.setText(filler+DH.lk("controls",3)+": " + Registry.controls[Keys.IDX_UP] +
							 "\n"+DH.lk("controls",4)+": " + Registry.controls[Keys.IDX_DOWN] +
							 "\n"+DH.lk("controls",5)+": " + Registry.controls[Keys.IDX_LEFT] +
							 "\n"+DH.lk("controls",6)+": " + Registry.controls[Keys.IDX_RIGHT] +
							 "\n"+DH.lk("controls",8)+": " + Registry.controls[Keys.IDX_ACTION_1] +
							 "\n"+jump+": " + Registry.controls[Keys.IDX_ACTION_2] +
							 "\n"+DH.lk("controls",9)+": " + Registry.controls[Keys.IDX_PAUSE], true, 0, 0, "center", true);
			}
			
			
			if (recent_key_code != 1000) {
				if (i != 0) {
					Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
					input = FlxG.keys.getKeyName(recent_key_code);
					recent_key_code = 1000;
				}
			}
			
			if (i < 3 && FlxG.keys.justPressed("ESCAPE")) {
				updating = false;
				return;
			}
						
			if (Registry.keywatch.LEFT && (i == 0)) { 
					Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
				i += 2;
				//instruction.setText("Press key for\nUp", true, 0, 0, "center", true);
				instruction.setText(DH.lk("controls",0)+"\n"+DH.lk("controls",3), true, 0, 0, "center", true);
				recent_key_code = 1000;
				updating = true;
				return;
			}
			
			switch (i) {
				case 2:
					instruction.setText(DH.lk("controls",0)+"\n"+DH.lk("controls",3), true, 0, 0, "center", true);
					if (input != "") {
						if (is_valid(Keys.IDX_UP, input)) break;
						Registry.controls[Keys.IDX_UP] = input;
						i++;
					}
					break;
				case 3:
					instruction.setText(DH.lk("controls",0)+"\n"+DH.lk("controls",4), true, 0, 0, "center", true);
					if (input != "") {
						if (is_valid(Keys.IDX_DOWN, input)) break;
						Registry.controls[Keys.IDX_DOWN] = input;
						i++;
					}
					break;
				case 4:
					instruction.setText(DH.lk("controls",0)+"\n"+DH.lk("controls",5), true, 0, 0, "center", true);
					if (input != "") {
						if (is_valid(Keys.IDX_LEFT, input)) break;
						Registry.controls[Keys.IDX_LEFT] = input;
						i++;
					}
					break;
				case 5:
					instruction.setText(DH.lk("controls",0)+"\n"+DH.lk("controls",6),true, 0, 0, "center", true);
					if (input != "") {
						if (is_valid(Keys.IDX_RIGHT, input)) break;
						Registry.controls[Keys.IDX_RIGHT] = input;
						i++;
						if (is_blank_world) i = 10;
					}
					break;
				case 6:
					instruction.setText(DH.lk("controls",0)+"\n"+DH.lk("controls",8), true, 0, 0, "center", true);
					if (input != "") {
						if (is_valid(Keys.IDX_ACTION_1, input)) break;
						Registry.controls[Keys.IDX_ACTION_1] = input;
						i++;
					}
					break;
				case 7:
					
					var jump_2:String = "???";
					if (Registry.inventory[Registry.IDX_JUMP]) {
						jump_2 = DH.lk("controls", 7);
					}
					
					instruction.setText(DH.lk("controls",0)+"\n"+jump_2+"\n", true, 0, 0, "center", true);
					if (input != "") {
						if (is_valid(Keys.IDX_ACTION_2, input)) break;
						Registry.controls[Keys.IDX_ACTION_2] = input;
						i++;
					}
					break;
				case 8:
					i++;
					break;
				case 9:
					instruction.setText(DH.lk("controls",0)+"\n"+DH.lk("controls",9), true, 0, 0, "center", true);
					if (input != "") {
						if (is_valid(Keys.IDX_PAUSE, input)) break;
						Registry.controls[Keys.IDX_PAUSE] = input;
						i++;
					}
					break;
				case 10:
					instruction.setText(DH.lk("controls",0)+" "+Registry.controls[Keys.IDX_PAUSE]+"\n "+DH.lk("controls",11),true, 0, 0, "center", true);
					if (input != "") {
						i = 0;
						updating = false;
						instruction.setText(DH.lk("controls",0)+" " + Registry.controls[Keys.IDX_LEFT] + "\n"+DH.lk("controls",12)+"\n"
						+Registry.controls[Keys.IDX_PAUSE]+" "+DH.lk("controls",2), true, 0, 0, "left", true);
					}
					break;
			}
			input = "";
		}
		
		public function is_valid(index:int, input:String):int {
			if (index == 0) return (input == "ESCAPE") ? 1 : 0;
			for (var i:int = 0; i < index; i++) {
				if (input == "ESCAPE") return 1;
				if (Registry.controls[i] == input) return 1;
			}
			
			return 0;
		}
	}

}