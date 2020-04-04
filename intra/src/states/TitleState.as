package states 
{
	import ca.wegetsignal.nativeextensions.MacJoystickManager;
	import data.SoundData;
	import entity.gadget.Button;
	import entity.interactive.npc.Shadow_Briar;
	import entity.player.HealthBar;
	import entity.player.Player;
	import flash.desktop.NativeApplication;
	import flash.filters.BlurFilter;
	import flash.net.navigateToURL;
	import global.Keys;
	import global.Registry;
	import helper.Achievements;
	import helper.DH;
	import helper.EventScripts;
	import helper.Joypad_Config_Group;
	import helper.ScreenFade;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	import flash.net.URLRequest;
	
	/**
	 * the title screen duh
	 * @author Seagaia
	 */
	public class TitleState extends FlxState 
	{
		
		private var BACK_TEXT_MOBILE:FlxBitmapFont;
		private var bg:FlxSprite = new FlxSprite(0, 0);
		private var text:FlxBitmapFont;
		private var filler:String = "        \n";
		private var version:String;
		private var version_text:FlxBitmapFont;
		private var ad_text:FlxBitmapFont;
		private var mac_text:FlxBitmapFont;
		
		private var DEBUGTEXT:FlxBitmapFont;
			
		private var selector:FlxSprite;
		
		private var keywatch:Keys = new Keys();
		
		private var state:int = 7;
		private var loaded:Boolean = false;
		private var S_NEW:int = 0;
		private var S_CONTINUE:int = 1;
		private var S_DELETE:int = 2;
		private var S_NAME_FADE:int = 3;
		private var S_NAME_BLUR:int = 4;
		private var S_CONTROLS:int = 5;
		
		private const S_BEGIN:int = 7;
		private const S_NEXUS_SCROLL:int = 6;
		private var ctr:int = 0;
		
		
		// New stuff
		
		private var black_overlay:FlxSprite;
		private var scrolly_background:FlxSprite;
		private var scrolly_background2:FlxSprite;
		private var nexus_image:FlxSprite;
		private var dark_blend:FlxSprite;
		private var glow_blend:FlxSprite;
		private var wordmark:FlxSprite;
		private var wordmark_white:FlxSprite;
		private var press_enter_sprite:FlxSprite;
		private var door_glow:FlxSprite;
		private var door_spin_1:FlxSprite;
		private var door_spin_2:FlxSprite;
		private var downsample_fade:ScreenFade;
		private var btn:FlxSprite;
		
		private var health_bar:HealthBar;
		private var status_text:FlxBitmapFont;
		private var t_briar:FlxSprite;
		private var t_young:FlxSprite;
		
		[Embed(source = "../res/title/door.png")]  public static const embed_nexus_image:Class;
		[Embed(source = "../res/title/door_glow.png")] public static const embed_door_glow:Class;
		[Embed(source = "../res/title/door_spinglow1.png")] public static const embed_spin_glow1:Class;
		[Embed(source = "../res/title/door_spinglow2.png")] public static const embed_spin_glow2:Class;
		[Embed(source = "../res/title/press_enter.png")]  public static const embed_press_enter:Class;
		[Embed(source = "../res/title/title_bg.png")] public static const embed_title_bg:Class;
		[Embed(source = "../res/title/title_overlay1.png")] public static const embed_overlay_dark:Class;
		[Embed(source = "../res/title/title_overlay2.png")] public static const embed_overlay_glow:Class;
		[Embed(source = "../res/title/title_text.png")] public static const embed_wordmark:Class;
		[Embed(source = "../res/title/title_text_white.png")] public static const embed_wordmark_white:Class;
		
		
		
		//end new stuff

		
		private var other_fade:FlxSprite = new FlxSprite(0, 0);
		private var name_fade:FlxSprite = new FlxSprite(0, 0);
		private var name_buffer:FlxBitmapFont;
		private var name:String;
		private var name_array:Array = new Array();
		private var name_array_nrs:Array = new Array();
		private var name_array_visibilities:Array = new Array();
		private var name_timer_max:Number = 0.04;
		private var name_timer:Number = name_timer_max;
		private var downscale:int = 2;
		
		private var transition_out:Boolean = false;
		
		private var controls_state:ControlsState = new ControlsState();
		
		private var rect_fade:FlxSprite; 
		
		private static var do_joypad_config:Boolean = true;
		
		private var do_window_config:Boolean  = false;
		private var window_config:FlxSprite;
		private var window_words:FlxBitmapFont;
		
		[Embed (source = "../res/title/titlepicture.png")] public var S_TITLE_PICTURE:Class;
		[Embed (source = "../res/title/selector.png")] public static var S_SELECTOR:Class;
		[Embed (source = "../res/sprites/screen_config.png")] public static var embed_screen_config:Class;
		
		private var did_init_fadein:Boolean = false;
		
		private var mobile_message:FlxBitmapFont;
		public function TitleState() {
			
		}
		override public function create():void {
			name = DH.lk("title", 3);
			name = "Melos Han-Tani\nMarina Kittaka";
			if (Intra.is_release) version = "Demo";
			//BACK_TEXT_MOBILE = EventScripts.init_bitmap_font("Press BACK again\nto exit.\nUnsaved progress\nwill be lost.", "center", 21, 16, null,"apple_white");
			BACK_TEXT_MOBILE = EventScripts.init_bitmap_font(DH.lk("title",17), "center", 21, 16, null,"apple_white");
			rect_fade = new FlxSprite(0, 0);
			rect_fade.scrollFactor.x = rect_fade.scrollFactor.y = 0;
			rect_fade.makeGraphic(160, 180, 0xff000000);
			
			
			bg.loadGraphic(S_TITLE_PICTURE, false, false, 160, 180);
			add(bg);
			
			Registry.sound_data = new SoundData();
		
			Registry.sound_data.start_song_from_title("TITLE");
			if (Intra.is_mobile) {
				Registry.sound_data.current_song.volume = 0;
				//mobile_message = EventScripts.init_bitmap_font("NOTE\n\nIf you have input\nlag during gameplay,\nreturn to your\nhome screen and\nre-enter Anodyne.\n\nPRESS C TO CONTINUE", "center", 9, 20, null, "apple_white");
				mobile_message = EventScripts.init_bitmap_font(DH.lk("title",16), "center", 9, 20, null, "apple_white");
			}
			
			btn = new FlxSprite(FlxG.width - 80, FlxG.height - 40);
			btn.loadGraphic(Button.S_BUTTON, true, false, 16, 16);
			btn.frame = 2;
			
			
			selector = new FlxSprite();
			selector.loadGraphic(PauseState.arrows_sprite, true, false, 7,7);
			selector.addAnimation("enabled", [2,3], 6);
			selector.play("enabled");
			
			//ad_text = EventScripts.init_bitmap_font("Press 'G' to vote for\nAnodyne on\n Steam Greenlight.\nPress 'B' to purchase\n the full version!", "left", 2, 106, null, "apple_white");
			ad_text = EventScripts.init_bitmap_font("Yeah no", "left", 2, 106, null, "apple_white");
			//mac_text = EventScripts.init_bitmap_font("Anodyne supports\nmost controllers.\n\nWill you use one?\n\nYes   No\n\nIf so, connect it now.\n\nMove with arrow keys\n\nSelect with\nC, SPACE, or ENTER\n\nDefaulting to yes in\n", "left", 8, 8, null,"apple_white");
			mac_text = EventScripts.init_bitmap_font(DH.lk("title",15), "left", 8, 8, null,"apple_white");
			mac_text.visible = false;
			name_fade.makeGraphic(160, 180, 0xff000000);
			add(name_fade);
			
			name_buffer = EventScripts.init_bitmap_font(" ", "center", 38, 88, null, "apple_white");
			name_buffer.setText(name, true, 0, 0, "center", true);
			name_buffer.color = 0x758d91;
			name_buffer.customSpacingY = 2;
			name_buffer.text = " ";
			for (var i:int = 0; i < name.length; i++) {
				name_array.push(name.charAt(i));
				name_array_nrs.push(i);
				name_array_visibilities.push(false);
				if (i == 13) {
					name_buffer.text += "\n";
				} else {
					name_buffer.text += " ";
				}
			}
			name_buffer.x = 80 - name_buffer.width/2;
			name_buffer.y = 90;
			other_fade.makeGraphic(160, 180, 0xff000000);
			
			
			if (Save.load()) {
				//text.setText(filler + "Continue\nNew Game", true, 0, 0, "left", true);
				text  = EventScripts.init_bitmap_font(" ", "left", 41, 41, null, "apple_white");
				if (DH.isZH()) text  = EventScripts.init_bitmap_font(" ", "left", 41, 28, null, "apple_white");
				text.setText(filler + DH.lk("title", 8) + "\n" + DH.lk("title", 9) + "\nBuy Anodyne 2", true, 0, 0, "left", true);
				if (DH.isZH()) text.setText(filler + DH.lk("title",8)+"\n"+DH.lk("title",9)+"\nAnodyne 2", true, 0, 0, "left", true);
				
				selector.x = text.x - selector.width - 1;
				selector.y = text.y + 8;
				if (DH.isZH()) selector.y += 8;
				
				loaded = true;
				
				// Grab steam achievements if we didnt connet last time
				Achievements.set_steam_achievements();
			} else {
				selector.visible = false;
				//text.setText(filler + "Press C\n"+"to start", true, 0, 0, "left", true);
			text  = EventScripts.init_bitmap_font(" ", "left", 42, 41, null, "apple_white");
				text.setText(filler + DH.lk("title", 5) + " " + Registry.controls[Keys.IDX_ACTION_1] + "\n" + DH.lk("title", 6) + "\nPress X to\nbuy Anodyne 2 ", true, 0, 0, "left", true);
				if (DH.isZH()) text.setText(filler + DH.lk("title",5)+" "+Registry.controls[Keys.IDX_ACTION_1]+"\n"+DH.lk("title",6)+"\nX = Buy\nAnodyne 2", true, 0, 0, "left", true);
				loaded = false;
				Registry.controls = Registry.default_controls;
				
			}
			
			
			text.color = 0x758d91;
			version = DH.lk("title", 7) + " 1.55S";
			version_text = EventScripts.init_bitmap_font(version, "left", 2, 156, null, "apple_white");
			version_text.visible = false;
			
				if (Intra.is_ouya) {
					Registry.controls = new Array("UP","DOWN","LEFT","RIGHT","ENTER","T","Z","Y");
				}
			keywatch.x = 2000;
			add(keywatch);
			rect_fade.y = -180;
			add(rect_fade);
			Registry.keywatch = keywatch;
			
		
			
			
			black_overlay = new FlxSprite(0, 0);
			black_overlay.makeGraphic(160, 180, 0xff000000);
			
			scrolly_background = new FlxSprite(0, 0, embed_title_bg);
			scrolly_background2 = new FlxSprite(0, -320, embed_title_bg);
			
			dark_blend = new FlxSprite(0, 0, embed_overlay_dark);
			dark_blend.blend = "overlay";
			
			glow_blend = new FlxSprite(0, 0, embed_overlay_glow);
			glow_blend.blend = "overlay";
			glow_blend.visible = false;
			
			door_glow = new FlxSprite(0, 0, embed_door_glow);
			door_glow.visible = false;
			door_spin_1 = new FlxSprite(0, 0, embed_spin_glow1);
			door_spin_2 = new FlxSprite(0, 0, embed_spin_glow2);
			door_spin_1.visible = door_spin_2.visible = false;
			
			press_enter_sprite = new FlxSprite(0, 0, embed_press_enter);
			press_enter_sprite.visible = false;
			
			wordmark = new FlxSprite(16, 16, embed_wordmark);
			wordmark.visible = false;
			wordmark_white = new FlxSprite(16, 16, embed_wordmark_white);
			wordmark_white.visible = false;
			
			nexus_image = new FlxSprite(0, 180, embed_nexus_image);
			
			
			downsample_fade = new ScreenFade(160, 180, this, ScreenFade.T_DS);
			
			add(scrolly_background);
			add(scrolly_background2);
			add(nexus_image);
			add(door_glow);
			add(door_spin_1);
			add(door_spin_2);
			
			add(name_buffer);
			add(wordmark);
			add(wordmark_white);
			add(dark_blend);
			add(glow_blend);
			add(press_enter_sprite);
			add(black_overlay);
			
			add(text);
			add(selector);
			add(version_text);
			if (Intra.is_release) {
				add(ad_text);	
			}
			add(mac_text);
			if (Intra.is_mobile) {
				add(mobile_message);
				add(btn);
			}
			
			status_text = EventScripts.init_bitmap_font(" ", "left", 4, 76,null,"apple_white");
			if (loaded) {
				var playtime_dat:int = 0;
				playtime_dat = Registry.playtime;
				var hrs:int = int(playtime_dat / 3600);
				
				if (hrs >= 10) {
					status_text.text = int(playtime_dat / 3600).toString() + ":";
				} else {
					status_text.text = "0" + int(playtime_dat / 3600).toString() + ":";
				}
				playtime_dat -= 3600 * hrs;
				
				var mins:int = int(playtime_dat / 60);
				if (mins >= 10) {
					status_text.text += int(playtime_dat / 60).toString() + ":";	
				} else {
					status_text.text = status_text.text + "0" + int(playtime_dat / 60).toString() + ":";
				}
				playtime_dat -= 60 * mins;
				
				if (playtime_dat >= 10) {
					status_text.text += playtime_dat.toString();	
				} else {
					status_text.text = status_text.text +  "0"+ playtime_dat.toString();	
				}
				
				//status_text.text += "\n" + Registry.death_count.toString() + " deaths\n" + Registry.nr_growths.toString() + " cards";
				if (DH.language_type == DH.LANG_ja) {
				status_text.text += "\n死亡" + Registry.death_count.toString() +"回\nカード" + Registry.nr_growths.toString() + "枚";
					
				} else {
				status_text.text += "\n" + Registry.death_count.toString() +" " + DH.lk("title", 13) + " \n" + Registry.nr_growths.toString() + " " + DH.lk("title", 14);
				}
			}
			
			var hby:int = 80;
			if (DH.isZH()) hby = 92;
			if (loaded) {
				health_bar = new HealthBar(150, hby, Registry.MAX_HEALTH);
			} else {
				health_bar = new HealthBar(150,hby, 6);
				health_bar.exists = false;
			}
			t_briar = new FlxSprite; t_briar.exists = false;
			t_young = new FlxSprite; t_young.exists = false;
		
			if (Registry.GE_States[Registry.GE_BRIAR_BOSS_DEAD]) {
				t_briar.x = 2;
				t_briar.y = 2;
				t_briar.loadGraphic(Shadow_Briar.embed_briar, true, false, 16, 16);
				t_briar.exists = true; t_briar.visible = false;
				add(t_briar);
			}
			if (Registry.nr_growths > 48) {
				t_young.x = 160 - 2 - 16;
				t_young.y = 2;
				t_young.loadGraphic(Player.Player_Sprite, true, false, 16, 16);
				t_young.exists = true; t_young.visible = false;
				add(t_young);
			}
			
			health_bar.visible = status_text.visible = ad_text.visible = version_text.visible = text.visible = selector.visible = false;
			add(status_text); add(health_bar);
			
			
			add(other_fade);
			other_fade.alpha = 0;
				
			// Only bother with this when not on the computer
			if (!Intra.did_window_config && !Intra.is_mobile) {
				//window_words = EventScripts.init_bitmap_font("Please use the\narrow keys to resize\nthe window until\nyou cannot see\nany black around\n the borders.\n\nPress "+Registry.controls[Keys.IDX_ACTION_1]+"\nwhen done.", "center", 10, 10, null, "apple_white");
				window_words = EventScripts.init_bitmap_font(DH.lk("title",0)+" "+Registry.controls[Keys.IDX_ACTION_1]+" "+DH.lk("title",1), "center", 10, 10, null, "apple_white");
				
				window_config = new FlxSprite(-3,-3);	
				window_config.loadGraphic(embed_screen_config, false, false, 166, 186);
				add(window_config);
				add(window_words);
				Intra.force_window(3);
				do_window_config = true;
			// Otherwise do a Left or Right hand config
			} else if (Intra.is_mobile) {
				
			}
			
			DEBUGTEXT = EventScripts.init_bitmap_font(Achievements.DEBUG_TEXT, "left", 0, 0, null, "apple_white");
			DEBUGTEXT.visible = true;
			//add(DEBUGTEXT);
			DEBUGTEXT.text += Main.debugstring;
			
			BACK_TEXT_MOBILE.alpha = 0;
			add(BACK_TEXT_MOBILE);
		}
		
		public function name_fade_state():void {
			other_fade.alpha -= 0.008;
			name_timer -= FlxG.elapsed;
			if (name_timer < 0) {
			name_buffer.text = " ";
				name_timer = name_timer_max;
				var idx:int = int(Math.random() * name_array_nrs.length);
				name_array_visibilities[13] = true;
				name_array_visibilities[name_array_nrs[idx]] = true;
				name_array_nrs.splice(idx, 1);
				for (var i:int = 0; i < name.length; i++) {
					if (name_array_visibilities[i]) {
						name_buffer.text += name_array[i];
					} else {
						name_buffer.text += " ";
				 	}
				}
			}
			
			if (name_array_nrs.length == 0 ) {
				state = S_NAME_BLUR;
			}
			return;
		}
		public function name_blur_state():void {
			
			other_fade.alpha -= 0.008;
			name_buffer.alpha -= 0.006;
			name_timer -= FlxG.elapsed;
			name_timer_max = 0.1;
			if (name_timer < 0 && name_buffer.alpha < 0.64 ) {
				name_timer = name_timer_max;
				name_buffer.pixels.applyFilter(name_buffer.framePixels, name_buffer.framePixels.rect, name_buffer.framePixels.rect.topLeft, new BlurFilter(2,2, 1));
			}
			
			name_buffer.dirty = true;
			if (name_buffer.alpha < 0.2) {
				name_fade.alpha -= 0.03;
				if (name_fade.alpha < 0.03) {
					state = S_NEXUS_SCROLL;
					if (loaded) { 
						//state = S_CONTINUE;
					} else {
						//state = S_NEW;
					}
				}
			}
		}
		
		override public function draw():void 
		{
			
			super.draw();
			downsample_fade.rate = 15;
			if (state == S_NEXUS_SCROLL && ctr == 2) {
				black_overlay.alpha += 0.006;
				if (downsample_fade.do_effect() == ScreenFade.DONE) {
					black_overlay.alpha += 0.01;
					if (black_overlay.alpha == 1) {
						t_young.visible = t_briar.visible = health_bar.visible = status_text.visible = ad_text.visible = version_text.visible = text.visible = selector.visible = true;
						if (loaded) { 
							state = S_CONTINUE;
						} else {
							selector.visible = false;
							state = S_NEW;
						}
					}
				}	
			}
		}
		
		private var reeeeeesize:Boolean = false; // Force the game to be windowed if we need to do manual window resize
		private var window_during_joyconfig:Boolean = false; // Force the game to be windowed if we need to do manual window resize
		private var window_to_joyconfig_delay:Number = 0;
		private var window_to_joyconfig_happened:Boolean = false;
		private static var do_prevent_mac_joy_error:Boolean = false;
		private var mac_selector_state:int = 0;
		private var mac_timeout:Number = 10;
		public static var restart_on_mobile_enter:Boolean = false;
		public static var mobile_message_done:Boolean = false;
		
		private var t_mobile_back:Number = 0;
		override public function update():void {
			
			if (Registry.MOBILE_ASK_TO_EXIT_WITH_BACK) {
				t_mobile_back = 2;
				Registry.MOBILE_ASK_TO_EXIT_WITH_BACK = false;
				Registry.MOBILE_OKAY_TO_EXIT_WITH_BACK = true;
			}
			if (t_mobile_back > 0 ) {
				BACK_TEXT_MOBILE.alpha = t_mobile_back / 2.0;
				t_mobile_back -= FlxG.elapsed;
				if (t_mobile_back < 0) {
					Registry.MOBILE_OKAY_TO_EXIT_WITH_BACK = false;
				}
			}
			
			if (Intra.is_mobile) {
				
				
				
				if (did_init_fadein == false) {
					Registry.sound_data.current_song.volume += 0.0025;
					if (Registry.sound_data.current_song.volume == 1) {
						Registry.sound_data.current_song.play();
						did_init_fadein = true;
					}
				}
				
			}
			if (restart_on_mobile_enter) {
				restart_on_mobile_enter = false;
				Registry.sound_data.start_song_from_title("TITLE");
			}
			
			
			if (Intra.is_mobile) {
				if (mobile_message_done == false) {
					if (Registry.keywatch.JP_ACTION_1 || Registry.keywatch.JP_ACTION_2) {
						mobile_message_done = true;
						mobile_message.visible = false;
						btn.visible = false;
					}
					Registry.keywatch.update();
					return;
				}
			}
			
			if (FlxG.keys.THREE && FlxG.keys.D && FlxG.keys.justPressed("T")) {
				DEBUGTEXT.visible = !DEBUGTEXT.visible;
			}
			//if (Intra.is_release) {
				//if (FlxG.keys.justPressed("G")) {
					//Achievements.unlock(Achievements.Greenlit);
					//FlxU.openURL("http://steamcommunity.com/sharedfiles/filedetails/?id=92921739");
				//}
				//
				//if (FlxG.keys.justPressed("B")) {
					//Achievements.unlock(Achievements.Website);
					//FlxU.openURL("http://www.anodynegame.com");
				//}
			//}
			if (Achievements.IS_STEAM) {
				//DEBUGTEXT.text = Achievements.DEBUG_TEXT;
			}
			
			if (Intra.is_ouya) {
				//DEBUGTEXT.text = Main.debugstring;
			} else if (Intra.is_mobile && !Intra.is_ios) {
				//DEBUGTEXT.text = Main.debugstring;
			}
			
			if (do_window_config) {
				if (reeeeeesize == false) {
					reeeeeesize = true;
					trace("Windowing for window config.");
					Intra.force_window(3);
				}
				window_config_logic(keywatch);	
				if (keywatch.JP_ACTION_1 || keywatch.JP_ACTION_2) {
					do_window_config = false;
					remove(window_config, true);
					remove(window_words, true);
					trace("Exiting window config, fullscreening.");
					Intra.scale_factor = FlxG.stage.fullScreenHeight / 180;
					Intra.force_scale = true;
					Intra.scale_ctr = Intra.SCALE_TYPE_INT;
					window_to_joyconfig_delay = 1;
					reeeeeesize = false;
				}
				super.update();
				return;
			}
			
			// prevent bad controllers from crashing the extension (and thus the game)
			if (!do_prevent_mac_joy_error && Intra.IS_MAC && Main.fixedjoy) {
				
				mac_text.visible = true;
				//mac_text.text = "Anodyne supports\nmost controllers.\n\nWill you use one?\n\nYes   No\n\nIf so, connect it now.\n\nMove with arrow keys\n\nSelect with\nC, SPACE, or ENTER\n\nDefaulting to YES in\n" + mac_timeout.toFixed(2);
				mac_text.text = DH.lk("title",15) + mac_timeout.toFixed(2);
				mac_timeout -= FlxG.elapsed;
				
				selector.visible = true;
				
				if (mac_selector_state == 0) {
					selector.x = mac_text.x + 32;
					selector.y = mac_text.y + 40;
					if (Registry.keywatch.JP_LEFT) {
						mac_selector_state = 1;
					} else if (FlxG.keys.justPressed("C") || FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER")) {
						do_prevent_mac_joy_error = true;
						mac_text.visible = false;
						window_to_joyconfig_delay = 1;
						selector.visible = false;
					}
				} else { // yes
					selector.x = mac_text.x - 6	;
					selector.y = mac_text.y + 40;
					
					if (Registry.keywatch.JP_RIGHT) {
						mac_selector_state = 0;
					} else if (FlxG.keys.justPressed("C") || FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER")) {
						do_prevent_mac_joy_error = true;
						Main.mac_joy_manager = new MacJoystickManager();
						Main.macmanexists = true;
						mac_text.visible = false;
						window_to_joyconfig_delay = 1;
						selector.visible = false;
					}
				}
				
				if (mac_timeout < 0) {
					do_prevent_mac_joy_error = true;
					Main.mac_joy_manager = new MacJoystickManager();
					Main.macmanexists = true;
					mac_text.visible = false;
					window_to_joyconfig_delay = 1;
					selector.visible = false;

				}
				
				super.update();
				return;
			}
			
			if (Keys.has_joypad) {
				if (do_joypad_config) {
					
					if (window_to_joyconfig_delay > 0) {
						window_to_joyconfig_happened = true;
						window_to_joyconfig_delay -= FlxG.elapsed;
						super.update();
						return;
					}
					
					// If we did the window config then we shouldn't fullscreen
					if (false == reeeeeesize) {
						trace("Windowing for joypad config.");
						reeeeeesize = true;
						Intra.force_window(3);
					}
					
					if (Registry.joy_grp == null) {
						Registry.joy_grp = new Joypad_Config_Group();
						add(Registry.joy_grp);
					}
					
					if (Registry.joy_grp.is_done()) {
						trace("Title joypad config done");
						do_joypad_config = false;
						remove(Registry.joy_grp, true);
						window_to_joyconfig_delay = 1;
						if (window_to_joyconfig_happened) {
							trace("Fullscreening from joypad config");
							Intra.scale_factor = FlxG.stage.fullScreenHeight / 180;
							Intra.force_scale = true;
							Intra.scale_ctr = Intra.SCALE_TYPE_INT;
						} else {
							Save.load();
							// Prevent zerooing out the array from loading a game that
							// has no joy bindings, if we set joy bindings previously
							if (Joypad_Config_Group.REAL_JOYBINDS != null) {
								Registry.joybinds = Joypad_Config_Group.REAL_JOYBINDS;
							}
						}
						
					}
					super.update();
					return;
				}
			}
			
			
			if (scrolly_background.y <= -320) {
				scrolly_background.y = 180;
			}
			if (scrolly_background2.y <= -320) {
				scrolly_background2.y = 180;
			}
			if (state == S_BEGIN) {
				switch (ctr) {
					case 0:
						scrolly_background.velocity.y =  scrolly_background2.velocity.y = -30;
						black_overlay.alpha -= 0.0079;
						if (black_overlay.alpha == 0) {
							ctr = 0;
							state = S_NAME_FADE;
						}
						break;
				}
				
				if (window_to_joyconfig_delay < 0) {
					do_skip();
				} else {
					window_to_joyconfig_delay -= FlxG.elapsed;
				}
				super.update();
				return;
			} else if (state == S_NEXUS_SCROLL) {
				switch(ctr) {
					case 0:
						nexus_image.velocity.y = -20;
						
						if (Registry.keywatch.JP_ACTION_1 || Registry.keywatch.JP_ACTION_2) {
							nexus_image.y = 180 - nexus_image.height;
						}
						if (nexus_image.y + nexus_image.height <= 180) {
							nexus_image.y = 180 - nexus_image.height;
							nexus_image.velocity.y = 0;
							FlxG.flash(0xffffffff, 1.5);
							glow_blend.visible = true;
							dark_blend.visible = false;
							
							door_glow.visible = true;
							
							door_glow.x = (160 - 64) / 2;
							door_glow.y = nexus_image.y + 17;
							
							door_spin_1.visible = true;
							door_spin_1.x = door_spin_2.x = door_glow.x;
							door_spin_1.y = nexus_image.y;
							door_spin_1.blend = "screen";
							door_spin_2.angularVelocity = -90;
							
							door_spin_2.visible = true;
							door_spin_2.y = nexus_image.y;
							door_spin_2.blend = "screen";
							door_spin_1.angularVelocity = 90;
							
							wordmark.visible = wordmark_white.visible = true;
							
							press_enter_sprite.visible = true;
							
							press_enter_sprite.x = (160 - press_enter_sprite.width) / 2;
							press_enter_sprite.y = 160;
							 
							name_timer = 0;
							
							ctr++;
						}
						break;
						//17
					case 1:
						wordmark_white.alpha -= 0.0033;
						
						name_timer += FlxG.elapsed;
						if (press_enter_sprite.visible) {
							if (name_timer > 1) {
								name_timer = 0;
								press_enter_sprite.visible = false;
							}
						} else {
							if (name_timer > 0.75) {
								name_timer = 0;
								press_enter_sprite.visible = true;
							}
						}
						
						if (glow_blend.alive) {
							glow_blend.alpha -= 0.001;
							if (glow_blend.alpha <= 0.7) {
								glow_blend.alive = false;
							}
						} else {
							glow_blend.alpha += 0.001;
							if (glow_blend.alpha >= 1) {
								glow_blend.alive = true;
							}
						}
						
						if (door_spin_1.alive) {
							door_spin_1.alpha -= 0.003;
							if (door_spin_1.alpha <= 0.5) {
								door_spin_1.alive = false;
							}
						} else {
							door_spin_1.alpha += 0.003;
							if (door_spin_1.alpha >= 1) {
								door_spin_1.alive = true;
							}
						}
						
						if (door_spin_2.alive) {
							door_spin_2.alpha -= 0.0015;
							if (door_spin_2.alpha <= 0.7) {
								door_spin_2.alive = false;
							}
						} else {
							door_spin_2.alpha += 0.0015;
							if (door_spin_2.alpha >= 1) {
								door_spin_2.alive = true;
							}
						}
						
						if (FlxG.keys.justPressed("ENTER") || Registry.keywatch.JUST_PRESSED_PAUSE || Registry.keywatch.JP_ACTION_1 || Registry.keywatch.JP_ACTION_2) {
							ctr++;
							downsample_fade.timer_max = 0.03;
						}
						break;
					case 2:
						
						selector.x = text.x - selector.width - 1;
						selector.y = text.y + (text.characterHeight+text.customSpacingY);
						black_overlay.alpha += 0.002;
						break;
				}
				super.update();
				return;
			}
			
			
			if (transition_out) {
				other_fade.alpha += 0.012;
				if (other_fade.alpha >= 1) {
					
					if (state == S_CONTINUE) {
						Registry.CURRENT_MAP_NAME = Registry.checkpoint.area;
						Registry.set_is_playstate(Registry.CURRENT_MAP_NAME);
						Registry.ENTRANCE_PLAYER_X = Registry.checkpoint.x;
						Registry.ENTRANCE_PLAYER_Y = Registry.checkpoint.y;
						
						if (Registry.is_playstate) {
							FlxG.switchState(new PlayState); 
							Registry.MOBILE_OKAY_TO_EXIT_WITH_BACK = false; 	
						} else {
							FlxG.switchState(new RoamState);
						}
					} else {
						FlxG.switchState(new IntroScene);
						Registry.MAX_HEALTH = Registry.CUR_HEALTH = 6;
						Registry.CURRENT_MAP_NAME = "BLANK";
						Registry.checkpoint.x = Registry.ENTRANCE_PLAYER_X = 23;
						Registry.checkpoint.y = Registry.ENTRANCE_PLAYER_Y = 130;
						Registry.checkpoint.area = "BLANK";
					}
				}
				super.update();
				return;
			}
			
			if (state == S_NAME_FADE) {
				do_skip();
				name_fade_state();
				super.update();
				return;
			} else if (state == S_NAME_BLUR) {
				do_skip();
				name_blur_state();
				super.update();
				return;
				
			}
			
			if (keywatch.JP_ACTION_1) {
				Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
			} 
			
			if (keywatch.JP_DOWN || keywatch.JP_UP) {
				Registry.sound_data.play_sound_group(Registry.sound_data.menu_move_group);
			}
			
			switch (state) {
				case S_CONTROLS:
					keywatch.update();
					controls_state.update();
					if (FlxG.keys.justPressed("ESCAPE") || (keywatch.JUST_PRESSED_PAUSE && !controls_state.updating)) {
						controls_state.updating = false;
						controls_state.pop(this as FlxState);
						if (loaded) {
							state = S_CONTINUE;
						} else {
							state = S_NEW;
						}
					}
					return;
					
				case S_NEW:
					if (keywatch.JP_ACTION_1 || FlxG.keys.justPressed("ENTER")) {
						transition_out = true;
						rect_fade.velocity.y = 80;
					}
					if (keywatch.JP_ACTION_2) {
						navigateToURL(new URLRequest("https://store.steampowered.com/app/877810/Anodyne_2_Return_to_Dust/"));
					}
					/* Check for ESC input to bring up controls */
					if (FlxG.keys.justPressed("ESCAPE")) {
						state = S_CONTROLS;
						controls_state.change_text();
						controls_state.push(this as FlxState);
					}
					break;
				case S_CONTINUE:
					var lineHeightCont:int = text.characterHeight + text.customSpacingY;
					if (keywatch.JP_DOWN) {
						
						//some_stupid_shit(downscale);
						downscale++;
						if (selector.y < text.y + 3*lineHeightCont)
							selector.y += lineHeightCont;
					} else if (keywatch.JP_UP) {
						if (selector.y > text.y + lineHeightCont) 
							selector.y -= lineHeightCont;
					}
					if (keywatch.JP_ACTION_1 || FlxG.keys.justPressed("ENTER")) {
						if (selector.y == text.y + lineHeightCont) {
							
							rect_fade.velocity.y = 80;
							transition_out = true;
						} else if (selector.y == text.y + 2*lineHeightCont) {
							state = S_DELETE;
							//text.text = filler+"Are you sure?\nNo\nYes";
							text.text = filler + DH.lk("title", 10);
							
						} else {
							navigateToURL(new URLRequest("https://store.steampowered.com/app/877810/Anodyne_2_Return_to_Dust/"));
						}
					}
					
					/* Check for ESC input to bring up controls */
					if (FlxG.keys.justPressed("ESCAPE")) {
						state = S_CONTROLS;
						controls_state.push(this as FlxState);
					}
					break;
				case S_DELETE:
					
					var lineHeightDel:int = text.characterHeight + text.customSpacingY;
					if (keywatch.JP_DOWN) {
						if (selector.y < text.y + 3*lineHeightDel)
							selector.y += lineHeightDel;
					} else if (keywatch.JP_UP) {
						if (selector.y > text.y + 2*lineHeightDel) 
							selector.y -= lineHeightDel;
					}
					
					if (keywatch.JP_ACTION_1 || FlxG.keys.justPressed("ENTER")) {
							selector.x = text.x - selector.width - 1;
						if (selector.y == text.y + 2*lineHeightDel) {
							state = S_CONTINUE;
							selector.x = text.x - selector.width - 1;
							//text.setText(filler + "Continue\nNew Game", true, 0, 0, "left", true);
							text.setText(filler + DH.lk("title", 8) + "\n" + DH.lk("title", 9) + "\nBuy Anodyne 2", true, 0, 0, "left", true);
							if (DH.isZH()) text.setText(filler + DH.lk("title",8)+"\n"+DH.lk("title",9)+"\nAnodyne 2", true, 0, 0, "left", true);
							selector.y -= lineHeightDel;
						} else {
							selector.y -= lineHeightDel;
							if (text.text == filler+DH.lk("title",11)) {
								selector.x = text.x - selector.width - 1;
								//text.text = filler+"No going back!\nForget it\nI know"
								text.text = filler + DH.lk("title", 12);
							} else if (text.text == filler + DH.lk("title", 12)) {
								Registry.embed2saveXML(); //Reset this current session's XML.
								Registry.controls = Registry.default_controls;
								Save.delete_save();
								status_text.visible = false;
								health_bar.visible = false;
								t_young.visible = t_briar.visible = false;
								//text.setText(filler + "Press C" + "\nto start", true, 0, 0, "left", true);
								text.setText(filler + DH.lk("title",5)+" "+Registry.controls[Keys.IDX_ACTION_1]+"\n"+DH.lk("title",6), true, 0, 0, "left", true);
								state = S_NEW;
								selector.visible = false;
								
								//FlxG.switchState(new FirstRoomState);
							} else {
								text.text = filler+DH.lk("title",11);
							
							}
						}
					}
					break;
					
			}
			super.update();
			//Add a glitch effect to the words, or a blur effect. Make it blink too.
			//Particles in the background?
		}
		
		override public function destroy():void {
			remove(keywatch, true);
			bg = null;
			controls_state.destroy();
			controls_state = null;
			keywatch = null;
			name_buffer = null;
			name_fade = null;
			other_fade = null;
			rect_fade = null;
			version_text = null;
			selector = null;
			text = null;
			
			black_overlay = null;
			downsample_fade = null;
			scrolly_background = null;
			nexus_image = null;
			door_glow = null;
			door_spin_1 = null;
			door_spin_2 = null;
			press_enter_sprite = null;
			wordmark = null;
			wordmark_white = null;
			
			health_bar = null;
			mac_text = null;
			status_text = null;
			DEBUGTEXT = null;
			BACK_TEXT_MOBILE = null;
			
			super.destroy();
		}
		
		/**
		 * Based on keypresses,
		 * change the size of the windowed windwos
		 */
		public static function window_config_logic(_keywatch:Keys):void 
		{
			if (_keywatch.JP_DOWN) {
				if (Intra.frame_y_px < 50) {
					Intra.frame_y_px++;
				}
			} else if (_keywatch.JP_UP) {
				if (Intra.frame_y_px > 0) {
					Intra.frame_y_px--;
				}
			}
			
			if (_keywatch.JP_RIGHT) {
				if (Intra.frame_x_px < 50) {
					Intra.frame_x_px++;
				}
			} else if (_keywatch.JP_LEFT) {
				if (Intra.frame_x_px > 0) {
					Intra.frame_x_px--;
				}
			}
			
			if (_keywatch.JP_RIGHT || _keywatch.JP_LEFT || _keywatch.JP_DOWN || _keywatch.JP_UP) {
				NativeApplication.nativeApplication.activeWindow.width = 480 + Intra.frame_x_px;
				NativeApplication.nativeApplication.activeWindow.height = 540 + Intra.frame_y_px;
			}
		
		}
		
		private function do_skip():void 
		{
			if (FlxG.keys.justPressed("ENTER") || Registry.keywatch.JP_ACTION_1 || Registry.keywatch.JP_ACTION_2) {
				state = S_NEXUS_SCROLL;
				ctr = 0;
				wordmark_white.alpha = 1;
				nexus_image.y = 180 - nexus_image.height;
				name_buffer.visible = false;
				dark_blend.visible = false;
				glow_blend.visible = true;
				black_overlay.alpha = 0;
			}
		}
	}

}