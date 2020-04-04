package states 
{
	import data.CSV_Data;
	import data.TileData;
	import global.Registry;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import org.flixel.system.FlxTile;
	/**
	 * ...
	 * @author Seagaia
	 */
	public class MinimapState extends PushableFlxState 
	{
		
		public var minimap:FlxTilemap;
		private var blank_tile_index:int  = 9;
		
		/* contants, screen width and height, used for centering the map */
		private var sw:int = 160;
		private var sh:int = 180;
		
		public static var visited:Object = { STREET: new Array(), BEDROOM: new Array(), REDCAVE: new Array(), CROWD: new Array(), APARTMENT: new Array(), CIRCUS: new Array(), HOTEL: new Array(), FIELDS: new Array(), CLIFF: new Array(), OVERWORLD: new Array(), BEACH: new Array(), REDSEA: new Array(), FOREST: new Array(), SUBURB: new Array(), TRAIN: new Array(), SPACE: new Array() , TERMINAL: new Array()};
		public static var minimap_strings:Array = new Array("","","","","","","","","","","","","","","","");
		
		public static var minimap_areas:Array = new Array("STREET", "BEDROOM", "REDCAVE", "CROWD", "APARTMENT", "CIRCUS", "HOTEL","FIELDS","CLIFF","OVERWORLD","BEACH","REDSEA","FOREST","SUBURB","TRAIN","SPACE","TERMINAL");
		
		public var is_finished:Boolean = false;
		
		public var entrance:FlxSprite = new FlxSprite();
		public var player_marker:FlxSprite = new FlxSprite();
		public var player_marker_blink_timer:Number = 0;
		public var player_marker_blink_timer_max:Number = 0.4;
		public var has_map:Boolean = false;
		
		public var nr_times_coords_set:int = 0;
		public var invalid:Boolean = false;
		
		public function MinimapState() 
		{
			
			trace("Initializing Minimap");
			minimap = new FlxTilemap();
			minimap.loadMap("0,2", TileData.Minimap_Tiles, 7, 7);
			reset_minimap();
			
			add(minimap);
			add(entrance);
			
			add(player_marker);
			
			setAll("scrollFactor", new FlxPoint(0, 0));
			
		}
		public static function save_delete_routine():void {
			visited["STREET"] = new Array();
			visited["BEDROOM"] = new Array();
			visited["CROWD"] = new Array();
			visited["REDCAVE"] = new Array();
			visited["APARTMENT"] = new Array();
			visited["CIRCUS"] = new Array();
			visited["HOTEL"] = new Array();
			
			visited["FOREST"] = new Array();
			visited["CLIFF"] = new Array();
			visited["BEACH"] = new Array();
			visited["REDSEA"] = new Array();
			visited["OVERWORLD"] = new Array();
			visited["FIELDS"] = new Array();
			
			visited["SPACE"] = new Array();
			visited["TERMINAL"] = new Array();
			visited["SUBURB"] = new Array();
			visited["TRAIN"] = new Array();
			
			MinimapState.minimap_strings = new Array("","","","","","","","","","","","","","","","","");
		}
		
		public function get_minimap():FlxTilemap {
			if (has_map) return minimap;
			return null;
		}
		private function reset_minimap():void {
			
			nr_times_coords_set = 0;
			is_finished = false;
			
			
			if (CSV_Data.minimap_csv.hasOwnProperty(Registry.CURRENT_MAP_NAME)) {
				player_marker.makeGraphic(3, 3, 0xffff5949);
				entrance.makeGraphic(3, 3, 0xff0d52af);
			}
			
			
			var idx:int = minimap_areas.indexOf(Registry.CURRENT_MAP_NAME);
			if (idx == -1) {
				visible = false;
				invalid = true;
				has_map = false;
				return;
			}
			visible = true;
			
			minimap.null_buffer(0); // Force a redraw?
			minimap.loadMap(new CSV_Data.minimap_csv[Registry.CURRENT_MAP_NAME], TileData.Minimap_Tiles, 7, 7);
			set_coords(minimap); // Set alignment of minimap
			
			var tmap:FlxTilemap = new FlxTilemap;
			// If we have not yet initialized this according to the serialized
			// minimap state, then mark all rooms as not visited
			if (minimap_strings[idx] == "" || minimap_strings[idx] == null) {
				for (var i:int = 0; i < minimap.totalTiles; i++) {
					visited[Registry.CURRENT_MAP_NAME].push(0);
				}
			// Otherwise use a dirty hack to get the visited data
			} else {
				tmap.loadMap(minimap_strings[idx], TileData.Minimap_Tiles, 7, 7);
				visited[Registry.CURRENT_MAP_NAME] = tmap.getData();
			}
			
			
			
			minimap.draw(); // Maybe redraw??
			update_map(); // Make rooms invisible if not visited yet
			
			set_marker_coords(); // Set entrance/player spot etc
		}
		
		
		
		override public function update():void 
		{
			
			player_marker_blink_timer += FlxG.elapsed;
			if (player_marker_blink_timer > player_marker_blink_timer_max) {
				player_marker.visible = !player_marker.visible;
				player_marker_blink_timer = 0;
			}
			
			super.update();
		}
		
		public function stuff_for_pause_state():void {
			
			if (CSV_Data.minimap_csv.hasOwnProperty(Registry.CURRENT_MAP_NAME)) {
				// UPdate a room as visited
				update_visited_array(Registry.CURRENT_MAP_NAME, Registry.CURRENT_GRID_X, Registry.CURRENT_GRID_Y);
				// Reload the uncovered rooms
				minimap.loadMap(new CSV_Data.minimap_csv[Registry.CURRENT_MAP_NAME], TileData.Minimap_Tiles, 7, 7)
				// Redraw the map
				update_map();
				// MOve markers
				set_marker_coords();
			}
		}
		
		override public function push(_parent:FlxState):void 
		{
			if (minimap_areas.indexOf(Registry.CURRENT_MAP_NAME) != -1) {	
				is_finished = false;
				minimap.loadMap(new CSV_Data.minimap_csv[Registry.CURRENT_MAP_NAME], TileData.Minimap_Tiles, 7, 7)
				update_visited_array(Registry.CURRENT_MAP_NAME, Registry.CURRENT_GRID_X, Registry.CURRENT_GRID_Y);
				update_map();
				minimap_strings[minimap_areas.indexOf(Registry.CURRENT_MAP_NAME)] = FlxTilemap.arrayToCSV(visited[Registry.CURRENT_MAP_NAME],minimap.widthInTiles);
				set_marker_coords();
			}
			super.push(_parent);
		}
		
		public function init_minimap():void {
			if (minimap_areas.indexOf(Registry.CURRENT_MAP_NAME) != -1) {	
				invalid = false;
				is_finished = false;
				has_map = true;
				minimap.visible = player_marker.visible = entrance.visible = true;
				player_marker.exists = true;
				reset_minimap();
				minimap.loadMap(new CSV_Data.minimap_csv[Registry.CURRENT_MAP_NAME], TileData.Minimap_Tiles,7, 7)
				update_visited_array(Registry.CURRENT_MAP_NAME, Registry.CURRENT_GRID_X, Registry.CURRENT_GRID_Y);
				minimap_strings[minimap_areas.indexOf(Registry.CURRENT_MAP_NAME)] = FlxTilemap.arrayToCSV(visited[Registry.CURRENT_MAP_NAME],minimap.widthInTiles);
				update_map();
				set_marker_coords();
			} else {
				has_map = false;
				invalid = true;
				minimap.visible = player_marker.visible = entrance.visible = false;
				player_marker.exists = false;
			}
		}
		
		public function set_coords(map:FlxTilemap):void {
			
			minimap.x = 60 + (100 - map.width) / 2;
			minimap.y = Registry.HEADER_HEIGHT + (100 - map.height) / 2;
			
		}
		override public function destroy():void 
		{
			// Calls the level up, destroys all things added to this state
			super.destroy();
		}
		
		public function update_visited_array(mapName:String, gx:int, gy:int):void {
			if (!invalid) {
				if (minimap == null) return;
				var idx:int = gy * minimap.widthInTiles + gx;
				trace("Updated!", gx, gy);
				visited[mapName][idx] = 1;
				// Update the serialized map state
				minimap_strings[minimap_areas.indexOf(Registry.CURRENT_MAP_NAME)] = FlxTilemap.arrayToCSV(visited[Registry.CURRENT_MAP_NAME], minimap.widthInTiles);
				
			}
		}
		
		private function update_map():void 
		{
			for (var i:int = 0; i < minimap.widthInTiles * minimap.heightInTiles; i++) {
				if (1 != visited[Registry.CURRENT_MAP_NAME][i]) {
					minimap.setTileByIndex(i, blank_tile_index, true);
				}
			}
		}
		
		private function set_marker_coords():void 
		{
			if (nr_times_coords_set < 2) {
				nr_times_coords_set++;
				entrance.x = minimap.x + 2 + Registry.CURRENT_GRID_X * 7;
				entrance.y = minimap.y + 2 + Registry.CURRENT_GRID_Y * 7;
			}
			player_marker.x = minimap.x + 2 + Registry.CURRENT_GRID_X * 7;
			player_marker.y = minimap.y + 2 + Registry.CURRENT_GRID_Y * 7;
		}
	}

}