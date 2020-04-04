package states 
{
	import data.SoundData;
	import entity.gadget.Treasure;
	import entity.interactive.NPC;
	import entity.interactive.npc.Trade_NPC;
	import flash.desktop.NativeApplication;
	import helper.Achievements;
	//import flash.desktop.NativeApplication;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import entity.*;
	import entity.player.*;
	import global.Registry;
	import global.Keys;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	import org.flixel.system.FlxAnim;
	
	public class PauseState extends PushableFlxState
	{
		
		
		
		/* Position of these two are set in PlayState */
		
		
		
		/** NEW!!!!!!! **/
		
		
		private var no_scroll_point:FlxPoint = new FlxPoint(0, 0);
		public var current_substate_visible:Boolean = false;
		private var init_parent:Boolean = false;
		
		public var state:int = 0;
		private var s_browse:int = 0;
		private var s_map:int = 1; // Probably not used.
		private var s_equip:int = 2;
		private var s_cards:int = 3;
		private var s_save:int = 4;
		private var s_settings:int = 5;
		private var s_dialogue:int = 6;
		private var s_cheatz:int = 7;
		private var s_secretz:int = 8;
		public var done:Boolean = false;
		public var exit_latency:Number = 0.5;
		
		private var load_dialogue:Boolean = false;
		private var t_d:Number = 0;
		private var tm_d:Number = 0.2;
		
		private var text_1:FlxBitmapFont;
		private var text_2:FlxBitmapFont;
		private var text_3:FlxBitmapFont;
		
		private var base_group:FlxGroup = new FlxGroup;
		private var base_menu:FlxSprite;
		private var text_categories:FlxBitmapFont;
		private var text_info:FlxBitmapFont;
		private var base_index:int = 0;
		private var max_base_index:int = 4;
		private var menu_select_inactive:FlxSprite;
		private var menu_select_active:FlxSprite;
		
		[Embed (source = "../res/sprites/menu/arrows.png")] public static var arrows_sprite:Class;
		[Embed (source = "../res/sprites/menu/menu_select_active.png")] public static var men_sel_act:Class;
		[Embed (source = "../res/sprites/menu/menu_select_inactive.png")] public static var men_sel_inact:Class;
		[Embed (source = "../res/sprites/menu/menu_bg.png")] public static var menu_bg_sprite:Class;
		
		
		
		private var selectors:FlxGroup = new FlxGroup(4);
		
		public var minimap:MinimapState;
		private var map_cursor_idx:int = 0;
		private var map_ctr:int = 0;
		
		private var legend_entrance:FlxSprite;
		private var legend_cur:FlxSprite;
		private var legend_entrance_b:FlxSprite;
		private var legend_cur_b:FlxSprite;
		
		[Embed (source = "../res/sprites/menu/equipped_icon.png")] public static var equipped_icon:Class;
		[Embed (source = "../res/sprites/menu/none_icon.png")] public static var none_icon_sprite:Class;
		[Embed (source = "../res/sprites/menu/long_icon.png")] public static var long_icon_sprite:Class;
		[Embed (source = "../res/sprites/menu/wide_icon.png")] public static var wide_icon_sprite:Class;
		[Embed (source = "../res/sprites/menu/transformer_icon.png")] public static var transformer_icon_sprite:Class;
		
		
		private var equip_overlay:FlxSprite;
		private var equip_boxes:FlxGroup = new FlxGroup(4);
		private var equip_cursor_idx:int = 0;
		private var equip_icon:FlxSprite;
		private var key_icons:FlxGroup = new FlxGroup(3);
		private var trade_item:FlxSprite;
		private var jump_shoes:FlxSprite;
		
		
		[Embed (source = "../res/sprites/menu/card_empty.png")] public static var card_empty_sprite:Class;
		[Embed (source = "../res/sprites/menu/card_1.png")] public static var card_1_sprite:Class;
		[Embed (source = "../res/sprites/menu/card_sheet.png")] public static var card_sheet_embed:Class;
		
		private var cards:FlxGroup = new FlxGroup(12);
		private var cur_cards_pg:int = 0;
		private var cards_cursor_idx:int = 0;
		
		private var save_cursor_idx:int = 0;
		
		[Embed (source = "../res/sprites/menu/volume_bar.png")] public static var volume_bar_embed:Class;
		
		private var volume_bar:FlxSprite;
		private var volume_bar_overlay:FlxSprite = new FlxSprite;
		private var volume_bar_bg:FlxSprite;
		private var doing_window_config:Boolean = false;
		public var controls_state:ControlsState = new ControlsState;
		private var window_config:FlxSprite;
		private var window_words:FlxBitmapFont;
		private var settings_cursor_idx:int = 0;
		private var ctr_settings:int = 0;
		
		private var trophies:FlxGroup;
		
		private var playtime_text:FlxBitmapFont;
		
		
		
		
		public function PauseState() 
		{
			create();
		}
		
		override public function add(Object:FlxBasic):FlxBasic 
		{
			if (Registry.GAMESTATE != null) {
				Registry.GAMESTATE.dialogue_state.set_dialogue_box();
			}
			
			if (Registry.GE_States[Registry.GE_HAVE_A_SECRET]) {
				text_categories.text = "Map\n\nItems\n\nCards\n\nSave\n\nConfig\n\n???";
			}
			if (trophies != null) {
				for (var i:int = 0; i < trophies.length; i++) {
					set_trophy_vis(trophies, i);
				}
			}
			text_info.text = Registry.controls[Keys.IDX_ACTION_1] + ":Select " + Registry.controls[Keys.IDX_ACTION_2] + ":Back";
			return super.add(Object);
		}
		
		override public function draw():void 
		{
			
			
			super.draw();
		}
		override public function destroy():void 
		{
			if (minimap != null) minimap.destroy();
			minimap = null;
			
			if (controls_state != null) controls_state.destroy();
			controls_state = null;
			
			/** NEW **/ 
			
			/* Call destroy on and null all added Flixel objects */
			/* Pushable flxstates have all of their added objects removed from here*/
			super.destroy();
			
			/* Remove refs */
			playtime_text = null;
			text_categories = null;
			text_info = null;
			text_1 = null;
			text_2 = null;
			text_3 = null;
			window_words = null;
			window_config = null;
			base_menu = null;
			legend_entrance = legend_cur = null;
			selectors = null;
			equip_overlay = null;
			equip_boxes = null;
			key_icons = null;
			trade_item = null;
			jump_shoes = null;
			cards = null;
			legend_cur_b = legend_entrance_b = null;
			volume_bar_bg = null;
			
			volume_bar = null;
			volume_bar_overlay = null;
			
			base_group = null;
			
			trophies = null;
		}
		
		override public function create():void {
			/* Begin new logic */
			var i:int = 0;
			current_substate_visible = false;
			/* COMMON OBJECTS */
			base_menu = new FlxSprite(0, Registry.HEADER_HEIGHT);
			base_menu.loadGraphic(menu_bg_sprite);
			base_menu.scrollFactor.x = base_menu.scrollFactor.y = 0;
			
			text_categories = EventScripts.init_bitmap_font("Map\n\nItems\n\nCards\n\nSave\n\nConfig", "left", 10, 13 + Registry.HEADER_HEIGHT, null, "apple_white");
			text_categories.color = 0xffffff;
			text_categories.drop_shadow = true;
			
			
			
			text_info = EventScripts.init_bitmap_font(Registry.controls[Keys.IDX_ACTION_1] + ":Select " + Registry.controls[Keys.IDX_ACTION_2] + ":Back", "left", 2, 150 + Registry.HEADER_HEIGHT, null, "apple_white");
			text_info.color = 0x909ab1;
			
			//11323b
			text_1 = EventScripts.init_bitmap_font(" ", "left",0,0,null,"apple_white");
			text_2 = EventScripts.init_bitmap_font(" ", "left",0,0,null,"apple_white");
			text_3 = EventScripts.init_bitmap_font(" ", "left", 0, 0, null, "apple_white");
			text_1.color = text_2.color = text_3.color = 0xffffff;
			text_1.drop_shadow = text_2.drop_shadow = text_3.drop_shadow = true;
			
			menu_select_inactive = new FlxSprite(0, 30);
			menu_select_active = new FlxSprite(0, 30);
			menu_select_active.scrollFactor = menu_select_inactive.scrollFactor = no_scroll_point;
			menu_select_active.addAnimation("flash", [0, 1], 4);
			menu_select_active.play("flash");
			menu_select_inactive.loadGraphic(men_sel_act, true, false, 61, 15);
			
			menu_select_active.loadGraphic(men_sel_act, true, false, 61,15);
			menu_select_inactive.visible = false;
			menu_select_inactive.frame = 2;
			
			var selector:FlxSprite;
			for (i = 0; i < selectors.maxSize; i++) {
				selector = new FlxSprite;
				selector.loadGraphic(arrows_sprite, true, false, 7,7);
				selector.addAnimation("disabled", [2]);
				selector.addAnimation("enabled", [2,3], 6);
				selector.play("disabled");
				selector.visible = false;
				selector.scrollFactor = no_scroll_point;
				selectors.add(selector);
			}
			selector = null;
		
			add(selectors);
			
			base_group.add(base_menu);
			base_group.add(menu_select_active);
			base_group.add(menu_select_inactive);
			base_group.add(text_categories);
			base_group.add(text_info);
			base_group.add(text_1);
			base_group.add(text_2);
			base_group.add(text_3);
			add(base_group);
			add(selectors);
		
			/* MINIMAP */
			minimap = new MinimapState();
			add(minimap);
			
			legend_cur = new FlxSprite(63, 117);
			legend_cur.makeGraphic(4,4,0xffff5949);
			legend_entrance = new FlxSprite(63, 125);
			legend_entrance.makeGraphic(4, 4, 0xff0d52af);
			
			legend_cur_b = new FlxSprite(62, 116);
			legend_cur_b.makeGraphic(6,6,0xff000000);
			legend_entrance_b = new FlxSprite(62, 124);
			legend_entrance_b.makeGraphic(6, 6, 0xff000000);
			legend_cur_b.scrollFactor = legend_entrance_b.scrollFactor = legend_cur.scrollFactor = legend_entrance.scrollFactor = no_scroll_point;
			add(legend_cur_b); add(legend_entrance_b);
			add(legend_cur); add(legend_entrance);
			
			
			/* EQUIP */
			
			var equip_box:FlxSprite;
			for (i = 0; i < equip_boxes.maxSize; i++) {
				equip_box = new FlxSprite;
				equip_box.loadGraphic(none_icon_sprite, true, false, 18, 18);
				equip_box.x = 65;
				equip_box.y = 25 + 24 * i;
				equip_box.scrollFactor = no_scroll_point;
				equip_boxes.add(equip_box);
				
				switch (i) {
					case 0:
						break;
					case 1:
						equip_box.loadGraphic(long_icon_sprite, false, false, 18, 18);
						break;
					case 2:
						equip_box.loadGraphic(wide_icon_sprite, false, false, 18, 18);
						break;
					case 3:
						equip_box.loadGraphic(transformer_icon_sprite, false, false, 18, 18);
						break;
					
				}
			}
			equip_box = null;
			add(equip_boxes);
			
			//Load key icons
			for (i = 0; i < 3; i++) {
				var key:FlxSprite = new FlxSprite;
				key_icons.add(key);
				key.x = 95 + 16 * i;
				key.y = 130;
			}
			set_key_graphics();
			key_icons.setAll("scrollFactor", no_scroll_point);
			add(key_icons);
			
			trade_item = new FlxSprite(78, 130);
			trade_item.scrollFactor.x = trade_item.scrollFactor.y = 0;
			set_trade_item();
			add(trade_item);
			
			jump_shoes = new FlxSprite(62, 130, Treasure.embed_jump_shoes);
			jump_shoes.scrollFactor.x = jump_shoes.scrollFactor.y = 0;
			add(jump_shoes);
			
			equip_icon = new FlxSprite(equip_boxes.members[0].x + 12, equip_boxes.members[0].y - 1);
			equip_icon.scrollFactor = no_scroll_point;
			equip_icon.loadGraphic(equipped_icon, true, false, 7, 9);
			add(equip_icon);
			
			/* CARDS*/
			var card:FlxSprite;
			for (i = 0; i < cards.maxSize; i++) {
				card = new FlxSprite;
				card.loadGraphic(card_sheet_embed, false, false, 24, 24);
				card.frame = 36;
				// LOGIC FOR LOADING DIFFERENT CARD PICTURE HERE
				card.x = 60 + 8 + (24 + 6) * (i % 3);
				card.y = 20 + 8 + (24 + 6) * int(i / 3);
				cards.add(card);
				card.scrollFactor = no_scroll_point;
			}
			add(cards);
			card = null;
			
			/* SAVE GAME */
			// ----
			
			/* SETTINGS */
			
			
			volume_bar = new FlxSprite;
			volume_bar.makeGraphic(2, 7, 0xffc7003d);
			volume_bar.scale.x = int(FlxG.volume * 30);
			volume_bar.x = 73;
			volume_bar.y = 58;
			
			volume_bar_bg = new FlxSprite;
			volume_bar_bg.makeGraphic(60, 7, 0xff000000);
			volume_bar_bg.x = volume_bar.x;
			volume_bar_bg.y = volume_bar.y;
			
			
			volume_bar_bg.scrollFactor = volume_bar.scrollFactor = volume_bar_overlay.scrollFactor = no_scroll_point;
			
			volume_bar_overlay.loadGraphic(volume_bar_embed, false, false, 60, 11);
			volume_bar_overlay.x = volume_bar.x;
			volume_bar_overlay.y = volume_bar.y - 2;
			volume_bar.x = volume_bar_overlay.x + volume_bar.scale.x - 1;
			
			window_config = new FlxSprite( -3, -3);
			window_config.scrollFactor.x = window_config.scrollFactor.y = 0;
			window_config.loadGraphic(TitleState.embed_screen_config, false, false, 166, 186);
			window_words = EventScripts.init_bitmap_font("Please use the\narrow keys to resize\nthe window until\nyou cannot see\nany black around\n the borders.\n\nPress "+Registry.controls[Keys.IDX_ACTION_1]+"\nwhen done.", "center", 10, 10, null, "apple_white");
			add(volume_bar_bg);
			add(volume_bar);
			add(volume_bar_overlay);
			window_config.visible = window_words.visible = false;
			add(window_config);
			add(window_words);
			
			/* secrets *
			 * */
			 
			trophies = new FlxGroup;
			for (i = 0; i < 16; i++) {
				var trophy:FlxSprite = new FlxSprite;
				trophy.loadGraphic(Treasure.embed_secret_trophies, true, false, 16, 16);
				trophy.frame = i;
				trophies.add(trophy);
				set_trophy_vis(trophies, i);
				trophy.x = 64 + (i % 4)  * 24;
				trophy.y = 40 + int(i / 4) * 24;
				trophy.scrollFactor.x = trophy.scrollFactor.y = 0;
			}
			add(trophies);
			 
			  
			/* playtime **/
			
			playtime_text = EventScripts.init_bitmap_font("00:00:00", "left", 1, 156, null, "apple_white");
			playtime_text.color = 0xffffff;
			playtime_text.drop_shadow = true;
			base_group.add(playtime_text);
			add(playtime_text);
			
		}
		override public function update():void {
		
			// Calc playtime!!!!
			var playtime_dat:int = 0;
			playtime_dat = Registry.playtime;
			var hrs:int = int(playtime_dat / 3600);
			
			if (hrs >= 10) {
				playtime_text.text = int(playtime_dat / 3600).toString() + ":";
			} else {
				playtime_text.text = "0" + int(playtime_dat / 3600).toString() + ":";
			}
			playtime_dat -= 3600 * hrs;
			
			var mins:int = int(playtime_dat / 60);
			if (mins >= 10) {
				playtime_text.text += int(playtime_dat / 60).toString() + ":";	
			} else {
				playtime_text.text = playtime_text.text + "0" + int(playtime_dat / 60).toString() + ":";
			}
			playtime_dat -= 60 * mins;
			
			if (playtime_dat >= 10) {
				playtime_text.text += playtime_dat.toString();	
			} else {
				playtime_text.text = playtime_text.text +  "0"+ playtime_dat.toString();	
			}
			
			if (Registry.GAMESTATE.load_dialogue) {
				Registry.GAMESTATE.dialogue_state.push(this as FlxState);
				Registry.GAMESTATE.load_dialogue = false;
				state = s_dialogue;
				return;
				 
			} else if (state == s_dialogue) {
				dialogue_logic();
				super.update();
				return;
			}
		
			if (ctr_settings != 1) {
				if (state == s_browse) {
					check_for_exit_with(Registry.keywatch.JP_ACTION_2 || Registry.keywatch.JUST_PRESSED_PAUSE);
				} else {
					check_for_exit_with(Registry.keywatch.JUST_PRESSED_PAUSE);
				}
			}
			if (!init_parent) {
				parent = Registry.GAMESTATE;
				init_parent = true;
			}
			switch (state) {
				case s_browse:
					browse_logic();
					break;
				case s_map:
					map_logic();
					break;
				case s_equip:
					equip_logic();
					break;
				case s_cards:
					cards_logic();
					break;
				case s_save:
					save_logic();
					break;
				case s_settings:
					settings_logic();
					break;
				case s_secretz:
					secretz_logic();
					break;
				case s_cheatz:
					cheatz_logic();
					break;
			}
			
			if (Registry.keywatch.JP_UP || Registry.keywatch.JP_DOWN || Registry.keywatch.JP_LEFT || Registry.keywatch.JP_RIGHT) {
				Registry.sound_data.play_sound_group(Registry.sound_data.menu_move_group);
			} 
			
			if (Registry.keywatch.JP_ACTION_1) {
				Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
			}
			
			super.update();
		}
		

		private function set_equip_vis(idx:int):void {
			var equip_box:FlxSprite = equip_boxes.members[idx];
			
			switch (idx) {
				case 1: //long 
					idx = Registry.IDX_LENGTHEN;
					break;
				case 2: //widen
					idx = Registry.IDX_WIDEN;
					break; 
				case 3: //stransform
					idx = Registry.IDX_TRANSFORMER;
					break;
			}
			if (!Registry.inventory[idx]) {
				equip_box.visible = false;
			} else {
				equip_box.visible = true;
			}
		}

		public var secret_counter:int = 0;
		public function browse_logic():void {
			
			/* Pop up substates but don't do their logic */
			if (!current_substate_visible) {
				
				current_substate_visible = true;
				
				remove(base_group, true);
				add(base_group);		
				remove(selectors, true);
				add(selectors);
				
				selectors.setAll("visible", false);
				
				switch (base_index) {
					case 0: // Minimap
						if (minimap.has_map) {
							minimap.stuff_for_pause_state();
						}
						remove(minimap, true);
						add(minimap);
						remove(legend_cur_b, true);
						add(legend_cur_b);
						remove(legend_entrance_b, true);
						add(legend_entrance_b);
						remove(legend_cur, true);
						add(legend_cur);
						remove(legend_entrance, true);
						add(legend_entrance);
						remove(selectors, true); add(selectors);
						text_1.visible = text_2.visible = true;
					text_1.text = " :Current room\n\
									 :Door/Exit\n"; 
						text_1.x = 60;
						text_1.y = 115;
						
						text_2.multiLine = true;
						text_2.autoUpperCase = false;
						
						text_3.visible = false;
						text_3.text = "Yes    No";
						if (Registry.GE_States[Registry.GE_ENTERED_NEXUS_ONCE] == true && false == is_crowd_minidungeon()) {
							if (false == Registry.is_dungeon(Registry.CURRENT_MAP_NAME)) {
								
									text_2.text = "Return to\nNexus";
								if (minimap.has_map) {
									text_2.x = text_1.x + 19;
									text_3.x = text_1.x + 14;
									text_2.y = 135;
									text_3.y = 153;
									
									legend_cur_b.visible = legend_entrance_b.visible = legend_cur.visible = legend_entrance.visible = true;
								} else {
									text_1.text = "No map";
									text_1.x = equip_boxes.members[0].x + equip_boxes.members[0].width + 4;
									text_1.y = 30;
									text_2.x = 60 + 19;
									text_2.y = 135;
									text_3.x = 79;
									text_3.y = 153;
									text_2.text = "Return to\nNexus";
									legend_cur_b.visible = legend_entrance_b.visible = legend_cur.visible = legend_entrance.visible = false;
								}
								
							} else {
								text_2.text = "Return to\nentrance"
								text_2.x = text_1.x + 19;
								text_3.x = text_1.x + 14;
								text_2.y = 135;
								text_3.y = 153;
								
								legend_cur_b.visible = legend_entrance_b.visible = legend_cur.visible = legend_entrance.visible = true;
							}
						} else {
							text_2.visible = false;
						}
						break;
					case 1: // eqip
						remove(equip_overlay, true); add(equip_overlay);
						remove(equip_boxes, true); add(equip_boxes);
						remove(key_icons, true); add(key_icons);
						remove(equip_icon, true); add(equip_icon);
						remove(selectors, true); add(selectors);
						remove(trade_item, true); add(trade_item);
						remove(jump_shoes, true); add(jump_shoes);
						
						jump_shoes.visible = (Registry.bound_item_2 == "JUMP");
						set_trade_item();
						
						set_key_graphics();
						
						for (var fuckme:int = 0; fuckme < 4; fuckme++) {
							equip_boxes.members[fuckme].visible = false;
						}
						
						if (Registry.inventory[Registry.IDX_BROOM]) {
							equip_boxes.members[0].visible = true;
						}
						if (Registry.inventory[Registry.IDX_LENGTHEN]) {
							equip_boxes.members[1].visible = true;
						} 
						if (Registry.inventory[Registry.IDX_WIDEN]) {
							equip_boxes.members[2].visible = true;
						}
						if (Registry.inventory[Registry.IDX_TRANSFORMER]) {
							equip_boxes.members[3].visible = true;
						}
						
						if (Registry.bound_item_1 == Registry.item_names[Registry.IDX_TRANSFORMER]) {
							equip_icon.y = equip_boxes.members[0].y - 1 + 24*3;
						}  else if (Registry.bound_effect == Registry.item_names[Registry.IDX_WIDEN]) {
							equip_icon.y = equip_boxes.members[0].y - 1 + 24*2;
						} else if (Registry.bound_effect == Registry.item_names[Registry.IDX_LENGTHEN]) {
							equip_icon.y = equip_boxes.members[0].y - 1 + 24;
						} else {
							equip_icon.y = equip_boxes.members[0].y - 1;
						}
						if (!Registry.inventory[Registry.IDX_BROOM]) {
							equip_icon.visible = false;
						} else {
							equip_icon.visible = true;
						}
						var normal_string:String = Registry.inventory[Registry.IDX_BROOM] ? "Normal" : "-";
						var status_1:String = Registry.inventory[Registry.IDX_LENGTHEN] ? "Extend" : "-";
						var status_2:String = Registry.inventory[Registry.IDX_WIDEN] ? "Widen" : "-";
						var status_3:String = Registry.inventory[Registry.IDX_TRANSFORMER] ? "Swap" : "-";
						
						text_1.visible = true;
						text_1.setText(normal_string+"\n\n\n"+status_1+"\n\n\n"+status_2+"\n\n\n"+status_3, true, 0, 0, "left", true);
						text_1.x = equip_boxes.members[0].x + equip_boxes.members[0].width + 4;
						text_1.y = 30;
						text_2.visible = text_3.visible = false;
						break; 
					case 2: //card
						remove(cards, true); add(cards);
						remove(selectors, true); add(selectors);
						set_card_images();
						text_1.visible = true;
						text_1.setText("1/4", true, 0, 0, "center", true);
						text_1.x = 99;
						text_1.y = 158;
						text_2.visible = true;
						text_2.setText(Registry.nr_growths.toString() + " cards", true, 0, 0, "left", true);
						text_2.x = 70;
						text_2.y = 148;
						 text_3.visible = false;
						cards_cursor_idx = 0;
						cur_cards_pg = 0;
						break;
					case 3: // save 
						text_1.visible = true;
						text_1.setText("Save\nSave and go\n to title\nSave and quit\nQuit game", true, 0, 0, "left", true);
						text_1.text += "\n\n\n\nDeaths: " + Registry.death_count.toString();
						
						text_1.x = 69;
						text_1.y = 30;
						text_2.visible = text_3.visible = false;
						break;
					case 4: //settings
						text_1.visible = text_3.visible = true;
						var autosave_state:String = Registry.autosave_on ? "On" : "Off";
						set_settings_text(true);
						text_1.x = 68;
						text_1.y = 30;
						text_2.visible = false;
						text_3.x = 68;
						text_3.y = 120;
						if (Intra.is_mobile) text_3.visible = false;
						text_3.setText("Scaling: " + Intra.scale_factor.toString() + "x",true,0,0,"left",true);
						
						remove(volume_bar_bg, true); add(volume_bar_bg);
						remove(volume_bar, true); add(volume_bar);
						remove(volume_bar_overlay, true); add(volume_bar_overlay);
						remove(window_config, true); add(window_config);
						remove(window_words, true); add(window_words);
						break;
					case 5: // SECRETS!!!
						text_1.visible = text_2.visible = text_3.visible = false;
						remove(trophies, true); add(trophies);
						remove(selectors, true); add(selectors);
						break;
					case 6: // CHEATS!!!	
						break;
				}
			}
			
			if (Registry.keywatch.JP_DOWN) {
				if (base_index < max_base_index) {
					current_substate_visible = false;
					base_index++;
					secret_counter = 0;
					menu_select_active.y += 16;
					menu_select_inactive.y = menu_select_active.y;
				} else {
					if (base_index == 4 && Registry.GE_States[Registry.GE_HAVE_A_SECRET]) {
						current_substate_visible = false;
						menu_select_active.y += 16;
						menu_select_inactive.y = menu_select_active.y;
						base_index++;
					} else {
						secret_counter++;
						if (secret_counter > 20 && base_index != 6) {
							current_substate_visible = false;
							if (base_index == 4) {
								menu_select_active.y += 32;
							} else {
								menu_select_active.y += 16;
							}
							menu_select_inactive.y = menu_select_active.y;
							base_index = 6;
						}
					}
				}
			} else if (Registry.keywatch.JP_UP) {
				if (base_index > 0) {
					current_substate_visible = false;
					if (base_index == 6 && false == Registry.GE_States[Registry.GE_HAVE_A_SECRET]) {
						base_index = 4;
						menu_select_active.y -= 32;
					} else {
						base_index--;
						menu_select_active.y -= 16;
					}
					menu_select_inactive.y =  menu_select_active.y;
				}
			}
			
			/* State change to submenus, also change cursor animations and positions */
			if (Registry.keywatch.JP_ACTION_1 || Registry.keywatch.JP_RIGHT) {
				menu_select_active.visible = false;
				menu_select_inactive.visible = true;
				
				switch (base_index) {
					case 0:
						
						if (Registry.GE_States[Registry.GE_ENTERED_NEXUS_ONCE] == false || is_crowd_minidungeon()) {
							menu_select_active.visible = true;
							menu_select_inactive.visible = false;
							break;
						}
						state = s_map;
						selectors.members[1].scale.x = 1;
						selectors.members[2].scale.x = 1;
						selectors.members[1].visible = true;
						selectors.members[1].x = 70;
						selectors.members[1].y = 135;
						selectors.members[1].play("enabled");
						map_cursor_idx = 1;
						break;
					case 1:
						// If no items, equip submenu is inacessible.
						if (!equip_icon.visible) {
							menu_select_active.visible = true;
							menu_select_inactive.visible = false;
						} else {
							state = s_equip;
							equip_cursor_idx = 0;
							selectors.members[1].scale.x = 1;
							selectors.members[1].visible = true;
							selectors.members[1].x = 80;
							selectors.members[1].y = 30;
							selectors.members[1].play("enabled");
						}
						break;
					case 2:
						
						//selectors.members[1].visible = selectors.members[2].visible = true;
						selectors.members[1].x = text_1.x - 7;
						selectors.members[1].y = text_1.y;
						selectors.members[2].x = text_1.x + text_1.width;
						selectors.members[2].y = text_1.y;
						selectors.members[1].play("enabled");
						selectors.members[2].play("enabled");
						selectors.members[1].scale.x = -1;
						selectors.members[2].scale.x = 1;
						
						
						cards_cursor_idx = 0;
						state = s_cards;
						card_pg_to_cards();
						break;
					case 3:
						state = s_save;
						selectors.members[1].scale.x = 1;
						selectors.members[1].visible = true;
						selectors.members[1].x = text_1.x - 8;
						selectors.members[1].y = text_1.y;
						selectors.members[1].play("enabled");
						save_cursor_idx = 0;
						break;
					case 4:
						selectors.members[1].scale.x = 1;
						selectors.members[1].visible = true;
						selectors.members[1].x = text_1.x - 7;
						selectors.members[1].y = text_1.y;
						selectors.members[1].play("enabled");
						settings_cursor_idx = 0;
						state = s_settings;
						break;
					case 5:
						 //secretsx
						 state = s_secretz;
						selectors.members[1].scale.x = 1;
						selectors.members[1].visible = true;
						selectors.members[1].x = trophies.members[0].x - 7;
						selectors.members[1].y = trophies.members[0].y + 4;
						selectors.members[1].play("enabled");
						secretz_idx = 0;
						break;
					case 6: //cheatsz
						state = s_cheatz;
						break;
				}
			}
			
			
			
		}
		
		
		
		private function map_logic():void {
			
			// Cancel
			if (Registry.keywatch.JP_ACTION_2 || Registry.keywatch.JP_LEFT) {
				// Return to browse, or
				if (map_ctr == 0) {
					Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
					state = s_browse;
					selectors.members[1].visible = false;
					selectors.members[2].visible = false;
					menu_select_active.visible = true;
					menu_select_inactive.visible = false;
					map_cursor_idx = 1;
				// Return to top-level of map submenu
				} else if (!Registry.keywatch.JP_LEFT) {
					selectors.members[2].visible = false;
					selectors.members[1].play("enabled");
					map_cursor_idx = 1;
					map_ctr = 0;
				}
			}
			
			// Select
			if (Registry.keywatch.JP_ACTION_1) {
				switch (map_ctr) {
					// Go to yes/no context for return to entrance
					case 0:
						selectors.members[2].visible = true;
						selectors.members[2].play("enabled");
						selectors.members[1].play("disabled");
						selectors.members[2].x = text_3.x - 6 + 45;
						selectors.members[2].y = text_3.y;
						text_3.visible = true;
						map_ctr++;
					
						break;
					// Eitehr go back, or switch maps
					case 1:
						if (map_cursor_idx == 0) {
							// switch state
							Registry.cleanup_on_map_change();
							if (false == Registry.is_dungeon(Registry.CURRENT_MAP_NAME)) { // If not in a dungeon want 2 warp to nexus
								if (Registry.CURRENT_MAP_NAME == "BLANK" || Registry.CURRENT_MAP_NAME == "DRAWER" || Registry.CURRENT_MAP_NAME == "NEXUS") {
									Registry.NEXT_MAP_NAME = "NEXUS";
									Registry.ENTRANCE_PLAYER_X = Registry.DUNGEON_ENTRANCES["NEXUS"].x;
									Registry.ENTRANCE_PLAYER_Y = Registry.DUNGEON_ENTRANCES["NEXUS"].y;
								} else {
									NPC.load_nexus_data();
								}
							} else {
								Registry.NEXT_MAP_NAME = Registry.CURRENT_MAP_NAME;
								Registry.ENTRANCE_PLAYER_X = Registry.DUNGEON_ENTRANCES[Registry.CURRENT_MAP_NAME].x;
								Registry.ENTRANCE_PLAYER_Y = Registry.DUNGEON_ENTRANCES[Registry.CURRENT_MAP_NAME].y;
							}
							//FlxG.switchState(new PlayState);
							Registry.BOI = false;
							parent.SWITCH_MAPS = true;
							Registry.sound_data.start_song_from_title(Registry.NEXT_MAP_NAME);
							reset_counters();
							done = true;
						} else { 
							selectors.members[1].play("enabled");
							selectors.members[2].visible = false;
							map_cursor_idx = 1;
							map_ctr = 0;
						}
						break;
				}
			}
			
			// Deal with/left right for yes/no context
			if (map_ctr == 1) {
				if (Registry.keywatch.JP_RIGHT && map_cursor_idx < 1) {
					map_cursor_idx++;
					selectors.members[2].x += 47;
				} else if (Registry.keywatch.JP_LEFT && map_cursor_idx > 0) {
					map_cursor_idx--;
					selectors.members[2].x -= 47;
				}
			}
		}
		private function equip_logic():void {
			if (Registry.keywatch.JP_ACTION_2 || (Registry.keywatch.JP_LEFT && equip_cursor_idx <= 10)) {
				Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
				state = s_browse;
				selectors.members[1].visible = false;
				menu_select_active.visible = true;
				menu_select_inactive.visible = false;
			}
			
			if (Registry.keywatch.JP_DOWN) {
				if (equip_cursor_idx < 3) {
					equip_cursor_idx++;
					selectors.members[1].y += 24;
				} else if (equip_cursor_idx == 3) {
					equip_cursor_idx = 10;

					if (Registry.inventory[Registry.IDX_JUMP]) {
						selectors.members[1].y = jump_shoes.y;
						selectors.members[1].x = jump_shoes.x - 3;	
					} else if (Registry.inventory[Registry.IDX_BIKE_SHOES] || Registry.inventory[Registry.IDX_BOX]) {
						selectors.members[1].y = trade_item.y;
						selectors.members[1].x = trade_item.x - 3;	
						equip_cursor_idx = 11;
					} else {
						selectors.members[1].y = key_icons.members[0].y;
						selectors.members[1].x = key_icons.members[0].x - 3;	
						equip_cursor_idx = 12;
					}
					
				}
			} else if (Registry.keywatch.JP_UP) {
				if (equip_cursor_idx > 0) {
					if (equip_cursor_idx >= 10) {
						selectors.members[1].y = 102;
						selectors.members[1].x = 80;
						equip_cursor_idx = 3;
					} else {
						equip_cursor_idx--;
						selectors.members[1].y -= 24;
					}
				} 
			}
			
			if (Registry.keywatch.JP_RIGHT) {
				if (equip_cursor_idx < 14) {
					if (equip_cursor_idx == 10) {
						if (!(Registry.inventory[Registry.IDX_BIKE_SHOES] || Registry.inventory[Registry.IDX_BOX])) {
							equip_cursor_idx = 12;
						} else {
							equip_cursor_idx = 11;
						}
					} else {
						equip_cursor_idx++;
					}
				}
				// oh my goddd
			} else if (Registry.keywatch.JP_LEFT) {
				if (equip_cursor_idx > 10) {
					if (equip_cursor_idx == 11) {
						if (Registry.inventory[Registry.IDX_JUMP]) {
							equip_cursor_idx = 10;
						}
					} else {
						if (equip_cursor_idx == 12) {
							if ((Registry.inventory[Registry.IDX_BIKE_SHOES] || Registry.inventory[Registry.IDX_BOX])) {
								equip_cursor_idx = 11;
							} else if (Registry.inventory[Registry.IDX_JUMP]) {
								equip_cursor_idx = 10;
							}
						} else {
							equip_cursor_idx--;
						}
					}
				}
			}
			
			if (Registry.keywatch.JP_LEFT || Registry.keywatch.JP_RIGHT) {
				if (equip_cursor_idx == 10) {
					selectors.members[1].y = jump_shoes.y;
					selectors.members[1].x = jump_shoes.x - 3;	
				} else if (equip_cursor_idx == 11) {
					selectors.members[1].y = trade_item.y;
					selectors.members[1].x = trade_item.x - 3;	
				} else if (equip_cursor_idx > 11) {
					selectors.members[1].y = key_icons.members[equip_cursor_idx - 12].y;
					selectors.members[1].x = key_icons.members[equip_cursor_idx - 12].x - 3;	
				}
			}
			
			if (Registry.keywatch.JP_ACTION_1) {
				
				switch(equip_cursor_idx) {
					case 0:
						Registry.bound_item_1 = Registry.item_names[Registry.IDX_BROOM];
						set_passive_effect(Registry.IDX_BROOM);
						
						equip_icon.y = equip_boxes.members[0].y - 1;
						break;
					case 1:
						if (Registry.inventory[Registry.IDX_LENGTHEN]) {
							Registry.bound_item_1 = Registry.item_names[Registry.IDX_BROOM];
							if (Registry.bound_effect != Registry.item_names[Registry.IDX_LENGTHEN]) {
								set_passive_effect(Registry.IDX_LENGTHEN);
							}
							equip_icon.y = equip_boxes.members[0].y - 1 + 24;
						}
						break;
					case 2:
						if (Registry.inventory[Registry.IDX_WIDEN]) {
							Registry.bound_item_1 = Registry.item_names[Registry.IDX_BROOM];
							if (Registry.bound_effect != Registry.item_names[Registry.IDX_WIDEN]) {
								set_passive_effect(Registry.IDX_WIDEN);
							}
							equip_icon.y = equip_boxes.members[0].y - 1 + 24*2;
						}
						break;
					case 3:
						if (Registry.inventory[Registry.IDX_TRANSFORMER]) {
							Registry.bound_item_1 = Registry.item_names[Registry.IDX_TRANSFORMER];
							set_passive_effect(Registry.IDX_BROOM); // Remove the passive effect
							equip_icon.y = equip_boxes.members[0].y - 1 + 24*3;
						}
						break;
					case 10:
						DH.dialogue_popup("A pair of spring-loaded shoes - press "+Registry.controls[Keys.IDX_ACTION_2]+" to jump!");
						break;
					case 11:
						if (Registry.inventory[Registry.IDX_BIKE_SHOES]) {
							DH.dialogue_popup("A pair of shoes for biking.");
						} else {
							DH.dialogue_popup("An empty cardboard box.");
						}
						break;
					case 12:
						if (Registry.inventory[Registry.IDX_GREEN_KEY]) 
							DH.dialogue_popup("A key found in the Temple of the Seeing One.");
						break;
					case 13:
						if (Registry.inventory[Registry.IDX_RED_KEY]) 
							DH.dialogue_popup("A key found in a red, underground cave.");
						break;
					case 14:
						if (Registry.inventory[Registry.IDX_BLUE_KEY]) 
							DH.dialogue_popup("A key found in a mountain cave.");
						break;
				}
				
				if (equip_cursor_idx < 4) {
					if (Registry.bound_item_1 == "TRANSFORMER" || Registry.bound_item_2 == "TRANSFORMER") {
						Registry.E_Transformer_On = true;
					} else {
						Registry.E_Transformer_Off = true;
					}
					
					
					Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
					state = s_browse;
					selectors.members[1].visible = false;
					current_substate_visible = false;
					menu_select_active.visible = true;
					menu_select_inactive.visible = false;
				}
				
			//set_placeholder_image(1);
			}
			
		}
		
		// The locations of the cards, so we can map them to proper images when opening a chest.
		// Dungeon x/y vals are the room, roamstates are the actual coordinates in DAME-coords (so no y-offset of 20)
		public static var card_data:Object = {
			"BLANK": new Array( { id: 44, x: 5, y: 1 } ),
			"DRAWER": new Array( {id: 36, x:2, y:1}, {id: 37, x:4, y:7}),
			"OVERWORLD": new Array( { id: 0, x:1, y:9 } , {id: 1, x:5, y:7} ),
			"BEDROOM": new Array( { id: 2, x: 3, y: 0 }, { id:3, x:1, y:0 }, { id:4, x:2, y:3 }, { id:5, x:5, y:0 } ),
			"SUBURB": new Array( { id : 6 , x: 1, y:7 } , {id: 42, x:2 , y:7}),
			"APARTMENT": new Array( { id: 7, x : 8, y : 7 }, { id: 8, x:3, y:5 }, { id:9, x:0, y:0 } ) , 
			"FIELDS": new Array( { id: 10, x :3, y: 8}, {id : 11, x : 6, y: 9}, {id: 43, x: 8, y : 0}, {id: 45,x:11,y:9}),
			"WINDMILL": new Array( {id: 12, x: 1, y:5} ),
			"FOREST" :new Array( {id: 13, x:3, y:2}), 
			"CLIFF": new Array( { id: 14, x:4, y:2 }, { id: 15, x: 2, y:7}), 
			"BEACH": new Array( { id: 16, x:4, y:3 } ) , 
			"REDSEA": new Array( { id: 17, x:2, y:2}, {id: 47, x:0,y:6} ),
			"REDCAVE": new Array( { id: 18, x:3 , y :1 } , { id : 19, x:0, y:0 }, { id: 20, x:6, y:1 } ),
			"TRAIN" : new Array( { id: 21, x: 0 , y:0 } , {id: 40, x:5, y : 8}), // CELL
			"CIRCUS" : new Array( { id: 23, x: 0 , y : 3 }, { id : 22, x:3, y:6 } , { id : 24, x: 3, y:2 }, { id:25, x: 7, y: 0 } ),
			"CROWD" : new Array( {id : 26, x:2 , y: 2} , {id: 27, x: 8, y: 2} , {id: 28 , x:9, y:5 }),
			"SPACE" : new Array ( { id: 29, x:0, y:0} , {id: 30, x:9,y:0}, {id:41, x:5, y:7}),
			"HOTEL": new Array( { id: 31, x:3, y:6 }, { id:32, x:1, y:8 }, { id:33, x:9, y:3 } , { id:34, x:8, y:11 } , {id:38, x:5, y:0}),
			"TERMINAL" : new Array ( { id: 35, x: 4, y:2 } ),
			"DEBUG" : new Array( { id: 39, x:4, y:3 } ),
			"STREET": new Array( {id:46, x:1, y:6})
			
		};
		
		private function cards_logic():void {
			
			// Exit card select, or exit card submenu
			if (Registry.keywatch.JP_ACTION_2 || (Registry.keywatch.JP_LEFT && cur_cards_pg == 0 && (cards_cursor_idx % 3 == 0))) {
				Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
				state = s_browse;
				selectors.members[3].visible = false;
				selectors.members[1].visible = selectors.members[2].visible = false;
				menu_select_active.visible = true;
				menu_select_inactive.visible = false;
				//cur_cards_pg = 0;
				//cards_cursor_idx = 0;
			}
			
			
			
			// Move about card select, or move between pages
			if (selectors.members[3].visible) { //if card select 
				if ((cards_cursor_idx % 12) > 2 && Registry.keywatch.JP_UP) {
					cards_cursor_idx -= 3;
					selectors.members[3].y -= 29;
				} else if ((cards_cursor_idx % 12) < 9 && Registry.keywatch.JP_DOWN) {
					cards_cursor_idx += 3;
					selectors.members[3].y += 29;
				} else if (Registry.keywatch.JP_DOWN) {
					selectors.members[3].visible = false;
					selectors.members[1].visible = true;
					selectors.members[2].visible = true;
					selectors.members[1].play("enabled");
					selectors.members[2].play("enabled");
				}
				
				if ((cards_cursor_idx % 3) < 2 && Registry.keywatch.JP_RIGHT) {
					cards_cursor_idx ++;
					selectors.members[3].x += 30;
				} else if ((cards_cursor_idx % 3) > 0 && Registry.keywatch.JP_LEFT) {
					cards_cursor_idx --;
					selectors.members[3].x -= 30;
				} else if ((cards_cursor_idx % 3) == 0 && Registry.keywatch.JP_LEFT) {
					if (cur_cards_pg > 0) {
						cur_cards_pg --;
						cards_cursor_idx += 2;
						selectors.members[3].x += 60;
						set_card_images();
						if (cur_cards_pg == 1) {
							text_1.text = "2/4";
						} else if (cur_cards_pg == 2) {
							text_1.text = "3/4";
						} else {
							text_1.text = "1/4";
						}
					}
				} else if ((cards_cursor_idx % 3) == 2 && Registry.keywatch.JP_RIGHT) {
					if (cur_cards_pg < 3) {
						cur_cards_pg ++;
						cards_cursor_idx -= 2;
						selectors.members[3].x -= 60;
						set_card_images();
						if (cur_cards_pg == 1) {
							text_1.text = "2/4";
						} else if (cur_cards_pg == 2) {
							text_1.text = "3/4"
						} else {
							text_1.text = "4/4";
						}
					}
				}
			} else {
				if (cur_cards_pg < 3 && Registry.keywatch.JP_RIGHT) {
					cur_cards_pg++;
					set_card_images();
					if (cur_cards_pg == 1) {
						text_1.text = "2/4";
					} else if (cur_cards_pg == 2) {
						text_1.text = "3/4"
					} else {
						text_1.text = "4/4";
					}
					//Load new sprites....
				} else if (cur_cards_pg > 0 && Registry.keywatch.JP_LEFT) {
					cur_cards_pg--;
					set_card_images();
					if (cur_cards_pg == 1) {
						text_1.text = "2/4";
					} else if (cur_cards_pg == 2) {
						text_1.text = "3/4";
					} else {
						text_1.text = "1/4";
					}
					//load new sprites...
				}
				if (Registry.keywatch.JP_UP) {
					card_pg_to_cards();
				}
			}
			
			// Go to card select or do something with a single card
			if (Registry.keywatch.JP_ACTION_1) {
				if (selectors.members[3].visible) {
					var idx:int = cards_cursor_idx + cur_cards_pg * 12;
					if (Registry.card_states[idx]) {
						DH.start_dialogue(DH.name_card, DH.scene_card_one, DH.area_etc, idx);
					}
				// Do something
				} else { // Go to card select
					card_pg_to_cards();
				}
			}
		}
		private function save_logic():void {
			if (Registry.keywatch.JP_ACTION_2) {
				Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
				state = s_browse;
				selectors.members[1].visible = false;
				menu_select_active.visible = true;
				menu_select_inactive.visible = false;
			}

			if (Registry.keywatch.JP_DOWN) {
				if (save_cursor_idx < 3) {
					save_cursor_idx++;
					if (save_cursor_idx == 2) {
						selectors.members[1].y += 16;
					} else {
						selectors.members[1].y += 8;
					}
				}
			} else if (Registry.keywatch.JP_UP) {
				if (save_cursor_idx > 0) {
					save_cursor_idx--;
					if (save_cursor_idx == 1) {
						selectors.members[1].y -= 16;
					} else {
						selectors.members[1].y -= 8;
					}
				}
			}
			
			if (Registry.keywatch.JP_ACTION_1) {
				Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
				switch (save_cursor_idx) {
					case 0:
					if (Save.save()) {
						text_1.text =  "Saved!\nSave and go\n to title\nSave and quit\nQuit game";
						text_1.text += "\n\n\n\nDeaths: " + Registry.death_count.toString();
					} else {
						text_1.text = "ERROR\nSave and go\n to title\nSave and quit\nQuit game";
						text_1.text += "\n\n\n\nDeaths: " + Registry.death_count.toString();
					}
					break;
				case 1:
					Registry.cleanup_on_map_change();
					Registry.sound_data.stop_current_song();
					Save.save();
					FlxG.switchState(new TitleState);
					break;
				case 2:
					Save.save();
					//NativeApplication.nativeApplication.exit();
					break;
				case 3:
					//NativeApplication.nativeApplication.exit();
					break;
					
				} 
			}
			
		}
		
		private function settings_logic():void {
			
			if (ctr_settings == 0) {
				if (Registry.keywatch.JP_ACTION_2 || (Registry.keywatch.JP_LEFT && !selectors.members[2].visible)) {
					Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
					state = s_browse;
					selectors.members[1].visible = false;
					menu_select_active.visible = true;
					menu_select_inactive.visible = false;
				}
				if (Registry.keywatch.JP_DOWN) {
					if (settings_cursor_idx < 5) {
						settings_cursor_idx ++;
						if (settings_cursor_idx == 2) {
							selectors.members[1].y += 24;
						} else if (settings_cursor_idx == 3) {
							selectors.members[1].y += 32;
							if (Intra.is_mobile) {
								selectors.members[1].y += 32; 
								settings_cursor_idx = 5;
							}
						} else {
							selectors.members[1].y += 16;
						}
					} 
				} else if (Registry.keywatch.JP_UP) {
					if (settings_cursor_idx > 0) {
						settings_cursor_idx -- ;
						if (settings_cursor_idx == 1) {
							selectors.members[1].y -= 24;
						} else if (settings_cursor_idx == 2) {
							selectors.members[1].y -= 32;
						} else if (settings_cursor_idx == 4 && Intra.is_mobile) {
							selectors.members[1].y -= 64;
							settings_cursor_idx = 2;
						} else {
							selectors.members[1].y -= 16;
						}
					}
				}
				
				if (Registry.keywatch.JP_ACTION_1) {
					if (settings_cursor_idx == 0) { 
						// Goto controls
						if (!Intra.is_mobile) {
							ctr_settings = 1;
							controls_state.push(this);
						// If mobile, just flip X/C functions
						} else {
							var gam:Intra = FlxG._game as Intra;
							gam.mobile_flip_x_c();
						}
					} else if (settings_cursor_idx == 1) { // goto volume
						ctr_settings = 2;
						selectors.members[1].play("disabled");
						selectors.members[2].play("enabled");
						selectors.members[3].play("enabled");
						selectors.members[2].visible = selectors.members[3].visible = true;
						selectors.members[2].scale.x = -1;
						selectors.members[2].x = selectors.members[1].x; selectors.members[2].y = 58;
						selectors.members[3].x = 138; selectors.members[3].y = 58;
						
					} else if (settings_cursor_idx == 2) {
						Registry.autosave_on = !Registry.autosave_on;
						set_settings_text(true);
						
					} else if (settings_cursor_idx == 3) { // Change resize type
						Intra.force_scale = true;
						set_settings_text();
					
					} else if (settings_cursor_idx == 4) { // Change integer scaling
						ctr_settings = 3;
						selectors.members[1].play("disabled");
						selectors.members[2].play("enabled");
						selectors.members[3].play("enabled");
						selectors.members[1].visible = false;
						selectors.members[2].visible = selectors.members[3].visible = true;
						selectors.members[2].scale.x = -1;
						selectors.members[2].x = selectors.members[1].x + 58; selectors.members[2].y = 120;
						selectors.members[3].x = 147; selectors.members[3].y = 120;
						
					} else if (settings_cursor_idx == 5) { //window size config
						if (Intra.is_mobile) {
							var _gam:Intra = FlxG._game as Intra;
							_gam.mobile_flip_handedness();
						} else if (false == Intra.is_web) {
							ctr_settings = 4;
							Intra.scale_factor = 3;
							Intra.force_scale = true;
							window_words.visible = window_config.visible = true;
						}
					}
				} 
			} else if (ctr_settings == 1) { //controls
				controls_state.update();
				if (!controls_state.updating && (Registry.keywatch.JUST_PRESSED_PAUSE || FlxG.keys.justPressed("ESCAPE")) ) {
					controls_state.pop(this);
					ctr_settings = 0;
					text_info.text = Registry.controls[Keys.IDX_ACTION_1] + ":Select " + Registry.controls[Keys.IDX_ACTION_2] + ":Back";
				}
			} else  if (ctr_settings == 2) { //volume
				if (Registry.keywatch.JP_ACTION_2) {
						selectors.members[1].play("enabled");
						ctr_settings = 0;
						selectors.members[2].visible = selectors.members[3].visible = false;
						selectors.members[2].scale.x = 1;
				}
				
				if (Registry.keywatch.JP_LEFT) {
					FlxG.volume > 0 ? FlxG.volume -= 0.1 : 1;
				} else if (Registry.keywatch.JP_RIGHT) {
					FlxG.volume < 1 ? FlxG.volume += 0.1 : 1;
				}
				
				
				//text_2.setText(int(FlxG.volume * 10).toString());
				volume_bar.scale.x = int(FlxG.volume * 30);
				volume_bar.x = volume_bar_overlay.x + volume_bar.scale.x -1;
			 } else if (ctr_settings == 3) { // Integer scaling
				if (Registry.keywatch.JP_ACTION_2) {
					selectors.members[1].play("enabled");
					ctr_settings = 0;
					selectors.members[1].visible = true
					selectors.members[2].visible = selectors.members[3].visible = false;
					selectors.members[2].scale.x = 1;
				}
				
				
				text_3.setText("Scaling: " + Intra.scale_factor.toString() + "x",true,0,0,"left",true);
				
				if (Registry.keywatch.JP_LEFT) {
					if (Intra.scale_factor > 1) {
						Intra.scale_factor--;
						Intra.scale_ctr = (Intra.scale_ctr - 1) % 3;
						Intra.force_scale = true;
					}
				} else if (Registry.keywatch.JP_RIGHT) {
					// See if we can scale further 
					var ratio:Number = (Intra.scale_factor + 1 ) / 3;
					if (FlxG._game.stage.fullScreenHeight < ratio * 540 || FlxG._game.stage.fullScreenWidth < ratio * 480) {
						
					}else if  (Intra.scale_factor < 8) {
						Intra.scale_factor++;
						Intra.scale_ctr = (Intra.scale_ctr - 1) % 3; // Display style should stay the same
						Intra.force_scale = true;
					}
				}
			} else if (ctr_settings == 4) { 
				//TitleState.window_config_logic(Registry.keywatch);
				if (Registry.keywatch.JP_ACTION_2 || Registry.keywatch.JP_ACTION_1) {
					ctr_settings = 0;
						window_words.visible = window_config.visible = false;
				}
			}
		}
		
		private function cheatz_logic():void {
			if (Registry.keywatch.JP_ACTION_2) {
					Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
					state = s_browse;
					menu_select_active.visible = true;
					menu_select_inactive.visible = false;
			}
			
			text_1.visible = true;
			text_1.x = 64;
			text_1.y = 50;
			
			
			if (text_1.text.length < 11) {
				if (Registry.keywatch.JP_DOWN) {
					text_1.text += "D";
				} else if (Registry.keywatch.JP_RIGHT) {
					text_1.text += "R";
				} else if (Registry.keywatch.JP_UP) {
					text_1.text += "U";
				} else if (Registry.keywatch.JP_LEFT) {
					text_1.text += "L";
				} else if (Registry.keywatch.JP_ACTION_1) {
					text_1.text += "1";
				} else if (Registry.keywatch.JP_ACTION_2) {
					text_1.text += "2";
				}
		
				
			} else {
				switch (text_1.text) {
					case " UUDDLRLR21":
						Registry.sound_data.get_key.play();
						Registry.GAMESTATE.player.health_bar.modify_health(20);
						Achievements.unlock_all();
						break;
					case " URDLURDLUR":
						Registry.sound_data.shieldy_hit.play();
						Registry.sound_data.small_wave.play();
						Registry.sound_data.big_door_locked.play();
						FlxG.flash(0xffffffff, 3);
						FlxG.shake(0.05, 3);
						FlxG.scramble_cache();
						break;
					case " URLDURLD11":
						var p:Player = Registry.GAMESTATE.player;
						p.loadGraphic(Player.Cell_Player_Sprite, true, false, 16, 16);
						
						break;
					case " LRLR121212":
						Registry.FUCK_IT_MODE_ON = !Registry.FUCK_IT_MODE_ON;
						break;
					default:
						Registry.GAMESTATE.player.health_bar.modify_health( -2);
						Registry.sound_data.sb_hurt.play();
						break;
				}
				text_1.text = " ";
			}
			
		}
		
		private var secretz_idx:int = 0;
		private var secretz_wordz:Array = new Array(
		"You’re rolling in it!",
		"Once the property of a famous Bubble Mage.",
		"If your graphics become scrambled, look at the pokedex entry of an official Pokemon.",
		"This heart has no name.",
		"Please visit the electric monsters' world.",
		"A kitty statue. Cute, but useless.",
		"Oh my!!!!",
		"Oh no!!!!",
		"It's black.",
		"It's red.",
		"It's green.",
		"It's blue.",
		"It's white."
		);
		private function secretz_logic():void {
			if (Registry.keywatch.JP_ACTION_2) {
					Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
					state = s_browse;
					secretz_idx = 0;
					menu_select_active.visible = true;
					menu_select_inactive.visible = false;
					selectors.members[1].visible = false;
			}
			
			if (Registry.keywatch.JP_RIGHT && (secretz_idx % 4) < 3) {
				selectors.members[1].x += 24;
				secretz_idx ++;
			} else if (Registry.keywatch.JP_LEFT && (secretz_idx % 4) > 0) {
				selectors.members[1].x -= 24;
				secretz_idx --;
			}
			
			if (Registry.keywatch.JP_DOWN && int(secretz_idx / 4) < 3) {
				selectors.members[1].y += 20;
				secretz_idx += 4;
			} else if (Registry.keywatch.JP_UP && int(secretz_idx / 4) > 0) {
				selectors.members[1].y -= 20;
				secretz_idx -= 4;
			}
			
			if (Registry.keywatch.JP_ACTION_1) {
				if (trophies.members.length - 1 >= secretz_idx && trophies.members[secretz_idx].visible) {
					DH.dialogue_popup(secretz_wordz[secretz_idx]);
				}
			}
		}
		
		private function set_passive_effect(selector_index:int):void 
		{
			var p:* = parent;
			if (selector_index == Registry.IDX_WIDEN) {
				// bound_effect ripples over to the state of the broom
				if (Registry.bound_effect == Registry.item_names[Registry.IDX_WIDEN]) {
					Registry.bound_effect = "none"; //de-equip the effect
					p.player.action_latency_max = Player.ATK_DELAY;
				} else {
					Registry.bound_effect = Registry.item_names[Registry.IDX_WIDEN];
					p.player.action_latency_max = Player.WATK_DELAY;
				}
			} else if (selector_index == Registry.IDX_LENGTHEN) {
				// bound_effect ripples over to the state of the broom
				if (Registry.bound_effect == Registry.item_names[Registry.IDX_LENGTHEN]) {
					Registry.bound_effect = "none"; //de-equip the effect
					p.player.action_latency_max = Player.ATK_DELAY;
				} else {
					Registry.bound_effect = Registry.item_names[Registry.IDX_LENGTHEN];
					p.player.action_latency_max = Player.LATK_DELAY;
				}
			} else if (selector_index == Registry.IDX_BROOM) {
				Registry.bound_effect = "none"; //de-equip the effect
				p.player.action_latency_max = Player.ATK_DELAY;
			}
		}
		
		private function set_card_images():void 
		{
			for (var card_page_idx:int = 0; card_page_idx < 12; card_page_idx++) {
				if (1 == Registry.card_states[card_page_idx + cur_cards_pg * 12]) {
					trace(card_page_idx + cur_cards_pg * 12);
					cards.members[card_page_idx].frame = card_page_idx + cur_cards_pg * 12;
				} else {
					cards.members[card_page_idx].frame = 49;
				}
			}
		}
		
		private function set_key_graphics():void 
		{
			//not working
			for (var i:int = 0; i < 3; i++) {
				var key:FlxSprite = key_icons.members[i];
				key.loadGraphic(NPC.key_green_embed, true, false, 16, 16);
				switch (i) {
					case 0: if (Registry.inventory[Registry.IDX_GREEN_KEY]) {
						key.frame = 0;
					} else {
						key.frame = 1;
					}
					break;
					case 1: if (Registry.inventory[Registry.IDX_RED_KEY]) {
						key.frame = 2;
					} else {
						key.frame = 3;
					}
					break;
					case 2: if (Registry.inventory[Registry.IDX_BLUE_KEY]) {
						key.frame = 4;
					} else {
						key.frame = 5;
					}
					break;
				}
			}
		}
		
		private function check_for_exit_with(condition:Boolean):void 
		{
			if (condition) {
				if (exit_latency < 0) {
					done = true;
					exit_latency = 0.5;
					current_substate_visible = false;
					Registry.GAMESTATE.player.no_jump_ticks = 7;
					reset_counters();
					menu_select_active.visible = true;
					menu_select_inactive.visible = false;
					window_words.visible = window_config.visible = false;
				}
			} else {
				if (exit_latency > 0) {
					exit_latency -= FlxG.elapsed;
				}
			}
		}
		
		private function reset_counters():void {
			
			state = s_browse;
			ctr_settings = 0;
			map_ctr = 0;
			map_cursor_idx = save_cursor_idx = settings_cursor_idx = equip_cursor_idx = equip_cursor_idx = 0;
			doing_window_config = false;
			
		}
		
		private function dialogue_logic():void 
		{
			Registry.GAMESTATE.dialogue_state.update();
			if (t_d > tm_d) {
				if (Registry.GAMESTATE.dialogue_state.is_finished && (Registry.keywatch.JP_ACTION_2 || Registry.keywatch.JP_ACTION_1)) {
					t_d = 0;
					Registry.GAMESTATE.dialogue_state.reset();
					if (equip_cursor_idx >= 10) {
						state = s_equip;
					} else if (base_index == 5) {
						state = s_secretz;
					} else {
						state = s_cards; // mayneed to change later
					}
					Registry.GAMESTATE.dialogue_state.pop(this as FlxState);
					DH.dont_need_recently_finished();
				}
			} else {
				t_d += FlxG.elapsed;
			}
		}
		
		private function get_resolution_string(is_init:Boolean=false):String {
			
			if (Intra.is_mobile) return " ";
			if (is_init) {
				Intra.scale_ctr--;
			}
			var res:String = "Windowed";
			switch (Intra.scale_ctr) {
				case 1:
					res =  "Int. Scaled";
					break;
				case 2:
					res = "Fit Scaled";
					break;
				case 0:
					res =  "Windowed";
					break;
			}
			if (is_init) {
				Intra.scale_ctr++;
			}
			return res;
		}
		private function set_settings_text(is_init:Boolean=false):void {
			var autosave_state:String = Registry.autosave_on ? "On" : "Off";
			var first:String = Intra.is_mobile ? "Flip actions" : "Set controls";
			var last:String = Intra.is_mobile ? "Flip controls" : "Resize window";
			var res:String = Intra.is_mobile ? "\n\n\n" : "\n\nResolution:\n ";
			if (is_init) {
				text_1.setText(first+"\n\nSet volume\n\n\nAutosave at\ncheckpoints:\n    " + autosave_state + res + get_resolution_string(true)+"\n\n\n"+last, true, 0, 0, "left", true);
			} else {
				text_1.setText(first+"\n\nSet volume\n\n\nAutosave at\ncheckpoints:\n    " + autosave_state + res + get_resolution_string()+"\n\n\n"+last, true, 0, 0, "left", true);
			}
		}
		
		private function set_trade_item():void {
			trade_item.visible = true;
			if (Registry.inventory[Registry.IDX_BOX]) {
				trade_item.loadGraphic(Trade_NPC.embed_dame_trade_npc, true, false, 16, 16);
				trade_item.frame = 31;
			} else if (Registry.inventory[Registry.IDX_BIKE_SHOES]) {
				trade_item.loadGraphic(Trade_NPC.embed_dame_trade_npc, true, false, 16, 16);
				trade_item.frame = 56;
			} else {
				trade_item.visible = false;
			}
		}
		
		private function set_trophy_vis(_trophies:FlxGroup, idx:int):void {
			_trophies.members[idx].visible = false;
			//_trophies.members[idx].visible = true;
			switch (idx) {
				case 0:
					if (Registry.inventory[Registry.IDX_POO]) _trophies.members[idx].visible = true;
					break;
				case 1:
					if (Registry.inventory[Registry.IDX_SPAM]) _trophies.members[idx].visible = true;
					break;
				case 2:
					if (Registry.inventory[Registry.IDX_MISSINGNO]) _trophies.members[idx].visible = true;
					break;
				case 3:
					if (Registry.inventory[Registry.IDX_AUS_HEART]) _trophies.members[idx].visible = true;
					break;
				case 4:
					if (Registry.inventory[Registry.IDX_ELECTRIC]) _trophies.members[idx].visible = true;
					break;
				case 5:
					if (Registry.inventory[Registry.IDX_KITTY]) _trophies.members[idx].visible = true;
					break;
				case 6:
					if (Registry.inventory[Registry.IDX_MELOS]) _trophies.members[idx].visible = true;
					break;
				case 7:
					if (Registry.inventory[Registry.IDX_MARINA]) _trophies.members[idx].visible = true;
					break;
				case 8:
					if (Registry.inventory[Registry.IDX_BLACK]) _trophies.members[idx].visible = true;
					break;
				case 9:
					if (Registry.inventory[Registry.IDX_RED]) _trophies.members[idx].visible = true;
					break;
				case 10:
					if (Registry.inventory[Registry.IDX_GREEN]) _trophies.members[idx].visible = true;
					break;
				case 11:
					if (Registry.inventory[Registry.IDX_BLUE]) _trophies.members[idx].visible = true;
					break;
				case 12:
					if (Registry.inventory[Registry.IDX_WHITE]) _trophies.members[idx].visible = true;
					break;
				
					
			}
		}
		
		private function is_crowd_minidungeon():Boolean {
			return (Registry.CURRENT_MAP_NAME == "CROWD" && 
			(
				(Registry.CURRENT_GRID_X >= 4 && Registry.CURRENT_GRID_X <= 7 && Registry.CURRENT_GRID_Y == 7) ||
				(Registry.CURRENT_GRID_X == 7 && Registry.CURRENT_GRID_Y == 6)
				)
				);
		}
		private function card_pg_to_cards():void 
		{
			selectors.members[3].visible = true;
			selectors.members[2].visible = false;
			selectors.members[1].visible = false;
			selectors.members[3].play("enabled");
			selectors.members[2].play("disabled");
			selectors.members[1].play("disabled");
			selectors.members[3].x = cards.members[0].x - 10 + ((cards_cursor_idx % 3) * 30);
			selectors.members[3].y = cards.members[0].y + 10 + (int(cards_cursor_idx / 3) * 29);
		}
	}

}