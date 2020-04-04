package entity.gadget 
{
	import entity.player.Player;
	import global.Keys;
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	import states.PauseState;
	
	public class Checkpoint extends FlxSprite 
	{	
		private var player:Player;
		private var parent:*;
		private var xml:XML;
		private var did_init:Boolean = false;
		
		private var state:int;
		private var s_inactive:int = 0;
		private var s_stepped_on:int = 1;
		private var s_active:int = 2;
		private var s_dialog:int = 3;
		private var did_save:Boolean = false;
		private var did_autosave:Boolean = false;
		private var t_save:Number = 0;
		private var tm_save:Number = 0.1;
		private var saved_coords:Boolean = false;
		
		private var save_dialog_bg:FlxSprite;
		private var save_dialog_text:FlxBitmapFont;
		private var save_dialog_selector:FlxSprite;
		private var ctr:int = 0;
		
		private var autosave_anim_ctr:int = 0;
		private var autosave_started:Boolean = false;
		private var autosave_loop:Boolean = true;
		
		
		private var player_hasnt_stepped_off:Boolean = false;
		
		[Embed (source = "../../res/sprites/gadgets/checkpoint.png")] public static var checkpoint_sprite:Class;
		[Embed (source = "../../res/sprites/inventory/checkpoint_save_box.png")] public static var checkpoint_save_box_sprite:Class;
		public function Checkpoint(_player:Player,_parent:*,_xml:XML) 
		{
			player = _player;
			parent = _parent;
			xml = _xml;
			super(parseInt(xml.@x), parseInt(xml.@y));
			loadGraphic(checkpoint_sprite, true, false, 16, 16);
			if (Registry.CURRENT_MAP_NAME == "TRAIN") {
				addAnimation("inactive", [4]);
				addAnimation("stepped_on", [5,6],12);
				addAnimation("active", [5,6,7], 10, false);
			} else {
				addAnimation("inactive", [0]);
				addAnimation("stepped_on", [1, 2],12);
				addAnimation("active", [1, 2, 3], 10, false);
			}
			
			width = height = 8;
			offset.x = offset.y = 4;
			x += 4;
			y += 4;
			
			save_dialog_bg = new FlxSprite;
			save_dialog_bg.loadGraphic(checkpoint_save_box_sprite, true, false, 80, 29);
			save_dialog_bg.x = (160 - save_dialog_bg.width) / 2;
			save_dialog_bg.y = 20 + (160 - save_dialog_bg.height) / 2;
			save_dialog_bg.scrollFactor = new FlxPoint(0, 0);
			//save_dialog_text = EventScripts.init_bitmap_font("Save game?\n  Yes\n  No", "left", save_dialog_bg.x + 5, save_dialog_bg.y + 2, null, "apple_white");
			save_dialog_text = EventScripts.init_bitmap_font(DH.lk("checkpoint",0), "left", save_dialog_bg.x + 5, save_dialog_bg.y + 2, null, "apple_white");
			save_dialog_text.color = 0xffffff;
			save_dialog_text.drop_shadow = true;
			save_dialog_selector = new FlxSprite;
			save_dialog_selector.loadGraphic(PauseState.arrows_sprite, true, false, 7, 7);
			save_dialog_selector.scrollFactor = new FlxPoint(0, 0);
			save_dialog_selector.addAnimation("flash", [0, 1], 8);
			save_dialog_selector.play("flash");
			save_dialog_selector.scale.x = -1;
			
			parent.fg_sprites.add(save_dialog_bg);
			parent.fg_sprites.add(save_dialog_text);
			parent.fg_sprites.add(save_dialog_selector);
			save_dialog_bg.visible = save_dialog_text.visible = save_dialog_selector.visible =  false;
			
		}
		
		override public function update():void 
		{
			oscillate_autosave();
			if (!did_init) {
				did_init = true;
				
				if (player.overlaps(this)) {
					player_hasnt_stepped_off = true;
				}
				
				if (Registry.checkpoint.area == Registry.CURRENT_MAP_NAME && Registry.checkpoint.x == x && Registry.checkpoint.y == y) {
					play("active");
					state = s_active;
				} else {
					state = s_inactive;
					play("inactive");
				}
			}
			
			if (player_hasnt_stepped_off) {
				super.update();
				if (!player.overlaps(this)) {
					player_hasnt_stepped_off = false;
				}
				return;
			} 
			
			// Info popup
			if (!Registry.GE_States[Registry.GE_Did_A_Checkpoint]) {
				if (!Intra.is_test && EventScripts.distance(this,player) < 18) {
					Registry.GE_States[Registry.GE_Did_A_Checkpoint] = true;
					player.be_idle();
					
					//DH.dialogue_popup("While standing on a checkpoint, press " + Registry.controls[Keys.IDX_ACTION_1] + " to save your progress and set it as your respawn point if you die.");
					DH.dialogue_popup(DH.lk("checkpoint",1)+" " + Registry.controls[Keys.IDX_ACTION_1] + " "+DH.lk("checkpoint",2));
				}
			}
			
			// Do autosave if close or in same room
			//if (!did_autosave) {
				//if (Registry.autosave_on) {
					//if (Registry.is_playstate || (Math.abs(x - player.x) < 48 && Math.abs(y - player.y) < 48)) {
						//did_autosave = true;
						//autosave_started = true;
						// Make save icon appear
						//Save.save();
					//}
				//} 
			//}
			// Behavior the same otherwise
			switch (state) {
				case s_inactive:
					if (player.overlaps(this) && player.state == player.S_GROUND) {
						play("stepped_on");
						Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
						state = s_stepped_on;
					}
					break;
				case s_stepped_on:
						// Require player input to set checkpint.
						if (Registry.keywatch.JP_ACTION_1) {
							Registry.sound_data.button_down.play();
							// If this checkpoint is activated and it is not ou current one,
							// then refill the health of the palyer
							if (!(Registry.checkpoint.area == Registry.CURRENT_MAP_NAME && Registry.checkpoint.x == x && Registry.checkpoint.y == y)) {
								player.health_bar.modify_health(20);
							}
							update_global_checkpoint();
							
							// Ask the player if they want to save if autosave is not on.
							if (!Registry.autosave_on) {
								state = s_dialog;
								player.state = player.S_INTERACT;
								player.be_idle()
								save_dialog_bg.visible = save_dialog_selector.visible = save_dialog_text.visible = true;
								save_dialog_selector.x = save_dialog_text.x + 4;
								save_dialog_selector.y = save_dialog_text.y + 8;
							} else {
								
								if (Registry.is_playstate || (Math.abs(x - player.x) < 48 && Math.abs(y - player.y) < 48)) {
									did_autosave = true;
									autosave_started = true;
									// Make save icon appear
									Save.save();
								}
								
								did_save = true;
								state = s_active;
								play("active");
							}
						} else {
							if (!player.overlaps(this)) {
								state = s_inactive;
								play("inactive");
								
								if (Registry.checkpoint.area == Registry.CURRENT_MAP_NAME && Registry.checkpoint.x == x && Registry.checkpoint.y == y) {
									play("active");
								}
							}
						}
						
					break;
				case s_active:
					if (!did_save) {
						if (player.overlaps(this)) {
							play("stepped_on");
							Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
							state = s_stepped_on;
						}
					} else { // Timeout, lets you save again if you want to 
						if (!player.overlaps(this)) {
							t_save += FlxG.elapsed;
							if (t_save > tm_save) {
								t_save = 0;
								did_save = false;
							}
						}
					}
					break;
				case s_dialog:
					player.invincible = true;
					player.invincible_timer = 0.1;
					
					if (ctr == 0) {
						if (Registry.keywatch.JP_DOWN) {
							Registry.sound_data.play_sound_group(Registry.sound_data.menu_move_group);
							ctr++;
							save_dialog_selector.y += 8;
						} 
					} else {
						if (Registry.keywatch.JP_UP) {
							Registry.sound_data.play_sound_group(Registry.sound_data.menu_move_group);
							ctr--;
							save_dialog_selector.y -= 8;
						}
					}
					
					if (Registry.keywatch.JP_ACTION_1) {
						if (ctr == 0) {
							Save.save();
							autosave_started = true;
						}
						
						save_dialog_bg.visible = save_dialog_selector.visible = save_dialog_text.visible = false;
						ctr = 0;
						player.state = player.S_GROUND;
						state = s_active;
						did_save = true;
						play("active");	
					}
					//something something dialog
					break;
			}
			super.update();
		}
		
		private function update_global_checkpoint():void 
		{
			if (saved_coords) return;
			saved_coords = true;
			Registry.checkpoint.area = Registry.CURRENT_MAP_NAME; 
			Registry.checkpoint.x = x;
			Registry.checkpoint.y = y;
			trace("Check point updated: ",Registry.checkpoint.area, Registry.checkpoint.x, Registry.checkpoint.y);
		}
		
		private function oscillate_autosave():void {
			
			if (autosave_started) {
				switch (autosave_anim_ctr) {
					case 0:
							parent.autosave_icon.visible = true;
							parent.autosave_icon.alpha = 1;
							autosave_anim_ctr++;
						break;
					case 1:
						parent.autosave_icon.alpha -= (FlxG.elapsed / 3);
						if (parent.autosave_icon.alpha < 0.03) {
							parent.autosave_icon.visible = false;
							autosave_started = false;
							autosave_anim_ctr = 0;
						}
						break;
				}
			}
		}
		
		override public function destroy():void 
		{
			
			super.destroy();
			save_dialog_bg = save_dialog_selector = null;
			save_dialog_text = null;
			if (parent.autosave_icon != null) {
				parent.autosave_icon.visible = false;
			}
			
		}
		
	}

}