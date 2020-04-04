package data 
{
	import entity.player.Player;
	import global.Registry;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTilemap;
	import org.flixel.system.FlxTile;

    public class TileData 
    {
        
		/* Area tilesets */
		[Embed(source = "../res/tilemaps/mockup_tiles.png")] public static var Debug_Tiles:Class;
		[Embed(source = "../res/tilemaps/apartment_tilemap.png")] public static var _Apartment_Tiles:Class;
		[Embed(source = "../res/tilemaps/bedroom_tilemap.png")] public static var _Bedroom_Tiles:Class;
		[Embed(source = "../res/tilemaps/fields_tilemap.png")] public static var _Fields_Tiles:Class;
		[Embed(source = "../res/tilemaps/street_tilemap.png")] public static var _Street_Tiles:Class;
		[Embed(source = "../res/tilemaps/overworld_tilemap.png")] public static var _Overworld_Tiles:Class;
		[Embed(source = "../res/tilemaps/beach_tilemap.png")] public static var _Beach_Tiles:Class;
		[Embed(source = "../res/tilemaps/blank_tiles.png")] public static var Blank_Tiles:Class;
		[Embed(source = "../res/tilemaps/cliff_tilemap.png")] public static var Cliff_Tiles:Class;
		[Embed(source = "../res/tilemaps/crowd_tilemap.png")] public static var _Crowd_Tiles:Class;
		[Embed(source = "../res/tilemaps/circus_tilemap.png")] public static var _Circus_Tiles:Class;
		[Embed(source = "../res/tilemaps/forest_tilemap.png")] public static var Forest_Tiles:Class;
		[Embed(source = "../res/tilemaps/hotel_tilemap.png")] public static var _Hotel_Tiles:Class;
		[Embed(source = "../res/tilemaps/redsea_tiles.png")] public static var Red_Sea_Tiles:Class;
		[Embed(source = "../res/tilemaps/redcave_tiles.png")] public static var REDCAVE_Tiles:Class;
		[Embed(source = "../res/tilemaps/nexus_tilemap.png")] public static var _Nexus_Tiles:Class;
		[Embed(source = "../res/tilemaps/windmill_tilemap.png")] public static var _Windmill_Tiles:Class;
		[Embed(source = "../res/tilemaps/terminal_tilemap.png")] public static var Terminal_Tiles:Class;
		[Embed(source = "../res/tilemaps/cell_tilemap.png")] public static var Cell_Tiles:Class;
		[Embed(source = "../res/tilemaps/blackwhite_tilemap.png")] public static var BlackWhite_Tiles:Class;
		[Embed(source = "../res/tilemaps/blue_tilemap.png")] public static var Blue_Tiles:Class;
		[Embed(source = "../res/tilemaps/happy_tilemap.png")] public static var Happy_Tiles:Class;
		[Embed(source = "../res/tilemaps/space_tilemap.png")] public static var Space_Tiles:Class;
		[Embed(source = "../res/tilemaps/suburb_tilemap.png")] public static var Suburb_Tiles:Class;
		[Embed(source = "../res/tilemaps/go_tilemap.png")] public static var Go_Tiles:Class;
		
		
		
		
		/*Minimap tilemap */
		[Embed(source = "../res/tilemaps/minimap_tiles.png")] public static var Minimap_Tiles:Class;
		
		
		
		/* The main reference to the current tileset */
        public static var Tiles:Class;
		
		public static var Overworld_Tileset_Width:int = 10;
		public static var Overworld_Tilemap_Solid_Rows:int = 4;
		public static var Overworld_Tilemap_Special_Row_offset:int = 4;
		public static var Overworld_Tilemap_Nonsolid_Row_offset:int = 5;
		public static var Overworld_Tilemap_Nr_Rows:int = 10;
		
		public static var CUR_MAP_HAS_CONVEYERS:Boolean = false;
        
		/**
		 * The indices of tiles that have hole callbacks.
		 */
		public static var HOLE_INDICES:Array = new Array();
		// it looks like you're adding a new tileset.
		// did you make sure to add in the new csv in csvdata??
		/* Making a new tileset work 
		 * 1. Make sure it's included above in the list of Embeds
		 * 2. Add it to the if statement right after this comment
		 * 3. Remove that maps name from the "no_tiles_yet" array at the beginning of the
		 * 	 	set_tile_properties array
		 * 4. Add in an else-if block to deal with setting the walkable/solid properties of the tileset
		 * 5. if there are more detailed things (holes, conveyers), you can try to figure it out
		 * 		or i'll just deal with it. */
		
		
        public static function setTileset(MapName:String):void {
            if (MapName == "BEDROOM") {
                Tiles = _Bedroom_Tiles;
			} else if (MapName == "APARTMENT") {
                Tiles = _Apartment_Tiles;
            } else if (MapName == "FIELDS") {
                Tiles = _Fields_Tiles;
            } else if (MapName == "STREET") {
                Tiles = _Street_Tiles;
            } else if (MapName == "OVERWORLD") {
				Tiles = _Overworld_Tiles;
			} else if (MapName == "BEACH") {
				Tiles = _Beach_Tiles;
			} else if (MapName == "BLANK") {
				Tiles = Blank_Tiles;
			} else if (MapName == "REDSEA") {
				Tiles = Red_Sea_Tiles;
			} else if (MapName == "DEBUG") {
				Tiles = Debug_Tiles;
			} else if (MapName == "REDCAVE") {
				Tiles = REDCAVE_Tiles;
			} else if (MapName == "TERMINAL") {
				Tiles = Terminal_Tiles;
			} else if (MapName == "HOTEL") {
				Tiles = _Hotel_Tiles;
			} else if (MapName == "NEXUS") {
				Tiles = _Nexus_Tiles;
			} else if (MapName == "CROWD") {
				Tiles = _Crowd_Tiles;
			} else if (MapName == "CIRCUS") {
				Tiles = _Circus_Tiles;
			} else if (MapName == "CLIFF") {
				Tiles = Cliff_Tiles;
			} else if (MapName == "WINDMILL") {
				Tiles = _Windmill_Tiles;
			} else if (MapName == "FOREST") {
				Tiles = Forest_Tiles;
			} else if (MapName == "TRAIN") {
				Tiles = Cell_Tiles;
			} else if (MapName == "DRAWER") {
				Tiles = BlackWhite_Tiles;
			} else if (MapName == "BLUE") {
				Tiles = Blue_Tiles;
			} else if (MapName == "HAPPY") {
				Tiles = Happy_Tiles;
			} else if (MapName == "SPACE") {
				Tiles = Space_Tiles;
			} else if (MapName == "SUBURB") {
				Tiles = Suburb_Tiles;
			} else if (MapName == "GO") {
				Tiles = Go_Tiles;
			} else {
				Tiles = Debug_Tiles;
			}
        }
		
		/* EMBEDS, ARRAYS, FUNCTIONS RELATED TO ANIMATED TILES */
		
		// Embedded graphics
		[Embed (source = "../res/sprites/animtiles/shoreline.png")] private static var Shoreline_Anims:Class;
		[Embed (source = "../res/sprites/animtiles/beach_anims.png")] private static var Beach_Anims:Class;
		[Embed (source = "../res/sprites/animtiles/conveyer_anim_tiles.png")] private static var Conveyer_Anims:Class;
		[Embed (source = "../res/sprites/animtiles/water_edges.png")] private static var Water_Edge_Anims:Class;
		[Embed (source = "../res/sprites/animtiles/torch_pillars.png")] private static var Torch_Pillar_Anims:Class;
		[Embed (source = "../res/sprites/animtiles/windmill_drops.png")] private static var Windmill_Drops_Anims:Class;
		[Embed (source = "../res/sprites/animtiles/terminal.png")] private static var Terminal_Anims:Class;
		[Embed (source = "../res/sprites/animtiles/happy_anims.png")] private static var Happy_Anims:Class;
		[Embed (source = "../res/sprites/animtiles/cell_anims.png")] private static var Cell_Anims:Class;
		[Embed (source = "../res/sprites/animtiles/suburbs_anims.png")] private static var Suburbs_Anims:Class;
		[Embed (source = "../res/sprites/animtiles/forest_anims.png")] private static var Forest_Anims:Class;
		[Embed (source = "../res/sprites/animtiles/fields_anims.png")] private static var Fields_Anims:Class;
		[Embed (source = "../res/sprites/animtiles/go_anims.png")] private static var Go_Anims:Class;
		[Embed (source = "../res/sprites/animtiles/flame_anims.png")] private static var Flame_Anims:Class;
		
		// Add new tile indice here
		public static var animtiles_indices_dict:Object = { 
			BEACH :  new Array(109, 116, 117, 118, 119, 141, 142, 143, 144, 145, 150, 151, 250, 251, 252, 253, 254, 255, 256, 257, 260, 261, 262, 270, 272),
			DEBUG : new Array(16, 17, 18, 19, 20),
			REDCAVE : new Array(16, 17, 18, 19, 30,32, 70, 71, 72, 73, 74, 75, 76),
			WINDMILL : new Array(130,130), // as3 arrays make empty arrays with x elements if only one arg x
			CIRCUS : new Array(41, 46, 111, 112, 113, 114),
			HOTEL :  new Array(180, 181, 182, 183, 190, 191, 192, 193, 194), // Don't forget the comma if adding a new row
			TERMINAL: new Array(20, 21, 22, 150, 151, 152, 153),
			HAPPY: new Array(20,21,30,31,40,41),
			BLUE: new Array(30,31,35),
			GO: new Array(50, 130,190,191,192,193,194),
			FOREST: new Array(110, 110),
			SUBURB: new Array(68, 69, 78, 79),
			FIELDS: new Array(246, 250, 270, 271, 272, 273),
			TRAIN: new Array(3, 3)
		}
		
		/**
		 * Produce an animated tile sprite based on the map name, and the index of the tile
		 * (With respect to the tileset)
		 * @param x  x-coord in WORLD SPACE
		 * @return 1 if sprite added, 0 if not.
		 */
		public static function make_anim_tile(anim_tile_group:FlxGroup, MapName:String, tileType:int, x:int = 0, y:int = 0):int {
			
			// Check if this map even has animated tiles
			if (animtiles_indices_dict.hasOwnProperty(MapName)) {
				// Check whether this tile type doesn't need an animated tile
				if (animtiles_indices_dict[MapName].indexOf(tileType) == -1) {
					return 0;
				}
			} else {
				return 0;
			}
			
			var anim_tile:FlxSprite = new FlxSprite(x, y); // This will be our animated tile.
			if (MapName == "BEACH") { // If we're in the BEACH
				if (tileType == 250 || tileType == 251 || tileType == 252 || tileType >= 260)  {
					anim_tile.loadGraphic(Shoreline_Anims, true, false,16,16);
				}
				switch (tileType) {
					case 251:
						anim_tile.addAnimation("a",  [ 0,  1,  2,  3,  4,  5], 4, true); break;
					case 261:
						anim_tile.addAnimation("a",  [ 6, 7,  8,  9, 10, 11], 4, true); break;
					case 252:
						anim_tile.addAnimation("a",  [30, 31, 32, 33, 34, 35], 4, true); break;
					case 262:
						anim_tile.addAnimation("a",  [36, 37, 38, 39, 40, 41], 4, true); break;
					case 272:
						anim_tile.addAnimation("a",  [42, 43, 44, 45, 46, 47], 4, true); break;
					case 250:
						anim_tile.addAnimation("a",  [12, 13, 14, 15, 16, 17], 4, true); break;
					case 260:
						anim_tile.addAnimation("a",  [18, 19, 20, 21, 22, 23], 4, true); break;
					case 270:
						anim_tile.addAnimation("a",  [24, 25, 26, 27, 28, 29], 4, true); break;
				}
				if (tileType <= 151 || (tileType >= 253 && tileType <= 257))  {
					anim_tile.loadGraphic(Beach_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 109:
						anim_tile.addAnimation("a", [0, 1], 4, true); break;
					case 116:
						anim_tile.addAnimation("a", [2, 3], 4, true); break;
					case 117:
						anim_tile.addAnimation("a", [4, 5], 4, true); break;
					case 118:
						anim_tile.addAnimation("a", [6, 7], 4, true); break;
					case 119:
						anim_tile.addAnimation("a", [8, 9], 4, true); break;
					case 141:
						anim_tile.addAnimation("a", [10, 11], 4, true); break;
					case 142:
						anim_tile.addAnimation("a", [12, 13], 4, true); break;
					case 143:
						anim_tile.addAnimation("a", [14, 15], 4, true); break;
					case 144:
						anim_tile.addAnimation("a", [16, 17], 4, true); break;
					case 145:
						anim_tile.addAnimation("a", [18, 19], 4, true); break;
					case 150:
						anim_tile.addAnimation("a", [20, 21], 4, true); break;
					case 151:
						anim_tile.addAnimation("a", [22, 23], 4, true); break;
					case 253:
						anim_tile.addAnimation("a", [24, 25], 4, true); break;
					case 254:
						anim_tile.addAnimation("a", [26, 27], 4, true); break;
					case 255:
						anim_tile.addAnimation("a", [28, 29], 4, true); break;
					case 256:
						anim_tile.addAnimation("a", [30, 31], 4, true); break;
					case 257:
						anim_tile.addAnimation("a", [32, 33], 4, true); break;
				}
				anim_tile.play("a");
			} else if (MapName == "DEBUG") {
				//R D L U NONE
				// CONVEYER TILE TEST.
				if (tileType <= 20 && tileType >= 16) {
					anim_tile.loadGraphic(Conveyer_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 16:
						anim_tile.addAnimation("a", [0, 4], 4, true); break;
					case 17:
						anim_tile.addAnimation("a", [1, 5], 4, true); break;
					case 18:
						anim_tile.addAnimation("a", [2, 6], 4, true); break;
					case 19:
						anim_tile.addAnimation("a", [3, 7], 4, true); break;
					case 20:
						anim_tile.addAnimation("a", [8, 9], 4, true); break;
				}
				anim_tile.play("a");
			} else if (MapName == "REDCAVE") {
				if (tileType >= 16 && tileType <= 19)  {
					anim_tile.loadGraphic(Conveyer_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 16:
						anim_tile.addAnimation("a", [16, 17, 18], 4, true); break;
					case 17:
						anim_tile.addAnimation("a", [20, 21, 22], 4, true); break;
					case 18:
						anim_tile.addAnimation("a", [24, 25, 26], 4, true); break;
					case 19:
						anim_tile.addAnimation("a", [28, 29, 30], 4, true); break;
				}
				if (tileType == 30 || tileType == 32)  {
					anim_tile.loadGraphic(Flame_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 30:
					case 32:
						anim_tile.addAnimation("a", [0, 1, 2], 6, true); break;
				}
				if (tileType >= 70 && tileType <= 76)  {
					anim_tile.loadGraphic(Water_Edge_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 70:
						anim_tile.addAnimation("a", [10, 11], 4, true); break;
					case 71:
						anim_tile.addAnimation("a", [12, 13], 4, true); break;
					case 72:
						anim_tile.addAnimation("a", [14, 15], 4, true); break;
					case 73:
						anim_tile.addAnimation("a", [16, 17], 4, true); break;
					case 74:
						anim_tile.addAnimation("a", [18, 19], 4, true); break;
					case 75:
						anim_tile.addAnimation("a", [20, 21], 4, true); break;
					case 76:
						anim_tile.addAnimation("a", [22, 23], 4, true); break;
				}
				anim_tile.play("a");
			} else if (MapName == "WINDMILL") {
				if (tileType == 130)  {
					anim_tile.loadGraphic(Windmill_Drops_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 130:
						anim_tile.addAnimation("a", [0, 1, 2, 3, 4, 5], 10, true); break;
				}
				anim_tile.play("a");
			} else if (MapName == "FOREST") {
				if (tileType == 110)  {
					anim_tile.loadGraphic(Forest_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 110:
						anim_tile.addAnimation("a", [0, 1, 2], 3, true); break;
				}
				anim_tile.play("a");
			} else if (MapName == "GO") {
				if (tileType == 50 || tileType == 130 || tileType >= 190)  {
					anim_tile.loadGraphic(Go_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 50:
						anim_tile.addAnimation("a", [60, 61], 3, true); break;
					case 130:
						anim_tile.addAnimation("a", [54, 55, 56], 4, true); break;
					case 190: // red right
						anim_tile.addAnimation("a", [0,1,2], 4, true); break;
					case 191: // red up
						anim_tile.addAnimation("a", [18,19,20], 4, true); break;
					case 192: // blue left
						anim_tile.addAnimation("a", [36,37,38], 4, true); break;
					case 193: // blue up
						anim_tile.addAnimation("a", [42,43,44], 4, true); break;
					case 194: // mix up
						anim_tile.addAnimation("a", [48,49,50], 4, true); break;
				}
				anim_tile.play("a");
			} else if (MapName == "TRAIN") {
				if (tileType == 3)  {
					anim_tile.loadGraphic(Cell_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 3:
						anim_tile.addAnimation("a", [0, 1], 3, true); break;
				}
				anim_tile.play("a");
			} else if (MapName == "FIELDS") {
				if (tileType == 250 || tileType == 246)  {
					anim_tile.loadGraphic(Fields_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 246:
						anim_tile.addAnimation("a", [10, 11], 3, true); break;
					case 250:
						anim_tile.addAnimation("a", [0, 1, 2], 3, true); break;
				}
				if (tileType >= 270 && tileType <= 273)  {
					anim_tile.loadGraphic(Conveyer_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 270:
						anim_tile.addAnimation("a", [48, 49, 50], 4, true); break;
					case 271:
						anim_tile.addAnimation("a", [52, 53, 54], 4, true); break;
					case 272:
						anim_tile.addAnimation("a", [56, 57, 58], 4, true); break;
					case 273:
						anim_tile.addAnimation("a", [60, 61, 62], 4, true); break;
				}
				anim_tile.play("a");
			} else if (MapName == "SUBURB") {
				if (tileType == 68 || tileType == 69 || tileType == 78 || tileType == 79)  {
					anim_tile.loadGraphic(Suburbs_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 68:
						anim_tile.addAnimation("a", [0, 2], 4, true); break;
					case 69:
						anim_tile.addAnimation("a", [1, 3], 4, true); break;
					case 78:
						anim_tile.addAnimation("a", [4, 6], 4, true); break;
					case 79:
						anim_tile.addAnimation("a", [5, 7], 4, true); break;
				}
				anim_tile.play("a");
			} else if (MapName == "CIRCUS") {
				if (tileType == 41 || tileType == 46)  {
					anim_tile.loadGraphic(Torch_Pillar_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 41:
						anim_tile.addAnimation("a", [3, 4, 5], 7, true); break;
					case 46:
						anim_tile.addAnimation("a", [0, 1, 2], 7, true); break;
				}
				if (tileType >= 111 && tileType <= 114)  {
					anim_tile.loadGraphic(Conveyer_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 111:
						anim_tile.addAnimation("a", [32, 33, 34], 4, true); break;
					case 112:
						anim_tile.addAnimation("a", [36, 37, 38], 4, true); break;
					case 113:
						anim_tile.addAnimation("a", [40, 41, 42], 4, true); break;
					case 114:
						anim_tile.addAnimation("a", [44, 45, 46], 4, true); break;
				}
				if (tileType >= 111 && tileType <= 114)  {
					anim_tile.loadGraphic(Conveyer_Anims, true, false, 16, 16);
				}
				/*switch (tileType) {
					case 111:
						anim_tile.addAnimation("a", [16, 17, 18], 4, true); break;
					case 112:
						anim_tile.addAnimation("a", [20, 21, 22], 4, true); break;
					case 113:
						anim_tile.addAnimation("a", [24, 25, 26], 4, true); break;
					case 114:
						anim_tile.addAnimation("a", [28, 29, 30], 4, true); break;
				}*/
				anim_tile.play("a");
			} else if (MapName == "HOTEL") {
				if (tileType >= 180 && tileType <= 183)  {
					anim_tile.loadGraphic(Conveyer_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 180:
						anim_tile.addAnimation("a", [32, 33, 34], 4, true); break;
					case 181:
						anim_tile.addAnimation("a", [36, 37, 38], 4, true); break;
					case 182:
						anim_tile.addAnimation("a", [40, 41, 42], 4, true); break;
					case 183:
						anim_tile.addAnimation("a", [44, 45, 46], 4, true); break;
				}
				if (tileType >= 190 && tileType <= 194)  {
					anim_tile.loadGraphic(Water_Edge_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 190:
						anim_tile.addAnimation("a", [0, 1], 4, true); break;
					case 191:
						anim_tile.addAnimation("a", [2, 3], 4, true); break;
					case 192:
						anim_tile.addAnimation("a", [4, 5], 4, true); break;
					case 193:
						anim_tile.addAnimation("a", [6, 7], 4, true); break;
					case 194:
						anim_tile.addAnimation("a", [8, 9], 4, true); break;
				}
				anim_tile.play("a");
			} else if (MapName == "TERMINAL") {
				if ((tileType >= 20 && tileType <= 22)  || (tileType >= 150 && tileType <= 153))  {
					anim_tile.loadGraphic(Terminal_Anims, true, false, 16, 16);
				}
				switch (tileType) {
					case 20:
						anim_tile.addAnimation("a", [12, 13, 14], 3, true); break;
					case 21:
						anim_tile.addAnimation("a", [15, 16, 17], 3, true); break;
					case 22:
						anim_tile.addAnimation("a", [18, 19, 20], 3, true); break;
					case 150:
						anim_tile.addAnimation("a", [0, 1, 2], 4, true); break;
					case 151:
						anim_tile.addAnimation("a", [3, 4, 5], 4, true); break;
					case 152:
						anim_tile.addAnimation("a", [6, 7, 8], 4, true); break;
					case 153:
						anim_tile.addAnimation("a", [9, 10, 11], 4, true); break;
				}
				anim_tile.play("a");
			} else if (MapName == "HAPPY") {
				anim_tile.loadGraphic(Happy_Anims, true, false, 16, 16);
				switch (tileType) {
					case 21:  // burning tree single
						anim_tile.addAnimation("a", [10, 11, 12], 7, true);
						break; 
					case 20: //normal tree single
					case 30: // normal tree multiple
						if (Registry.GE_States[Registry.GE_Happy_Started]) {
							if (Registry.CURRENT_GRID_X == 4 && Registry.CURRENT_GRID_Y == 1) {
								if (tileType == 20) {
									anim_tile.addAnimation("a", [10, 11, 12], 7, true);
								} else {
									anim_tile.addAnimation("a", [0, 1, 2], 7, true);
								}
							} else if (Registry.CURRENT_GRID_X == 1 && Registry.CURRENT_GRID_Y == 2) {
								if (tileType == 20) {
									anim_tile.addAnimation("a", [10, 11, 12], 7, true);
								} else {
									anim_tile.addAnimation("a", [0, 1, 2], 7, true);
								}
							} else {
								anim_tile = null;
							}
						} else {
							anim_tile = null;
						}
						break;
					case 31: //  burning tree multiple 
						
						anim_tile.addAnimation("a", [0, 1, 2], 7, true);
						break; 
					case 40: // right
						anim_tile.loadGraphic(Go_Anims, true, false, 16, 16);
						anim_tile.addAnimation("a", [0,1], 5);
						break;
					case 41:
						anim_tile.loadGraphic(Go_Anims, true, false, 16, 16);
						anim_tile.addAnimation("a", [6, 7], 5);
						break;
				}
				if (anim_tile != null) anim_tile.play("a");
			} else if (MapName == "BLUE") {
				anim_tile.loadGraphic(Go_Anims, true, false, 16, 16);
				switch (tileType) {
					case 30: //left
						anim_tile.addAnimation("a", [36,37,38], 6);
						break;
					case 31: //down 
						anim_tile.addAnimation("a", [30, 31, 32], 6);
						break;
				}
				anim_tile.play("a");
			} else { // Catches errors where we forget to add an else if block for some map
				anim_tile = null;
			}
			
			// Make sure the tile is valid before we add it
			if (anim_tile != null && anim_tile._curAnim != null) {
				anim_tile_group.add(anim_tile);
				return 1;
			}
			
			return 0;
		}
		
		
		public static function set_tile_properties(curMapBuf:FlxTilemap):void {
			CUR_MAP_HAS_CONVEYERS = false;
			HOLE_INDICES = new Array();
			var j:int = 0;
			var no_tiles_yet:Array = new Array("DEBUG");
			if (Registry.CURRENT_MAP_NAME == "OVERWORLD") {
				for (j = TileData.Overworld_Tilemap_Nonsolid_Row_offset*TileData.Overworld_Tileset_Width; j < TileData.Overworld_Tilemap_Nr_Rows*TileData.Overworld_Tileset_Width; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE);
				}
				curMapBuf.setTileProperties(TileData.Overworld_Tilemap_Special_Row_offset * TileData.Overworld_Tileset_Width, FlxObject.DOWN);
				curMapBuf.setTileProperties(TileData.Overworld_Tilemap_Special_Row_offset * TileData.Overworld_Tileset_Width + 2, FlxObject.UP);
				//10 11 20 21
				curMapBuf.setTileProperties(10, FlxObject.ANY, null, null, 2);
				curMapBuf.setTileProperties(20, FlxObject.ANY, null, null, 2);
				
			} else if (Registry.CURRENT_MAP_NAME == "CLIFF") {
				curMapBuf.setTileProperties(150, FlxObject.NONE, null, null, 10);
				curMapBuf.setTileProperties(177, FlxObject.NONE, null, null, 13);
				curMapBuf.setTileProperties(220, FlxObject.NONE, null, null, 3);
				curMapBuf.setTileProperties(210, FlxObject.NONE, ladder,Player,2);
			} else if (Registry.CURRENT_MAP_NAME == "FOREST") {
				CUR_MAP_HAS_CONVEYERS = true;
				curMapBuf.setTileProperties(80, FlxObject.NONE, null, null, 60);
				curMapBuf.setTileProperties(110, FlxObject.NONE, conveyer);
				curMapBuf.setTileProperties(134, FlxObject.NONE, conveyer,null,4);
			} else if (Registry.CURRENT_MAP_NAME == "TERMINAL") {
				CUR_MAP_HAS_CONVEYERS = true;
				curMapBuf.setTileProperties(120, FlxObject.NONE,null,null,3);
				curMapBuf.setTileProperties(126, FlxObject.NONE, hole);
				curMapBuf.setTileProperties(127, FlxObject.NONE, hole);
				curMapBuf.setTileProperties(127, FlxObject.NONE, hole);
				curMapBuf.setTileProperties(21, FlxObject.NONE,hole);
				curMapBuf.setTileProperties(136, FlxObject.NONE, null, null, 3);
				curMapBuf.setTileProperties(146, FlxObject.NONE, null, null, 3);
				curMapBuf.setTileProperties(150, FlxObject.NONE, conveyer, null, 2);
				for (j = 61; j < 65; j++) curMapBuf.setTileProperties(j, FlxObject.NONE, hole);
				
			} else if (Registry.CURRENT_MAP_NAME == "BEACH") {
				CUR_MAP_HAS_CONVEYERS = true;
				curMapBuf.setTileProperties(200, FlxObject.NONE, null, null, 50);
				curMapBuf.setTileProperties(250, FlxObject.NONE, conveyer, null, 25);
				curMapBuf.setTileProperties(261, FlxObject.ANY,null);
				curMapBuf.setTileProperties(270, FlxObject.ANY,null);
				curMapBuf.setTileProperties(272, FlxObject.ANY,null);
			} else if (Registry.CURRENT_MAP_NAME == "HAPPY") {
				curMapBuf.setTileProperties(60, FlxObject.NONE);
				curMapBuf.setTileProperties(70, FlxObject.NONE, spike, Player);
				
				curMapBuf.setTileProperties(110, FlxObject.NONE,hole,null,10);
			} else if (Registry.CURRENT_MAP_NAME == "NEXUS") {
				for (j = 30; j < 150; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE);
				}
				curMapBuf.setTileProperties(44, FlxObject.ANY, null, null, 4);
			} else if (Registry.CURRENT_MAP_NAME == "STREET") {
				for (j = 29; j < 80; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE);
				}
			} else if (Registry.CURRENT_MAP_NAME == "BLANK") {
				curMapBuf.setTileProperties(0, FlxObject.ANY);
				curMapBuf.setTileProperties(1, FlxObject.NONE);
				curMapBuf.setTileProperties(2, FlxObject.ANY);
				for (j = 3; j < 16; j++) curMapBuf.setTileProperties(j, FlxObject.ANY);
				for (j = 17; j < 39; j++) curMapBuf.setTileProperties(j, FlxObject.NONE);
			} else if (Registry.CURRENT_MAP_NAME == "BEDROOM") {
				for (j = 24; j < 62; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE);
				}
				curMapBuf.setTileProperties(5, FlxObject.NONE, TileData.thin_down);
				curMapBuf.setTileProperties(37, FlxObject.NONE, TileData.hole);
			} else if (Registry.CURRENT_MAP_NAME == "CROWD") {
				for (j = 40; j < 150; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE);
				}
				for (j = 43; j < 50; j++) {
					HOLE_INDICES.push(j);
					curMapBuf.setTileProperties(j, FlxObject.NONE,TileData.hole);
				}
				curMapBuf.setTileProperties(80, FlxObject.NONE, TileData.hole);
				curMapBuf.setTileProperties(81, FlxObject.NONE, TileData.hole);
				curMapBuf.setTileProperties(82, FlxObject.NONE, TileData.hole);
				curMapBuf.setTileProperties(90, FlxObject.NONE, TileData.hole);
				curMapBuf.setTileProperties(91, FlxObject.NONE, TileData.hole);
				curMapBuf.setTileProperties(92, FlxObject.NONE, TileData.hole);
				curMapBuf.setTileProperties(100, FlxObject.NONE, TileData.hole);
			//	curMapBuf.setTileProperties(65, FlxObject.NONE, TileData.thin_left); 
				curMapBuf.setTileProperties(70, FlxObject.RIGHT);  //Fixes issue for now
				curMapBuf.setTileProperties(64, FlxObject.NONE, TileData.thin_right);
				curMapBuf.setTileProperties(62, FlxObject.ANY);
				curMapBuf.setTileProperties(72, FlxObject.ANY);
				curMapBuf.setTileProperties(140, FlxObject.NONE,ladder,Player); //Ladder
			} else if (Registry.CURRENT_MAP_NAME == "APARTMENT") {
				CUR_MAP_HAS_CONVEYERS = true;
				for (j = 150; j < 300; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE);
				}
				curMapBuf.setTileProperties(255, FlxObject.NONE,ladder,Player); //Ladder
				curMapBuf.setTileProperties(257, FlxObject.ANY);
				curMapBuf.setTileProperties(258, FlxObject.ANY);
				curMapBuf.setTileProperties(259, FlxObject.ANY);
				curMapBuf.setTileProperties(265, FlxObject.NONE, ladder, Player); // Ladder
				curMapBuf.setTileProperties(266, FlxObject.ANY);
				curMapBuf.setTileProperties(267, FlxObject.ANY);
				curMapBuf.setTileProperties(268, FlxObject.ANY);
				curMapBuf.setTileProperties(269, FlxObject.ANY);//Only hard CITYLIGHT tile (to prevent weird things)
				curMapBuf.setTileProperties(271, FlxObject.NONE, TileData.thin_left);
				curMapBuf.setTileProperties(272, FlxObject.NONE, TileData.thin_right);
				curMapBuf.setTileProperties(275, FlxObject.NONE, TileData.thin_up);
				curMapBuf.setTileProperties(157, FlxObject.NONE, TileData.thin_up);
				curMapBuf.setTileProperties(158, FlxObject.NONE, TileData.thin_up);
				curMapBuf.setTileProperties(276, FlxObject.ANY);//These are the lighter outside walls
				curMapBuf.setTileProperties(277, FlxObject.ANY);
				curMapBuf.setTileProperties(278, FlxObject.ANY);
				curMapBuf.setTileProperties(279, FlxObject.ANY);
				for (j = 160; j < 190; j++) {//normal hole cases
					curMapBuf.setTileProperties(j, FlxObject.NONE,TileData.hole);
				}
				for (j = 280; j < 300; j++) {//CITYLIGHT tiles = holes
					curMapBuf.setTileProperties(j, FlxObject.NONE,TileData.hole);
				}
				curMapBuf.setTileProperties(190, FlxObject.NONE, TileData.slow, Player);
				curMapBuf.setTileProperties(191, FlxObject.NONE, TileData.slow, Player);
				CUR_MAP_HAS_CONVEYERS = true;
				curMapBuf.setTileProperties(206, FlxObject.NONE,TileData.conveyer);
				curMapBuf.setTileProperties(231, FlxObject.NONE,TileData.conveyer);
			} else if (Registry.CURRENT_MAP_NAME == "CIRCUS") {
				for (j = 60; j < 200; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE);
				}
				for (j = 70; j < 80; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE,TileData.hole);
				}
				CUR_MAP_HAS_CONVEYERS = true;
				curMapBuf.setTileProperties(110, FlxObject.NONE,TileData.conveyer);
				curMapBuf.setTileProperties(111, FlxObject.NONE,TileData.conveyer);
				curMapBuf.setTileProperties(112, FlxObject.NONE,TileData.conveyer);
				curMapBuf.setTileProperties(113, FlxObject.NONE,TileData.conveyer);
				curMapBuf.setTileProperties(114, FlxObject.NONE, TileData.conveyer);
				curMapBuf.setTileProperties(66, FlxObject.NONE, TileData.spike, Player);
				curMapBuf.setTileProperties(67, FlxObject.NONE, TileData.spike, Player);
				curMapBuf.setTileProperties(67, FlxObject.NONE, TileData.spike, Player);
				curMapBuf.setTileProperties(69, FlxObject.NONE, TileData.spike, Player);
			} else if (Registry.CURRENT_MAP_NAME == "HOTEL") {
				CUR_MAP_HAS_CONVEYERS = true;
				for (j = 80; j < 220; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE);
				}
				for (j = 90; j < 120; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE,TileData.hole);
				}
				
				for (j = 180; j < 184; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE, TileData.conveyer);
				}
				for (j = 190; j < 195; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE,TileData.hole);
				}
				curMapBuf.setTileProperties(131, FlxObject.NONE, TileData.conveyer);
				curMapBuf.setTileProperties(210, FlxObject.NONE, TileData.spike);
			} else if (no_tiles_yet.indexOf(Registry.CURRENT_MAP_NAME) != -1)  {
				CUR_MAP_HAS_CONVEYERS = true;
				curMapBuf.setTileProperties(1, FlxObject.ANY);
				curMapBuf.setTileProperties(2, FlxObject.NONE);
				curMapBuf.setTileProperties(3, FlxObject.ANY);
				curMapBuf.setTileProperties(10, FlxObject.NONE);
				curMapBuf.setTileProperties(11, FlxObject.NONE);
				curMapBuf.setTileProperties(4, FlxObject.DOWN);
				curMapBuf.setTileProperties(5, FlxObject.RIGHT);
				curMapBuf.setTileProperties(6, FlxObject.UP);
				curMapBuf.setTileProperties(7, FlxObject.LEFT);
				curMapBuf.setTileProperties(8, FlxObject.NONE,TileData.slow,Player);
				curMapBuf.setTileProperties(9, FlxObject.NONE,TileData.hole);
				curMapBuf.setTileProperties(12, FlxObject.NONE,TileData.thin_down); //um this cn be abstracted to 'thin'
				curMapBuf.setTileProperties(13, FlxObject.NONE,TileData.thin_right);
				curMapBuf.setTileProperties(14, FlxObject.NONE, TileData.thin_up);
				curMapBuf.setTileProperties(15, FlxObject.NONE,TileData.thin_left);
				curMapBuf.setTileProperties(16, FlxObject.NONE,TileData.conveyer);
				curMapBuf.setTileProperties(17, FlxObject.NONE,TileData.conveyer);
				curMapBuf.setTileProperties(18, FlxObject.NONE,TileData.conveyer);
				curMapBuf.setTileProperties(19, FlxObject.NONE,TileData.conveyer);
				curMapBuf.setTileProperties(20, FlxObject.NONE, TileData.conveyer);
				curMapBuf.setTileProperties(21, FlxObject.ANY, null, null, 3);
				curMapBuf.setTileProperties(32, FlxObject.NONE, TileData.spike, Player);
				for (j = 36; j <= 48; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE);
				}
				HOLE_INDICES.push(9);
			} else if (Registry.CURRENT_MAP_NAME == "REDCAVE") {
				CUR_MAP_HAS_CONVEYERS = true;
				curMapBuf.setTileProperties(1, FlxObject.ANY);
				curMapBuf.setTileProperties(2, FlxObject.NONE);
				curMapBuf.setTileProperties(3, FlxObject.ANY, null, null, 13);
				curMapBuf.setTileProperties(16, FlxObject.NONE, TileData.conveyer, null, 4);
				curMapBuf.setTileProperties(20, FlxObject.NONE, TileData.slow,Player, 6);
				curMapBuf.setTileProperties(26, FlxObject.NONE,TileData.conveyer,Player);
				curMapBuf.setTileProperties(27, FlxObject.NONE);
				curMapBuf.setTileProperties(28, FlxObject.NONE,TileData.conveyer);
				//everything else to nothing for now
				curMapBuf.setTileProperties(29, FlxObject.NONE, null, null, 64);
				curMapBuf.setTileProperties(40, FlxObject.NONE,TileData.hole,null,3);
				curMapBuf.setTileProperties(50, FlxObject.NONE,TileData.hole,null,3);
				curMapBuf.setTileProperties(60, FlxObject.NONE, TileData.hole, null, 3);
				curMapBuf.setTileProperties(70, FlxObject.NONE, TileData.hole, null, 7);
				curMapBuf.setTileProperties(92, FlxObject.NONE, TileData.hole);
				curMapBuf.setTileProperties(30, FlxObject.NONE, TileData.spike, Player);
				curMapBuf.setTileProperties(31, FlxObject.NONE, TileData.spike, Player);
				curMapBuf.setTileProperties(32, FlxObject.NONE, TileData.spike, Player);
			} else if (Registry.CURRENT_MAP_NAME == "REDSEA") {
				for (j = 49; j < 129; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE);
				}
			} else if (Registry.CURRENT_MAP_NAME == "FIELDS") {
				CUR_MAP_HAS_CONVEYERS = true;
				curMapBuf.setTileProperties(200, FlxObject.NONE, null, null, 64);
				curMapBuf.setTileProperties(203, FlxObject.NONE, TileData.hole);
				curMapBuf.setTileProperties(204, FlxObject.NONE, TileData.hole);
				curMapBuf.setTileProperties(205, FlxObject.NONE, spike, Player);
				curMapBuf.setTileProperties(250, FlxObject.NONE, conveyer);
				curMapBuf.setTileProperties(270, FlxObject.NONE, conveyer,null,4);
			} else if (Registry.CURRENT_MAP_NAME == "WINDMILL") {
				for (j = 100; j < 150; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE);
				}
				curMapBuf.setTileProperties(110, FlxObject.NONE, ladder, Player); //Ladder
				curMapBuf.setTileProperties(111, FlxObject.NONE, ladder, Player); //Ladder
				curMapBuf.setTileProperties(130, FlxObject.NONE, conveyer, Player);
				CUR_MAP_HAS_CONVEYERS = true;
			} else if (Registry.CURRENT_MAP_NAME == "TRAIN") { //CELL!!!
				for (j = 40; j < 70; j++) {
					curMapBuf.setTileProperties(j, FlxObject.NONE);
					
				}
				curMapBuf.setTileProperties(14, FlxObject.NONE, hole, null, 2);
				curMapBuf.setTileProperties(70, FlxObject.NONE, hole, null, 2);
				curMapBuf.setTileProperties(80, FlxObject.NONE, spike,Player, 2);
			} else if (Registry.CURRENT_MAP_NAME == "DRAWER") {
				curMapBuf.setTileProperties(1, FlxObject.ANY);
				curMapBuf.setTileProperties(2, FlxObject.NONE);
				curMapBuf.setTileProperties(3, FlxObject.ANY, null, null, 20);
				curMapBuf.setTileProperties(30, FlxObject.NONE);
				curMapBuf.setTileProperties(25, FlxObject.NONE);
				curMapBuf.setTileProperties(71, FlxObject.NONE, null, null, 41);
				curMapBuf.setTileProperties(120, FlxObject.NONE, null, null, 23);
				curMapBuf.setTileProperties(150, FlxObject.NONE, null, null, 2);
				curMapBuf.setTileProperties(162, FlxObject.NONE);
				curMapBuf.setTileProperties(168, FlxObject.NONE);
				curMapBuf.setTileProperties(170, FlxObject.NONE,null,null,3);
				curMapBuf.setTileProperties(181, FlxObject.NONE, null, null, 2);
				curMapBuf.setTileProperties(196, FlxObject.NONE, null, null, 2);
			} else if (Registry.CURRENT_MAP_NAME == "BLUE") {
				curMapBuf.setTileProperties(60, FlxObject.NONE, null, null, 10); // 40 to 69
				curMapBuf.setTileProperties(70, FlxObject.NONE, spike, Player);
				curMapBuf.setTileProperties(110, FlxObject.NONE, hole, null, 10); // 110 to 119
				
			} else if (Registry.CURRENT_MAP_NAME == "SPACE") {
				curMapBuf.setTileProperties(80, FlxObject.NONE, null, null, 30); 
				curMapBuf.setTileProperties(12, FlxObject.NONE); 
				curMapBuf.setTileProperties(25, FlxObject.NONE); 
				curMapBuf.setTileProperties(110, FlxObject.NONE, ladder, Player, 10); 
				curMapBuf.setTileProperties(120, FlxObject.NONE,null,null,2); 
				
				
			} else if (Registry.CURRENT_MAP_NAME == "SUBURB") {
				curMapBuf.setTileProperties(90, FlxObject.NONE, null, null, 80); 
			} else if (Registry.CURRENT_MAP_NAME == "GO") {
				curMapBuf.setTileProperties(90, FlxObject.NONE, null, null, 40); 
				//50 rdlu
				if (curMapBuf == Registry.GAMESTATE.curMapBuf)  {
					curMapBuf.setTileProperties(0, FlxObject.ANY);
				}
				
				curMapBuf.setTileProperties(50, FlxObject.NONE, conveyer, null, 4); 
				curMapBuf.setTileProperties(130, FlxObject.NONE,conveyer); 
				curMapBuf.setTileProperties(140, FlxObject.NONE); 
				curMapBuf.setTileProperties(170, FlxObject.NONE, null, null, 14); 
				curMapBuf.setTileProperties(194, FlxObject.NONE,conveyer,Player);
				CUR_MAP_HAS_CONVEYERS = true;
			}
			
		}
		
		/* Conveyers are also quicksand like things for the player. 
		 * (basically, they're water or moving sand etc...
		 * If it's not a player, the velocity just changes. If it's the player
		 * the velocity does change but a flag for sinking is set to true, IF 
		 * the plyer isn't in a raft state */
		private static var mapcompare:String = "aaaaaaaaaa";
		private static var tilecompare:int = 0;
		public static function conveyer(tile:FlxTile, o:*):void {
			
			if (!o.has_tile_callbacks) return;
			if (!o.hasOwnProperty("cid")) return;
			if (CUR_MAP_HAS_CONVEYERS) {
				if (o.cid == CLASS_ID.PLAYER) {
					if (!pt_in_tile(o.midpoint.x, o.midpoint.y, tile)) return;
					if (!o.ON_RAFT) { //If we're not on the raft we're sinking. set in dust collision
						o.IS_SINKING = true;
						o.slow_mul = 0.5;
					}
					tilecompare = tile.index;
					mapcompare = Registry.CURRENT_MAP_NAME;
					if (mapcompare == "WINDMILL") {
						if (tilecompare == 130) {
							o.IS_SINKING = false;
							o.slow_mul = 1;
							o.ON_CONVEYER  = FlxObject.ANY;
						}
					} else if (mapcompare == "FOREST") {
						if (tilecompare == 110) {
							o.ON_CONVEYER = FlxObject.ANY; 
						} else if (tilecompare == 134) {
							o.ON_CONVEYER = FlxObject.RIGHT; 
						} else if (tilecompare == 135) {
							o.ON_CONVEYER = FlxObject.DOWN; 
						} else if (tilecompare == 136) {
							o.ON_CONVEYER = FlxObject.LEFT; 
						} else if (tilecompare == 137) {
							o.ON_CONVEYER = FlxObject.UP; 
						}
					} else if (mapcompare == "REDCAVE" || mapcompare == "DEBUG") {
						switch (tilecompare) {
							case 16:
								o.ON_CONVEYER = FlxObject.RIGHT; break;
							case 17:
								o.ON_CONVEYER = FlxObject.DOWN; break;
							case 18:
								o.ON_CONVEYER = FlxObject.LEFT; break;
							case 19:
								o.ON_CONVEYER = FlxObject.UP;	break; 
							case 20:
								o.ON_CONVEYER = FlxObject.ANY; break;
							case 26:
							case 28: 
								o.ON_CONVEYER = FlxObject.ANY;
								break;
						}
					} else	if (mapcompare == "CIRCUS") {
						switch (tilecompare) {
							case 110:
								o.ON_CONVEYER = FlxObject.ANY;
								break;
							case 111:
								o.ON_CONVEYER = FlxObject.RIGHT;
								break;
							case 112:
								o.ON_CONVEYER = FlxObject.DOWN;
								break;
							case 113:
								o.ON_CONVEYER = FlxObject.LEFT;
								break;
							case 114:
								o.ON_CONVEYER = FlxObject.UP;
								break;
						}
					} else if (mapcompare == "APARTMENT") {
						switch (tilecompare) {
							case 206: case 231:
								o.ON_CONVEYER = FlxObject.ANY;
								break;
						}
					} else if (mapcompare == "HOTEL") {
						switch (tilecompare) {
							case 180:
								o.ON_CONVEYER = FlxObject.RIGHT;
								break;
							case 181:
								o.ON_CONVEYER = FlxObject.DOWN;
								break;
							case 182:
								o.ON_CONVEYER = FlxObject.LEFT;
								break;
							case 183:
								o.ON_CONVEYER = FlxObject.UP;
								break;
							case 131:
								o.ON_CONVEYER = FlxObject.ANY; 
								break;
						}
					} else if (mapcompare == "BEACH") {
						o.IS_SINKING = false;
						o.slow_mul = 1;
						o.ON_CONVEYER  = FlxObject.ANY;
					} else if (mapcompare == "FIELDS") {
						if (tilecompare == 250) {
							o.ON_CONVEYER = FlxObject.ANY;
						} else if (tilecompare == 270) {
							o.ON_CONVEYER = FlxObject.RIGHT;
						} else if (tilecompare == 271) {
							o.ON_CONVEYER = FlxObject.DOWN;
						} else if (tilecompare == 272) {
							o.ON_CONVEYER = FlxObject.LEFT;
						} else if (tilecompare == 273) {
							o.ON_CONVEYER = FlxObject.UP;
						}
							
					} else if (mapcompare == "GO") {
						if (tilecompare == 130 || tilecompare == 194) {
							o.ON_CONVEYER = FlxObject.ANY;
						}
					} else if (mapcompare == "TERMINAL") {
						o.IS_SINKING = false;
						o.slow_mul = 1;
						o.ON_CONVEYER  = FlxObject.ANY;
					}
				} else if (o.cid == CLASS_ID.DUST) {
					if (!pt_in_tile(o.midpoint.x, o.midpoint.y, tile)) return;
					o.ON_CONVEYER = true; //Set this to true. It gets reset at the end of the dust's update call.
					if (Registry.CURRENT_MAP_NAME == "CIRCUS") {
						o.velocity.x = o.velocity.y = 0;
						//rdlu
						switch (tile.index) {
							case 111:
								o.velocity.x = 10;
								break;
							case 112:
								o.velocity.y = 10;
								break;
							case 113:
								o.velocity.x = -10;
								break;
							case 114:
								o.velocity.y = -10;
								break;
						}
					} else if (Registry.CURRENT_MAP_NAME == "HOTEL") {
						o.velocity.x = o.velocity.y = 0;
						switch (tile.index) {
							case 180:
								o.velocity.x = 10;
								break;
							case 181:
								o.velocity.y = 10;
								break;
							case 182:
								o.velocity.x = -10;
								break;
							case 183:
								o.velocity.y = -10;
								break;
						}
					} else if (Registry.CURRENT_MAP_NAME == "FOREST") {
						o.velocity.x = o.velocity.y = 0;
						switch (tile.index) {
							case 134:
								o.velocity.x = 10;
								break;
							case 135:
								o.velocity.y = 10;
								break;
							case 136:
								o.velocity.x = -10;
								break;
							case 137:
								o.velocity.y = -10;
								break;
						}
					} else if (Registry.CURRENT_MAP_NAME == "FIELDS") {
						o.velocity.x = o.velocity.y = 0;
						switch (tile.index) {
							case 270:
								o.velocity.x = 10;
								break;
							case 271:
								o.velocity.y = 10;
								break;
							case 272:
								o.velocity.x = -10;
								break;
							case 273:
								o.velocity.y = -10;
								break;
						}
					}  else {
						o.velocity.x = o.velocity.y = 0;
						switch (tile.index) {
						case 16:
							o.velocity.y = 0;
							o.velocity.x = 10; break;
						case 17:
							o.velocity.x = 0;
							o.velocity.y = 10; 
							break;
						case 18:
							o.velocity.y = 0;
							o.velocity.x = -10; break;
						case 19:
							o.velocity.x = 0;
							o.velocity.y = -10; 
							break; 
						}		
					}
				} else if (o.cid == CLASS_ID.TRADE_NPC) {
					if (!pt_in_tile(o.midpoint.x, o.midpoint.y, tile)) return;
					o.ON_CONVEYER = true; 
				}
			}
		}
		
		public static function thin_down(tile:FlxTile, o:FlxObject):void {
			var off_x:int = Registry.CURRENT_GRID_X * 160;
			var off_y:int = Registry.CURRENT_GRID_Y * 160 + 20;
			var tx:int = int(tile.mapIndex % 10) * 16 + off_x;
			var ty:int = (int(tile.mapIndex / 10)) * 16 + off_y;
			if (o.x + o.width < tx) return;
			if (o.x > tx + 16) return;
			if (o.y + o.height > ty + 13) {
				o.y = ty + 13 - o.height;
				o.velocity.y = 0;
			}
		}
			
			
		public static function thin_up(tile:FlxTile, o:FlxObject):void {
			var off_x:int = Registry.CURRENT_GRID_X * 160;
			var off_y:int = Registry.CURRENT_GRID_Y * 160 + 20;
			var tx:int = int(tile.mapIndex % 10) * 16 + off_x;
			if (o.x + o.width < tx) return;
			if (o.x > tx + 16) return;			
			var ty:int = (int(tile.mapIndex / 10)) * 16 + off_y;
			if (o.y < ty + 3) {
				o.y = ty + 4;
				o.velocity.y = 0;
			}
		}
		
			
		public static function thin_left(tile:FlxTile, o:FlxObject):void {
		
			var off_y:int = Registry.CURRENT_GRID_Y * 160 + 20;
			var ty:int = (int(tile.mapIndex / 10)) * 16 + off_y;
			var off_x:int = Registry.CURRENT_GRID_X * 160;
			var tx:int = int(tile.mapIndex % 10) * 16 + off_x;
			if (o.y + o.height < ty) return;
			if (o.y > ty + 16) return;
			if (o.x < tx + 3) {
				o.x = tx + 4;
				o.velocity.x = 0;
			}
		}
		public static function thin_right(tile:FlxTile, o:FlxObject):void {
			var off_x:int = Registry.CURRENT_GRID_X * 160;
			var tx:int = int(tile.mapIndex % 10) * 16 + off_x;
			var off_y:int = Registry.CURRENT_GRID_Y * 160 + 20;
			var ty:int = (int(tile.mapIndex / 10)) * 16 + off_y;
			
			if (o.y + o.height < ty) return;
			if (o.y > ty + 16) return;
			if (o.x + o.width > tx + 13) {
				o.x = tx + 13 - o.width;
				o.velocity.x = 0;
			}
			
		}
		
		// fine tune hitboxes on these
		public static function hole(tile:FlxTile, p:*):void {
			if (!p.has_tile_callbacks) return;
			if (!p.hasOwnProperty("cid")) return;
			var off_y:int = Registry.CURRENT_GRID_Y * 160 + 20;
			var ty:int = (int(tile.mapIndex / 10)) * 16 + off_y;
			var off_x:int = Registry.CURRENT_GRID_X * 160;
			var tx:int = int(tile.mapIndex % 10) * 16 + off_x;
			tx += 4;
			ty += 5;
			
			if (p.cid == CLASS_ID.PLAYER) {
				tx -= 4;
				if (p.state == p.S_AIR) return;
				var t_height:int = 4;
				if (p.facing == FlxObject.UP) t_height = 1;
				if ((p.y < ty + t_height) && (p.y + p.height > ty) &&
					(p.x < tx + 11) && (p.x + p.width > tx + 5)) {  // 6 0
					p.isFalling = true;
					p.fall_pt.x = tx + 7;
					p.fall_pt.y = ty - 5;
				}
			} else if (p.cid == CLASS_ID.DUST && p != Registry.GAMESTATE.player.raft) {
				if ((p.y < ty + 4) && (p.y + p.height > ty) &&
					(p.x < tx + 6) && (p.x + p.width > tx)) {
					if (p.frame == 0)	
						p.fell_in_hole = true;
				}
			} else if (p.cid == CLASS_ID.DASHTRAP) {	
				if ((p.y < ty + 4) && (p.y + p.height > ty) &&
					(p.x < tx + 6) && (p.x + p.width > tx)) {
					p.touching = FlxObject.ANY;
					
				}
			} else if (p.cid == CLASS_ID.SILVERFISH) {
				if ((p.y < ty + 4) && (p.y + p.height > ty) &&
					(p.x < tx + 6) && (p.x + p.width > tx)) {
					p.xml.@alive = "false";
					Registry.GRID_ENEMIES_DEAD++;
					p.exists = false;
				}
			} else if (p.cid == CLASS_ID.PERSON) {
				
				if ((p.y < ty + 11) && (p.y + p.height > ty) &&
					(p.x < tx + 8) && (p.x + p.width > tx)) {
					p.xml.@alive = "false";
					Registry.GRID_ENEMIES_DEAD++;
					p.exists = false;
				}
				
				
			} else { //probably an enemy, try to make them not walk on the hole
				// FUCK IT THEY DDISAPPEAR
				p.velocity.x *= 0.25;
				p.velocity.y *= 0.25;
				if ((p.y < ty + 4) && (p.y + p.height > ty) &&
					(p.x < tx + 6) && (p.x + p.width > tx)) {
					p.xml.@alive = "false";
					Registry.GRID_ENEMIES_DEAD++;
					p.exists = false;
				}
			}
		}
		public static function slow(tile:FlxTile, p:Player):void {
			if (!p.has_tile_callbacks) return;
			//add general stuff
			if (p.state == p.S_AIR) return;
			
			var off_y:int = Registry.CURRENT_GRID_Y * 160 + 20;
			var ty:int = (int(tile.mapIndex / 10)) * 16 + off_y;
			var off_x:int = Registry.CURRENT_GRID_X * 160;
			var tx:int = int(tile.mapIndex % 10) * 16 + off_x;
			
			if ((p.y < ty + 16) && (p.y + p.height > ty) &&
				(p.x < tx + 16) && (p.x + p.width > tx)) {
					p.slow_mul = 0.5;
				}
			
		}
		
		public static function spike(tile:FlxTile, p:Player):void {
			if (!p.has_tile_callbacks) return;
			//add general stuff
			if (p.state == p.S_AIR) return;
			
			var off_y:int = Registry.CURRENT_GRID_Y * 160 + 20;
			var ty:int = (int(tile.mapIndex / 10)) * 16 + off_y;
			var off_x:int = Registry.CURRENT_GRID_X * 160;
			var tx:int = int(tile.mapIndex % 10) * 16 + off_x;
			
			if ((p.y < ty + 11) && (p.y + p.height > ty + 6) &&
				(p.x < tx + 12) && (p.x + p.width > tx + 6)) {
					p.touchDamage(1);
				}
		}
		
		public static function ladder(tile:FlxTile, p:Player):void {
			if (!p.has_tile_callbacks) return;
			//add general stuff
			
			var off_y:int = Registry.CURRENT_GRID_Y * 160 + 20;
			var ty:int = (int(tile.mapIndex / 10)) * 16 + off_y;
			var off_x:int = Registry.CURRENT_GRID_X * 160;
			var tx:int = int(tile.mapIndex % 10) * 16 + off_x;
			
			if (Registry.CURRENT_MAP_NAME == "WINDMILL") {
				ty = (int(tile.mapIndex / Registry.GAMESTATE.map_bg_2.widthInTiles)) * 16 + 20;
				tx = int(tile.mapIndex % Registry.GAMESTATE.map_bg_2.widthInTiles) * 16;
			}
			if ((p.y < ty + 16) && (p.y + p.height > ty) &&
				(p.x < tx + 16) && (p.x + p.width > tx)) {
					// Deal with jumping onto ladder
					if (p.state == p.S_AIR) {
						return;
						var diff:int = p.offset.y - p.DEFAULT_Y_OFFSET;
						p.y -= diff;
						p.offset.y = p.DEFAULT_Y_OFFSET;
					}
					p.state = p.S_LADDER;
			}
			
		}
		
		static private function pt_in_tile(x:int,y:int,tile:FlxTile):Boolean
		{
			var off_x:int = Registry.CURRENT_GRID_X * 160;
			var off_y:int = Registry.CURRENT_GRID_Y * 160 + 20;
			var tx:int = int(tile.mapIndex % 10) * 16 + off_x;
			var ty:int = (int(tile.mapIndex / 10)) * 16 + off_y;
			return ((y <= ty + 16) && (y  >= ty) &&
		(x <= tx + 16) && (x >= tx));
		}
		
    }

}
