package states {
	import entity.decoration.Light;
	import global.Keys;
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	
	
	public class IntroScene extends FlxState {
		
		
		public var darkness:FlxSprite = new FlxSprite(0, 0);
		public var dialogue_state:DialogueState = new DialogueState;
		public var started_dialogue:Boolean = false;
		public var popped_dialogue:Boolean = false;
		public var c_sprite:FlxBitmapFont;
		
		public var light_timer:Number = 2;
		public function IntroScene() {
			
		}
		override public function create():void {
			
			Registry.keywatch = new Keys();
			add(Registry.keywatch);
			Registry.keywatch.visible = false;
			darkness.makeGraphic(160, 180, 0xff000000);
			
			darkness.blend = "multiply";
			add(darkness);
			//Registry.sound_data.stop_current_song();
		
			Registry.sound_data.start_song_from_title("BLANK");
			Registry.ENTRANCE_PLAYER_X = 397 - 320;
			Registry.ENTRANCE_PLAYER_Y = 107;
			Registry.CURRENT_MAP_NAME = "BLANK";
			
			c_sprite = EventScripts.init_bitmap_font(Registry.controls[Keys.IDX_ACTION_1], "center", 146, 165, null, "apple_white");
			c_sprite.color = 0xff2222;
			
		}
		
		private var t_csprite:Number = 0;
		private var c_ctr:int = 0;
		
		override public function update():void 
		{
			light_timer -= FlxG.elapsed;
			if (!started_dialogue && light_timer < 1) {
				started_dialogue = true;
				// handle edge case when we restart a new game
				// and the gamestate object isn'tnull
				if (Registry.GAMESTATE != null) Registry.GAMESTATE.dialogue_latency = -1;
				
				DH.set_scene_to_pos(DH.name_sage, DH.scene_sage_blank_intro, 0);
				DH.start_dialogue(DH.name_sage, DH.scene_sage_blank_intro, "BLANK");
				//DH.dialogue_popup("Young...^Young...^are you there?^ Wake up!");
				dialogue_state.push(this as FlxState);
				dialogue_state.blinky_box.exists = false;
				add(c_sprite);
			} else if (!started_dialogue) {
				super.update();
				return;
			}
			
				t_csprite += FlxG.elapsed;
			if (c_sprite.alive) {
				if (t_csprite > 0.6) {
					t_csprite = 0; 
					c_sprite.alive = c_sprite.visible = false;
				}
			} else {
				if (t_csprite > 0.6) {
					t_csprite = 0;
					c_sprite.visible = true;
					c_sprite.alive = true;
				}
			}
			if (Registry.keywatch.JP_ACTION_1) {
				c_ctr ++;
			}
			if (c_ctr > 3) {
				c_sprite.exists = false;
				dialogue_state.blinky_box.exists = true;
			}
			
			if (dialogue_state.is_finished) {
				DH.update_current_scene_on_chunk_finish();
				if (!popped_dialogue) {
					popped_dialogue = true;
					light_timer = 2;
					c_sprite.visible = false;
					dialogue_state.pop(this as FlxState);
				}
				if (light_timer < 0.5) {
					Registry.E_Blank_Fade = true;
					FlxG.switchState(new PlayState);
				}
			} else {
				if (FlxG.keys.any()) { // havent said to press anything yet
					Registry.keywatch.JP_ACTION_1 = true;
				}
				dialogue_state.update();
			}
			super.update();
		}
		
		override public function draw():void {
			darkness.fill(0xff000000);
			super.draw();
		}
		
		override public function destroy():void 
		{
			remove(Registry.keywatch, true);
			dialogue_state.destroy();
			dialogue_state = null;
			c_sprite = null;
			darkness = null;
			super.destroy();
		}
	}
}