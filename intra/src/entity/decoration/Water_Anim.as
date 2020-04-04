package entity.decoration 
{
	import data.TileData;
	import global.Registry;
	import org.flixel.AnoSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
/**
 * Given a map buffer will transform a list of tiles at some rate into water or whatever 
 */
	public class Water_Anim extends AnoSprite
	{
		
		private var started:Boolean = false;
		
		private var target_tiles:Array; // List of tiles [0,99] that will be transformed in order
		private var target_tile_types:Array; // What each tile will change to.
		
		private var latency:Number = 0.3; //Time between tile transforms
		private var t:Number = 0;
		
		private var map_ref:FlxTilemap;
		private var map_name:String;
		
		public var anim_tiles:FlxGroup; // Group of animated tiles, added to parent.
		
		private var anim_idx:int = 0; // Which animated tile in anim_tiles will be visible next.
		private var cur_idx:int = 0;  // Which tile in target_tiles, w.r.t. the current wscreen, will change next.
		
		
		public static var START_WATER_ANIM:Boolean = false;
		public function Water_Anim(args:Array)
		{
			super(args);
			map_name = Registry.CURRENT_MAP_NAME;
			START_WATER_ANIM = false; // Reset this every tiemmmm 
			switch (map_name) {
				case "DEBUG":
					target_tiles =      new Array(10, 11, 12, 13, 14);
					target_tile_types = new Array(16,17,18,19,19);
					latency = 0.3;
					break;
				case "BLUE":
					target_tiles =      new Array(3,13,23,33,32,31,30);
					target_tile_types = new Array(31,31,31,30,30,30,30);
					latency = 0.3;
					break;
				case "HAPPY":
					target_tiles =      new Array(6,16,26,36,37,38,39);
					target_tile_types = new Array(41,41,41,40,40,40,40);
					latency = 0.3;
					break;
				case "GO":
					var gx:int = Registry.CURRENT_GRID_X;
					var gy:int = Registry.CURRENT_GRID_Y;
					
					if (gx == 0 && gy == 2) {
						if (Registry.GE_States[Registry.GE_Briar_Happy_Done]) {
							xml.@alive = "true";
						}
						target_tiles =      new Array(30, 31, 32, 33, 34, 35, 36, 37, 38, 39);
						target_tile_types = new Array(190,190,190,190,190,190,190,190,190,190);
						
					} else if (gx == 1 && gy == 2) { 
						if (Registry.GE_States[Registry.GE_Briar_Happy_Done]) xml.@alive = "true";
						target_tiles =      new Array(30,31,32,33,34,35,36,37,27,17,7);
						target_tile_types = new Array(190,190,190,190,190,190,190,191,191,191,191);
					} else if (gx == 2 && gy == 1) {
						latency = 0.2;
						target_tiles =      new Array(40,  41,  31,  21,  22,  12,  13,    49,  48,  38,  28,  27,  17,  16,  15, 5,  14,  4);
						target_tile_types = new Array(190,191,191,190,191,190,190,192,193,193,192,193,192,192,194,194,194,194);
						
					} else if (gx == 3 && gy == 2) {
						if (Registry.GE_States[Registry.GE_Briar_Blue_Done]) xml.@alive = "true";
						target_tiles =      new Array(2,12,22,32,33,34,35,36,37,38,39);
						target_tile_types = new Array(193,193,193,193,192,192,192,192,192,192,192);
					} else if (gx == 4 && gy == 2) {
						if (Registry.GE_States[Registry.GE_Briar_Blue_Done]) xml.@alive = "true";
						target_tiles =      new Array(30, 31, 32, 33, 34, 35, 36, 37, 38, 39);
						target_tile_types = new Array(192,192,192,192,192,192,192,192,192,192);
					}
					
					break;
				default:
					exists = false;
					break;
			}
			visible = false;
			anim_tiles = new FlxGroup();
			//set up group and indices 
			//TileData.make_anim_tile(anim_tiles,map_name,.,
			
			for (var i:int = 0; i < target_tiles.length; i++) {
				TileData.make_anim_tile(anim_tiles, map_name, target_tile_types[i], tl.x + 16 * (target_tiles[i] % 10), tl.y +  16 * int(target_tiles[i] / 10));
			}
			anim_tiles.setAll("visible", false);
			parent.anim_tiles_group.add(anim_tiles);
			
			// If we activated this event already, the animated tiles should be visible.
			if (xml.@alive == "true") {
				anim_tiles.setAll("visible", true);
				
				while (set_next_tile()) {
					
				}
			}
		}
		
		
		private function set_next_tile():Boolean {
			
			if (cur_idx < target_tiles.length) {
				if (TileData.animtiles_indices_dict[Registry.CURRENT_MAP_NAME].indexOf(target_tile_types[cur_idx]) != -1) {
					anim_tiles.members[anim_idx].visible = true;
					anim_idx++;
				}
			
				parent.curMapBuf.setTileByIndex(target_tiles[cur_idx], target_tile_types[cur_idx], true);
				cur_idx++;
				return true;
			}
			
			return false;
			
		}
		
		public static var UNALIVE:Boolean = false;
		override public function update():void 
		
		{
			
			if (UNALIVE) {
				xml.@alive = "false";
				UNALIVE = false;
			}
			
			if (START_WATER_ANIM) {
				START_WATER_ANIM = false;
				if (xml.@alive == "false") {
					started = true;
					player.state = player.S_INTERACT;
					player.be_idle();
				}
			}
			
			if (started) {
				t += FlxG.elapsed;
				if (t > latency) {
					t = 0;
					if (!set_next_tile()) { // When finished...
						started = false;
						xml.@alive = "true";
						if (Registry.CURRENT_MAP_NAME != "BLUE") {
							
						player.state = player.S_GROUND;
						}
					}
				}
			}
			
			super.update();
		}
		
		
		
		public function start():void {
			
			if (xml.@alive == "true") {
				return;
				//Yeah no.
			}
			started = true;
			
			
		}
		
		public static function START_WATER_ANIMF():void {
			START_WATER_ANIM = true;
		}
		
		override public function destroy():void 
		{
			target_tile_types = null;
			target_tiles = null;
			anim_tiles = null;
			map_ref = null;
			super.destroy();
		}
		
		/**
		 * Takes a single screen's 10x10 tilemap
		 * @param	map
		 */
		public function set_map(map:FlxTilemap):void {
			map_ref = map;
		}
		
	}

}