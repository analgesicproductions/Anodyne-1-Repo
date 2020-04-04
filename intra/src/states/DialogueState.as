package states 
{
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	/**
	 * ...
	 * @author Seagaia
	 */
	public class DialogueState extends PushableFlxState
	{
		
		public var dialogue_box:FlxSprite = new FlxSprite(0, 0);
		public var dialogue:FlxBitmapFont;
		public var dialogue_shadow:FlxBitmapFont;
		public var is_finished:Boolean = false;
		private var next_char_timer_max:Number = 0.022;
		private var next_char_timer:Number = 0.022;
		private var chunked_dialogue:Boolean = false;
		private var cur_line_nr:int = 0;
		private var cur_char_nr:int = 0;
		private var nr_lines_in_buffer:int = 0;
		private var lines:Array;
		private var Max_Lines_In_Buffer:int = 3;
		public static var Max_Line_Size:int = 21;
		
		private var s_writing:int = 0;
		private var max_lines_since_last_wait:int = 3;
		// Counter # of lines since the last time the player had a non-forced required input.
		private var lines_since_last_wait:int = 0;
		// Whether the first X lines were read. 
		private var did_initial_read:Boolean = false;
		// Whether a ^ was read, meaning the player needs to input to proceed
		private var forced_input:Boolean = false;
		
		private var s_bumping_up:int = 1;
		private var bump_timer_max:Number = 0.2;
		private var bump_timer:Number = 0.2;
		private var nr_bumps:int = 0;
		private var bump_state_ctr:int = 0;
		private var s_waiting:int = 2;
		
		private var s_done:int = 3;
		
		private var state:int = s_writing;
		
		private var base_y:int; //y-coord of the text when displayed.
		private var bumped_y:int; //y-coord of text when moving up.
		
		public var blinky_box:FlxSprite = new FlxSprite(0, 0);
		private var blinky_box_timer_max:Number = 0.4;
		private var blinky_box_timer:Number = 0.4;
		
		private static var box_align:uint = FlxObject.DOWN;
		
		[Embed (source = "../res/sprites/menu/dialogue_box.png")] public static var menu_dialogue_box:Class;
		[Embed(source = "../res/sprites/menu/menudialogue_box.png")] public static var real_menu_dialogue_Box:Class;
		[Embed (source = "../res/sprites/menu/dialogue_blinky_box.png")] public static var menu_dialogue_blinky_box:Class;
		
		public function DialogueState() 
		{
			create();
		}
		
		public function create_bitmap_text():void {
			var idx_1:int = members.indexOf(dialogue);
			var idx_2:int = members.indexOf(dialogue_shadow);
			dialogue = EventScripts.init_bitmap_font(" ", "left", dialogue_box.x + 4, dialogue_box.y + 7, null, "apple_white");
			dialogue_shadow = EventScripts.init_bitmap_font(" ", "left", dialogue_box.x + 4, dialogue_box.y + 7, null, "apple_white");
			if (idx_1 != -1 && idx_2 != -1) {
				members[idx_1] = dialogue;
				members[idx_2] = dialogue_shadow;
			}
			dialogue_shadow.customSpacingY = 2;
			dialogue.customSpacingY = 2;
			set_dialogue_box();		
		}
		override public function create():void 
		{
			dialogue_box.loadGraphic(menu_dialogue_box, false, false, 156, 44);
			add(dialogue_box);
			
			create_bitmap_text();

			add(dialogue_shadow);
			add(dialogue);
			
			// Blinky box for dialogue
			blinky_box.loadGraphic(menu_dialogue_blinky_box, true, false, 8, 8);
			blinky_box.addAnimation("a", [0], 10, true);
			blinky_box.play("a");
			
			blinky_box.visible = false;
			add(blinky_box);
			
			change_visibility(false);
			
			setAll("scrollFactor", new FlxPoint(0, 0));
			
			set_box_position(FlxObject.DOWN);
		
			
		}
		
		override public function draw():void 
		{
			super.draw();
		}
		
		public function set_dialogue_box():void {
			if (Registry.GAMESTATE != null && Registry.GAMESTATE.state == Registry.GAMESTATE.S_PAUSED) {
				dialogue.color = 0xFFFFFF;
				dialogue_shadow.color = 0x000000;
				dialogue_box.loadGraphic(real_menu_dialogue_Box, false, false, 156, 44);
			} else if (Registry.CURRENT_MAP_NAME == "TRAIN" && Registry.GAMESTATE != null) {
				dialogue.color = 0xffffff;
				
				dialogue_box.makeGraphic(156, 44, 0xff000000);
			} else {
				dialogue.color = 0xFFFFFF;
				dialogue_shadow.color = 0x000000;
				dialogue_box.loadGraphic(menu_dialogue_box, false, false, 156, 44);
			}
		}
		
		public static function set_dialogue_box_align(direction:uint):void {
			box_align = direction;
		}
		
		override public function update():void 
		{
			if (!chunked_dialogue && !is_finished) {
				set_box_position(box_align);
				lines = get_chunks(Registry.cur_dialogue);
				chunked_dialogue = true;
				did_initial_read = false;
				change_visibility(true);
				blinky_box.visible = false;
				
			}
			
			switch (state) {
				case s_writing:
					next_char_timer -= FlxG.elapsed;
					if (next_char_timer < 0) {
						next_char_timer = next_char_timer_max;
						if ( Registry.keywatch.ACTION_1 || Registry.keywatch.ACTION_2) { //impatient!!
							next_char_timer /= 2;
						}
						if (cur_line_nr == 0 && cur_char_nr == 0) {
							dialogue.text = get_next_char(lines);
						} else {
							Registry.sound_data.play_sound_group(Registry.sound_data.dialogue_blip_group);
							dialogue.text = dialogue.text + get_next_char(lines);
							if (Registry.FUCK_IT_MODE_ON) {
								for (var asdf:int = 0; asdf < 10; asdf++) {
									if (state != s_writing) break;
									dialogue.text = dialogue.text + get_next_char(lines);
								}
								
							}
						}
						
					}
					break;
				case s_bumping_up: // onnly enter this state with at least 2 or 3 lines.
					//bump
					//wait
					//bump
					//wait
					if (bump_state_ctr == 0) {
						var chunks:Array = dialogue.text.split("\n");
						dialogue.text = " \n";
						for (var i:int = 1; i < Max_Lines_In_Buffer; i++) {
							dialogue.text += chunks[i];
							dialogue.text += "\n";
						}
						dialogue.y = bumped_y;
						bump_state_ctr = 1;
					} else {
						bump_timer -= FlxG.elapsed;
						if (bump_timer < 0) {
							bump_timer = bump_timer_max;
							if (Registry.FUCK_IT_MODE_ON) {
								bump_timer = 0.01;
							}
							// Prevent empty string breaking FLxBitmapFont
							dialogue.text = dialogue.text.substring(2);
							dialogue.y = base_y;
							state = s_writing;
							bump_state_ctr = 0;
						}
					}
					break;
				case s_waiting:
					blinky_box_timer -= FlxG.elapsed;
					if (blinky_box_timer < 0) {
						blinky_box_timer = blinky_box_timer_max;
						blinky_box.visible = !blinky_box.visible;
					}
					if ( Registry.keywatch.ACTION_1 || Registry.keywatch.ACTION_2) {
						// When done
						Registry.sound_data.dialogue_bloop.play();
						if (cur_line_nr == lines.length && ( Registry.keywatch.JP_ACTION_1 || Registry.keywatch.JP_ACTION_2)) {
							is_finished = true;
							chunked_dialogue = false;
							cur_line_nr = cur_char_nr = 0;
							nr_lines_in_buffer = 0;
							blinky_box.visible = false;
							state = s_done;
							Registry.cur_dialogue = "";
							change_visibility(false);
						} else if (!forced_input && cur_line_nr != lines.length) {
							blinky_box.visible = false;
							state = s_bumping_up;
						} else if (forced_input) {
							blinky_box.visible = false;
							state = s_writing;
							forced_input = false;
						}
					}
					break;
				case s_done:
					break;
			}
		
			dialogue_shadow.x = dialogue.x;
			dialogue_shadow.y = dialogue.y + 1;
			dialogue_shadow.text = dialogue.text;
			
			
			super.update();
		}
		
		private function get_chunks(dialogue:String):Array {
			var lines:Array = new Array();
			var line:String = "";
			
			// Split on [\n!?.] 
			var punc:Array = new Array("\n", ".", "!", "。","…","？","！", "?");
		
			var punc_chunks:Array = new Array();
			// Break dialogue into chunks by punctuation. Lone newlines become whitespace
			for (var pos:int = 0; pos < dialogue.length; pos++) {
				
				
				line += dialogue.charAt(pos);
				if (punc.indexOf(dialogue.charAt(pos)) != -1) {
					if (dialogue.charAt(pos) == "\n") {
						line = line.substring(0, line.length -1);
						if (line.length == 0) {
							line = " ";
						}
					} else  {
						if (dialogue.length - 1 > pos) {
							var next_char:String = dialogue.charAt(pos +1);
							// Don't push this sentence chunk if the next character is in {.!?} , or 
							// if the next character is not whittespace.
							if (punc.indexOf(next_char) != -1 || next_char != " ") { 
								continue; //skips the pushing of current sentence
							// Double space = line break 
							} else if (next_char == " ") {
								//Skip one of the two whitespaces, and then end up pushing the line anyways
								pos++;
							}
						}
					} 
					punc_chunks.push(line);
					line = "";
				}
				
			}
			if (line != "") {
				punc_chunks.push(line);
			}
			line = "";
			
			
			var cc:Array = new Array(); // chunk chunks <_>
			for each (var chunk:String in punc_chunks) {
				// If this chunk fits, just push it into the list.
				if (chunk.length <= Max_Line_Size) {
					//Remove trailing whitespace if not a single character
					var nr_forced_breaks:int = 0;
					for (pos = 0; pos < chunk.length; pos++) {
						if (chunk.charAt(pos) == "^") {
							nr_forced_breaks++;
						}
					}
					// Prevent bitmap font error w/ empty str
					if ((chunk.charAt(0) == " " || chunk.charAt(0) == "　" )&& (chunk.length - nr_forced_breaks) > 1) {
						chunk = chunk.substring(1);
					}
					lines.push(chunk);
					continue;
				}
				/* Otherwise we gotta break it up */
				cc = chunk.split(" ");
				var cur_len:int = 0;
				for each (var c:String in cc) {
					//make a new line if the current word doesnt fit
					if (line.length + c.length + 1 > Max_Line_Size) {
						if (line.length != 0) {
							lines.push(line);
						}
						if (c.length > Max_Line_Size) {
							var intermedIdx:int = 0;
							var intermedstring:String = c;
							while (intermedstring.length > Max_Line_Size) {
								lines.push(c.substr(Max_Line_Size * intermedIdx, Max_Line_Size));
								intermedIdx++;
								intermedstring = c.substr(Max_Line_Size * intermedIdx);
							}
							line = intermedstring;
						} else {
							line = c;
						}
					} else {
						if (line.length == 0) {
							line += c;
						} else {
							line += " " + c;
						}
					}
				}
				lines.push(line);
				line = "";
			}
			
			return lines;
			
		}
		
		/* Return the next character in this line.
		 * if we reach the end, return a new line and increment
		 * the number of lines in the buffer, and change state
		 * if needed. */
		private function get_next_char(lines:Array):String {
			var line:String = lines[cur_line_nr];
			if (line.charAt(cur_char_nr) == "^") {
				cur_char_nr++;
				state = s_waiting;
				forced_input  = true;
				return "";
				// wait for input
			}
			if (cur_char_nr >= line.length) {
				cur_char_nr = 0;
				cur_line_nr++;
				nr_lines_in_buffer++;
				if (!did_initial_read) {
					if (nr_lines_in_buffer == Max_Lines_In_Buffer) {
						state = s_waiting;
						did_initial_read = true;
					} else if (cur_line_nr == lines.length) {
						state = s_waiting;
						blinky_box.visible = true;
						blinky_box_timer = blinky_box_timer_max;
					}
				} else {
					lines_since_last_wait++;
					if (lines_since_last_wait == max_lines_since_last_wait || cur_line_nr == lines.length) {
						lines_since_last_wait = 0;
						state = s_waiting;
						blinky_box.visible = true;
						blinky_box_timer = blinky_box_timer_max;
					} else {
						state = s_bumping_up;
					}
				}
				// read, read, read, wait
				// bump, read, bump, read, bump, read
				// wait
				// bump, read, bump, read
				return "\n";
			} else {
				return line.charAt(cur_char_nr++);
			}
		}
		
		private function set_box_position(position:uint):void 
		{
			if (position == FlxObject.DOWN) {
				dialogue_box.y = 180 - dialogue_box.height - 2;
			} else if (position == FlxObject.UP) {
				dialogue_box.y = 22;
			}
			
			dialogue_box.x = 2;
			
			dialogue.x = dialogue_box.x + 4;
			dialogue.y = dialogue_box.y + 7;
			if (DH.isZH()) dialogue.y = dialogue_box.y + 2;
			base_y = dialogue.y;
			bumped_y = dialogue.y - 5;
			
			blinky_box.x = dialogue_box.x + dialogue_box.width - 10;
			blinky_box.y = dialogue_box.y + dialogue_box.height - 10;
		}
		
		private function change_visibility(visible:Boolean):void {
			dialogue_shadow.visible = dialogue.visible = dialogue_box.visible = blinky_box.visible = visible;
		}
		
		override public function push(_parent:FlxState):void 
		{
			dialogue.text = ".";
			super.push(_parent);
		}
		
		public function reset():void {
			state = s_writing;
			is_finished = false;
			DH.update_current_scene_on_chunk_finish();
		
		}
	}

}