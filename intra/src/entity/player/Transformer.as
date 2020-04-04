package entity.player 
{
	import flash.geom.Point;
	import global.Registry;
	import helper.DH;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	/**
	 * Item that switches two arbitrary tiles on the map.
	 * Obviously breaks things to hell so we only give it 
	 * to the player at the end.
	 * @author Seagaia
	 */
	public class Transformer extends FlxSprite
	{
		
		public var selector:FlxSprite = new FlxSprite;
		public var selected:FlxSprite = new FlxSprite;
		
		private var state:int = 0;
		private var s_idle:int = 0;
		private var s_ready:int = -1;
		private var s_has_one:int = 1;
		private var s_transforming:int = 2;
		
		private var map:FlxTilemap = new FlxTilemap;
		private var g_off:Point  = new Point();
		private var is_playstate:Boolean = false;
		
		private var p:Player;
		private var parent:*;
		
		private var did_init:Boolean = false;
		private var dontfuckgindoanything:Boolean = true;
		
		private var okay_places:Array;
		private var okay_rooms:Array;
		
		
		[Embed(source = "../../res/sprites/inventory/selector.png")] public static const embed_selector:Class;
		public function Transformer(_p:Player,_parent:*) 
		{
			p = _p;
			parent = _parent;
			reset_next();
			
			selector.loadGraphic(embed_selector, true, false, 16, 16);
			selected.loadGraphic(embed_selector, true, false, 16, 16);
			selected.addAnimation("a", [1]);
			selector.addAnimation("a", [0, 1], 4);
			selector.play("a");
			selected.play("a");
			
			visible = false;
			selector.visible = false;
			selected.visible = false;
			
			
			okay_places = new Array("GO", "CIRCUS", "HOTEL", "APARTMENT");
			okay_rooms = new Array(new Point(2,3), new Point(7, 0), new Point(8, 11), new Point(8, 7));
			
			
		}
		
		
		override public function update():void 
		{
			
			if (Registry.FUCK_IT_MODE_ON && FlxG.keys.justPressed("T")) {
				trace("Transformer.as: GE_EVENTS: BEAT GAME IS NOW TRUE");
				Registry.GE_States[Registry.GE_Finished_Game] = true;
			}
			
			// Extra nexus and drawer hardcoded check...
			
			if (!did_init) {
				reset_next();
				did_init = true;
			
			}
			// hack
			map = parent.curMapBuf;
			g_off.x = Registry.CURRENT_GRID_X * 160;
			g_off.y = Registry.CURRENT_GRID_Y * 160 + Registry.HEADER_HEIGHT;
			switch (state) {
				case s_idle:
					break;
				case s_ready:
				case s_transforming:
					facing = p.facing;
					var hh:int = Registry.HEADER_HEIGHT;
					
					if (facing == UP) {x = p.x; y = p.y - 16; } 
					else if (facing == LEFT) {  x = p.x - 16;  y = p.y; }
					else if (facing == RIGHT) {  x = p.x + 16;  y = p.y; }
					else {  x = p.x;  y = p.y + 16; }
						
					if ( x % 16 <= 10) {  x -=  x % 16; }
					else {  x += (16  -  x % 16); }
					if ((y - hh) % 16 <= 7) {  y -= ((y - hh) % 16); }
					else {  y += (16 - (y - hh) % 16); }
					
					selector.x = x;
					selector.y = y;
						
					break;
				
			}
			
			if (Registry.E_Transformer_On) {
				Registry.E_Transformer_On = false;
				
			}
			if (Registry.E_Transformer_Off) {
				Registry.E_Transformer_Off = false;
				selector.visible = selected.visible = false;
				state = s_idle;
				
			}
			
			super.update();
		}
		
		//called by player
		public function use_item():void {
			if (Registry.sound_data.current_song_name == "BRIARFIGHT") {
				return;
			}
			// If we finished the game, use swap everywhere
			if (Registry.GE_States[Registry.GE_Finished_Game]) { 
				dontfuckgindoanything = false;
				
				if (Registry.CURRENT_MAP_NAME == "DRAWER" && Registry.CURRENT_GRID_Y >= 9) {
					dontfuckgindoanything = true;
				} else if (Registry.CURRENT_MAP_NAME == "NEXUS" && Registry.CURRENT_GRID_Y <= 3) {
					dontfuckgindoanything = true;
				} else if (Registry.CURRENT_MAP_NAME == "BLANK" && Registry.CURRENT_GRID_Y >= 7) {
					dontfuckgindoanything = true;
				} else if (Registry.CURRENT_MAP_NAME == "SPACE" && Registry.CURRENT_GRID_Y >= 5) {
					dontfuckgindoanything = true;
				} else if (Registry.CURRENT_MAP_NAME == "TRAIN" && Registry.CURRENT_GRID_Y >= 8) {
					dontfuckgindoanything = true;
				} else if (Registry.CURRENT_MAP_NAME == "SUBURB" && Registry.CURRENT_GRID_Y >= 5 && Registry.CURRENT_GRID_X == 2) {
					dontfuckgindoanything = true;
				} else if (Registry.CURRENT_MAP_NAME == "DEBUG") {
					dontfuckgindoanything = true;
				}
			// Otherwise, only activate swap in certain rooms.
			} else {
				for (var i:int = 0; i < 4; i++) {
					if (Registry.CURRENT_MAP_NAME == okay_places[i] && Registry.CURRENT_GRID_X == okay_rooms[i].x && Registry.CURRENT_GRID_Y == okay_rooms[i].y) {
						if (Registry.CURRENT_MAP_NAME == "GO") {
							if (Registry.GAMESTATE.player.facing == FlxObject.UP && Registry.GAMESTATE.player.y < Registry.CURRENT_GRID_Y * 160 +20 + 32) {
								dontfuckgindoanything = true;
								break;
							} 
						}
						dontfuckgindoanything = false;
						break;
					} else {
						dontfuckgindoanything = true;
					}
					
				}
			}
			
			// If we get here and have the swap non-activated, show messsage.
			if (dontfuckgindoanything) {
				if (Registry.CURRENT_MAP_NAME == "DRAWER") { // Weird old overworld area
					//DH.dialogue_popup("The swap won't work here.");
					DH.dialogue_popup(DH.lk("swap", 1));
				} else if (Registry.CURRENT_MAP_NAME == "NEXUS" && Registry.CURRENT_GRID_Y <= 3) { // postgame..
					DH.dialogue_popup(DH.lk("swap", 1));
				} else if (Registry.CURRENT_MAP_NAME == "BLANK" && Registry.CURRENT_GRID_Y >= 7) {
					DH.dialogue_popup(DH.lk("swap", 1));
				} else if (Registry.CURRENT_MAP_NAME == "SPACE" && Registry.CURRENT_GRID_Y >= 5) {
					DH.dialogue_popup(DH.lk("swap", 1));
				} else if (Registry.CURRENT_MAP_NAME == "TRAIN" && Registry.CURRENT_GRID_Y >= 7) {
					DH.dialogue_popup(DH.lk("swap", 1));
				} else if (Registry.CURRENT_MAP_NAME == "SUBURB" && Registry.CURRENT_GRID_Y >= 5 && Registry.CURRENT_GRID_X == 2) {
					DH.dialogue_popup(DH.lk("swap", 1));
				} else if (Registry.CURRENT_MAP_NAME == "DEBUG") {
					//DH.dialogue_popup("Sorry!");
					DH.dialogue_popup(DH.lk("swap", 0));
				}  else {
					//DH.dialogue_popup("Young could not muster the strength to use the swap here.");
					DH.dialogue_popup(DH.lk("swap", 2));
				}
				return;
			}
				
			if (state == s_idle) {
				state  = s_ready;
				selector.visible = true;
			} else if (state == s_ready) {
				selected.visible = true;
				Registry.sound_data.play_sound_group(Registry.sound_data.menu_move_group);
				selected.x = selector.x;
				selected.y = selector.y;
				state = s_transforming;
			} else if (state == s_transforming) {
				Registry.sound_data.play_sound_group(Registry.sound_data.menu_select_group);
				
				var _x:int = (selected.x - g_off.x) / 16;
				var _y:int = (selected.y - g_off.y) / 16;
				
				var tt1:int = map.getTile(_x, _y);
				
				var _x2:int = (selector.x - g_off.x) / 16;
				var _y2:int = (selector.y - g_off.y) / 16;
				
				var tt2:int = map.getTile(_x2, _y2);
				
				//Switch tiles
				
				//trace("tt1: ", tt1, _x, _y);
				//trace("tt2: ", tt2, _x2, _y2);
				
				map.setTile(_x, _y, tt2);
				map.setTile(_x2, _y2, tt1);
				
				state = s_ready;
				selected.visible = false;
				
			}
		}
		/**
		 * Updates grid coords if needed, also the current map buffer
		 */
		public function reset_next():void {
			state = s_idle;
			selected.visible = selector.visible = false;
			if (Registry.is_playstate) {
				is_playstate = true;
				g_off.x = Registry.CURRENT_GRID_X * 160;
				g_off.y = Registry.CURRENT_GRID_Y * 160 + Registry.HEADER_HEIGHT;
			} else {
				g_off.x = 0;
				g_off.y = Registry.HEADER_HEIGHT;
			}
			map = parent.curMapBuf;	
		}
	}

}